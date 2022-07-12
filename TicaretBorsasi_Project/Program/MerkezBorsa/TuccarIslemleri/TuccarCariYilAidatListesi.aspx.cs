using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using TicaretBorsasi_Project.Class.Helper;
using TicaretBorsasi_Project.Data;

namespace TicaretBorsasi_Project.Program.MerkezBorsa.TuccarIslemleri
{
    public partial class TuccarCariYilAidatListesi : Page
    {
        #region Properties

        #endregion

        #region Events

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                SetInitials();
            }
            else
            {
                GridViewCariYilAidatListesi.DataSource = PageHelper.SessionData;
                GridViewCariYilAidatListesi.DataBind();
            }
        }

        protected void ButtonRapor_Click(object sender, EventArgs e)
        {
            GridViewCariYilAidatListesi.DataSource = PageHelper.SessionData;
            GridViewCariYilAidatListesi.DataBind();

            switch (ComboBoxRapor.SelectedIndex)
            {
                case 0:
                    GridViewExporterCariYilAidatListesi.WriteXlsxToResponse("Cari Yıl Aidat Listesi");
                    break;
                case 1:
                    GridViewExporterCariYilAidatListesi.WritePdfToResponse("Cari Yıl Aidat Listesi");
                    break;
                default:
                    break;
            }
        }

        protected void ButtonAra_Click(object sender, EventArgs e)
        {
            Ara();
        }

        protected void ButtonTemizle_Click(object sender, EventArgs e)
        {
            Response.Redirect(Request.Url.AbsoluteUri);
        }

        #endregion

        #region Methods

        private void SetInitials()
        {
            LabelBaslik.Text = "CARİ YIL AİDAT LİSTESİ";
            PageHelper.SessionData = null;

            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                List<TT_KURULUS_TUR> listKURULUS_TUR = entity.TT_KURULUS_TUR.AsNoTracking().ToList();
                List<TT_DERECE> listDERECE = entity.TT_DERECE.AsNoTracking().ToList();
                var listYil = new List<string>();
                for (int i = DateTime.Now.Year; i > 1900; i--)
                {
                    listYil.Add(i.ToString());
                }

                ComboBoxUyeTipi.DataSource = listKURULUS_TUR;
                ComboBoxUyeTipi.DataBind();

                ComboBoxUyeDerece.DataSource = listDERECE;
                ComboBoxUyeDerece.DataBind();

                ComboBoxAidatYili.DataSource = listYil;
                ComboBoxAidatYili.DataBind();
                ComboBoxAidatYili.SelectedIndex = 0;
            }
        }

        private void Ara()
        {
            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                int? pUyeTipi = ComboBoxUyeTipi.SelectedIndex == -1
                                    ? null
                                    : (int?) Convert.ToInt32(ComboBoxUyeTipi.SelectedItem.Value);
                int? pUyeDerece = ComboBoxUyeDerece.SelectedIndex == -1
                                      ? null
                                      : (int?) Convert.ToInt32(ComboBoxUyeDerece.SelectedItem.Value);
                short pAidatYili = Convert.ToInt16(ComboBoxAidatYili.SelectedItem.Value);

                GridViewCariYilAidatListesi.DataSource = null;

                var sonuc =
                    entity.AIDAT_TAKIP.Include("TUCCAR_SICIL")
                          .Include("TUCCAR_SICIL.TT_MESLEK_GRUP")
                          .Include("TT_DERECE")
                          .AsNoTracking()
                          .ToList()
                          .Select(p => new
                              {
                                  p.AidatTakipKey,
                                  Sira = 0,
                                  p.TuccarSicilKey,
                                  UyeTipiKey = p.TUCCAR_SICIL.KurulusTurKey,
                                  p.TUCCAR_SICIL.SicilNo,
                                  p.TUCCAR_SICIL.Unvan,
                                  DereceAdi = p.TT_DERECE.Kod,
                                  p.DereceKey,
                                  p.Yil,
                                  MeslekGrupAdi = p.TUCCAR_SICIL.TT_MESLEK_GRUP.MeslekAdi,
                                  Taksit1 = p.Taksit1OdemeMiktar,
                                  Taksit2 = p.Taksit2OdemeMiktar,
                                  Aidat = p.AidatMiktar,
                              });

                #region sıralama

                switch (ComboBoxSiralaArtanAzalan.SelectedItem.Value.ToString())
                {
                    default:
                    case "1":
                        switch (ComboBoxSirala.SelectedItem.Value.ToString())
                        {
                            default:
                            case "1":
                                sonuc = sonuc.OrderBy(p => p.SicilNo);
                                break;
                            case "2":
                                sonuc = sonuc.OrderBy(p => p.Unvan);
                                break;
                            case "3":
                                sonuc = sonuc.OrderBy(p => p.MeslekGrupAdi);
                                break;
                            case "4":
                                sonuc = sonuc.OrderBy(p => p.DereceKey);
                                break;
                        }
                        break;
                    case "2":
                        switch (ComboBoxSirala.SelectedItem.Value.ToString())
                        {
                            default:
                            case "1":
                                sonuc = sonuc.OrderByDescending(p => p.SicilNo);
                                break;
                            case "2":
                                sonuc = sonuc.OrderByDescending(p => p.Unvan);
                                break;
                            case "3":
                                sonuc = sonuc.OrderByDescending(p => p.MeslekGrupAdi);
                                break;
                            case "4":
                                sonuc = sonuc.OrderByDescending(p => p.DereceKey);
                                break;
                        }
                        break;
                }

                #endregion

                #region koşullar

                sonuc = sonuc.Where(p => p.Yil == pAidatYili);

                if (pUyeTipi != null)
                {
                    sonuc = sonuc.Where(p => p.UyeTipiKey == pUyeTipi);
                }

                if (pUyeDerece != null)
                {
                    sonuc = sonuc.Where(p => p.DereceKey == pUyeDerece);
                }

                #endregion

                int counter = 1;
                sonuc = sonuc.Select(p => new
                    {
                        p.AidatTakipKey,
                        Sira = counter++,
                        p.TuccarSicilKey,
                        p.UyeTipiKey,
                        p.SicilNo,
                        p.Unvan,
                        p.DereceAdi,
                        p.DereceKey,
                        p.Yil,
                        p.MeslekGrupAdi,
                        p.Taksit1,
                        p.Taksit2,
                        p.Aidat,
                    });

                GridViewCariYilAidatListesi.DataSource = sonuc;
                PageHelper.SessionData = GridViewCariYilAidatListesi.DataSource;
                GridViewCariYilAidatListesi.DataBind();
            }
        }

        #endregion
    }
}
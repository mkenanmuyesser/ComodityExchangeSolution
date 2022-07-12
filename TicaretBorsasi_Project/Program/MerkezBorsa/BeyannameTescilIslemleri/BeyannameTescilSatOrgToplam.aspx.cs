using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web.UI;
using TicaretBorsasi_Project.Class.CustomType;
using TicaretBorsasi_Project.Class.Helper;
using TicaretBorsasi_Project.Class.Query;
using TicaretBorsasi_Project.Data;

namespace TicaretBorsasi_Project.Program.MerkezBorsa.BeyannameTescilIslemleri
{
    public partial class BeyannameTescilSatOrgToplam : Page
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
                GridViewSatOrgHToplam.DataSource = PageHelper.SessionData;
                GridViewSatOrgHToplam.DataBind();
            }
        }

        protected void ButtonRapor_Click(object sender, EventArgs e)
        {
            GridViewSatOrgHToplam.DataSource = PageHelper.SessionData;
            GridViewSatOrgHToplam.DataBind();

            switch (ComboBoxRapor.SelectedIndex)
            {
                case 0:
                    GridViewExporterSatOrgHToplam.WriteXlsxToResponse("Beyanname Tescil ve Sat.Org.H. Toplamları Listeleri");
                    break;
                case 1:
                    GridViewExporterSatOrgHToplam.WritePdfToResponse("Beyanname Tescil ve Sat.Org.H. Toplamları Listeleri");
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
            LabelBaslik.Text = "BEYANNAME TESCİL VE SAT. ORG. H. TOPLAMLARI LİSTESİ";
            PageHelper.SessionData = null;

            DateEditBaslangic.Date = new DateTime(DateTime.Now.Year, 01, 01);
            DateEditBitis.Date = DateTime.Now;

            using (var entity = new DBEntities())
            {
                List<TT_SATIS_SEKLI> listTT_SATIS_SEKLI = entity.TT_SATIS_SEKLI.AsNoTracking().OrderBy(p => p.SatisSekliKey).ToList();
                listTT_SATIS_SEKLI.Insert(0, new TT_SATIS_SEKLI { SatisSekliKey = 0, SatisSekliAdi = "TÜMÜ", SatisSekliUzunAdi = "TÜMÜ" });
                ComboBoxSatisSekli.DataSource = listTT_SATIS_SEKLI;
                ComboBoxSatisSekli.DataBind();

                ComboBoxSatisSekli.SelectedIndex = 0;
            }
        }

        private void Ara()
        {
            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                int? pSatisSekli = ComboBoxSatisSekli.SelectedIndex == 0 ? null : (int?)Convert.ToInt32(ComboBoxSatisSekli.SelectedItem.Value);
                DateTime pBaslangic = DateEditBaslangic.Date;
                DateTime pBitis = DateEditBitis.Date;
                string pSicilNoBaslangic = SpinEditSicilNoBaslangic.Text.Trim();
                string pSicilNoBitis = SpinEditSicilNoBitis.Text.Trim();
                string pSubeKodBaslangic = SpinEditBaslangicSubeKodu.Text.Trim();
                string pSubeKodBitis = SpinEditBitisSubeKodu.Text.Trim();
                string pMeslekKodBaslangic = SpinEditBaslangicMeslekKodu.Text.Trim();
                string pMeslekKodBitis = SpinEditBitisMeslekKodu.Text.Trim();

                GridViewSatOrgHToplam.DataSource = null;
                int counter = 1;
                var sonuc =
                    entity.BEYANs.Include("TUCCAR_SICIL")
                          .Include("TUCCAR_SICIL.TT_MESLEK_GRUP")
                          .Include("TT_BORSA_SUBE")
                          .AsNoTracking()
                          .ToList()
                          .Select(p => new
                          {
                              p.TuccarSicilKey,
                              p.SatisSekliKey,
                              SicilNo = p.TUCCAR_SICIL.SicilNo.TrimStart('0'),
                              Tarih = p.BeyanTarihi,
                              p.BeyanKayitTipKey,
                              SubeKodu = p.TT_BORSA_SUBE.Kod,
                              MeslekKodu = p.TUCCAR_SICIL.TT_MESLEK_GRUP.Kod,
                              Sira = 0,
                              p.TUCCAR_SICIL.Unvan,
                              SatOrgHUcreti = p.SimsariyeMiktar,
                              TescilUcreti = p.TescilMiktar
                          });

                #region koşullar

                if (pSatisSekli != null)
                {
                    sonuc = sonuc.Where(p => p.SatisSekliKey == pSatisSekli);
                }

                if (!string.IsNullOrEmpty(pSicilNoBaslangic) || !string.IsNullOrEmpty(pSicilNoBitis))
                {
                    if (!string.IsNullOrEmpty(pSicilNoBaslangic) && string.IsNullOrEmpty(pSicilNoBitis))
                    {
                        int baslangic;
                        if (!int.TryParse(pSicilNoBaslangic, out baslangic))
                        {
                            PageHelper.MessageBox(this, "Sicil numara girişi hatalıdır!");
                            return;
                        }

                        for (int i = pSicilNoBaslangic.Length; i < 6; i++)
                        {
                            pSicilNoBaslangic = "0" + pSicilNoBaslangic;
                        }
                        sonuc = sonuc.Where(p => p.SicilNo == pSicilNoBaslangic);
                    }
                    else
                    {
                        int baslangic;
                        int bitis;
                        if (int.TryParse(pSicilNoBaslangic, out baslangic) && int.TryParse(pSicilNoBitis, out bitis))
                        {
                            sonuc =
                                sonuc.Where(
                                    p =>
                                    Convert.ToInt32(p.SicilNo) >= baslangic && Convert.ToInt32(p.SicilNo) <= bitis);
                        }
                        else
                        {
                            PageHelper.MessageBox(this, "Sicil numara girişi hatalıdır!");
                            return;
                        }
                    }
                }

                sonuc = sonuc.Where(p => p.Tarih != null && p.Tarih >= pBaslangic && p.Tarih <= pBitis);

                if (!string.IsNullOrEmpty(pSubeKodBaslangic) || !string.IsNullOrEmpty(pSubeKodBitis))
                {
                    if (!string.IsNullOrEmpty(pSubeKodBaslangic) && string.IsNullOrEmpty(pSubeKodBitis))
                    {
                        int baslangic;
                        if (!int.TryParse(pSubeKodBaslangic, out baslangic))
                        {
                            PageHelper.MessageBox(this, "Şube kodu girişi hatalıdır!");
                            return;
                        }

                        sonuc = sonuc.Where(p => p.SubeKodu == pSubeKodBaslangic);
                    }
                    else
                    {
                        int baslangic;
                        int bitis;
                        if (int.TryParse(pSubeKodBaslangic, out baslangic) && int.TryParse(pSubeKodBitis, out bitis))
                        {
                            sonuc =
                                sonuc.Where(
                                    p =>
                                    Convert.ToInt32(p.SubeKodu) >= baslangic && Convert.ToInt32(p.SubeKodu) <= bitis);
                        }
                        else
                        {
                            PageHelper.MessageBox(this, "Şube kodu girişi hatalıdır!");
                            return;
                        }
                    }
                }

                if (!string.IsNullOrEmpty(pMeslekKodBaslangic) || !string.IsNullOrEmpty(pMeslekKodBitis))
                {
                    if (!string.IsNullOrEmpty(pMeslekKodBaslangic) && string.IsNullOrEmpty(pMeslekKodBitis))
                    {
                        int baslangic;
                        if (!int.TryParse(pMeslekKodBaslangic, out baslangic))
                        {
                            PageHelper.MessageBox(this, "Meslek kodu girişi hatalıdır!");
                            return;
                        }

                        sonuc = sonuc.Where(p => Convert.ToInt32(p.MeslekKodu) == baslangic);
                    }
                    else
                    {
                        int baslangic;
                        int bitis;
                        if (int.TryParse(pMeslekKodBaslangic, out baslangic) && int.TryParse(pMeslekKodBitis, out bitis))
                        {
                            sonuc =
                                sonuc.Where(
                                    p =>
                                    Convert.ToInt32(p.MeslekKodu) >= baslangic && Convert.ToInt32(p.MeslekKodu) <= bitis);
                        }
                        else
                        {
                            PageHelper.MessageBox(this, "Meslek kodu girişi hatalıdır!");
                            return;
                        }
                    }
                }

                #endregion

                #region sıralama

                sonuc = sonuc.OrderBy(p => Convert.ToInt32(p.SicilNo)).OrderBy(p => Convert.ToInt32(p.SubeKodu));

                #endregion

                var data = sonuc.GroupBy(p =>
                               new
                               {
                                   p.TuccarSicilKey,
                                   p.SicilNo,
                                   p.Sira,
                                   p.Unvan,
                               })
                                .Select(p => new
                                {
                                    p.Key.TuccarSicilKey,
                                    p.Key.SicilNo,
                                    p.Key.Sira,
                                    p.Key.Unvan,
                                    SatOrgHToplam = p.Sum(x => x.SatOrgHUcreti),
                                    TescilToplam = p.Sum(x => x.TescilUcreti),
                                })
                                .Distinct().Select(p => new
                                {
                                    p.TuccarSicilKey,
                                    p.SicilNo,
                                    Sira = counter++,
                                    p.Unvan,
                                    SatOrgHToplam = p.SatOrgHToplam == 0 ? null : p.SatOrgHToplam,
                                    TescilToplam = p.TescilToplam == 0 ? null : p.TescilToplam,
                                })
                                .ToList();

                GridViewSatOrgHToplam.DataSource = data;
                PageHelper.SessionData = GridViewSatOrgHToplam.DataSource;
                GridViewSatOrgHToplam.DataBind();
            }
        }

        #endregion
    }
}
using DevExpress.Web.ASPxGridView;
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
    public partial class BeyannameEmtiaKodluTesSimToplam : Page
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
                GridViewEmtiaKodluToplam.DataSource = PageHelper.SessionData;
                GridViewEmtiaKodluToplam.DataBind();
            }
        }

        protected void ButtonRapor_Click(object sender, EventArgs e)
        {
            GridViewEmtiaKodluToplam.DataSource = PageHelper.SessionData;
            GridViewEmtiaKodluToplam.DataBind();

            switch (ComboBoxRapor.SelectedIndex)
            {
                case 0:
                    GridViewExporterEmtiaKodluToplam.WriteXlsxToResponse("Beyanname Emtia Kodlu Tescil ve Sat.Org.H. Toplamları Listeleri");
                    break;
                case 1:
                    GridViewExporterEmtiaKodluToplam.WritePdfToResponse("Beyanname Emtia Kodlu Tescil ve Sat.Org.H. Toplamları Listeleri");
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
            LabelBaslik.Text = "BEYANNAME EMTİA KODUNA GÖRE TESCİL VE SAT.ORG.H. TOPLAMLARI LİSTESİ";
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

                List<TT_DERECE> listTT_DERECE = entity.TT_DERECE.AsNoTracking().ToList();
                ComboBoxBaslangicDerece.DataSource = listTT_DERECE;
                ComboBoxBaslangicDerece.DataBind();
                ComboBoxBaslangicDerece.SelectedIndex = 0;

                ComboBoxBitisDerece.DataSource = listTT_DERECE;
                ComboBoxBitisDerece.DataBind();
                ComboBoxBitisDerece.SelectedIndex = ComboBoxBitisDerece.Items.Count - 1;
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
                string pMeslekKodBaslangic = SpinEditBaslangicMeslekKodu.Text.Trim();
                string pMeslekKodBitis = SpinEditBitisMeslekKodu.Text.Trim();
                string pEmtiaKodBaslangic = SpinEditBaslangicEmtiaKodu.Text.Trim();
                string pEmtiaKodBitis = SpinEditBitisEmtiaKodu.Text.Trim();
                int pDereceKeyBaslangic = Convert.ToInt32(ComboBoxBaslangicDerece.SelectedItem.Value);
                int pDereceKeyBitis = Convert.ToInt32(ComboBoxBitisDerece.SelectedItem.Value);

                GridViewEmtiaKodluToplam.DataSource = null;
                int counter = 1;
                var sonuc =
                    entity.BEYANs.Include("TUCCAR_SICIL")
                          .Include("TUCCAR_SICIL.TT_MESLEK_GRUP")
                          .Include("TT_BORSA_SUBE")
                          .Include("TT_MADDE_KOD")
                          .Include("TT_BEYAN_TIP")
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
                              EmtiaKodu = p.TT_MADDE_KOD.Kod,
                              DereceKey = p.TUCCAR_SICIL.DereceKey,
                              Sira = 0,
                              p.TUCCAR_SICIL.Unvan,
                              Cinsi = p.TT_MADDE_KOD.Adi,
                              Tipi = p.TT_BEYAN_TIP.BeyanTipAdi,
                              SimsarTescil = p.SimsariyeMiktar + p.TescilMiktar,
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

                if (!string.IsNullOrEmpty(pEmtiaKodBaslangic) || !string.IsNullOrEmpty(pEmtiaKodBitis))
                {
                    if (!string.IsNullOrEmpty(pEmtiaKodBaslangic) && string.IsNullOrEmpty(pEmtiaKodBitis))
                    {
                        int baslangic;
                        if (!int.TryParse(pEmtiaKodBaslangic, out baslangic))
                        {
                            PageHelper.MessageBox(this, "Emtia kodu girişi hatalıdır!");
                            return;
                        }

                        sonuc = sonuc.Where(p => p.EmtiaKodu == pEmtiaKodBaslangic);
                    }
                    else
                    {
                        int baslangic;
                        int bitis;
                        if (int.TryParse(pEmtiaKodBaslangic, out baslangic) && int.TryParse(pEmtiaKodBitis, out bitis))
                        {
                            sonuc =
                                sonuc.Where(
                                    p =>
                                    Convert.ToInt32(p.EmtiaKodu) >= baslangic && Convert.ToInt32(p.EmtiaKodu) <= bitis);
                        }
                        else
                        {
                            PageHelper.MessageBox(this, "Emtia kodu girişi hatalıdır!");
                            return;
                        }
                    }
                }

                sonuc = sonuc.Where(p => p.DereceKey != null && p.DereceKey >= pDereceKeyBaslangic && p.DereceKey <= pDereceKeyBitis);

                #endregion

                #region sıralama

                sonuc = sonuc.OrderBy(p => Convert.ToInt32(p.EmtiaKodu)).OrderBy(p => Convert.ToInt32(p.SicilNo));

                var siralamadata = sonuc.Select(p => new { p.TuccarSicilKey }).Distinct().ToList();

                #endregion

                var data = sonuc.GroupBy(p =>
                               new
                               {
                                   p.TuccarSicilKey,
                                   p.Sira,
                                   p.SicilNo,
                                   p.Unvan,
                                   p.Cinsi,
                                   p.Tipi,
                               })
                                .Select(p => new
                                {
                                    p.Key.TuccarSicilKey,
                                    p.Key.Sira,
                                    p.Key.SicilNo,
                                    p.Key.Unvan,
                                    p.Key.Cinsi,
                                    p.Key.Tipi,
                                    SimsarTescilToplam = p.Sum(x => x.SimsarTescil),
                                })
                                .Distinct().Select(p => new
                                {
                                    p.TuccarSicilKey,
                                    Sira = siralamadata.FindIndex(x => x.TuccarSicilKey == p.TuccarSicilKey) + 1,
                                    p.SicilNo,
                                    p.Unvan,
                                    p.Cinsi,
                                    p.Tipi,
                                    p.SimsarTescilToplam
                                })
                                .ToList();

                GridViewEmtiaKodluToplam.DataSource = data;
                PageHelper.SessionData = GridViewEmtiaKodluToplam.DataSource;
                GridViewEmtiaKodluToplam.DataBind();

                #region gruplama

                foreach (GridViewDataColumn item in GridViewEmtiaKodluToplam.GetGroupedColumns())
                {
                    GridViewEmtiaKodluToplam.UnGroup(item);
                }

                GridViewEmtiaKodluToplam.GroupBy(GridViewEmtiaKodluToplam.Columns["Sira"]);

                #endregion
            }
        }

        #endregion
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using DevExpress.Web.ASPxGridView;
using TicaretBorsasi_Project.Class.Helper;
using TicaretBorsasi_Project.Data;

namespace TicaretBorsasi_Project.Program.SalonSatis.LabSatisListeleri
{
    public partial class OtomatikSatisDetaylari : Page
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
                GridViewOtomatikSatisDetaylari.DataSource = PageHelper.SessionData;
                GridViewOtomatikSatisDetaylari.DataBind();
            }
        }

        protected void ButtonRapor_Click(object sender, EventArgs e)
        {
            GridViewOtomatikSatisDetaylari.DataSource = PageHelper.SessionData;
            GridViewOtomatikSatisDetaylari.DataBind();

            switch (ComboBoxRapor.SelectedIndex)
            {
                case 0:
                    GridViewExporterOtomatikSatisDetaylari.WriteXlsxToResponse("Otomatik Satış Detayları");
                    break;
                case 1:
                    GridViewExporterOtomatikSatisDetaylari.WritePdfToResponse("Otomatik Satış Detayları");
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
            LabelBaslik.Text = "OTOMATİK SATIŞ DETAYLARI";
            PageHelper.SessionData = null;

            DateEditBaslangic.Date = new DateTime(DateTime.Now.Year, 01, 01);
            DateEditBitis.Date = DateTime.Now;           
        }

        private void Ara()
        {
            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                int pListeTipi = Convert.ToInt32(ComboBoxListeTipi.SelectedItem.Value);
                DateTime pBaslangic = DateEditBaslangic.Date;
                DateTime pBitis = DateEditBitis.Date;
                string pSicilNoBaslangic = SpinEditSicilNoBaslangic.Text.Trim();
                string pSicilNoBitis = SpinEditSicilNoBitis.Text.Trim();                
                string pMaddeKodBaslangic = SpinEditBaslangicMaddeKodu.Text.Trim();
                string pMaddeKodBitis = SpinEditBitisMaddeKodu.Text.Trim();

                GridViewOtomatikSatisDetaylari.DataSource = null;
                var sonuc =
                    entity.BEYANs.Include("TUCCAR_SICIL")
                          .Include("TT_BIRIM_TIP")
                          .Include("TT_MADDE_KOD")
                          .Include("TT_BORSA_SUBE")
                          .AsNoTracking()
                          .ToList()
                          .Select(p => new
                              {
                                  p.BeyanKey,
                                  SubeKodu = p.TT_BORSA_SUBE.Kod,
                                  MaddeKodu = p.TT_MADDE_KOD.Kod,
                                  MaddeAdi = p.TT_MADDE_KOD.Adi,
                                  p.TUCCAR_SICIL.SicilNo,
                                  p.TUCCAR_SICIL.Unvan,
                                  Tarih = p.BeyanTarihi,
                                  p.BeyanNo,
                                  BirimAdi = p.TT_BIRIM_TIP.BirimTipAdi,
                                  MiktarAlis = p.BeyanTipKey == 1 ? p.BeyanMiktar : null,
                                  TutarAlis = p.BeyanTipKey == 1 ? p.BeyanSatisTutari : null,
                                  TipAlis = p.BeyanTipKey == 1 ? p.TT_MADDE_KOD.Adi : null,
                                  MiktarSatis = p.BeyanTipKey == 2 ? p.BeyanMiktar : null,
                                  TutarSatis = p.BeyanTipKey == 2 ? p.BeyanSatisTutari : null,
                                  TipSatis = p.BeyanTipKey == 2 ? p.TT_MADDE_KOD.Adi : null,
                              });

                #region koşullar

                sonuc = sonuc.Where(p => p.Tarih != null && p.Tarih >= pBaslangic && p.Tarih <= pBitis);

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
                                    p => Convert.ToInt32(p.SicilNo) >= baslangic && Convert.ToInt32(p.SicilNo) <= bitis);
                        }
                        else
                        {
                            PageHelper.MessageBox(this, "Sicil numara girişi hatalıdır!");
                            return;
                        }
                    }
                }

                if (pListeTipi != 0)
                {
                    //??sonuc = sonuc.Where(p => p
                }              

                if (!string.IsNullOrEmpty(pMaddeKodBaslangic) || !string.IsNullOrEmpty(pMaddeKodBitis))
                {
                    if (!string.IsNullOrEmpty(pMaddeKodBaslangic) && string.IsNullOrEmpty(pMaddeKodBitis))
                    {
                        int baslangic;
                        if (!int.TryParse(pMaddeKodBaslangic, out baslangic))
                        {
                            PageHelper.MessageBox(this, "Madde kodu girişi hatalıdır!");
                            return;
                        }

                        sonuc = sonuc.Where(p => p.MaddeKodu == pMaddeKodBaslangic);
                    }
                    else
                    {
                        int baslangic;
                        int bitis;
                        if (int.TryParse(pMaddeKodBaslangic, out baslangic) && int.TryParse(pMaddeKodBitis, out bitis))
                        {
                            sonuc =
                                sonuc.Where(
                                    p =>
                                    Convert.ToInt32(p.MaddeKodu) >= baslangic && Convert.ToInt32(p.MaddeKodu) <= bitis);
                        }
                        else
                        {
                            PageHelper.MessageBox(this, "Madde kodu girişi hatalıdır!");
                            return;
                        }
                    }
                }

                //??sonuc = sonuc.Where(p => p.pDigerBorsaAlisSatis              

                #endregion

                #region gruplama

                if (pListeTipi != 0)
                {
                    //??sonuc = sonuc.Where(p => p
                }  

                //GridViewOtomatikSatisDetaylari.GroupBy(GridViewOtomatikSatisDetaylari.Columns["MaddeKodu"]);

                #endregion

                #region sıralama

                sonuc = sonuc.OrderBy(p => p.BeyanNo).OrderBy(p => p.MaddeKodu).ToList();

                #endregion

                GridViewOtomatikSatisDetaylari.DataSource = sonuc;
                PageHelper.SessionData = GridViewOtomatikSatisDetaylari.DataSource;
                GridViewOtomatikSatisDetaylari.DataBind();
            }
        }

        #endregion
    }
}
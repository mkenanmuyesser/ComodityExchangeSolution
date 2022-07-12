using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using TicaretBorsasi_Project.Class.Helper;
using TicaretBorsasi_Project.Data;

namespace TicaretBorsasi_Project.Program.MerkezBorsa.BeyannameTescilIslemleri
{
    public partial class BeyannameBeyanTarama : Page
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
                GridViewBeyanTarama.DataSource = PageHelper.SessionData;
                GridViewBeyanTarama.DataBind();
            }
        }

        protected void ButtonRapor_Click(object sender, EventArgs e)
        {
            GridViewBeyanTarama.DataSource = PageHelper.SessionData;
            GridViewBeyanTarama.DataBind();

            switch (ComboBoxRapor.SelectedIndex)
            {
                case 0:
                    GridViewExporterBeyanTarama.WriteXlsxToResponse("Birim Fiyatlı Beyan Listesi");
                    break;
                case 1:
                    GridViewExporterBeyanTarama.WritePdfToResponse("Birim Fiyatlı Beyan Listesi");
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
            LabelBaslik.Text = "BİRİM FİYATLI BEYAN TARAMA";

            DateEditBaslangic.Date = new DateTime(DateTime.Now.Year, 01, 01);
            DateEditBitis.Date = DateTime.Now;

            using (var entity = new DBEntities())
            {
                List<TT_BEYAN_TIP> listBEYAN_TIP = entity.TT_BEYAN_TIP.AsNoTracking().OrderBy(p => p.BeyanTipKey).ToList();
                listBEYAN_TIP.Insert(0, new TT_BEYAN_TIP { BeyanTipKey = 0, BeyanTipAdi = "TÜMÜ", Aciklama = "TÜMÜ" });
                ComboBoxBeyannameTipi.DataSource = listBEYAN_TIP;
                ComboBoxBeyannameTipi.DataBind();

                ComboBoxBeyannameTipi.SelectedIndex = 0;
            }
        }

        private void Ara()
        {
            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                byte pBeyannameTipi = Convert.ToByte(ComboBoxBeyannameTipi.SelectedItem.Value);
                string pSicilNoBaslangic = SpinEditSicilNoBaslangic.Text.Trim();
                string pSicilNoBitis = SpinEditSicilNoBitis.Text.Trim();
                decimal? pAltLimit = string.IsNullOrEmpty(SpinEditAltLimit.Text) ? null : (decimal?)Convert.ToDecimal(SpinEditAltLimit.Text);
                decimal? pUstLimit = string.IsNullOrEmpty(SpinEditUstLimit.Text) ? null : (decimal?)Convert.ToDecimal(SpinEditUstLimit.Text);
                DateTime pBaslangic = DateEditBaslangic.Date;
                DateTime pBitis = DateEditBitis.Date;
                string pSubeKodBaslangic = SpinEditBaslangicSubeKodu.Text.Trim();
                string pSubeKodBitis = SpinEditBitisSubeKodu.Text.Trim();
                string pMaddeKodBaslangic = SpinEditBaslangicMaddeKodu.Text.Trim();
                string pMaddeKodBitis = SpinEditBitisMaddeKodu.Text.Trim();

                GridViewBeyanTarama.DataSource = null;
                var sonuc =
                    entity.BEYANs.Include("TUCCAR_SICIL")
                          .Include("TT_BEYAN_TIP")
                          .Include("TT_BORSA_SUBE")
                          .Include("TT_MADDE_KOD")
                          .Include("TT_ALIS_SATIS_TIP")
                          .AsNoTracking()
                          .ToList()
                          .Select(p => new
                              {
                                  p.BeyanKey,
                                  p.BeyanKayitTipKey,
                                  p.TUCCAR_SICIL.SicilNo,
                                  p.BeyanMiktar,
                                  SubeKodu = p.TT_BORSA_SUBE.Kod,
                                  Tarih = p.BeyanTarihi,
                                  MaddeKodu = p.TT_MADDE_KOD.Kod,
                                  TescilTarihi = p.BeyanTarihi,
                                  TescilNo = p.TUCCAR_SICIL.SicilKayitNo,
                                  SubeNo = p.TT_BORSA_SUBE.Kod,
                                  FirmaNo = p.TUCCAR_SICIL.SicilNo,
                                  BTP = p.TT_ALIS_SATIS_TIP.AlisSatisTipAdi,
                                  Fiyati = p.BirimFiyat,
                                  Miktari = p.BeyanMiktar,
                                  Tutari = p.BirimFiyat * p.BeyanMiktar,
                              });

                #region koşullar

                if (pBeyannameTipi != 0)
                {
                    sonuc = sonuc.Where(p => p.BeyanKayitTipKey == pBeyannameTipi);
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

                if (pAltLimit != null)
                {
                    sonuc = sonuc.Where(p => p.BeyanMiktar >= pAltLimit);
                }

                if (pUstLimit != null)
                {
                    sonuc = sonuc.Where(p => p.BeyanMiktar <= pUstLimit);
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

                #endregion
                
                GridViewBeyanTarama.DataSource = sonuc.OrderBy(p => p.Tarih);
                PageHelper.SessionData = GridViewBeyanTarama.DataSource;
                GridViewBeyanTarama.DataBind();
            }
        }

        #endregion
    }
}
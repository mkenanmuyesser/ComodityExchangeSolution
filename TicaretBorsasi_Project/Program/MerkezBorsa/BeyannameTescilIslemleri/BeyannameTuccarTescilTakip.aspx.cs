using DevExpress.Web.ASPxGridView;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using TicaretBorsasi_Project.Class.Helper;
using TicaretBorsasi_Project.Data;

namespace TicaretBorsasi_Project.Program.MerkezBorsa.BeyannameTescilIslemleri
{
    public partial class BeyannameTuccarTescilTakip : Page
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
                GridViewTuccarTescilTakip.DataSource = PageHelper.SessionData;
                GridViewTuccarTescilTakip.DataBind();
            }
        }

        protected void ButtonRapor_Click(object sender, EventArgs e)
        {
            GridViewTuccarTescilTakip.DataSource = PageHelper.SessionData;
            GridViewTuccarTescilTakip.DataBind();

            switch (ComboBoxRapor.SelectedIndex)
            {
                case 0:
                    GridViewExporterTuccarTescilTakip.WriteXlsxToResponse("Tüccar Tescil Takip");
                    break;
                case 1:
                    GridViewExporterTuccarTescilTakip.WritePdfToResponse("Tüccar Tescil Takip");
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
            LabelBaslik.Text = "TÜCCAR TESCİL TAKİP";
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
                int? pSatisSekli = ComboBoxSatisSekli.SelectedIndex == 0 ? null : (int?)Convert.ToInt32(ComboBoxSatisSekli.SelectedItem.Value);
                DateTime pBaslangic = DateEditBaslangic.Date;
                DateTime pBitis = DateEditBitis.Date;
                string pMaddeKodBaslangic = SpinEditBaslangicMaddeKodu.Text.Trim();
                string pMaddeKodBitis = SpinEditBitisMaddeKodu.Text.Trim();
                string pSubeKodBaslangic = SpinEditBaslangicSubeKodu.Text.Trim();
                string pSubeKodBitis = SpinEditBitisSubeKodu.Text.Trim();

                GridViewTuccarTescilTakip.DataSource = null;
                var sonuc =
                    entity.BEYANs.Include("TUCCAR_SICIL")
                          .Include("TT_BEYAN_TIP")
                          .Include("TT_BORSA_SUBE")
                          .Include("TT_BIRIM_TIP")
                          .Include("TT_ALIS_SATIS_TIP")
                          .AsNoTracking()
                          .ToList()
                          .Select(p => new
                              {
                                  p.BeyanKey,
                                  p.SatisSekliKey,
                                  SubeKodu = p.TT_BORSA_SUBE.Kod,
                                  MaddeKodu = p.TT_MADDE_KOD == null ? null : p.TT_MADDE_KOD.Kod,
                                  Tarih = p.BeyanTarihi,
                                  TuccarBilgi = p.TUCCAR_SICIL.SicilNo + " - " + p.TUCCAR_SICIL.Unvan,
                                  TescilTarihi = p.BeyanTarihi,
                                  TescilNo = p.BeyanNo.ToString().TrimStart('0') + "-" + p.BeyanSatirNo,
                                  FaturaTarihi = p.BeyanFaturaTarihi,
                                  FaturaNo = p.BeyanFaturaNo,
                                  Birim = p.TT_BIRIM_TIP.BirimTipAdi,
                                  SatOrgHUcret = p.SimsariyeMiktar,
                                  TescilUcret = p.TescilMiktar,
                                  AlisMiktar = p.AlisSatisTipKey == 1 ? p.BeyanMiktar : null,
                                  AlisTutar = p.AlisSatisTipKey == 1 ? p.BeyanSatisTutari : null,
                                  AlisTur = p.AlisSatisTipKey == 1 ? p.TT_ALIS_SATIS_TIP.AlisSatisTipAdi : null,
                                  SatisMiktar = p.AlisSatisTipKey == 2 ? p.BeyanMiktar : null,
                                  SatisTutar = p.AlisSatisTipKey == 2 ? p.BeyanSatisTutari : null,
                                  SatisTur = p.AlisSatisTipKey == 2 ? p.TT_ALIS_SATIS_TIP.AlisSatisTipAdi : null,
                              });

                #region koşullar

                if (pSatisSekli != null)
                {
                    sonuc = sonuc.Where(p => p.SatisSekliKey == pSatisSekli);
                }

                sonuc = sonuc.Where(p => p.Tarih != null && p.Tarih >= pBaslangic && p.Tarih <= pBitis);

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

                #endregion

                #region sıralama

                switch (ComboBoxSiralaArtanAzalan.SelectedItem.Value.ToString())
                {
                    default:
                    case "1":
                        switch (ComboBoxSirala.SelectedItem.Value.ToString())
                        {
                            default:
                            case "1":
                                sonuc = sonuc.OrderBy(p => p.Tarih);
                                break;
                            case "2":
                                sonuc = sonuc.OrderBy(p => p.TescilNo);
                                break;
                        }
                        break;
                    case "2":
                        switch (ComboBoxSirala.SelectedItem.Value.ToString())
                        {
                            default:
                            case "1":
                                sonuc = sonuc.OrderByDescending(p => p.Tarih);
                                break;
                            case "2":
                                sonuc = sonuc.OrderByDescending(p => p.TescilNo);
                                break;
                        }
                        break;
                }

                #endregion

                #region gruplama

                foreach (GridViewDataColumn item in GridViewTuccarTescilTakip.GetGroupedColumns())
                {
                    GridViewTuccarTescilTakip.UnGroup(item);
                }

                GridViewTuccarTescilTakip.GroupBy(GridViewTuccarTescilTakip.Columns["TuccarBilgi"]);

                #endregion

                GridViewTuccarTescilTakip.DataSource = sonuc;
                PageHelper.SessionData = GridViewTuccarTescilTakip.DataSource;
                GridViewTuccarTescilTakip.DataBind();
            }
        }

        #endregion
    }
}
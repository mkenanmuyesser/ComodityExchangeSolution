using DevExpress.Web.ASPxGridView;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using TicaretBorsasi_Project.Class.Helper;
using TicaretBorsasi_Project.Data;

namespace TicaretBorsasi_Project.Program.MerkezBorsa.BeyannameTescilIslemleri
{
    public partial class BeyannameTescilNoTakip : Page
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
                GridViewTescilNoTakip.DataSource = PageHelper.SessionData;
                GridViewTescilNoTakip.DataBind();
            }
        }

        protected void ButtonRapor_Click(object sender, EventArgs e)
        {
            GridViewTescilNoTakip.DataSource = PageHelper.SessionData;
            GridViewTescilNoTakip.DataBind();

            int pListeTipi = Convert.ToInt32(ComboBoxListeTipi.SelectedItem.Value);
            if (pListeTipi == 2)
            {
                GridViewTescilNoTakip.Columns["Madde"].Visible = true;
                GridViewTescilNoTakip.Columns["No"].Visible = true;
                GridViewTescilNoTakip.Columns["TeslimTarihi"].Visible = true;
                GridViewTescilNoTakip.Columns["SaticiFirmaUnvan"].Visible = true;
                GridViewTescilNoTakip.Columns["Miktar"].Visible = true;
                GridViewTescilNoTakip.Columns["BirimAdi"].Visible = true;
            }

            switch (ComboBoxRapor.SelectedIndex)
            {
                case 0:
                    GridViewExporterTescilNoTakip.WriteXlsxToResponse("Tescil No Takip Çizelgesi");
                    break;
                case 1:
                    GridViewExporterTescilNoTakip.WritePdfToResponse("Tescil No Takip Çizelgesi");
                    break;
                default:
                    break;
            }

            if (pListeTipi == 2)
            {
                GridViewTescilNoTakip.Columns["Madde"].Visible = false;
                GridViewTescilNoTakip.Columns["No"].Visible = false;
                GridViewTescilNoTakip.Columns["TeslimTarihi"].Visible = false;
                GridViewTescilNoTakip.Columns["SaticiFirmaUnvan"].Visible = false;
                GridViewTescilNoTakip.Columns["Miktar"].Visible = false;
                GridViewTescilNoTakip.Columns["BirimAdi"].Visible = false;
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
            LabelBaslik.Text = "TESCİL NO TAKİP";
            PageHelper.SessionData = null;

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
                int pListeTipi = Convert.ToInt32(ComboBoxListeTipi.SelectedItem.Value);
                int? pBeyannameTip = ComboBoxBeyannameTipi.SelectedIndex == 0 ? null : (int?)Convert.ToInt32(ComboBoxBeyannameTipi.SelectedItem.Value);
                DateTime pBaslangic = DateEditBaslangic.Date;
                DateTime pBitis = DateEditBitis.Date;
                string pSubeKodBaslangic = SpinEditBaslangicSubeKodu.Text.Trim();
                string pSubeKodBitis = SpinEditBitisSubeKodu.Text.Trim();

                switch (pListeTipi)
                {
                    default:
                    case 1:
                        foreach (GridViewDataColumn kolon in GridViewTescilNoTakip.Columns)
                        {
                            kolon.DataItemTemplate = null;
                        }
                        break;
                    case 2:

                        break;
                }

                GridViewTescilNoTakip.DataSource = null;
                var sonuc =
                    entity.BEYANs.Include("TUCCAR_SICIL")
                          .Include("TUCCAR_SICIL1")
                          .Include("TT_BEYAN_TIP")
                          .Include("TT_BORSA_SUBE")
                          .Include("TT_BEYAN_KAYIT_TIP")
                          .Include("TT_MADDE_KOD")
                          .Include("TT_BIRIM_TIP")
                          .AsNoTracking()
                          .ToList()
                          .Select(p => new
                              {
                                  p.BeyanKey,
                                  p.BeyanNo,
                                  p.BeyanTipKey,
                                  Tarih = p.BeyanTarihi,
                                  TescilTarihi = p.BeyanTarihi,
                                  TescilNo = p.BeyanNo.ToString().TrimStart('0') + "-" + p.BeyanSatirNo,
                                  SubeKodu = p.TT_BORSA_SUBE.Kod,
                                  SubeKoduAdi = p.TT_BORSA_SUBE.Kod + "/" + p.TT_BORSA_SUBE.BorsaSubeAdi,
                                  FirmaNo = p.TUCCAR_SICIL.SicilNo,
                                  FirmaUnvan = p.TUCCAR_SICIL.Unvan,
                                  BeyanNevi = p.TT_BEYAN_TIP.BeyanTipAdi,
                                  Tip = p.TT_BEYAN_KAYIT_TIP.BeyanKayitTipAdi,
                                  Madde = p.TT_MADDE_KOD.Adi,
                                  No = "",
                                  TeslimTarihi = p.TeslimTarihi,
                                  SaticiFirmaUnvan = p.TUCCAR_SICIL1 == null ? " - " : p.TUCCAR_SICIL1.Unvan,
                                  Miktar = p.BeyanMiktar,
                                  BirimAdi = p.TT_BIRIM_TIP.BirimTipAdi
                              });

                #region koşullar

                if (pBeyannameTip != null)
                {
                    sonuc = sonuc.Where(p => p.BeyanTipKey == pBeyannameTip);
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

                #endregion

                #region sıralama

                sonuc = sonuc.OrderBy(p => p.BeyanNo).OrderBy(p => p.SubeKodu);

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

                GridViewTescilNoTakip.DataSource = sonuc;
                PageHelper.SessionData = GridViewTescilNoTakip.DataSource;
                GridViewTescilNoTakip.DataBind();
            }
        }

        #endregion

    }
}
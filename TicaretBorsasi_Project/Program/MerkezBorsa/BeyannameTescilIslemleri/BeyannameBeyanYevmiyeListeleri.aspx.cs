using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using TicaretBorsasi_Project.Class.Helper;
using TicaretBorsasi_Project.Data;

namespace TicaretBorsasi_Project.Program.MerkezBorsa.BeyannameTescilIslemleri
{
    public partial class BeyannameBeyanYevmiyeListeleri : Page
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
                GridViewBeyanYevmiye.DataSource = PageHelper.SessionData;
                GridViewBeyanYevmiye.DataBind();
            }
        }

        protected void ButtonRapor_Click(object sender, EventArgs e)
        {
            GridViewBeyanYevmiye.DataSource = PageHelper.SessionData;
            GridViewBeyanYevmiye.DataBind();

            switch (ComboBoxRapor.SelectedIndex)
            {
                case 0:
                    GridViewExporterBeyanYevmiye.WriteXlsxToResponse("Yevmiye Defteri");
                    break;
                case 1:
                    GridViewExporterBeyanYevmiye.WritePdfToResponse("Yevmiye Defteri");
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

        protected void ComboBoxListeTipi_SelectedIndexChanged(object sender, EventArgs e)
        {
            int listetip = ComboBoxListeTipi.SelectedIndex == -1
                               ? 0
                               : Convert.ToInt32(ComboBoxListeTipi.SelectedItem.Value);
            switch (listetip)
            {
                default:
                case -1:

                    break;
                case 1:
                    ComboBoxMuhasebeTip.Enabled = false;
                    SpinEditBaslangicSubeKodu.Enabled = true;
                    SpinEditBitisSubeKodu.Enabled = true;
                    ComboBoxSatisSekli.Enabled = true;
                    break;
                case 2:
                    ComboBoxMuhasebeTip.Enabled = false;
                    SpinEditBaslangicSubeKodu.Enabled = true;
                    SpinEditBitisSubeKodu.Enabled = true;
                    ComboBoxSatisSekli.Enabled = false;
                    break;
                case 3:
                    ComboBoxMuhasebeTip.Enabled = true;
                    SpinEditBaslangicSubeKodu.Enabled = false;
                    SpinEditBitisSubeKodu.Enabled = false;
                    ComboBoxSatisSekli.Enabled = false;
                    break;
            }
        }

        #endregion

        #region Methods

        private void SetInitials()
        {
            LabelBaslik.Text = "BEYAN YEVMİYE DEFTERİ";
            PageHelper.SessionData = null;

            DateEditBaslangic.Date = new DateTime(DateTime.Now.Year, 01, 01);
            DateEditBitis.Date = DateTime.Now;

            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                List<TT_MUHASEBE_TIP> listMUHASEBE_TIP = entity.TT_MUHASEBE_TIP.AsNoTracking().ToList();
                List<TT_SATIS_SEKLI> listSATIS_SEKLI = entity.TT_SATIS_SEKLI.AsNoTracking().ToList();

                ComboBoxMuhasebeTip.DataSource = listMUHASEBE_TIP;
                ComboBoxMuhasebeTip.DataBind();

                ComboBoxSatisSekli.DataSource = listSATIS_SEKLI;
                ComboBoxSatisSekli.DataBind();
            }
        }

        private void Ara()
        {
            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                int pListeTipi = Convert.ToInt32(ComboBoxListeTipi.SelectedItem.Value);
                int? pMuhasebeAdi = ComboBoxMuhasebeTip.SelectedIndex == -1
                                        ? null
                                        : (int?) Convert.ToInt32(ComboBoxMuhasebeTip.SelectedItem.Value);
                DateTime pBaslangic = DateEditBaslangic.Date;
                DateTime pBitis = DateEditBitis.Date;
                string pSubeKodBaslangic = SpinEditBaslangicSubeKodu.Text.Trim();
                string pSubeKodBitis = SpinEditBitisSubeKodu.Text.Trim();
                int? pSatisSekli = ComboBoxSatisSekli.SelectedIndex == -1
                                       ? null
                                       : (int?) Convert.ToInt32(ComboBoxSatisSekli.SelectedItem.Value);

                GridViewBeyanYevmiye.DataSource = null;
                var sonuc = entity.BEYANs
                    .Include("TUCCAR_SICIL")
                    .Include("TT_BORSA_SUBE")
                    .AsNoTracking()
                    .ToList().Select(p => new
                    {
                        p.BeyanKey,
                        Sira = 0,
                        SubeKodu = p.TT_BORSA_SUBE.Kod,
                        p.TUCCAR_SICIL.SicilNo,
                        p.TUCCAR_SICIL.Unvan,
                        Tarih = p.BeyanTarihi,
                        p.BeyanNo,
                        p.SatisSekliKey,
                        p.BeyanKayitTipKey,
                        p.SimsariyeMiktar,
                        p.TescilMiktar,
                    });

                #region koşullar

                switch (pListeTipi)
                {
                    case 1:
                        sonuc = sonuc.Where(p => p.BeyanKayitTipKey == 1);
                        break;
                    case 2:
                        sonuc = sonuc.Where(p => p.BeyanKayitTipKey == 2);
                        break;
                    default:
                    case 3:
                        break;
                }

                if (pMuhasebeAdi != null)
                {
                    //sonuc = sonuc.Where(p=>p);
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

                if (pSatisSekli != null)
                {
                    sonuc = sonuc.Where(p => p.SatisSekliKey == pSatisSekli.Value);
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
                                sonuc = sonuc.OrderBy(p => p.SicilNo);
                                break;
                            case "2":
                                sonuc = sonuc.OrderBy(p => p.Unvan);
                                break;
                            case "3":
                                sonuc = sonuc.OrderBy(p => p.BeyanNo);
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
                                sonuc = sonuc.OrderByDescending(p => p.BeyanNo);
                                break;
                        }
                        break;
                }

                #endregion

                int counter = 1;
                var data = sonuc.Select(p => new
                    {
                        p.Sira,
                        p.SicilNo,
                        p.Unvan,
                        p.SimsariyeMiktar,
                        p.TescilMiktar
                    }).GroupBy(p =>
                               new
                                   {
                                       p.Sira,
                                       p.SicilNo,
                                       p.Unvan
                                   })
                                .Select(p => new
                                    {
                                        Sira = 0,
                                        p.Key.SicilNo,
                                        p.Key.Unvan,
                                        SatOrgH = p.Sum(x => x.SimsariyeMiktar),
                                        Tescil = p.Sum(x => x.TescilMiktar),
                                    })
                                .Distinct().Select(p => new
                                    {
                                        Sira = counter++,
                                        SicilNo = p.SicilNo.TrimStart('0'),
                                        p.Unvan,
                                        p.SatOrgH,
                                        p.Tescil,
                                    })
                                .ToList();

                GridViewBeyanYevmiye.DataSource = data;
                PageHelper.SessionData = GridViewBeyanYevmiye.DataSource;
                GridViewBeyanYevmiye.DataBind();
            }
        }

        #endregion
    }
}
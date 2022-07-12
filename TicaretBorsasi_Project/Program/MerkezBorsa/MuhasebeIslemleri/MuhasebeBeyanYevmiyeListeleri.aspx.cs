using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using TicaretBorsasi_Project.Class.Helper;
using TicaretBorsasi_Project.Data;

namespace TicaretBorsasi_Project.Program.MerkezBorsa.MuhasebeIslemleri
{
    public partial class MuhasebeBeyanYevmiyeListeleri : Page
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

        protected void ButtonAra_Click(object sender, EventArgs e)
        {
            Ara();
        }

        protected void ButtonTemizle_Click(object sender, EventArgs e)
        {
            Response.Redirect(Request.Url.AbsoluteUri);
        }

        protected void ButtonRapor_Click(object sender, EventArgs e)
        {
            //Ara();
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

        #endregion

        #region Methods

        private void SetInitials()
        {
            LabelBaslik.Text = "MUHASEBE YEVMİYE DEFTERİ";

            DateEditBaslangic.Date = new DateTime(DateTime.Now.Year, 01, 01);
            DateEditBitis.Date = DateTime.Now;

            using (var entity = new DBEntities())
            {
                List<TT_MUHASEBE_TIP> listMUHASEBE_TIP = entity.TT_MUHASEBE_TIP.ToList();

                ComboBoxMuhasebeTip.DataSource = listMUHASEBE_TIP;
                ComboBoxMuhasebeTip.DataBind();
            }
        }

        private void Ara()
        {
            using (var entity = new DBEntities())
            {
                int pListeTipi = Convert.ToInt32(ComboBoxListeTipi.SelectedItem.Value);
                DateTime pBaslangic = DateEditBaslangic.Date;
                DateTime pBitis = DateEditBitis.Date;
                string pSubeKodBaslangic = SpinEditBaslangicSubeKodu.Text.Trim();
                string pSubeKodBitis = SpinEditBitisSubeKodu.Text.Trim();

                GridViewBeyanYevmiye.DataSource = null;
                var sonuc = entity.BEYANs.Include("TUCCAR_SICIL").Include("TT_BORSA_SUBE").ToList().Select(p => new
                    {
                        p.BeyanKey,
                        Sira = 0,
                        SubeKodu = p.TT_BORSA_SUBE.Kod,
                        p.TUCCAR_SICIL.SicilNo,
                        p.TUCCAR_SICIL.Unvan,
                        Tarih = p.BeyanTarihi,
                        p.BeyanNo,
                    });

                #region koşullar

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
                GridViewBeyanYevmiye.DataSource = sonuc.Select(p => new
                    {
                        p.BeyanKey,
                        Sira = counter++,
                        p.SubeKodu,
                        p.SicilNo,
                        p.Unvan,
                        p.BeyanNo,
                    });
                GridViewBeyanYevmiye.DataBind();

                //GridViewTahakkukBeyanYevmiye.GroupBy(GridViewTahakkukBeyanYevmiye.Columns[0]);
                //GridViewTuccarCariDefteri.ExpandAll();

                //if (sonuc.Count() > 0)
                //{
                //    raporDiv.Visible = true;
                //}
                //else
                //{
                //    raporDiv.Visible = false;
                //}
            }
        }

        #endregion
    }
}
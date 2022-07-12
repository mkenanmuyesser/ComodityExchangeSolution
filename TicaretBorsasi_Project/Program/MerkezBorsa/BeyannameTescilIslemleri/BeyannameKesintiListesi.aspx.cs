using System;
using System.Linq;
using System.Web.UI;
using TicaretBorsasi_Project.Class.Helper;
using TicaretBorsasi_Project.Data;

namespace TicaretBorsasi_Project.Program.MerkezBorsa.BeyannameTescilIslemleri
{
    public partial class BeyannameKesintiListesi : Page
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
                GridViewBeyannameKesinti.DataSource = PageHelper.SessionData;
                GridViewBeyannameKesinti.DataBind();
            }
        }

        protected void ButtonRapor_Click(object sender, EventArgs e)
        {
            GridViewBeyannameKesinti.DataSource = PageHelper.SessionData;
            GridViewBeyannameKesinti.DataBind();

            switch (ComboBoxRapor.SelectedIndex)
            {
                case 0:
                    GridViewExporterBeyannameKesinti.WriteXlsxToResponse("Beyanname Kesintileri Listesi");
                    break;
                case 1:
                    GridViewExporterBeyannameKesinti.WritePdfToResponse("Beyanname Kesintileri Listesi");
                    break;
                default:
                    break;
            }
        }

        protected void ComboBoxListeTipi_SelectedIndexChanged(object sender, EventArgs e)
        {

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
            LabelBaslik.Text = "BEYANNAME KESİNTİLERİ LİSTESİ";
            PageHelper.SessionData = null;

            DateEditBaslangic.Date = new DateTime(DateTime.Now.Year, 01, 01);
            DateEditBitis.Date = DateTime.Now;
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

                GridViewBeyannameKesinti.DataSource = null;
                var sonuc = entity.BEYANs.Include("TUCCAR_SICIL")
                                         .Include("TT_BORSA_SUBE")
                                         .AsNoTracking()
                                         .ToList().Select(p => new
                    {
                        p.BeyanKey,
                        Sira = 0,
                        SicilNo = p.TUCCAR_SICIL.SicilNo,
                        Unvan = p.TUCCAR_SICIL.Unvan,
                        BeyanNo = p.BeyanNo,
                        Tarih = p.BeyanTarihi,
                        SubeKodu = p.TT_BORSA_SUBE.Kod,
                        SatOrgHUcret = p.SimsariyeMiktar,
                        TescilUcret = p.TescilMiktar,
                        StopajUcret = p.Stopaj,
                        FonPayiUcret = p.FonPayiBagkur,
                        MeraFonuUcret = p.MeraFonu,
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

                sonuc = sonuc.OrderBy(p => Convert.ToInt32(p.BeyanNo)).OrderBy(p => Convert.ToInt32(p.SubeKodu));

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
                                sonuc = sonuc.OrderBy(p => p.SicilNo);
                                break;
                            case "3":
                                sonuc = sonuc.OrderBy(p => p.Unvan);
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
                                sonuc = sonuc.OrderByDescending(p => p.SicilNo);
                                break;
                            case "3":
                                sonuc = sonuc.OrderByDescending(p => p.Unvan);
                                break;
                        }
                        break;
                }

                #endregion

                int counter = 1;
                var data = sonuc.Select(p => new
                {
                    p.BeyanKey,
                    Sira = counter++,
                    p.SicilNo,
                    p.Unvan,
                    p.BeyanNo,
                    p.Tarih,
                    p.SubeKodu,
                    p.SatOrgHUcret,
                    p.TescilUcret,
                    p.StopajUcret,
                    p.FonPayiUcret,
                    p.MeraFonuUcret,
                });

                GridViewBeyannameKesinti.DataSource = data;
                PageHelper.SessionData = GridViewBeyannameKesinti.DataSource;
                GridViewBeyannameKesinti.DataBind();
            }
        }

        #endregion
    }
}
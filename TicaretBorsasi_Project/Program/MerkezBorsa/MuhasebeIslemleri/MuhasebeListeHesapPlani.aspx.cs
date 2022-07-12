using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using TicaretBorsasi_Project.Class.Helper;
using TicaretBorsasi_Project.Data;
using TicaretBorsasi_Project.Class.Business;

namespace TicaretBorsasi_Project.Program.MerkezBorsa.MuhasebeIslemleri
{
    public partial class MuhasebeListeHesapPlani : Page
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
                GridViewHesapPlani.DataSource = PageHelper.SessionData;
                GridViewHesapPlani.DataBind();
            }
        }

        protected void ButtonRapor_Click(object sender, EventArgs e)
        {
            GridViewHesapPlani.DataSource = PageHelper.SessionData;
            GridViewHesapPlani.DataBind();

            switch (ComboBoxRapor.SelectedIndex)
            {
                case 0:
                    GridViewExporterHesapPlani.WriteXlsxToResponse("Hesap Planı");
                    break;
                case 1:
                    GridViewExporterHesapPlani.WritePdfToResponse("Hesap Planı");
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
            LabelBaslik.Text = "HESAP PLANI";
            PageHelper.SessionData = null;

            using (var entity = new DBEntities())
            {
                List<TT_MUHASEBE_TIP> listMUHASEBE_TIP = entity.TT_MUHASEBE_TIP.AsNoTracking().ToList();
                List<TT_HESAP_PLANI_DOKUM_TIP> listHESAP_PLANI_DOKUM_TIP = entity.TT_HESAP_PLANI_DOKUM_TIP.AsNoTracking().ToList();
                var yillar = new List<int>();
                for (int i = DateTime.Now.Year; i >= 1900; i--)
                {
                    yillar.Add(i);
                }

                ComboBoxMuhasebeTip.DataSource = listMUHASEBE_TIP;
                ComboBoxMuhasebeTip.DataBind();

                ComboBoxHesapPlaniDokumTipi.DataSource = listHESAP_PLANI_DOKUM_TIP;
                ComboBoxHesapPlaniDokumTipi.DataBind();
                ComboBoxHesapPlaniDokumTipi.SelectedIndex = 0;

                ComboBoxYil.DataSource = yillar;
                ComboBoxYil.DataBind();
                ComboBoxYil.SelectedIndex = 0;

                TextBoxHesapNoBaslangic.Text = "000";
                TextBoxHesapNoBitis.Text = "999_99_99999";
            }
        }

        private void Ara()
        {
            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                string pHesapNoBaslangic = TextBoxHesapNoBaslangic.Text.Replace("_", "").Replace(" ", "").Trim();
                string pHesapNoBitis = TextBoxHesapNoBitis.Text.Replace("_", "").Replace(" ", "").Trim();

                #region validation

                if (MuhasebeBS.MuhasebeHesapNoHatalimi(pHesapNoBaslangic) || MuhasebeBS.MuhasebeHesapNoHatalimi(pHesapNoBitis))
                {
                    PageHelper.MessageBox(this, "Hesap no giriş hatası!");
                    return;
                }

                #endregion

                int pMuhasebeTip = Convert.ToInt32(ComboBoxMuhasebeTip.SelectedItem.Value);
                short pYil = Convert.ToInt16(ComboBoxYil.SelectedItem.Text);               
                byte pDokumTipi = Convert.ToByte(ComboBoxHesapPlaniDokumTipi.SelectedItem.Value);

                var sonuc =
                    entity.HESAP_PLANI.AsNoTracking().ToList()
                          .Where(p =>
                                 p.MuhasebeTipKey == pMuhasebeTip &&
                                (p.Yil == null || p.Yil == pYil) &&
                                (p.HesapKodu.CompareTo(pHesapNoBaslangic) == 1 || p.HesapKodu.CompareTo(pHesapNoBaslangic) == 0) &&
                                (p.HesapKodu.CompareTo(pHesapNoBitis) == -1 || p.HesapKodu.CompareTo(pHesapNoBitis) == 0) &&
                                (pDokumTipi == 1 ? p.HesapKodu.Length > 0 : (pDokumTipi == 2 ? p.HesapKodu.Length == 3 : p.HesapKodu.Length == 5)))
                                .Select(p => new
                                {
                                    p.HesapPlaniKey,
                                    HesapKodu = MuhasebeBS.MuhasebeHesapNo(p.HesapKodu),
                                    p.HesapAdi
                                })
                                .ToList();

                #region sıralama

                switch (ComboBoxSiralaArtanAzalan.SelectedItem.Value.ToString())
                {
                    default:
                    case "1":
                        switch (ComboBoxSirala.SelectedItem.Value.ToString())
                        {
                            default:
                            case "1":
                                sonuc = sonuc.OrderBy(p => p.HesapKodu).ToList();
                                break;
                            case "2":
                                sonuc = sonuc.OrderBy(p => p.HesapAdi).ToList();
                                break;
                        }
                        break;
                    case "2":
                        switch (ComboBoxSirala.SelectedItem.Value.ToString())
                        {
                            default:
                            case "1":
                                sonuc = sonuc.OrderByDescending(p => p.HesapKodu).ToList();
                                break;
                            case "2":
                                sonuc = sonuc.OrderByDescending(p => p.HesapAdi).ToList();
                                break;
                        }
                        break;
                }

                #endregion

                GridViewHesapPlani.DataSource = sonuc;
                PageHelper.SessionData = GridViewHesapPlani.DataSource;
                GridViewHesapPlani.DataBind();
            }
        }

        #endregion
    }
}
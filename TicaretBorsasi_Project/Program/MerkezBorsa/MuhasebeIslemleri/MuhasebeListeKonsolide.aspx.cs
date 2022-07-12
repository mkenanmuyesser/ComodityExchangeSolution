using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using TicaretBorsasi_Project.Class.Business;
using TicaretBorsasi_Project.Class.Helper;
using TicaretBorsasi_Project.Data;

namespace TicaretBorsasi_Project.Program.MerkezBorsa.MuhasebeIslemleri
{
    public partial class MuhasebeListeKonsolide : Page
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
                GridViewKonsolide.DataSource = PageHelper.SessionData;
                GridViewKonsolide.DataBind();
            }
        }

        protected void ButtonRapor_Click(object sender, EventArgs e)
        {
            GridViewKonsolide.DataSource = PageHelper.SessionData;
            GridViewKonsolide.DataBind();

            switch (ComboBoxRapor.SelectedIndex)
            {
                case 0:
                    GridViewExporterKonsolide.WriteXlsxToResponse("Konsolide");
                    break;
                case 1:
                    GridViewExporterKonsolide.WritePdfToResponse("Konsolide");
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
            LabelBaslik.Text = "KONSOLİDE";
            PageHelper.SessionData = null;

            using (var entity = new DBEntities())
            {
                List<TT_MUHASEBE_TIP> listMUHASEBE_TIP = entity.TT_MUHASEBE_TIP.AsNoTracking().ToList();
                List<TT_HESAP_PLANI_DOKUM_TIP> listHESAP_PLANI_DOKUM_TIP = entity.TT_HESAP_PLANI_DOKUM_TIP.AsNoTracking().ToList();
                List<TT_KONSOLIDE_TIP> listKONSOLIDE_TIP = entity.TT_KONSOLIDE_TIP.AsNoTracking().ToList();
                var listAy = new List<string>();
                for (int i = 1; i <= 12; i++)
                {
                    listAy.Add(i.ToString());
                }

                ComboBoxMuhasebeTip.DataSource = listMUHASEBE_TIP;
                ComboBoxMuhasebeTip.DataBind();

                ComboBoxDokumTipi.DataSource = listHESAP_PLANI_DOKUM_TIP;
                ComboBoxDokumTipi.DataBind();
                ComboBoxDokumTipi.SelectedIndex = 0;

                ComboBoxKonsolideTipi.DataSource = listKONSOLIDE_TIP;
                ComboBoxKonsolideTipi.DataBind();
                ComboBoxKonsolideTipi.SelectedIndex = 0;

                ComboBoxAy.DataSource = listAy;
                ComboBoxAy.DataBind();
                ComboBoxAy.SelectedIndex = 0;

                DateEditAcilisMaddesiTarihi.Date = new DateTime(DateTime.Now.Year, 1, 1);
                TextBoxBaslangicNo.Text = "0001";

            }
        }

        private void Ara()
        {
            using (var entity = new DBEntities())
            {
                int pMuhasebeTip = Convert.ToInt32(ComboBoxMuhasebeTip.SelectedItem.Value);
                byte pDokumTipi = Convert.ToByte(ComboBoxDokumTipi.SelectedItem.Value);
                DateTime pAcilisMaddeTarihi = DateEditAcilisMaddesiTarihi.Date;
                string pBaslangicNo = TextBoxBaslangicNo.Text;
                int pAy = Convert.ToInt32(ComboBoxAy.SelectedItem.Value);
                byte pKonsolideTipi = Convert.ToByte(ComboBoxKonsolideTipi.SelectedItem.Value);

                #region validation

                #endregion

                var sonuc = entity.HESAP_PLANI.Include("YEVMIYEs").AsNoTracking()
                              .ToList()
                              .Where(
                                     p =>
                                     p.MuhasebeTipKey == pMuhasebeTip &&
                                    (pDokumTipi == 1 ? p.HesapKodu.Length == 10 : (pDokumTipi == 2 ? p.HesapKodu.Length == 3 : p.HesapKodu.Length == 5)))
                                    .Select(p => new
                                    {
                                        p.HesapPlaniKey,
                                        HesapKodu = MuhasebeBS.MuhasebeHesapNo(p.HesapKodu),
                                        p.HesapAdi,
                                        AySonuToplamGelir = 0,
                                        OdenekMiktari = 0,
                                        KalanOdenekMiktari = 0,
                                        Yuzde = 0
                                    }).ToList();

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

                GridViewKonsolide.DataSource = sonuc;
                PageHelper.SessionData = GridViewKonsolide.DataSource;
                GridViewKonsolide.DataBind();
            }
        }

        #endregion
    }
}
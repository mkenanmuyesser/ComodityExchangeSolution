using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using DevExpress.Web.ASPxGridView;
using TicaretBorsasi_Project.Class.Business;
using TicaretBorsasi_Project.Class.Helper;
using TicaretBorsasi_Project.Data;
using DevExpress.Web.ASPxEditors;

namespace TicaretBorsasi_Project.Program.MerkezBorsa.MuhasebeIslemleri
{
    public partial class MuhasebeListeBilanco : Page
    {
        #region Properties

        public object SessionDataAktif
        {
            get { return Session["SessionDataAktif"]; }
            set { Session["SessionDataAktif"] = value; }
        }

        public object SessionDataPasif
        {
            get { return Session["SessionDataPasif"]; }
            set { Session["SessionDataPasif"] = value; }
        }

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
                GridViewAraAktif.DataSource = SessionDataAktif;
                GridViewAraAktif.DataBind();

                GridViewAraPasif.DataSource = SessionDataPasif;
                GridViewAraPasif.DataBind();
            }
        }

        protected void ButtonRapor_Click(object sender, EventArgs e)
        {
            ASPxButton btn = sender as ASPxButton;
            switch (btn.ID)
            {
                case "ButtonRaporAktif":
                    GridViewAraAktif.DataSource = SessionDataAktif;
                    GridViewAraAktif.DataBind();

                    switch (ComboBoxRaporAktif.SelectedIndex)
                    {
                        case 0:
                            GridViewExporterAraAktif.WriteXlsxToResponse("Aktif Bilanço");
                            break;
                        case 1:
                            GridViewExporterAraAktif.WritePdfToResponse("Aktif Bilanço");
                            break;
                        default:
                            break;
                    }
                    break;
                case "ButtonRaporPasif":
                    GridViewAraPasif.DataSource = SessionDataPasif;
                    GridViewAraPasif.DataBind();

                    switch (ComboBoxRaporPasif.SelectedIndex)
                    {
                        case 0:
                            GridViewExporterAraPasif.WriteXlsxToResponse("Pasif Bilanço");
                            break;
                        case 1:
                            GridViewExporterAraPasif.WritePdfToResponse("Pasif Bilanço");
                            break;
                        default:
                            break;
                    }
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
            LabelBaslik.Text = "BİLANÇO";
            SessionDataAktif = null;
            SessionDataPasif = null;

            using (var entity = new DBEntities())
            {
                List<TT_MUHASEBE_TIP> listMUHASEBE_TIP = entity.TT_MUHASEBE_TIP.ToList();
                var yillar = new List<int>();
                for (int i = DateTime.Now.Year; i >= 1900; i--)
                {
                    yillar.Add(i);
                }

                ComboBoxMuhasebeTip.DataSource = listMUHASEBE_TIP;
                ComboBoxMuhasebeTip.DataBind();
                ComboBoxMuhasebeTip.SelectedIndex = 0;

                ComboBoxYil.DataSource = yillar;
                ComboBoxYil.DataBind();
                ComboBoxYil.SelectedIndex = 0;

                DateEditBaslangic.Date = new DateTime(DateTime.Now.Year, 01, 01);
                DateEditBitis.Date = new DateTime(DateTime.Now.Year, 12, 31);
            }
        }

        private void Ara()
        {
            using (var entity = new DBEntities())
            {
                int pMuhasebeTip = Convert.ToInt32(ComboBoxMuhasebeTip.SelectedItem.Value);
                short pYil = Convert.ToInt16(ComboBoxYil.SelectedItem.Text);
                DateTime pBaslangicTarih = DateEditBaslangic.Date;
                DateTime pBitisTarih = DateEditBitis.Date;

                #region validation

                #endregion

                var data = entity.YEVMIYEs.Include("HESAP_PLANI").AsNoTracking()
                .ToList()
                .Where(p =>
                 p.MuhasebeTipKey == pMuhasebeTip &&
                (p.HESAP_PLANI.Yil == null || p.HESAP_PLANI.Yil == pYil) &&
                (p.FisTarih >= pBaslangicTarih && p.FisTarih <= pBitisTarih))
                .Select(p => new
                {
                    HesapKodu = p.HESAP_PLANI.HesapKodu.Substring(0, 3),
                    p.Borc,
                    p.Alacak,
                })
                .GroupBy(p => new
                {
                    p.HesapKodu
                })
                .Select(p =>
                new
                {
                    p.Key.HesapKodu,
                    Tutar = p.Sum(x => x.Borc)
                }).Distinct()
                .Select(p =>
                new
                {
                    AnaHesapKodu = p.HesapKodu,
                    AnaHesapAdi = MuhasebeBS.AnaHesapDondur(entity, pMuhasebeTip, p.HesapKodu),
                    p.Tutar,
                }
                ).ToList();

                #region koşullar

                var sonucaktif = data;

                var sonucpasif = data;

                #endregion

                GridViewAraAktif.DataSource = sonucaktif;
                SessionDataAktif = GridViewAraAktif.DataSource;
                GridViewAraAktif.DataBind();

                GridViewAraPasif.DataSource = sonucpasif;
                SessionDataPasif = GridViewAraPasif.DataSource;
                GridViewAraPasif.DataBind();
            }
        }

        #endregion
    }
}
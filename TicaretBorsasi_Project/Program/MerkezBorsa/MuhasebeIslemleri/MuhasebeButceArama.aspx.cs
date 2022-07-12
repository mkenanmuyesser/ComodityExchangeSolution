using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using DevExpress.Web.ASPxClasses;
using DevExpress.Web.ASPxGridView;
using DevExpress.Web.Data;
using TicaretBorsasi_Project.Class.Helper;
using TicaretBorsasi_Project.Data;
using TicaretBorsasi_Project.Class.Business;

namespace TicaretBorsasi_Project.Program.MerkezBorsa.MuhasebeIslemleri
{
    public partial class MuhasebeButceArama : Page
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
                GridViewButce.DataSource = PageHelper.SessionData;
                GridViewButce.DataBind();
            }
        }

        protected void ButtonRapor_Click(object sender, EventArgs e)
        {
            GridViewButce.DataSource = PageHelper.SessionData;
            GridViewButce.DataBind();

            switch (ComboBoxRapor.SelectedIndex)
            {
                case 0:
                    GridViewExporterButce.WriteXlsxToResponse("Muhasebe Bütçe Listesi");
                    break;
                case 1:
                    GridViewExporterButce.WritePdfToResponse("Muhasebe Bütçe Listesi");
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
            Response.Redirect("MuhasebeButceArama.aspx");
        }

        protected void GridViewButce_RowDeleting(object sender, ASPxDataDeletingEventArgs e)
        {
            using (var entity = new DBEntities())
            {
                int deletedkey = Convert.ToInt32(e.Keys[0]);
                HESAP_PLANI deleteddata = entity.HESAP_PLANI.Single(p => p.HesapPlaniKey == deletedkey);
                deleteddata.Borc1_ = 0.00m;
                deleteddata.Borc2_ = 0.00m;

                try
                {
                    entity.SaveChanges();
                    GridViewButce.JSProperties["cpErrorMessage"] = false;
                }
                catch
                {
                    GridViewButce.JSProperties["cpErrorMessage"] = true;
                }
            }

            Ara();
            e.Cancel = true;
        }

        protected void GridViewButce_CustomButtonCallback(object sender, ASPxGridViewCustomButtonCallbackEventArgs e)
        {
            int index = e.VisibleIndex;
            int key = Convert.ToInt32(GridViewButce.GetRowValues(index, new[] { "HesapPlaniKey" }));
            ASPxWebControl.RedirectOnCallback(string.Format("MuhasebeButceKayit.aspx?Key={0}", key));
        }

        #endregion

        #region Methods

        private void SetInitials()
        {
            LabelBaslik.Text = "BÜTÇE HESAP PLANI";
            PageHelper.SessionData = null;

            using (var entity = new DBEntities())
            {
                List<TT_MUHASEBE_TIP> listMUHASEBE_TIP = entity.TT_MUHASEBE_TIP.AsNoTracking().ToList();
                var yillar = new List<int>();
                for (int i = DateTime.Now.Year; i >= 1900; i--)
                {
                    yillar.Add(i);
                }

                ComboBoxMuhasebeTip.DataSource = listMUHASEBE_TIP;
                ComboBoxMuhasebeTip.DataBind();

                ComboBoxYil.DataSource = yillar;
                ComboBoxYil.DataBind();
                ComboBoxYil.SelectedIndex = 0;
            }
        }

        private void Ara()
        {
            using (var entity = new DBEntities())
            {

                #region validation

                #endregion

                Int16 pYil = Convert.ToInt16(ComboBoxYil.SelectedItem.Value);
                int pMuhesebeTipKey = Convert.ToInt32(ComboBoxMuhasebeTip.SelectedItem.Value);

                var sonuc =
                               entity.HESAP_PLANI.AsNoTracking()
                               .ToList()
                               .Where(p =>
                                        p.Borc1_ != 0.00m &&
                                       (p.Yil == null || p.Yil == pYil) &&
                                       p.MuhasebeTipKey == pMuhesebeTipKey)
                               .Select(p => new
                                   {
                                       p.HesapPlaniKey,
                                       p.Borc1_,
                                       p.Borc2_,
                                       HesapNo = MuhasebeBS.MuhasebeHesapNo(p.HesapKodu),
                                       p.HesapAdi,
                                       Durum = p.Borc1_ == 0.01m ? "B" : "A",
                                       ButceMiktari = p.Borc2_
                                   })
                          .ToList();

                GridViewButce.DataSource = sonuc;
                PageHelper.SessionData = GridViewButce.DataSource;
                GridViewButce.DataBind();

                LabelGelirButcesi.Text = sonuc.Where(p => p.Borc1_ == 0.01m).Sum(p => p.ButceMiktari).ToString("N");
                LabelGiderButcesi.Text = sonuc.Where(p => p.Borc1_ == 0.02m).Sum(p => p.ButceMiktari).ToString("N");                
            }
        }

        #endregion

    }
}
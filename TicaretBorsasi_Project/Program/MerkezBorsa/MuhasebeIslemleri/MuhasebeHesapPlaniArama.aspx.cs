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
    public partial class MuhasebeHesapPlaniArama : Page
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
            Response.Redirect("MuhasebeHesapPlaniArama.aspx");
        }

        protected void GridViewHesapPlani_RowDeleting(object sender, ASPxDataDeletingEventArgs e)
        {
            using (var entity = new DBEntities())
            {
                int deletedkey = Convert.ToInt32(e.Keys[0]);
                HESAP_PLANI deleteddata = entity.HESAP_PLANI.Single(p => p.HesapPlaniKey == deletedkey);
                entity.HESAP_PLANI.Remove(deleteddata);

                try
                {
                    entity.SaveChanges();
                    GridViewHesapPlani.JSProperties["cpErrorMessage"] = false;
                }
                catch
                {
                    GridViewHesapPlani.JSProperties["cpErrorMessage"] = true;
                }
            }

            Ara();
            e.Cancel = true;
        }

        protected void GridViewHesapPlani_CustomButtonCallback(object sender, ASPxGridViewCustomButtonCallbackEventArgs e)
        {
            int index = e.VisibleIndex;
            int key = Convert.ToInt32(GridViewHesapPlani.GetRowValues(index, new[] { "HesapPlaniKey" }));
            ASPxWebControl.RedirectOnCallback(string.Format("MuhasebeHesapPlaniKayit.aspx?Key={0}", key));
        }

        #endregion

        #region Methods

        private void SetInitials()
        {
            LabelBaslik.Text = "HESAP PLANI";
            PageHelper.SessionData = null;

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
                int pMuhasebeTip = Convert.ToInt32(ComboBoxMuhasebeTip.SelectedItem.Value);
                short pYil = Convert.ToInt16(ComboBoxYil.SelectedItem.Text);
                string pHesapNoBaslangic = TextBoxHesapNoBaslangic.Text.Replace("_", "").Replace(" ", "").Trim();
                string pHesapNoBitis = TextBoxHesapNoBitis.Text.Replace("_", "").Replace(" ", "").Trim();

                #region validation

                if (MuhasebeBS.MuhasebeHesapNoHatalimi(pHesapNoBaslangic) || MuhasebeBS.MuhasebeHesapNoHatalimi(pHesapNoBitis))
                {
                    PageHelper.MessageBox(this, "Hesap no giriş hatası!");
                    return;
                }

                #endregion

                List<HESAP_PLANI> sonuc =
                               entity.HESAP_PLANI.AsNoTracking()
                               .ToList()
                               .Where(
                                      p =>
                                      p.MuhasebeTipKey == pMuhasebeTip &&
                                     (p.Yil == null || p.Yil == pYil) &&
                                     (p.HesapKodu.CompareTo(pHesapNoBaslangic) == 1 || p.HesapKodu.CompareTo(pHesapNoBaslangic) == 0) &&
                                     (p.HesapKodu.CompareTo(pHesapNoBitis) == -1 || p.HesapKodu.CompareTo(pHesapNoBitis) == 0))
                                     .ToList();

                GridViewHesapPlani.DataSource = sonuc;
                PageHelper.SessionData = GridViewHesapPlani.DataSource;
                GridViewHesapPlani.DataBind();
            }
        }

        #endregion
    }
}
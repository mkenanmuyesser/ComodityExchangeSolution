using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using DevExpress.Web.ASPxClasses;
using DevExpress.Web.ASPxGridView;
using DevExpress.Web.Data;
using TicaretBorsasi_Project.Class.Helper;
using TicaretBorsasi_Project.Data;

namespace TicaretBorsasi_Project.Program.MerkezBorsa.MuhasebeIslemleri
{
    public partial class MuhasebeBankaMevduatArama : Page
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
                GridViewAra.DataSource = PageHelper.SessionData;
                GridViewAra.DataBind();
            }
        }

        protected void ButtonRapor_Click(object sender, EventArgs e)
        {
            GridViewAra.DataSource = PageHelper.SessionData;
            GridViewAra.DataBind();

            switch (ComboBoxRapor.SelectedIndex)
            {
                case 0:
                    GridViewExporterAra.WriteXlsxToResponse("Banka Mevduat Listesi");
                    break;
                case 1:
                    GridViewExporterAra.WritePdfToResponse("Banka Mevduat Listesi");
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
            Response.Redirect("MuhasebeBankaMevduatArama.aspx");
        }

        protected void GridViewAra_RowDeleting(object sender, ASPxDataDeletingEventArgs e)
        {
            using (var entity = new DBEntities())
            {
                int deletedkey = Convert.ToInt32(e.Keys[0]);
                BANKA_MEVDUAT deleteddata = entity.BANKA_MEVDUAT.Single(p => p.BankaMevduatKey == deletedkey);
                entity.BANKA_MEVDUAT.Remove(deleteddata);

                try
                {
                    entity.SaveChanges();
                    GridViewAra.JSProperties["cpErrorMessage"] = false;
                }
                catch
                {
                    GridViewAra.JSProperties["cpErrorMessage"] = true;
                }
            }

            Ara();
            e.Cancel = true;
        }

        protected void GridViewAra_CustomButtonCallback(object sender, ASPxGridViewCustomButtonCallbackEventArgs e)
        {
            int index = e.VisibleIndex;
            int key = Convert.ToInt32(GridViewAra.GetRowValues(index, new[] { "BankaMevduatKey" }));
            ASPxWebControl.RedirectOnCallback(string.Format("MuhasebeBankaMevduatKayit.aspx?Key={0}", key));
        }

        #endregion

        #region Methods

        private void SetInitials()
        {
            LabelBaslik.Text = "BANKA MEVDUAT ARAMA";
            PageHelper.SessionData = null;
        }

        private void Ara()
        {
            using (var entity = new DBEntities())
            {

                #region validation

                #endregion

                string pBankaHesapNo = TextBoxBankaHesapNo.Text.ToLower();
                string pBankaAdi = TextBoxBankaAdi.Text.ToLower();

                var sonuc = entity.BANKA_MEVDUAT.AsNoTracking().ToList();

                #region koşullar

                if (!string.IsNullOrEmpty(pBankaHesapNo))
                {
                    sonuc = sonuc.Where(p => p.BankaHesapNo.ToLower().Contains(pBankaHesapNo)).ToList();
                }

                if (!string.IsNullOrEmpty(pBankaAdi))
                {
                    sonuc = sonuc.Where(p => p.BankaAdi.ToLower().Contains(pBankaAdi)).ToList();
                }

                #endregion

                GridViewAra.DataSource = sonuc;
                PageHelper.SessionData = GridViewAra.DataSource;
                GridViewAra.DataBind();
            }
        }

        #endregion

    }
}
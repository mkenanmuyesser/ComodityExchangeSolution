using System;
using System.Data.SqlClient;
using System.Linq;
using System.Web.UI;
using TicaretBorsasi_Project.Class.CustomType;
using TicaretBorsasi_Project.Class.CustomType.MerkezBorsa;
using TicaretBorsasi_Project.Class.Helper;
using TicaretBorsasi_Project.Class.Query;
using TicaretBorsasi_Project.Data;

namespace TicaretBorsasi_Project.Program.MerkezBorsa.BeyannameTescilIslemleri
{
    public partial class BeyannameTescilGelirleri : Page
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
                GridViewTescilGelir.DataSource = PageHelper.SessionData;
                GridViewTescilGelir.DataBind();
            }
        }

        protected void ButtonRapor_Click(object sender, EventArgs e)
        {
            GridViewTescilGelir.DataSource = PageHelper.SessionData;
            GridViewTescilGelir.DataBind();

            switch (ComboBoxRapor.SelectedIndex)
            {
                case 0:
                    GridViewExporterTescilGelir.WriteXlsxToResponse("Beyanname Tescil Gelirleri");
                    break;
                case 1:
                    GridViewExporterTescilGelir.WritePdfToResponse("Beyanname Tescil Gelirleri");
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
            LabelBaslik.Text = "BEYANNAME TESCİL VE SAT. ORG. H. GELİRLERİ";
            PageHelper.SessionData = null;

            DateEditBaslangic.Date = new DateTime(DateTime.Now.Year, 01, 01);
            DateEditBitis.Date = DateTime.Now;
        }

        private void Ara()
        {
            using (var entity = new DBEntities())
            {

                #region koşullar

                var pBaslangic = new SqlParameter("Baslangic", DateEditBaslangic.Date);
                var pBitis = new SqlParameter("Bitis",DateEditBitis.Date);

                var parameters = new object[]
                    {
                        pBaslangic,
                        pBitis,
                    };

                #endregion

                GridViewTescilGelir.DataSource = null;
                var sonuc = entity.Database.SqlQuery(typeof(BeyannameTescilType), BeyannameTescilQuery.BeyannameTescilListeQuery, parameters).Cast<BeyannameTescilType>().ToList();              

                GridViewTescilGelir.DataSource = sonuc;
                PageHelper.SessionData = GridViewTescilGelir.DataSource;
                GridViewTescilGelir.DataBind();
            }
        }

        #endregion
    }
}
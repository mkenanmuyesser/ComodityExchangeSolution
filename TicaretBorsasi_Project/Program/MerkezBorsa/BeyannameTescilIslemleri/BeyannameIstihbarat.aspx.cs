using System;
using System.Collections.Generic;
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
    public partial class BeyannameIstihbarat : Page
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
                GridViewIstihbarat.DataSource = PageHelper.SessionData;
                GridViewIstihbarat.DataBind();
            }
        }

        protected void ButtonRapor_Click(object sender, EventArgs e)
        {
            GridViewIstihbarat.DataSource = PageHelper.SessionData;
            GridViewIstihbarat.DataBind();

            switch (ComboBoxRapor.SelectedIndex)
            {
                case 0:
                    GridViewExporterIstihbarat.WriteXlsxToResponse("İstihbarat Listeleri");
                    break;
                case 1:
                    GridViewExporterIstihbarat.WritePdfToResponse("İstihbarat Listeleri");
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
            LabelBaslik.Text = "İSTİHBARAT LİSTELERİ";
            PageHelper.SessionData = null;

            DateEditBaslangic.Date = new DateTime(DateTime.Now.Year, 01, 01);
            DateEditBitis.Date = DateTime.Now;
        }

        private void Ara()
        {
            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                DateTime pBaslangic = DateEditBaslangic.Date;
                DateTime pBitis = DateEditBitis.Date;
                int pSicilNoBaslangic = string.IsNullOrEmpty(SpinEditSicilNoBaslangic.Text.Trim())
                                            ? 0
                                            : Convert.ToInt32(SpinEditSicilNoBaslangic.Text.Trim());
                int pSicilNoBitis = string.IsNullOrEmpty(SpinEditSicilNoBitis.Text.Trim())
                                        ? 999999
                                        : Convert.ToInt32(SpinEditSicilNoBitis.Text.Trim());
                int pSubeKodBaslangic = string.IsNullOrEmpty(SpinEditBaslangicSubeKodu.Text.Trim())
                                            ? 0
                                            : Convert.ToInt32(SpinEditBaslangicSubeKodu.Text.Trim());
                int pSubeKodBitis = string.IsNullOrEmpty(SpinEditBitisSubeKodu.Text.Trim())
                                        ? 99
                                        : Convert.ToInt32(SpinEditBitisSubeKodu.Text.Trim());
                int pMaddeKodBaslangic = string.IsNullOrEmpty(SpinEditBaslangicMaddeKodu.Text.Trim())
                                             ? 0
                                             : Convert.ToInt32(SpinEditBaslangicMaddeKodu.Text.Trim());
                int pMaddeKodBitis = string.IsNullOrEmpty(SpinEditBitisMaddeKodu.Text.Trim())
                                         ? 999999
                                         : Convert.ToInt32(SpinEditBitisMaddeKodu.Text.Trim());

                #region koşullar

                var pBaslangicParam = new SqlParameter("Baslangic", pBaslangic);
                var pBitisParam = new SqlParameter("Bitis", pBitis);
                var pSicilNoBaslangicParam = new SqlParameter("SicilNoBaslangic", pSicilNoBaslangic);
                var pSicilNoBitisParam = new SqlParameter("SicilNoBitis", pSicilNoBitis);
                var pSubeKodBaslangicParam = new SqlParameter("SubeKodBaslangic", pSubeKodBaslangic);
                var pSubeKodBitisParam = new SqlParameter("SubeKodBitis", pSubeKodBitis);
                var pMaddeKodBaslangicParam = new SqlParameter("MaddeKodBaslangic", pMaddeKodBaslangic);
                var pMaddeKodBitisParam = new SqlParameter("MaddeKodBitis", pMaddeKodBitis);
                var parameters = new object[]
                    {
                        pBaslangicParam, pBitisParam, pSicilNoBaslangicParam, pSicilNoBitisParam, pSubeKodBaslangicParam,
                        pSubeKodBitisParam, pMaddeKodBaslangicParam, pMaddeKodBitisParam
                    };

                #endregion

                List<BeyannameIstihbaratType> sonuc = entity.Database.SqlQuery(typeof(BeyannameIstihbaratType), BeyannameIstihbaratQuery.BeyannameIstihbaratListeQuery, parameters).Cast<BeyannameIstihbaratType>().ToList();

                GridViewIstihbarat.DataSource = null;
                GridViewIstihbarat.DataSource = sonuc;
                PageHelper.SessionData = GridViewIstihbarat.DataSource;
                GridViewIstihbarat.DataBind();

                GridViewIstihbarat.GroupBy(GridViewIstihbarat.Columns["Unvan"]);
                GridViewIstihbarat.ExpandAll();
            }
        }

        #endregion
    }
}
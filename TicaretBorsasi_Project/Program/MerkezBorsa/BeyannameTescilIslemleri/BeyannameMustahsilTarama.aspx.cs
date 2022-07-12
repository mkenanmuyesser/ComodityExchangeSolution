using DevExpress.Web.ASPxGridView;
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
    public partial class BeyannameMustahsilTarama : Page
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
                GridViewMustahsilTarama.DataSource = PageHelper.SessionData;
                GridViewMustahsilTarama.DataBind();
            }
        }

        protected void ButtonRapor_Click(object sender, EventArgs e)
        {
            GridViewMustahsilTarama.DataSource = PageHelper.SessionData;
            GridViewMustahsilTarama.DataBind();

            switch (ComboBoxRapor.SelectedIndex)
            {
                case 0:
                    GridViewExporterMustahsilTarama.WriteXlsxToResponse("Müstahsil Tarama");
                    break;
                case 1:
                    GridViewExporterMustahsilTarama.WritePdfToResponse("Müstahsil Tarama");
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
            LabelBaslik.Text = "MÜSTAHSİL TARAMA";
            PageHelper.SessionData = null;

            DateEditBaslangic.Date = new DateTime(DateTime.Now.Year, 01, 01);
            DateEditBitis.Date = DateTime.Now;
        }

        private void Ara()
        {
            using (var entity = new DBEntities())
            {

                #region koşullar

                var pUnvan = new SqlParameter("Unvan", MemoUnvan.Text.Trim());
                var PBeyanTip = new SqlParameter("BeyanTip", DBNull.Value);
                var pBaslangic = new SqlParameter("BaslangicTarihi", DateEditBaslangic.Date);
                var pBitis = new SqlParameter("BitisTarihi", DateEditBitis.Date);
                var pSubeKodBaslangic = new SqlParameter("BaslangicSubeKodu", string.IsNullOrEmpty(SpinEditBaslangicSubeKodu.Text.Trim()) ? DBNull.Value : (object)SpinEditBaslangicSubeKodu.Text.Trim());
                var pSubeKodBitis = new SqlParameter("BitisSubeKodu", string.IsNullOrEmpty(SpinEditBitisSubeKodu.Text.Trim()) ? DBNull.Value : (object)SpinEditBitisSubeKodu.Text.Trim());
                var pFaturaNoGirilmisKayit = new SqlParameter("FaturaNoGirilmisKayit", !CheckBoxFaturaNo.Checked);

                var parameters = new object[]
                    {
                        pUnvan,
                        PBeyanTip,
                        pBaslangic,
                        pBitis,
                        pSubeKodBaslangic,
                        pSubeKodBitis,
                        pFaturaNoGirilmisKayit
                    };

                #endregion

                GridViewMustahsilTarama.DataSource = null;
                var sonuc = entity.Database.SqlQuery(typeof(MustahsilTaramaType), MustahsilTaramaQuery.MustahsilTaramaListeQuery, parameters).Cast<MustahsilTaramaType>().ToList();

                #region gruplama

                foreach (GridViewDataColumn item in GridViewMustahsilTarama.GetGroupedColumns())
                {
                    GridViewMustahsilTarama.UnGroup(item);
                }

                GridViewMustahsilTarama.GroupBy(GridViewMustahsilTarama.Columns["Unvan"]);              

                #endregion

                GridViewMustahsilTarama.DataSource = sonuc;
                PageHelper.SessionData = GridViewMustahsilTarama.DataSource;
                GridViewMustahsilTarama.DataBind();

                GridViewMustahsilTarama.ExpandAll();

            }
        }

        #endregion
    }
}
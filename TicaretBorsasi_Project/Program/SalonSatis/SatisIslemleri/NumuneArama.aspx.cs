using System;
using System.Globalization;
using System.Linq;
using System.Web.UI;
using DevExpress.Web.ASPxClasses;
using DevExpress.Web.ASPxGridView;
using DevExpress.Web.Data;
using TicaretBorsasi_Project.Class.Helper;
using TicaretBorsasi_Project.Data;

namespace TicaretBorsasi_Project.Program.SalonSatis.SatisIslemleri
{
    public partial class NumuneArama : Page
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
                GridViewNumune.DataSource = PageHelper.SessionData;
                GridViewNumune.DataBind();
            }
        }

        protected void ButtonRapor_Click(object sender, EventArgs e)
        {
            GridViewNumune.DataSource = PageHelper.SessionData;
            GridViewNumune.DataBind();

            switch (ComboBoxRapor.SelectedIndex)
            {
                case 0:
                    GridViewExporterNumune.WriteXlsxToResponse("Numune Bilgileri");
                    break;
                case 1:
                    GridViewExporterNumune.WritePdfToResponse("Numune Bilgileri");
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

        protected void GridViewNumune_RowDeleting(object sender, ASPxDataDeletingEventArgs e)
        {
            using (var entity = new DBEntities())
            {
                int deletedkey = Convert.ToInt32(e.Keys[0]);
                TUCCAR_DEPO deleteddata = entity.TUCCAR_DEPO.Single(p => p.TuccarDepoKey == deletedkey);
                entity.TUCCAR_DEPO.Remove(deleteddata);

                try
                {
                    entity.SaveChanges();
                    GridViewNumune.JSProperties["cpErrorMessage"] = false;
                }
                catch
                {
                    GridViewNumune.JSProperties["cpErrorMessage"] = true;
                }
            }

            Ara();
            e.Cancel = true;
        }

        protected void GridViewNumune_CustomButtonCallback(object sender, ASPxGridViewCustomButtonCallbackEventArgs e)
        {
            int index = e.VisibleIndex;
            int key = Convert.ToInt32(GridViewNumune.GetRowValues(index, new[] {"TuccarDepoKey"}));
            ASPxWebControl.RedirectOnCallback(string.Format("NumuneKayit.aspx?Key={0}", key));
        }

        #endregion

        #region Methods

        private void SetInitials()
        {
            LabelBaslik.Text = "NUMUNE ARAMA İŞLEMLERİ";
            PageHelper.SessionData = null;
        }

        private void Ara()
        {
            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                //string pSicilNo = SpinEditSicilNo.Text.Trim();
                //string pUnvan = TextBoxUnvan.Text.Trim().ToLower(CultureInfo.CurrentCulture);               

                GridViewNumune.DataSource = null;
                var sonuc = entity.TUCCAR_DEPO.Include("TUCCAR_SICIL").Include("TT_MADDE_KOD").AsNoTracking().ToList().Select(p => new
                    {
                        p.TuccarDepoKey,
                        p.TuccarSicilKey,
                        p.MaddeKodKey,
                        SicilNo = p.TUCCAR_SICIL == null ? null : p.TUCCAR_SICIL.SicilNo,
                        Unvan = p.TUCCAR_SICIL == null ? null : p.TUCCAR_SICIL.Unvan,
                        MaddeKoduAdi = p.TT_MADDE_KOD == null ? null : p.TT_MADDE_KOD.Adi,
                        p.Devir1,
                        p.Alis1,
                        p.Satis1,
                        p.DigerBorsaAlis1,
                        p.DigerBorsaSatis1,
                        p.Devir2,
                        p.Alis2,
                        p.Satis2,
                        p.DigerBorsaAlis2,
                        p.DigerBorsaSatis2
                    });

                //#region koşullar

                //if (!string.IsNullOrEmpty(pSicilNo))
                //{
                //    int baslangic;
                //    if (!int.TryParse(pSicilNo, out baslangic))
                //    {
                //        PageHelper.MessageBox(this, "Sicil numara girişi hatalıdır!");
                //        return;
                //    }

                //    for (int i = pSicilNo.Length; i < 6; i++)
                //    {
                //        pSicilNo = "0" + pSicilNo;
                //    }
                //    sonuc = sonuc.Where(p => p.SicilNo == pSicilNo);
                //}

                //if (!string.IsNullOrEmpty(pUnvan))
                //{
                //    sonuc = sonuc.Where(p => p.Unvan.ToLower(CultureInfo.CurrentCulture).Contains(pUnvan));
                //}              

                //#endregion              

                GridViewNumune.DataSource = sonuc;
                PageHelper.SessionData = GridViewNumune.DataSource;
                GridViewNumune.DataBind();
            }
        }

        #endregion
    }
}
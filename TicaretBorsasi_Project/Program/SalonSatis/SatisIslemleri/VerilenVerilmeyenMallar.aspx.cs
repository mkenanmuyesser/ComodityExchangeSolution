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
    public partial class VerilenVerilmeyenMallar : Page
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
                GridViewVerilenVerilmeyenMallar.DataSource = PageHelper.SessionData;
                GridViewVerilenVerilmeyenMallar.DataBind();
            }
        }

        protected void ButtonRapor_Click(object sender, EventArgs e)
        {
            GridViewVerilenVerilmeyenMallar.DataSource = PageHelper.SessionData;
            GridViewVerilenVerilmeyenMallar.DataBind();

            switch (ComboBoxRapor.SelectedIndex)
            {
                case 0:
                    GridViewExporterVerilenVerilmeyenMallar.WriteXlsxToResponse("Verilen/Verilmeyen Mallar Bilgileri");
                    break;
                case 1:
                    GridViewExporterVerilenVerilmeyenMallar.WritePdfToResponse("Verilen/Verilmeyen Mallar Bilgileri");
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

        protected void GridViewVerilenVerilmeyenMallar_CustomButtonCallback(object sender, ASPxGridViewCustomButtonCallbackEventArgs e)
        {
            int index = e.VisibleIndex;
            int key = Convert.ToInt32(GridViewVerilenVerilmeyenMallar.GetRowValues(index, new[] { "TuccarDepoKey" })); 

            switch (e.ButtonID)
            {
                case "ImageButtonKabul":
                default:

                    break;
                case "ImageButtonRed":

                    break;
            }
                    
            //ASPxWebControl.RedirectOnCallback(string.Format("TSELabParametreKayit.aspx?Key={0}", key));
        }

        protected void GridViewVerilenVerilmeyenMallar_DataBinding(object sender, EventArgs e)
        {

        }

        #endregion

        #region Methods

        private void SetInitials()
        {
            LabelBaslik.Text = "VERİLEN/VERİLMEYEN MALLAR";
            PageHelper.SessionData = null;

            DateEditTarih.Date = DateTime.Now.Date;
        }

        private void Ara()
        {
            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                //string pSicilNo = SpinEditSicilNo.Text.Trim();
                //string pUnvan = TextBoxUnvan.Text.Trim().ToLower(CultureInfo.CurrentCulture);               

                GridViewVerilenVerilmeyenMallar.DataSource = null;
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

                GridViewVerilenVerilmeyenMallar.DataSource = sonuc;
                PageHelper.SessionData = GridViewVerilenVerilmeyenMallar.DataSource;
                GridViewVerilenVerilmeyenMallar.DataBind();
            }
        }

        #endregion
   
    }
}
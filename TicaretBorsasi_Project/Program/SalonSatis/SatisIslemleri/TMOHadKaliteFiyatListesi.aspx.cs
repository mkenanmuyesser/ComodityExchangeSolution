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
    public partial class TMOHadKaliteFiyatListesi : Page
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
                GridViewTMOHadKaliteFiyatListesi.DataSource = PageHelper.SessionData;
                GridViewTMOHadKaliteFiyatListesi.DataBind();
            }
        }

        protected void ButtonRapor_Click(object sender, EventArgs e)
        {
            GridViewTMOHadKaliteFiyatListesi.DataSource = PageHelper.SessionData;
            GridViewTMOHadKaliteFiyatListesi.DataBind();

            switch (ComboBoxRapor.SelectedIndex)
            {
                case 0:
                    GridViewExporterTMOHadKaliteFiyatListesi.WriteXlsxToResponse("TMO Had, Kalite ve Fiyat Listesi");
                    break;
                case 1:
                    GridViewExporterTMOHadKaliteFiyatListesi.WritePdfToResponse("TMO Had, Kalite ve Fiyat Listesi");
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
            LabelBaslik.Text = "TMO HAD, KALİTE ve FİYAT LİSTESİ";
            PageHelper.SessionData = null;

            DateEditAnalizTarihi.Date = DateTime.Now.Date;
        }

        private void Ara()
        {
            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                //string pSicilNo = SpinEditSicilNo.Text.Trim();
                //string pUnvan = TextBoxUnvan.Text.Trim().ToLower(CultureInfo.CurrentCulture);               

                GridViewTMOHadKaliteFiyatListesi.DataSource = null;
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

                GridViewTMOHadKaliteFiyatListesi.DataSource = sonuc;
                PageHelper.SessionData = GridViewTMOHadKaliteFiyatListesi.DataSource;
                GridViewTMOHadKaliteFiyatListesi.DataBind();
            }
        }

        #endregion

    }
}
using DevExpress.Web.ASPxClasses;
using DevExpress.Web.ASPxGridView;
using System;
using System.Linq;
using TicaretBorsasi_Project.Class.Helper;
using TicaretBorsasi_Project.Data;

namespace TicaretBorsasi_Project.Program.SalonSatis.SatisIslemleri
{
    public partial class SatisEkrani : System.Web.UI.Page
    {
        #region properties

        #endregion

        #region events

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                SetInitials();
            }
            else
            {
                GridViewSatis.DataSource = PageHelper.SessionData;
                GridViewSatis.DataBind();
            }           
        }

        protected void ComboBoxListe_SelectedIndexChanged(object sender, EventArgs e)
        {
            Ara();
        }

        protected void DateEditSatisTarih_DateChanged(object sender, EventArgs e)
        {
            Ara();
        }

        protected void GridViewSatis_DataBound(object sender, EventArgs e)
        {

        }

        protected void GridViewSatis_CustomButtonCallback(object sender, ASPxGridViewCustomButtonCallbackEventArgs e)
        {
            int index = e.VisibleIndex;
            int key = Convert.ToInt32(GridViewSatis.GetRowValues(index, new[] { "SatisKey" }));
            ASPxWebControl.RedirectOnCallback(string.Format("Satis.aspx?Key={0}", key));
        }


        #endregion

        #region methods

        private void SetInitials()
        {
            using (var entity = new DBEntities())
            {
                BORSA_BILGI data = entity.BORSA_BILGI.SingleOrDefault();

                //if (data != null)
                //{
                //    BinaryImageLogo1.Value = data.ProgramLogo;
                //    BinaryImageLogo2.Value = data.ProgramLogo;
                //}
            }

            //DateEditSatisTarih.Date = DateTime.Now.Date;
            Ara();

            //if (Key == 0)
            //{
            //    buttonSatisaBasla.Disabled = true;
            //    buttonSatisiKapat.Disabled = true;
            //}
            //else
            //{
            //    buttonSatisaBasla.Disabled = false;
            //    buttonSatisiKapat.Disabled = true;

            //    DataLoad();
            //}
        }

        private void Ara()
        {
            using (var entity = new DBEntities())
            {
                int pListeTip = Convert.ToInt32(ComboBoxListe.SelectedItem.Value);
                //DateTime pTarih = DateEditSatisTarih.Date;

                entity.Configuration.AutoDetectChangesEnabled = false;

                GridViewSatis.DataSource = null;
                var sonuc = entity.SATIS.
                                   AsNoTracking().
                                   Include("URUN").
                                   Include("TEKLIFs").
                                   Where(p => pListeTip == 0 || (pListeTip == 1 && p.AktifMi) || (pListeTip == 2 && !p.AktifMi)).
                    //Where(p=>p.Tarih==pSatisTarih).
                                   ToList().
                                   Select(p => new
                                   {
                                       p.SatisKey,
                                       p.UrunKey,
                                       p.URUN.UrunAdi,
                                       p.BaslangicFiyati,
                                       p.BitisFiyati,
                                       p.AktifMi,
                                   });


                GridViewSatis.DataSource = sonuc;
                PageHelper.SessionData = GridViewSatis.DataSource;
                GridViewSatis.DataBind();

                GridViewSatis.ExpandAll();
            }
        }

        #endregion
    }
}
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
    public partial class MuhasebeListeFisListeleri : Page
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
                GridViewFis.DataSource = PageHelper.SessionData;
                GridViewFis.DataBind();
            }
        }

        protected void ButtonRapor_Click(object sender, EventArgs e)
        {
            GridViewFis.DataSource = PageHelper.SessionData;
            GridViewFis.DataBind();

            switch (ComboBoxRapor.SelectedIndex)
            {
                case 0:
                    GridViewExporterFis.WriteXlsxToResponse("Fiş Listeleri");
                    break;
                case 1:
                    GridViewExporterFis.WritePdfToResponse("Fiş Listeleri");
                    break;
                default:
                    break;
            }
        }

        protected void ButtonFisBas_Click(object sender, EventArgs e)
        {
            List<int> fisliste = new List<int>();
            foreach (var deger in GridViewFis.GetSelectedFieldValues("YevmiyeKey"))
            {
                fisliste.Add(Convert.ToInt32(deger));
            }
            //bundan sonra parametrelerle ne yapılacaksa devam edilecek.
            string keyler="";
            fisliste.ForEach(p => keyler += "," + p.ToString());
            keyler = keyler.Length == 0 ? keyler : keyler.Remove(0, 1);
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
            LabelBaslik.Text = "FİŞ LİSTELERİ";
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
                ComboBoxMuhasebeTip.SelectedIndex = 0;

                ComboBoxYil.DataSource = yillar;
                ComboBoxYil.DataBind();
                ComboBoxYil.SelectedIndex = 0;

                DateEditBaslangic.Date = new DateTime(DateTime.Now.Year, 01, 01);
                DateEditBitis.Date = new DateTime(DateTime.Now.Year, 12, 31);
            }
        }

        private void Ara()
        {
            using (var entity = new DBEntities())
            {

                int pMuhasebeTip = Convert.ToInt32(ComboBoxMuhasebeTip.SelectedItem.Value);
                short pYil = Convert.ToInt16(ComboBoxYil.SelectedItem.Text);
                DateTime pBaslangicTarih = DateEditBaslangic.Date;
                DateTime pBitisTarih = DateEditBitis.Date;

                #region validation



                #endregion

                var sonuc =
                               entity.YEVMIYEs.Include("HESAP_PLANI").Include("TT_FIS_TIP").AsNoTracking()
                               .ToList()
                               .Where(p =>
                                        p.MuhasebeTipKey == pMuhasebeTip &&
                                       (p.HESAP_PLANI.Yil == null || p.HESAP_PLANI.Yil == pYil) &&
                                       (p.FisTarih >= pBaslangicTarih && p.FisTarih <= pBitisTarih))
                               .Select(p => new
                                       {
                                           p.YevmiyeKey,
                                           p.FisTarih,
                                           FisTip = p.TT_FIS_TIP.FisTipAdi,
                                           p.FisNo
                                       })
                                      .ToList();

                GridViewFis.DataSource = sonuc;
                PageHelper.SessionData = GridViewFis.DataSource;
                GridViewFis.DataBind();
            }
        }

        #endregion


    }
}
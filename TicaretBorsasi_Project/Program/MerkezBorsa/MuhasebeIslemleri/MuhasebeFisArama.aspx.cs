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
    public partial class MuhasebeFisArama : Page
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
                    GridViewExporterFis.WriteXlsxToResponse("Muhasebe Fiş Listesi");
                    break;
                case 1:
                    GridViewExporterFis.WritePdfToResponse("Muhasebe Fiş Listesi");
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
            Response.Redirect("MuhasebeFisArama.aspx");
        }

        protected void GridViewFis_RowDeleting(object sender, ASPxDataDeletingEventArgs e)
        {
            using (var entity = new DBEntities())
            {
                int deletedkey = Convert.ToInt32(e.Keys[0]);
                YEVMIYE deleteddata = entity.YEVMIYEs.Single(p => p.YevmiyeKey == deletedkey);
                entity.YEVMIYEs.Remove(deleteddata);

                try
                {
                    entity.SaveChanges();
                    GridViewFis.JSProperties["cpErrorMessage"] = false;
                }
                catch
                {
                    GridViewFis.JSProperties["cpErrorMessage"] = true;
                }
            }

            Ara();
            e.Cancel = true;
        }

        protected void GridViewFis_CustomButtonCallback(object sender, ASPxGridViewCustomButtonCallbackEventArgs e)
        {
            int index = e.VisibleIndex;
            int key = Convert.ToInt32(GridViewFis.GetRowValues(index, new[] { "YevmiyeKey" }));
            ASPxWebControl.RedirectOnCallback(string.Format("MuhasebeFisKayit.aspx?Key={0}", key));
        }

        #endregion

        #region Methods

        private void SetInitials()
        {
            LabelBaslik.Text = "FİŞ LİSTESİ";
            PageHelper.SessionData = null;

            using (var entity = new DBEntities())
            {
                List<TT_MUHASEBE_TIP> listMUHASEBE_TIP = entity.TT_MUHASEBE_TIP.AsNoTracking().ToList();
                List<TT_FIS_TIP> listFIS_TIP = entity.TT_FIS_TIP.AsNoTracking().Take(3).ToList();

                ComboBoxMuhasebeTip.DataSource = listMUHASEBE_TIP;
                ComboBoxMuhasebeTip.DataBind();

                ComboBoxFisTip.DataSource = listFIS_TIP;
                ComboBoxFisTip.DataBind();
            }
        }

        private void Ara()
        {
            using (var entity = new DBEntities())
            {

                #region validation

                int pMuhasebeTip = Convert.ToInt32(ComboBoxMuhasebeTip.SelectedItem.Value);
                string HesapNo = TextBoxIlgiliKasaHesabi.Text.Replace("_", "").Replace(" ", "").Trim();
                var HesapPlani = entity.HESAP_PLANI.AsNoTracking().FirstOrDefault(p => p.MuhasebeTipKey == pMuhasebeTip && p.HesapKodu == HesapNo);
                if (!string.IsNullOrEmpty(HesapNo) && HesapPlani == null)
                {
                    PageHelper.MessageBox(this, "Yanlış hesap numarası girilmiştir.");
                    return;
                }

                #endregion

                byte pFisTip = Convert.ToByte(ComboBoxFisTip.SelectedItem.Value);
                DateTime? pTarih = string.IsNullOrEmpty(DateEditTarih.Text) ? null : (DateTime?)Convert.ToDateTime(DateEditTarih.Text);
                int? pHesapPlaniKey = string.IsNullOrEmpty(HesapNo) ? null : (int?)HesapPlani.HesapPlaniKey;
                int? pFisNo = string.IsNullOrEmpty(TextBoxFisNo.Text) ? null : (int?)Convert.ToInt32(TextBoxFisNo.Text);

                var sonuc =
                               entity.YEVMIYEs.Include("HESAP_PLANI").AsNoTracking()
                               .ToList()
                               .Where(p =>
                                   p.Borc == 0 &&
                               p.MuhasebeTipKey == pMuhasebeTip
                               && p.FisTipKey == pFisTip &&
                               (pTarih == null || pTarih == p.FisTarih) &&
                               (pFisNo == null || pFisNo == Convert.ToInt32(p.FisNo)) &&
                               (pHesapPlaniKey == null || pHesapPlaniKey == p.HesapPlaniKey))
                               .Select(p => new
                                   {
                                       p.YevmiyeKey,
                                       HesapNo = p.HESAP_PLANI.HesapKodu,
                                       p.Aciklama,
                                       Meblag = p.Alacak
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
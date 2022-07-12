using DevExpress.Web.ASPxGridView;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using TicaretBorsasi_Project.Class.Business;
using TicaretBorsasi_Project.Class.Helper;
using TicaretBorsasi_Project.Data;

namespace TicaretBorsasi_Project.Program.MerkezBorsa.MuhasebeIslemleri
{
    public partial class MuhasebeListeKasaRaporu : Page
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
                GridViewKasaRaporu.DataSource = PageHelper.SessionData;
                GridViewKasaRaporu.DataBind();
            }
        }

        protected void ButtonRapor_Click(object sender, EventArgs e)
        {
            GridViewKasaRaporu.DataSource = PageHelper.SessionData;
            GridViewKasaRaporu.DataBind();

            switch (ComboBoxRapor.SelectedIndex)
            {
                case 0:
                    GridViewExporterKasaRaporu.WriteXlsxToResponse("Kasa Raporu");
                    break;
                case 1:
                    GridViewExporterKasaRaporu.WritePdfToResponse("Kasa Raporu");
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
            LabelBaslik.Text = "KASA RAPORU";
            PageHelper.SessionData = null;

            using (var entity = new DBEntities())
            {
                List<TT_MUHASEBE_TIP> listMUHASEBE_TIP = entity.TT_MUHASEBE_TIP.ToList();
                ComboBoxMuhasebeTip.DataSource = listMUHASEBE_TIP;
                ComboBoxMuhasebeTip.DataBind();
            }

            DateEditDokumTarihi.Date = DateTime.Now.Date;
        }

        private void Ara()
        {
            using (var entity = new DBEntities())
            {
                int pMuhasebeTip = Convert.ToInt32(ComboBoxMuhasebeTip.SelectedItem.Value);
                DateTime pDokumTarihi = DateEditDokumTarihi.Date;
                byte pKasaDefteriYazmaDurum = Convert.ToByte(ComboBoxKasaDefteriDurum.SelectedItem.Value);
                bool pMahsupFislerineBakilacakMi = CheckBoxMahsupFislerineBakilacakmi.Checked;
                string pHesapNo = TextBoxHesapNo.Text.Replace("_", "").Replace(" ", "").Trim();

                #region validation

                var HesapPlani = entity.HESAP_PLANI.AsNoTracking().FirstOrDefault(p => p.MuhasebeTipKey == pMuhasebeTip && p.HesapKodu == pHesapNo);
                if (string.IsNullOrEmpty(pHesapNo) || HesapPlani == null)
                {
                    PageHelper.MessageBox(this, "Yanlış hesap numarası girilmiştir.");
                    return;
                }

                #endregion

                var data = entity.YEVMIYEs.Include("HESAP_PLANI").Include("TT_FIS_TIP").AsNoTracking().ToList();

                #region koşullar

                var sonuc = data.Select(p => new
                {
                    p.YevmiyeKey,
                    p.MuhasebeTipKey,
                    p.FisTarih,
                    p.FisTipKey,
                    FisTip = p.TT_FIS_TIP.FisTipAdi,
                    p.FisNo,
                    HesapNo=p.HESAP_PLANI.HesapKodu,
                    HesapKodu = MuhasebeBS.MuhasebeHesapNo(p.HESAP_PLANI.HesapKodu),
                    p.HESAP_PLANI.HesapAdi,
                    p.Aciklama,
                    Meblag = p.Borc
                }).ToList();

                sonuc = sonuc.Where(
                           p =>
                           p.FisTipKey != 2 &&
                           p.MuhasebeTipKey == pMuhasebeTip &&
                           //p.FisTarih == pDokumTarihi &&
                           p.HesapNo == pHesapNo)
                          .ToList();

                if (!pMahsupFislerineBakilacakMi)
                {
                    sonuc = sonuc.Where(p => p.FisTipKey != 3).ToList();
                }

                #endregion

                #region sıralama

                switch (ComboBoxSiralaArtanAzalan.SelectedItem.Value.ToString())
                {
                    default:
                    case "1":
                        switch (ComboBoxSirala.SelectedItem.Value.ToString())
                        {
                            default:
                            case "1":
                                sonuc = sonuc.OrderBy(p => p.HesapKodu).ToList();
                                break;
                            case "2":
                                sonuc = sonuc.OrderBy(p => p.HesapAdi).ToList();
                                break;
                        }
                        break;
                    case "2":
                        switch (ComboBoxSirala.SelectedItem.Value.ToString())
                        {
                            default:
                            case "1":
                                sonuc = sonuc.OrderByDescending(p => p.HesapKodu).ToList();
                                break;
                            case "2":
                                sonuc = sonuc.OrderByDescending(p => p.HesapAdi).ToList();
                                break;
                        }
                        break;
                }

                #endregion

                #region gruplama

                foreach (GridViewDataColumn item in GridViewKasaRaporu.GetGroupedColumns())
                {
                    GridViewKasaRaporu.UnGroup(item);
                }

                GridViewKasaRaporu.GroupBy(GridViewKasaRaporu.Columns["Tip"]);                

                #endregion

                GridViewKasaRaporu.DataSource = sonuc;
                PageHelper.SessionData = GridViewKasaRaporu.DataSource;
                GridViewKasaRaporu.DataBind();
            }
        }
        #endregion
    }
}
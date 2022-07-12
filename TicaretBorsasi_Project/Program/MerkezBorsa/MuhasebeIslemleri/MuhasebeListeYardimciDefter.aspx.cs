using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using DevExpress.Web.ASPxGridView;
using TicaretBorsasi_Project.Class.Business;
using TicaretBorsasi_Project.Class.Helper;
using TicaretBorsasi_Project.Data;

namespace TicaretBorsasi_Project.Program.MerkezBorsa.MuhasebeIslemleri
{
    public partial class MuhasebeListeYardimciDefter : Page
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
                GridViewYardimciDefter.DataSource = PageHelper.SessionData;
                GridViewYardimciDefter.DataBind();
            }
        }

        protected void ButtonRapor_Click(object sender, EventArgs e)
        {
            GridViewYardimciDefter.DataSource = PageHelper.SessionData;
            GridViewYardimciDefter.DataBind();

            switch (ComboBoxRapor.SelectedIndex)
            {
                case 0:
                    GridViewExporterYardimciDefter.WriteXlsxToResponse("Yardımcı Defter");
                    break;
                case 1:
                    GridViewExporterYardimciDefter.WritePdfToResponse("Yardımcı Defter");
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
            LabelBaslik.Text = "YARDIMCI DEFTER";
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

                ComboBoxYil.DataSource = yillar;
                ComboBoxYil.DataBind();
                ComboBoxYil.SelectedIndex = 0;

                DateEditBaslangic.Date = new DateTime(DateTime.Now.Year, 01, 01);
                DateEditBitis.Date = new DateTime(DateTime.Now.Year, 12, 31);

                TextBoxHesapNoBaslangic.Text = "000";
                TextBoxHesapNoBitis.Text = "999_99_99999";
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
                string pHesapNoBaslangic = TextBoxHesapNoBaslangic.Text.Replace("_", "").Replace(" ", "").Trim();
                string pHesapNoBitis = TextBoxHesapNoBitis.Text.Replace("_", "").Replace(" ", "").Trim();
                bool pNakliYekunIsteniyorMu = CheckBoxNakliYekun.Checked;
                bool pHareketiOlmayanCiksinMi = CheckBoxHareketiOlmayan.Checked;

                #region validation

                if (MuhasebeBS.MuhasebeHesapNoHatalimi(pHesapNoBaslangic) || MuhasebeBS.MuhasebeHesapNoHatalimi(pHesapNoBitis))
                {
                    PageHelper.MessageBox(this, "Hesap no giriş hatası!");
                    return;
                }

                #endregion

                var data = entity.YEVMIYEs.Include("HESAP_PLANI").Include("TT_FIS_TIP").AsNoTracking()
                           .ToList()
                           .Where(
                            p =>
                            p.MuhasebeTipKey == pMuhasebeTip &&
                           (p.HESAP_PLANI.Yil == null || p.HESAP_PLANI.Yil == pYil) &&
                           (p.FisTarih >= pBaslangicTarih && p.FisTarih <= pBitisTarih) &&
                           (p.HESAP_PLANI.HesapKodu.CompareTo(pHesapNoBaslangic) == 1 || p.HESAP_PLANI.HesapKodu.CompareTo(pHesapNoBaslangic) == 0) &&
                           (p.HESAP_PLANI.HesapKodu.CompareTo(pHesapNoBitis) == -1 || p.HESAP_PLANI.HesapKodu.CompareTo(pHesapNoBitis) == 0))
                           .ToList();

                #region koşullar

                var sonuc = data.Select(p => new
                    {
                        p.YevmiyeKey,
                        HesapKodu = MuhasebeBS.MuhasebeHesapNo(p.HESAP_PLANI.HesapKodu),
                        p.HESAP_PLANI.HesapAdi,
                        HesapButce = MuhasebeBS.MuhasebeHesapNo(p.HESAP_PLANI.HesapKodu) + " - " + p.HESAP_PLANI.HesapAdi + " / Bütçe : " + p.HESAP_PLANI.Borc2_.ToString(),
                        Tarih = p.FisTarih,
                        FisTip = p.TT_FIS_TIP.FisTipAdi,
                        p.FisNo,
                        p.Aciklama,
                        p.Borc,
                        p.Alacak
                    }).ToList();


                if (!pNakliYekunIsteniyorMu)
                {
                    //sonuc = sonuc.Where(p => p.Bakiye != 0).ToList();
                }

                if (!pHareketiOlmayanCiksinMi)
                {
                    //sonuc = sonuc.Where(p => p.Borc > 0 || p.Alacak > 0).ToList();
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

                foreach (GridViewDataColumn item in GridViewYardimciDefter.GetGroupedColumns())
                {
                    GridViewYardimciDefter.UnGroup(item);
                }

                GridViewYardimciDefter.GroupBy(GridViewYardimciDefter.Columns["HesapButce"]);

                #endregion

                GridViewYardimciDefter.DataSource = sonuc;
                PageHelper.SessionData = GridViewYardimciDefter.DataSource;
                GridViewYardimciDefter.DataBind();
            }
        }

        #endregion
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using TicaretBorsasi_Project.Class.Business;
using TicaretBorsasi_Project.Class.Helper;
using TicaretBorsasi_Project.Data;

namespace TicaretBorsasi_Project.Program.MerkezBorsa.MuhasebeIslemleri
{
    public partial class MuhasebeListeButceliMizan : Page
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
                GridViewMizan.DataSource = PageHelper.SessionData;
                GridViewMizan.DataBind();
            }
        }

        protected void ButtonRapor_Click(object sender, EventArgs e)
        {
            GridViewMizan.DataSource = PageHelper.SessionData;
            GridViewMizan.DataBind();

            switch (ComboBoxRapor.SelectedIndex)
            {
                case 0:
                    GridViewExporterMizan.WriteXlsxToResponse("Bütçeli Mizan");
                    break;
                case 1:
                    GridViewExporterMizan.WritePdfToResponse("Bütçeli Mizan");
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
            LabelBaslik.Text = "BÜTÇELİ MİZAN";
            PageHelper.SessionData = null;

            using (var entity = new DBEntities())
            {
                List<TT_MUHASEBE_TIP> listMUHASEBE_TIP = entity.TT_MUHASEBE_TIP.ToList();
                List<TT_HESAP_PLANI_DOKUM_TIP> listHESAP_PLANI_DOKUM_TIP = entity.TT_HESAP_PLANI_DOKUM_TIP.AsNoTracking().ToList();

                ComboBoxMuhasebeTip.DataSource = listMUHASEBE_TIP;
                ComboBoxMuhasebeTip.DataBind();

                ComboBoxDokumTipi.DataSource = listHESAP_PLANI_DOKUM_TIP;
                ComboBoxDokumTipi.DataBind();
                ComboBoxDokumTipi.SelectedIndex = 0;

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
                byte pDokumTipi = Convert.ToByte(ComboBoxDokumTipi.SelectedItem.Value);

                DateTime pBaslangic = DateEditBaslangic.Date;
                DateTime pBitis = DateEditBitis.Date;
                int pBaslangicYil = pBaslangic.Year;
                int pBaslangicAy = pBaslangic.Month;
                int pBitisYil = pBitis.Year;
                int pBitisAy = pBitis.Month;
                string pHesapNoBaslangic = TextBoxHesapNoBaslangic.Text.Replace("_", "").Replace(" ", "").Trim();
                string pHesapNoBitis = TextBoxHesapNoBitis.Text.Replace("_", "").Replace(" ", "").Trim();
                bool pBakiyesiOlmayanCiksinMi = CheckBoxBakiyesiOlmayan.Checked;
                bool pHareketiOlmayanCiksinMi = CheckBoxHareketiOlmayan.Checked;

                #region validation

                if (MuhasebeBS.MuhasebeHesapNoHatalimi(pHesapNoBaslangic) || MuhasebeBS.MuhasebeHesapNoHatalimi(pHesapNoBitis))
                {
                    PageHelper.MessageBox(this, "Hesap no giriş hatası!");
                    return;
                }

                #endregion

                var data = entity.HESAP_PLANI.Include("YEVMIYEs").AsNoTracking()
                              .ToList()
                              .Where(
                                     p =>
                                     p.MuhasebeTipKey == pMuhasebeTip &&
                                    (p.Yil == null || (p.Yil >= pBaslangicYil && p.Yil <= pBitisYil)) &&
                                    (p.HesapKodu.CompareTo(pHesapNoBaslangic) == 1 || p.HesapKodu.CompareTo(pHesapNoBaslangic) == 0) &&
                                    (p.HesapKodu.CompareTo(pHesapNoBitis) == -1 || p.HesapKodu.CompareTo(pHesapNoBitis) == 0) &&
                                    (pDokumTipi == 1 ? p.HesapKodu.Length > 0 : (pDokumTipi == 2 ? p.HesapKodu.Length == 3 : p.HesapKodu.Length == 5)))
                                    .ToList();

                #region koşullar

                var sonuc = data.Select(p => new
                    {
                        p.HesapPlaniKey,
                        Hareket = p.YEVMIYEs.Count(),
                        HesapKodu = MuhasebeBS.MuhasebeHesapNo(p.HesapKodu),
                        p.HesapAdi,
                        Borc = BorcHesapla(p, pBitisAy),
                        Alacak = AlacakHesapla(p, pBitisAy),
                        Bakiye = BakiyeHesapla(p, pBitisAy),
                        Durum = DurumHesapla(p, pBitisAy)
                    }).ToList();


                if (!pBakiyesiOlmayanCiksinMi)
                {
                    sonuc = sonuc.Where(p => p.Bakiye != 0).ToList();
                }

                if (!pHareketiOlmayanCiksinMi)
                {
                    sonuc = sonuc.Where(p => p.Borc > 0 || p.Alacak > 0).ToList();
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

                GridViewMizan.DataSource = sonuc;
                PageHelper.SessionData = GridViewMizan.DataSource;
                GridViewMizan.DataBind();
            }
        }

        private decimal BorcHesapla(HESAP_PLANI pHESAP_PLANI, int pBitisAy)
        {
            decimal borc = 0;
            for (int ay = 1; ay <= pBitisAy; ay++)
            {
                switch (ay)
                {
                    default:
                    case 1:
                        borc += pHESAP_PLANI.BorcOcak;
                        break;
                    case 2:
                        borc += pHESAP_PLANI.BorcSubat;
                        break;
                    case 3:
                        borc += pHESAP_PLANI.BorcMart;
                        break;
                    case 4:
                        borc += pHESAP_PLANI.BorcNisan;
                        break;
                    case 5:
                        borc += pHESAP_PLANI.BorcMayis;
                        break;
                    case 6:
                        borc += pHESAP_PLANI.BorcHaziran;
                        break;
                    case 7:
                        borc += pHESAP_PLANI.BorcTemmuz;
                        break;
                    case 8:
                        borc += pHESAP_PLANI.BorcAgustos;
                        break;
                    case 9:
                        borc += pHESAP_PLANI.BorcEylul;
                        break;
                    case 10:
                        borc += pHESAP_PLANI.BorcEkim;
                        break;
                    case 11:
                        borc += pHESAP_PLANI.BorcKasim;
                        break;
                    case 12:
                        borc += pHESAP_PLANI.BorcAralik;
                        break;
                }
            }
            return borc;
        }

        private decimal AlacakHesapla(HESAP_PLANI pHESAP_PLANI, int pBitisAy)
        {
            decimal alacak = 0;
            for (int ay = 1; ay <= pBitisAy; ay++)
            {
                switch (ay)
                {
                    default:
                    case 1:
                        alacak += pHESAP_PLANI.AlacakOcak;
                        break;
                    case 2:
                        alacak += pHESAP_PLANI.AlacakSubat;
                        break;
                    case 3:
                        alacak += pHESAP_PLANI.AlacakMart;
                        break;
                    case 4:
                        alacak += pHESAP_PLANI.AlacakNisan;
                        break;
                    case 5:
                        alacak += pHESAP_PLANI.AlacakMayis;
                        break;
                    case 6:
                        alacak += pHESAP_PLANI.AlacakHaziran;
                        break;
                    case 7:
                        alacak += pHESAP_PLANI.AlacakTemmuz;
                        break;
                    case 8:
                        alacak += pHESAP_PLANI.AlacakAgustos;
                        break;
                    case 9:
                        alacak += pHESAP_PLANI.AlacakEylul;
                        break;
                    case 10:
                        alacak += pHESAP_PLANI.AlacakEkim;
                        break;
                    case 11:
                        alacak += pHESAP_PLANI.AlacakKasim;
                        break;
                    case 12:
                        alacak += pHESAP_PLANI.AlacakAralik;
                        break;
                }
            }
            return alacak;
        }

        private decimal BakiyeHesapla(HESAP_PLANI pHESAP_PLANI, int pBitisAy)
        {
            decimal borc = BorcHesapla(pHESAP_PLANI, pBitisAy);
            decimal alacak = AlacakHesapla(pHESAP_PLANI, pBitisAy);
            decimal sonuc = Math.Abs(borc - alacak);
            return sonuc;
        }

        private string DurumHesapla(HESAP_PLANI pHESAP_PLANI, int pBitisAy)
        {
            decimal borc = BorcHesapla(pHESAP_PLANI, pBitisAy);
            decimal alacak = AlacakHesapla(pHESAP_PLANI, pBitisAy);
            string sonuc = borc >= alacak ? "B" : "A";
            return sonuc;
        }

        #endregion
    }
}
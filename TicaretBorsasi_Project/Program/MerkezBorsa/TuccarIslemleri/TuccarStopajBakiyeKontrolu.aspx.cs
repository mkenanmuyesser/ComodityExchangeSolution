using System;
using System.Collections.Generic;
using System.Web.UI;
using TicaretBorsasi_Project.Class.Helper;
using TicaretBorsasi_Project.Data;

namespace TicaretBorsasi_Project.Program.MerkezBorsa.TuccarIslemleri
{
    public partial class TuccarStopajBakiyeKontrolu : Page
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
                GridViewStopajArama.DataSource = PageHelper.SessionData;
                GridViewStopajArama.DataBind();
            }
        }

        protected void ButtonRapor_Click(object sender, EventArgs e)
        {
            GridViewStopajArama.DataSource = PageHelper.SessionData;
            GridViewStopajArama.DataBind();

            switch (ComboBoxRapor.SelectedIndex)
            {
                case 0:
                    GridViewExporterStopajArama.WriteXlsxToResponse("Stopaj Bakiye Bilgileri");
                    break;
                case 1:
                    GridViewExporterStopajArama.WritePdfToResponse("Stopaj Bakiye Bilgileri");
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
            LabelBaslik.Text = "STOPAJ BAKİYE KONTROLÜ";
            PageHelper.SessionData = null;

            var listAy = new List<string>();
            for (int i = 1; i <= 12; i++)
            {
                listAy.Add(i.ToString());
            }

            ComboBoxBaslangicAy.DataSource = listAy;
            ComboBoxBaslangicAy.DataBind();
            ComboBoxBaslangicAy.SelectedIndex = 0;

            ComboBoxBitisAy.DataSource = listAy;
            ComboBoxBitisAy.DataBind();
            ComboBoxBitisAy.SelectedIndex = 11;

            TextBoxSicilNoBaslangic.Text = "000000";
            TextBoxSicilNoBitis.Text = "999999";
            TextBoxBaslangicVergiDaireKodu.Text = "0000";
            TextBoxBitisVergiDaireKodu.Text = "9999";
        }

        private void Ara()
        {
            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                byte pAyBaslangic = Convert.ToByte(ComboBoxBaslangicAy.SelectedItem.Text);
                byte pAyBitis = Convert.ToByte(ComboBoxBitisAy.SelectedItem.Text);
                string pSicilNoBaslangic = TextBoxSicilNoBaslangic.Text.Trim();
                string pSicilNoBitis = TextBoxSicilNoBitis.Text.Trim();
                string pVergiDaireBaslangic = TextBoxBaslangicVergiDaireKodu.Text.Trim();
                string pVergiDaireBitis = TextBoxBitisVergiDaireKodu.Text.Trim();

                GridViewStopajArama.DataSource = null;

                //    var sonuc = entity.TUCCAR_SICIL.Include("TT_MESLEK_GRUP").Include("TT_KURULUS_TUR").Include("TT_VERGI_DAIRE").Include("TT_DERECE").Include("TT_IL_ILCE").Include("FIRMA_SAHIS").Include("FIRMA_YETKILI").Include("FIRMA_YONETIM").Include("FIRMA_TELEFON_FAX").ToList().Select(p => new
                //    {
                //        TuccarSicilKey = p.TuccarSicilKey,
                //        SicilNo = p.SicilNo,
                //        Unvan = p.Unvan,
                //        VergiNo = p.VergiNo,
                //        VergiDaireKey = p.VergiDaireKey,
                //        NaceKodu1 = p.NaceKodu1,
                //        NaceKodu2 = p.NaceKodu2,
                //        MeslekGrupKey = p.MeslekGrupKey,
                //        Adi = p.FIRMA_SAHIS.SingleOrDefault() == null ? null : p.FIRMA_SAHIS.SingleOrDefault().Ad,
                //        Soyadi = p.FIRMA_SAHIS.SingleOrDefault() == null ? null : p.FIRMA_SAHIS.SingleOrDefault().Soyad,
                //        Yetkili = p.FIRMA_YETKILI,
                //        YonetimKurulu = p.FIRMA_YONETIM.ToList(),
                //        BolgeAdi = p.BolgeAdi,
                //        IlIlceKey = p.IlIlceKey,
                //        MeslekGrupAdi = p.TT_MESLEK_GRUP == null ? null : p.TT_MESLEK_GRUP.MeslekAdi,
                //        KurulusTurAdi = p.TT_KURULUS_TUR == null ? null : p.TT_KURULUS_TUR.Adi,
                //        VergiDaireAdi = p.TT_VERGI_DAIRE == null ? null : p.TT_VERGI_DAIRE.VergiDairesiAdi,
                //        DereceAdi = p.TT_DERECE == null ? null : p.TT_DERECE.Kod,
                //        Tel = p.FIRMA_TELEFON_FAX == null ? "" : p.FIRMA_TELEFON_FAX.Where(x => x.FirmaTelefonFaxTipKey != 5).Count() > 0 ? p.FIRMA_TELEFON_FAX.Where(x => x.FirmaTelefonFaxTipKey != 5).First().FirmaTelefonFax : "",
                //        IlIlceAdi = p.TT_IL_ILCE == null ? null : p.TT_IL_ILCE.IlIlceAdi,
                //        KayitTarihi = p.KayitTarihi,
                //        TerkinTarihi = p.TerkinTarihi,
                //        MerkezSubeMi = p.MerkezSubeMi,
                //        TekinKayitNo = "",
                //        Fax = "",
                //        Adres = "",
                //        TSTarihi = "",
                //        TSKayitNo = "",
                //        YKKTarihi = "",
                //        YKKKayitNo = "",
                //        Sermaye = "",
                //        AskiDurum = "",
                //        SahisAd = "",
                //        SahisSoyad = "",
                //        SahisBabaAdi = "",
                //        SahisDogumYeri = "",
                //        SahisDogumTarihi = "",
                //        SahisUyruk = "",
                //        SahisAdres = "",
                //        SahisTelefon = "",
                //    });

                //    #region sıralama

                //    switch (ComboBoxSiralaArtanAzalan.SelectedItem.Value.ToString())
                //    {
                //        default:
                //        case "1":
                //            switch (ComboBoxSirala.SelectedItem.Value.ToString())
                //            {
                //                default:
                //                case "1":
                //                    sonuc = sonuc.OrderBy(p => p.SicilNo);
                //                    break;
                //                case "2":
                //                    sonuc = sonuc.OrderBy(p => p.Unvan);
                //                    break;
                //                case "3":
                //                    sonuc = sonuc.OrderBy(p => p.MeslekGrupAdi);
                //                    break;
                //                case "4":
                //                    sonuc = sonuc.OrderBy(p => p.KurulusTurAdi);
                //                    break;
                //                case "5":
                //                    sonuc = sonuc.OrderBy(p => p.VergiDaireAdi);
                //                    break;
                //                case "6":
                //                    sonuc = sonuc.OrderBy(p => p.DereceAdi);
                //                    break;
                //                case "7":
                //                    sonuc = sonuc.OrderBy(p => p.IlIlceAdi);
                //                    break;
                //            }
                //            break;
                //        case "2":
                //            switch (ComboBoxSirala.SelectedItem.Value.ToString())
                //            {
                //                default:
                //                case "1":
                //                    sonuc = sonuc.OrderByDescending(p => p.SicilNo);
                //                    break;
                //                case "2":
                //                    sonuc = sonuc.OrderByDescending(p => p.Unvan);
                //                    break;
                //                case "3":
                //                    sonuc = sonuc.OrderByDescending(p => p.MeslekGrupAdi);
                //                    break;
                //                case "4":
                //                    sonuc = sonuc.OrderByDescending(p => p.KurulusTurAdi);
                //                    break;
                //                case "5":
                //                    sonuc = sonuc.OrderByDescending(p => p.VergiDaireAdi);
                //                    break;
                //                case "6":
                //                    sonuc = sonuc.OrderByDescending(p => p.DereceAdi);
                //                    break;
                //                case "7":
                //                    sonuc = sonuc.OrderByDescending(p => p.IlIlceAdi);
                //                    break;
                //            }
                //            break;
                //    }

                //    #endregion

                //    #region koşullar

                //    if (!string.IsNullOrEmpty(pNaceKodu1))
                //    {
                //        sonuc = sonuc.Where(p => p.NaceKodu1 == pNaceKodu1);
                //    }

                //    if (!string.IsNullOrEmpty(pNaceKodu2))
                //    {
                //        sonuc = sonuc.Where(p => p.NaceKodu2 == pNaceKodu2);
                //    }

                //    if (pMeslekGrubuKey != null)
                //    {
                //        sonuc = sonuc.Where(p => p.MeslekGrupKey == pMeslekGrubuKey);
                //    }

                //    if (!string.IsNullOrEmpty(pBolgeAdi))
                //    {
                //        sonuc = sonuc.Where(p => p.BolgeAdi != null && p.BolgeAdi.ToLower(CultureInfo.CurrentCulture).Contains(pBolgeAdi));
                //    }

                //    if (pIlIlceKey != null)
                //    {
                //        sonuc = sonuc.Where(p => p.IlIlceKey == pIlIlceKey);
                //    }

                //    if (pMerkezSubeTipi != null)
                //    {
                //        sonuc = sonuc.Where(p => p.MerkezSubeMi == (pMerkezSubeTipi == 0 ? true : false));
                //    }

                //    if (!string.IsNullOrEmpty(pSicilNoBaslangic) || !string.IsNullOrEmpty(pSicilNoBitis))
                //    {
                //        if (!string.IsNullOrEmpty(pSicilNoBaslangic) && string.IsNullOrEmpty(pSicilNoBitis))
                //        {
                //            int baslangic;
                //            if (!int.TryParse(pSicilNoBaslangic, out baslangic))
                //            {
                //                PageHelper.MessageBox(this, "Sicil numara girişi hatalıdır!");
                //                return;
                //            }

                //            for (int i = pSicilNoBaslangic.Length; i < 6; i++)
                //            {
                //                pSicilNoBaslangic = "0" + pSicilNoBaslangic;
                //            }
                //            sonuc = sonuc.Where(p => p.SicilNo == pSicilNoBaslangic);
                //        }
                //        else
                //        {
                //            int baslangic;
                //            int bitis;
                //            if (int.TryParse(pSicilNoBaslangic, out baslangic) && int.TryParse(pSicilNoBitis, out bitis))
                //            {
                //                sonuc = sonuc.Where(p => Convert.ToInt32(p.SicilNo) >= baslangic && Convert.ToInt32(p.SicilNo) <= bitis);
                //            }
                //            else
                //            {
                //                PageHelper.MessageBox(this, "Sicil numara girişi hatalıdır!");
                //                return;
                //            }
                //        }
                //    }

                //    if (!string.IsNullOrEmpty(pUnvan))
                //    {
                //        sonuc = sonuc.Where(p => p.Unvan.ToLower(CultureInfo.CurrentCulture).Contains(pUnvan));
                //    }

                //    if (!string.IsNullOrEmpty(pVergiNo))
                //    {
                //        sonuc = sonuc.Where(p => p.VergiNo == pVergiNo);
                //    }

                //    if (pVergiDaireKey != null)
                //    {
                //        sonuc = sonuc.Where(p => p.VergiDaireKey == pVergiDaireKey);
                //    }

                //    if (!string.IsNullOrEmpty(pAdi))
                //    {
                //        sonuc = sonuc.Where(p => p.Adi != null && p.Adi.ToLower(CultureInfo.CurrentCulture).Contains(pAdi));
                //    }

                //    if (!string.IsNullOrEmpty(pSoyadi))
                //    {
                //        sonuc = sonuc.Where(p => p.Soyadi != null && p.Soyadi.ToLower(CultureInfo.CurrentCulture).Contains(pSoyadi));
                //    }

                //    if (!string.IsNullOrEmpty(pYetkili))
                //    {
                //        sonuc = sonuc.Where(p => p.Yetkili.Where(z => z.AdSoyad.ToLower(CultureInfo.CurrentCulture).Contains(pYetkili)).Count() > 0);
                //    }

                //    if (!string.IsNullOrEmpty(pYonetimKurulu))
                //    {
                //        sonuc = sonuc.Where(p => p.YonetimKurulu.Where(z => z.AdSoyad.ToLower(CultureInfo.CurrentCulture).Contains(pYonetimKurulu)).Count() > 0);
                //    }

                //    switch (pTerkinDurumu)
                //    {
                //        case "2":
                //            sonuc = sonuc.Where(p => p.TerkinTarihi == null);
                //            break;
                //        case "3":
                //            sonuc = sonuc.Where(p => p.TerkinTarihi != null);

                //            if (DateEditTerkinBaslangic.Value != null && DateEditTerkinBitis.Value != null)
                //            {
                //                pTerkinBaslangic = Convert.ToDateTime(DateEditTerkinBaslangic.Value);
                //                pTerkinBitis = Convert.ToDateTime(DateEditTerkinBitis.Value);

                //                sonuc = sonuc.Where(p => p.TerkinTarihi >= pTerkinBaslangic && p.TerkinTarihi <= pTerkinBitis);
                //            }
                //            else if (DateEditTerkinBaslangic.Value != null)
                //            {
                //                pTerkinBaslangic = Convert.ToDateTime(DateEditTerkinBaslangic.Value);

                //                sonuc = sonuc.Where(p => p.TerkinTarihi >= pTerkinBaslangic);
                //            }
                //            else if (DateEditTerkinBitis.Value != null)
                //            {
                //                pTerkinBitis = Convert.ToDateTime(DateEditTerkinBitis.Value);

                //                sonuc = sonuc.Where(p => p.TerkinTarihi <= pTerkinBitis);
                //            }
                //            break;
                //    }

                //    if (DateEditKayitBaslangic.Value != null && DateEditKayitBitis.Value != null)
                //    {
                //        pKayitBaslangic = Convert.ToDateTime(DateEditKayitBaslangic.Value);
                //        pKayitBitis = Convert.ToDateTime(DateEditKayitBitis.Value);

                //        sonuc = sonuc.Where(p => p.KayitTarihi >= pKayitBaslangic && p.KayitTarihi <= pKayitBitis);
                //    }
                //    else if (DateEditKayitBaslangic.Value != null)
                //    {
                //        pKayitBaslangic = Convert.ToDateTime(DateEditKayitBaslangic.Value);

                //        sonuc = sonuc.Where(p => p.KayitTarihi >= pKayitBaslangic);
                //    }
                //    else if (DateEditKayitBitis.Value != null)
                //    {
                //        pKayitBitis = Convert.ToDateTime(DateEditKayitBitis.Value);

                //        sonuc = sonuc.Where(p => p.KayitTarihi <= pKayitBitis);
                //    }

                //    #endregion

                //    GridViewSicilArama.DataSource = sonuc;
                PageHelper.SessionData = GridViewStopajArama.DataSource;
                GridViewStopajArama.DataBind();
            }
        }

        #endregion
    }
}
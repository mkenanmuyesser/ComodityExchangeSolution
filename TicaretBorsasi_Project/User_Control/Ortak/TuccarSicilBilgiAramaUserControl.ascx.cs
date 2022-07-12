using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web.UI;
using DevExpress.Web.ASPxClasses;
using DevExpress.Web.ASPxGridView;
using DevExpress.Web.Data;
using TicaretBorsasi_Project.Class.Helper;
using TicaretBorsasi_Project.Data;

namespace TicaretBorsasi_Project.User_Control.Ortak
{
    public partial class TuccarSicilBilgiAramaUserControl : UserControl
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
                GridViewSicilArama.DataSource = PageHelper.SessionData;
                GridViewSicilArama.DataBind();
            }
        }

        protected void ButtonRapor_Click(object sender, EventArgs e)
        {
            GridViewSicilArama.DataSource = PageHelper.SessionData;
            GridViewSicilArama.DataBind();

            switch (ComboBoxRapor.SelectedIndex)
            {
                case 0:
                    GridViewExporterSicilArama.WriteXlsxToResponse("Tüccar Sicil Bilgileri");
                    break;
                case 1:
                    GridViewExporterSicilArama.WritePdfToResponse("Tüccar Sicil Bilgileri");
                    break;
                default:
                    break;
            }
        }

        protected void ButtonTumDetay_Click(object sender, EventArgs e)
        {
            GridViewSicilArama.DataSource = PageHelper.SessionData;
            GridViewSicilArama.DataBind();

            for (int i = 10; i < (GridViewSicilArama.Columns.Count - 1); i++)
            {
                GridViewSicilArama.Columns[i].Visible = true;
            }

            switch (ComboBoxRapor.SelectedIndex)
            {
                case 0:
                    GridViewExporterSicilArama.WriteXlsxToResponse("Tüccar Detaylı Sicil Bilgileri");
                    break;
                case 1:
                    GridViewExporterSicilArama.WritePdfToResponse("Tüccar Detaylı Sicil Bilgileri");
                    break;
                default:
                    break;
            }

            for (int i = 10; i < (GridViewSicilArama.Columns.Count - 1); i++)
            {
                GridViewSicilArama.Columns[i].Visible = false;
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

        protected void RadioButtonListTerkinSecim_SelectedIndexChanged(object sender, EventArgs e)
        {
            string secim = RadioButtonListTerkinSecim.SelectedItem.Value.ToString();
            switch (secim)
            {
                default:
                case "1":
                case "2":
                    DateEditTerkinBaslangic.Value = null;
                    DateEditTerkinBitis.Value = null;

                    DateEditTerkinBaslangic.Enabled = false;
                    DateEditTerkinBitis.Enabled = false;
                    break;
                case "3":
                    DateEditTerkinBaslangic.Enabled = true;
                    DateEditTerkinBitis.Enabled = true;
                    break;
            }
        }

        protected void GridViewSicilArama_RowDeleting(object sender, ASPxDataDeletingEventArgs e)
        {
            using (var entity = new DBEntities())
            {
                int deletedkey = Convert.ToInt32(e.Keys[0]);
                TUCCAR_SICIL deleteddata = entity.TUCCAR_SICIL.Single(p => p.TuccarSicilKey == deletedkey);
                entity.TUCCAR_SICIL.Remove(deleteddata);

                try
                {
                    entity.SaveChanges();
                    GridViewSicilArama.JSProperties["cpErrorMessage"] = false;
                }
                catch
                {
                    GridViewSicilArama.JSProperties["cpErrorMessage"] = true;
                }
            }

            Ara();
            e.Cancel = true;
        }

        protected void GridViewSicilArama_CustomButtonCallback(object sender, ASPxGridViewCustomButtonCallbackEventArgs e)
        {
            int index = e.VisibleIndex;
            int key = Convert.ToInt32(GridViewSicilArama.GetRowValues(index, new[] { "TuccarSicilKey" }));
            string sayfa = Request.Url.AbsolutePath.Replace(Request.Url.Segments[4], "");
            ASPxWebControl.RedirectOnCallback(string.Format("{0}TuccarSicilBilgiKayit.aspx?Key={1}", sayfa, key));
        }

        #endregion

        #region Methods

        private void SetInitials()
        {
            LabelBaslik.Text = "TÜCCAR SİCİL ARAMA İŞLEMLERİ";
            PageHelper.SessionData = null;

            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                List<TT_MESLEK_GRUP> listMESLEK_GRUP = entity.TT_MESLEK_GRUP.AsNoTracking().ToList();
                List<TT_VERGI_DAIRE> listVERGI_DAIRE = entity.TT_VERGI_DAIRE.AsNoTracking().ToList();
                List<TT_IL_ILCE> listIL_ILCE = entity.TT_IL_ILCE.AsNoTracking().ToList();
                var listMerkezSube = new List<string>();
                listMerkezSube.Add("MERKEZ");
                listMerkezSube.Add("ŞUBE");

                ComboBoxVergiDairesi.DataSource = listVERGI_DAIRE;
                ComboBoxVergiDairesi.DataBind();

                ComboBoxMeslekGrubu.DataSource = listMESLEK_GRUP;
                ComboBoxMeslekGrubu.DataBind();

                ComboBoxIlIlce.DataSource = listIL_ILCE;
                ComboBoxIlIlce.DataBind();

                ComboBoxMerkezSubeMi.DataSource = listMerkezSube;
                ComboBoxMerkezSubeMi.DataBind();
            }
        }

        private void Ara()
        {
            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                string pSicilNoBaslangic = SpinEditSicilNoBaslangic.Text.Trim();
                string pSicilNoBitis = SpinEditSicilNoBitis.Text.Trim();
                string pVergiNo = TextBoxVergiNo.Text;
                string pUnvan = TextBoxUnvan.Text.Trim().ToLower(CultureInfo.CurrentCulture);
                int? pVergiDaireKey = ComboBoxVergiDairesi.SelectedIndex == -1
                                          ? null
                                          : (int?)Convert.ToInt32(ComboBoxVergiDairesi.SelectedItem.Value);
                string pNaceKodu1 = TextBoxNaceKodu1.Text;
                string pNaceKodu2 = TextBoxNaceKodu2.Text;
                int? pMeslekGrubuKey = ComboBoxMeslekGrubu.SelectedIndex == -1
                                           ? null
                                           : (int?)Convert.ToInt32(ComboBoxMeslekGrubu.SelectedItem.Value);
                string pAdi = TextBoxAdi.Text.Trim().ToLower(CultureInfo.CurrentCulture);
                string pSoyadi = TextBoxSoyadi.Text.Trim().ToLower(CultureInfo.CurrentCulture);
                string pYetkili = TextBoxYetkili.Text.Trim().ToLower(CultureInfo.CurrentCulture);
                string pYonetimKurulu = TextBoxYonetimKurulu.Text.Trim().ToLower(CultureInfo.CurrentCulture);
                string pBolgeAdi = TextBoxBolgeAdi.Text;
                int? pIlIlceKey = ComboBoxIlIlce.SelectedIndex == -1
                                      ? null
                                      : (int?)Convert.ToInt32(ComboBoxIlIlce.SelectedItem.Value);
                string pTerkinDurumu = RadioButtonListTerkinSecim.SelectedItem.Value.ToString();
                DateTime? pTerkinBaslangic = null;
                DateTime? pTerkinBitis = null;
                DateTime? pKayitBaslangic = null;
                DateTime? pKayitBitis = null;
                int? pMerkezSubeTipi = ComboBoxMerkezSubeMi.SelectedIndex == -1
                                           ? null
                                           : (int?)ComboBoxMerkezSubeMi.SelectedIndex;

                GridViewSicilArama.DataSource = null;

                var sonuc =
                    entity.TUCCAR_SICIL.Include("TT_MESLEK_GRUP")
                          .Include("TT_KURULUS_TUR")
                          .Include("TT_VERGI_DAIRE")
                          .Include("TT_DERECE")
                          .Include("TT_IL_ILCE")
                          .Include("FIRMA_SAHIS")
                          .Include("FIRMA_YETKILI")
                          .Include("FIRMA_YONETIM")
                          .Include("FIRMA_TELEFON_FAX")
                          .Include("FIRMA_ADRES")
                          .Include("TUCCAR_ASKI")
                          .AsNoTracking()
                          .ToList()
                          .Select(p => new
                          {
                              p.TuccarSicilKey,
                              p.SicilNo,
                              p.Unvan,
                              p.VergiNo,
                              p.VergiDaireKey,
                              p.NaceKodu1,
                              p.NaceKodu2,
                              p.MeslekGrupKey,
                              Adi =
                                       p.FIRMA_SAHIS.SingleOrDefault() == null
                                           ? null
                                           : p.FIRMA_SAHIS.SingleOrDefault().Ad,
                              Soyadi =
                                       p.FIRMA_SAHIS.SingleOrDefault() == null
                                           ? null
                                           : p.FIRMA_SAHIS.SingleOrDefault().Soyad,
                              Yetkili = p.FIRMA_YETKILI,
                              YonetimKurulu = p.FIRMA_YONETIM.ToList(),
                              p.BolgeAdi,
                              p.IlIlceKey,
                              MeslekGrupAdi = p.TT_MESLEK_GRUP == null ? null : p.TT_MESLEK_GRUP.MeslekAdi,
                              KurulusTurAdi = p.TT_KURULUS_TUR == null ? null : p.TT_KURULUS_TUR.Adi,
                              VergiDaireAdi = p.TT_VERGI_DAIRE == null ? null : p.TT_VERGI_DAIRE.VergiDairesiAdi,
                              DereceAdi = p.TT_DERECE == null ? null : p.TT_DERECE.Kod,
                              Tel =
                                       p.FIRMA_TELEFON_FAX == null
                                           ? ""
                                           : p.FIRMA_TELEFON_FAX.Any(x => x.FirmaTelefonFaxTipKey != 5)
                                                 ? p.FIRMA_TELEFON_FAX.First(x => x.FirmaTelefonFaxTipKey != 5)
                                                    .FirmaTelefonFax
                                                 : "",
                              IlIlceAdi = p.TT_IL_ILCE == null ? null : p.TT_IL_ILCE.IlIlceAdi,
                              p.KayitTarihi,
                              p.TerkinTarihi,
                              p.MerkezSubeMi,
                              TerkinKayitNo = p.TerkinYKKNo,
                              Fax =
                                       p.FIRMA_TELEFON_FAX == null
                                           ? ""
                                           : p.FIRMA_TELEFON_FAX.Any(x => x.FirmaTelefonFaxTipKey == 5)
                                                 ? p.FIRMA_TELEFON_FAX.First(x => x.FirmaTelefonFaxTipKey == 5)
                                                    .FirmaTelefonFax
                                                 : "",
                              Adres =
                                       p.FIRMA_ADRES == null
                                           ? ""
                                           : p.FIRMA_ADRES.Any() ? p.FIRMA_ADRES.First().FirmaAdres : "",
                              TSTarihi = p.SicilTarih,
                              TSKayitNo = p.SicilKayitNo,
                              p.YKKTarihi,
                              YKKKayitNo = p.YKKNo,
                              p.Sermaye,
                              AskiDurum =
                                       p.TUCCAR_ASKI.Any(x => x.BitisTarihi == null) ? "ASKI" : "",
                              SahisAd =
                                       p.FIRMA_SAHIS == null
                                           ? ""
                                           : !p.FIRMA_SAHIS.Any() ? "" : p.FIRMA_SAHIS.First().Ad,
                              SahisSoyad =
                                       p.FIRMA_SAHIS == null
                                           ? ""
                                           : !p.FIRMA_SAHIS.Any() ? "" : p.FIRMA_SAHIS.First().Soyad,
                              SahisBabaAdi =
                                       p.FIRMA_SAHIS == null
                                           ? ""
                                           : !p.FIRMA_SAHIS.Any() ? "" : p.FIRMA_SAHIS.First().BabaAdi,
                              SahisDogumYeri =
                                       p.FIRMA_SAHIS == null
                                           ? ""
                                           : !p.FIRMA_SAHIS.Any() ? "" : p.FIRMA_SAHIS.First().DogumYeri,
                              SahisDogumTarihi =
                                       p.FIRMA_SAHIS == null
                                           ? ""
                                           : !p.FIRMA_SAHIS.Any()
                                                 ? ""
                                                 : (object)p.FIRMA_SAHIS.First().DogumTarihi,
                              SahisUyruk =
                                       p.FIRMA_SAHIS == null
                                           ? ""
                                           : !p.FIRMA_SAHIS.Any() ? "" : p.FIRMA_SAHIS.First().Uyruk,
                              SahisAdres =
                                       p.FIRMA_SAHIS == null
                                           ? ""
                                           : !p.FIRMA_SAHIS.Any() ? "" : p.FIRMA_SAHIS.First().Adres,
                              SahisTelefon =
                                       p.FIRMA_SAHIS == null
                                           ? ""
                                           : !p.FIRMA_SAHIS.Any() ? "" : p.FIRMA_SAHIS.First().Tel,
                          });

                #region sıralama

                switch (ComboBoxSiralaArtanAzalan.SelectedItem.Value.ToString())
                {
                    default:
                    case "1":
                        switch (ComboBoxSirala.SelectedItem.Value.ToString())
                        {
                            default:
                            case "1":
                                sonuc = sonuc.OrderBy(p => p.SicilNo);
                                break;
                            case "2":
                                sonuc = sonuc.OrderBy(p => p.Unvan);
                                break;
                            case "3":
                                sonuc = sonuc.OrderBy(p => p.MeslekGrupAdi);
                                break;
                            case "4":
                                sonuc = sonuc.OrderBy(p => p.KurulusTurAdi);
                                break;
                            case "5":
                                sonuc = sonuc.OrderBy(p => p.VergiDaireAdi);
                                break;
                            case "6":
                                sonuc = sonuc.OrderBy(p => p.DereceAdi);
                                break;
                            case "7":
                                sonuc = sonuc.OrderBy(p => p.IlIlceAdi);
                                break;
                        }
                        break;
                    case "2":
                        switch (ComboBoxSirala.SelectedItem.Value.ToString())
                        {
                            default:
                            case "1":
                                sonuc = sonuc.OrderByDescending(p => p.SicilNo);
                                break;
                            case "2":
                                sonuc = sonuc.OrderByDescending(p => p.Unvan);
                                break;
                            case "3":
                                sonuc = sonuc.OrderByDescending(p => p.MeslekGrupAdi);
                                break;
                            case "4":
                                sonuc = sonuc.OrderByDescending(p => p.KurulusTurAdi);
                                break;
                            case "5":
                                sonuc = sonuc.OrderByDescending(p => p.VergiDaireAdi);
                                break;
                            case "6":
                                sonuc = sonuc.OrderByDescending(p => p.DereceAdi);
                                break;
                            case "7":
                                sonuc = sonuc.OrderByDescending(p => p.IlIlceAdi);
                                break;
                        }
                        break;
                }

                #endregion

                #region koşullar

                if (!string.IsNullOrEmpty(pNaceKodu1))
                {
                    sonuc = sonuc.Where(p => p.NaceKodu1 == pNaceKodu1);
                }

                if (!string.IsNullOrEmpty(pNaceKodu2))
                {
                    sonuc = sonuc.Where(p => p.NaceKodu2 == pNaceKodu2);
                }

                if (pMeslekGrubuKey != null)
                {
                    sonuc = sonuc.Where(p => p.MeslekGrupKey == pMeslekGrubuKey);
                }

                if (!string.IsNullOrEmpty(pBolgeAdi))
                {
                    sonuc =
                        sonuc.Where(
                            p =>
                            p.BolgeAdi != null && p.BolgeAdi.ToLower(CultureInfo.CurrentCulture).Contains(pBolgeAdi));
                }

                if (pIlIlceKey != null)
                {
                    sonuc = sonuc.Where(p => p.IlIlceKey == pIlIlceKey);
                }

                if (pMerkezSubeTipi != null)
                {
                    sonuc = sonuc.Where(p => p.MerkezSubeMi == (pMerkezSubeTipi == 0 ? true : false));
                }

                if (!string.IsNullOrEmpty(pSicilNoBaslangic) || !string.IsNullOrEmpty(pSicilNoBitis))
                {
                    if (!string.IsNullOrEmpty(pSicilNoBaslangic) && string.IsNullOrEmpty(pSicilNoBitis))
                    {
                        int baslangic;
                        if (!int.TryParse(pSicilNoBaslangic, out baslangic))
                        {
                            PageHelper.MessageBox(this.Page, "Sicil numara girişi hatalıdır!");
                            return;
                        }

                        for (int i = pSicilNoBaslangic.Length; i < 6; i++)
                        {
                            pSicilNoBaslangic = "0" + pSicilNoBaslangic;
                        }
                        sonuc = sonuc.Where(p => p.SicilNo == pSicilNoBaslangic);
                    }
                    else
                    {
                        int baslangic;
                        int bitis;
                        if (int.TryParse(pSicilNoBaslangic, out baslangic) && int.TryParse(pSicilNoBitis, out bitis))
                        {
                            sonuc =
                                sonuc.Where(
                                    p =>
                                    Convert.ToInt32(p.SicilNo) >= baslangic && Convert.ToInt32(p.SicilNo) <= bitis);
                        }
                        else
                        {
                            PageHelper.MessageBox(this.Page, "Sicil numara girişi hatalıdır!");
                            return;
                        }
                    }
                }

                if (!string.IsNullOrEmpty(pUnvan))
                {
                    sonuc = sonuc.Where(p => p.Unvan.ToLower(CultureInfo.CurrentCulture).Contains(pUnvan));
                }

                if (!string.IsNullOrEmpty(pVergiNo))
                {
                    sonuc = sonuc.Where(p => p.VergiNo == pVergiNo);
                }

                if (pVergiDaireKey != null)
                {
                    sonuc = sonuc.Where(p => p.VergiDaireKey == pVergiDaireKey);
                }

                if (!string.IsNullOrEmpty(pAdi))
                {
                    sonuc =
                        sonuc.Where(p => p.Adi != null && p.Adi.ToLower(CultureInfo.CurrentCulture).Contains(pAdi));
                }

                if (!string.IsNullOrEmpty(pSoyadi))
                {
                    sonuc =
                        sonuc.Where(
                            p => p.Soyadi != null && p.Soyadi.ToLower(CultureInfo.CurrentCulture).Contains(pSoyadi));
                }

                if (!string.IsNullOrEmpty(pYetkili))
                {
                    sonuc =
                        sonuc.Where(
                            p =>
                            p.Yetkili.Where(z => z.AdSoyad.ToLower(CultureInfo.CurrentCulture).Contains(pYetkili))
                             .Count() > 0);
                }

                if (!string.IsNullOrEmpty(pYonetimKurulu))
                {
                    sonuc =
                        sonuc.Where(
                            p =>
                            p.YonetimKurulu.Where(
                                z => z.AdSoyad.ToLower(CultureInfo.CurrentCulture).Contains(pYonetimKurulu)).Count() >
                            0);
                }

                switch (pTerkinDurumu)
                {
                    case "2":
                        sonuc = sonuc.Where(p => p.TerkinTarihi == null);
                        break;
                    case "3":
                        sonuc = sonuc.Where(p => p.TerkinTarihi != null);

                        if (DateEditTerkinBaslangic.Value != null && DateEditTerkinBitis.Value != null)
                        {
                            pTerkinBaslangic = Convert.ToDateTime(DateEditTerkinBaslangic.Value);
                            pTerkinBitis = Convert.ToDateTime(DateEditTerkinBitis.Value);

                            sonuc =
                                sonuc.Where(
                                    p => p.TerkinTarihi >= pTerkinBaslangic && p.TerkinTarihi <= pTerkinBitis);
                        }
                        else if (DateEditTerkinBaslangic.Value != null)
                        {
                            pTerkinBaslangic = Convert.ToDateTime(DateEditTerkinBaslangic.Value);

                            sonuc = sonuc.Where(p => p.TerkinTarihi >= pTerkinBaslangic);
                        }
                        else if (DateEditTerkinBitis.Value != null)
                        {
                            pTerkinBitis = Convert.ToDateTime(DateEditTerkinBitis.Value);

                            sonuc = sonuc.Where(p => p.TerkinTarihi <= pTerkinBitis);
                        }
                        break;
                }

                if (DateEditKayitBaslangic.Value != null && DateEditKayitBitis.Value != null)
                {
                    pKayitBaslangic = Convert.ToDateTime(DateEditKayitBaslangic.Value);
                    pKayitBitis = Convert.ToDateTime(DateEditKayitBitis.Value);

                    sonuc = sonuc.Where(p => p.KayitTarihi >= pKayitBaslangic && p.KayitTarihi <= pKayitBitis);
                }
                else if (DateEditKayitBaslangic.Value != null)
                {
                    pKayitBaslangic = Convert.ToDateTime(DateEditKayitBaslangic.Value);

                    sonuc = sonuc.Where(p => p.KayitTarihi >= pKayitBaslangic);
                }
                else if (DateEditKayitBitis.Value != null)
                {
                    pKayitBitis = Convert.ToDateTime(DateEditKayitBitis.Value);

                    sonuc = sonuc.Where(p => p.KayitTarihi <= pKayitBitis);
                }

                #endregion

                GridViewSicilArama.DataSource = sonuc;
                PageHelper.SessionData = GridViewSicilArama.DataSource;
                GridViewSicilArama.DataBind();
            }
        }

        #endregion
    }
}
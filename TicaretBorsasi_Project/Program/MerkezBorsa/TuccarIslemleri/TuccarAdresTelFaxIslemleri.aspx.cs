using System;
using System.Globalization;
using System.Linq;
using System.Web.UI;
using TicaretBorsasi_Project.Class.Helper;
using TicaretBorsasi_Project.Data;

namespace TicaretBorsasi_Project.Program.MerkezBorsa.TuccarIslemleri
{
    public partial class TuccarAdresTelFaxIslemleri : Page
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
                GridViewAdres.DataSource = PageHelper.SessionData;
                GridViewAdres.DataBind();
            }
        }

        protected void ButtonRapor_Click(object sender, EventArgs e)
        {
            GridViewAdres.DataSource = PageHelper.SessionData;
            GridViewAdres.DataBind();

            GridViewAdres.Columns["Tel1"].Visible = true;
            GridViewAdres.Columns["Tel2"].Visible = true;
            GridViewAdres.Columns["Tel3"].Visible = true;
            GridViewAdres.Columns["Fax"].Visible = true;
            GridViewAdres.Columns["Telefon/Fax"].Visible = false;

            switch (ComboBoxRapor.SelectedIndex)
            {
                case 0:
                    GridViewExporterAdres.WriteXlsxToResponse("Tüccar Adres/Tel/Fax Bilgileri");
                    break;
                case 1:
                    GridViewExporterAdres.WritePdfToResponse("Tüccar Adres/Tel/Fax Bilgileri");
                    break;
                default:
                    break;
            }

            GridViewAdres.Columns["Tel1"].Visible = false;
            GridViewAdres.Columns["Tel2"].Visible = false;
            GridViewAdres.Columns["Tel3"].Visible = false;
            GridViewAdres.Columns["Fax"].Visible = false;
            GridViewAdres.Columns["Telefon/Fax"].Visible = true;
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
            LabelBaslik.Text = "TÜCCAR ADRES İŞLEMLERİ";
            PageHelper.SessionData = null;
        }

        private void Ara()
        {
            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                string pSicilNoBaslangic = SpinEditSicilNoBaslangic.Text.Trim();
                string pSicilNoBitis = SpinEditSicilNoBitis.Text.Trim();
                string pUnvan = TextBoxUnvan.Text.Trim().ToLower(CultureInfo.CurrentCulture);
                string pUyeDurumu = RadioButtonListUyeSecim.SelectedItem.Value.ToString();
                string pTerkinDurumu = RadioButtonListTerkinSecim.SelectedItem.Value.ToString();
                string pAskiDurumu = RadioButtonListAskiSecim.SelectedItem.Value.ToString();
                DateTime? pTerkinBaslangic = null;
                DateTime? pTerkinBitis = null;
                DateTime? pKayitBaslangic = null;
                DateTime? pKayitBitis = null;

                GridViewAdres.DataSource = null;

                var data =
                    entity.TUCCAR_SICIL.Include("TT_VERGI_DAIRE")
                          .Include("TT_IL_ILCE")
                          .Include("FIRMA_SAHIS")
                          .Include("FIRMA_ADRES")
                          .Include("FIRMA_TELEFON_FAX")
                          .Include("TUCCAR_ASKI")
                          .AsNoTracking()
                          .AsQueryable();

                #region sıralama

                switch (ComboBoxSiralaArtanAzalan.SelectedItem.Value.ToString())
                {
                    default:
                    case "1":
                        switch (ComboBoxSirala.SelectedItem.Value.ToString())
                        {
                            default:
                            case "1":
                                data = data.OrderBy(p => p.SicilNo);
                                break;
                            case "2":
                                data = data.OrderBy(p => p.Unvan);
                                break;
                        }
                        break;
                    case "2":
                        switch (ComboBoxSirala.SelectedItem.Value.ToString())
                        {
                            default:
                            case "1":
                                data = data.OrderByDescending(p => p.SicilNo);
                                break;
                            case "2":
                                data = data.OrderByDescending(p => p.Unvan);
                                break;
                        }
                        break;
                }

                int counter = 1;
                var sonuc = data.ToList().Select(p => new
                    {
                        p.TuccarSicilKey,
                        Sira = counter++,
                        p.SicilNo,
                        p.Unvan,
                        Tel1 =
                                                          p.FIRMA_TELEFON_FAX.Where(x => x.FirmaTelefonFaxTipKey != 5)
                                                           .Count() > 0
                                                              ? p.FIRMA_TELEFON_FAX.Where(
                                                                  x => x.FirmaTelefonFaxTipKey != 5)
                                                                 .First()
                                                                 .FirmaTelefonFax
                                                              : "",
                        Tel2 =
                                                          p.FIRMA_TELEFON_FAX.Where(x => x.FirmaTelefonFaxTipKey != 5)
                                                           .Count() > 1
                                                              ? p.FIRMA_TELEFON_FAX.Where(
                                                                  x => x.FirmaTelefonFaxTipKey != 5)
                                                                 .Skip(1)
                                                                 .Take(1)
                                                                 .First()
                                                                 .FirmaTelefonFax
                                                              : "",
                        Tel3 =
                                                          p.FIRMA_TELEFON_FAX.Where(x => x.FirmaTelefonFaxTipKey != 5)
                                                           .Count() > 2
                                                              ? p.FIRMA_TELEFON_FAX.Where(
                                                                  x => x.FirmaTelefonFaxTipKey != 5)
                                                                 .Skip(2)
                                                                 .Take(1)
                                                                 .First()
                                                                 .FirmaTelefonFax
                                                              : "",
                        Fax =
                                                          p.FIRMA_TELEFON_FAX.Where(x => x.FirmaTelefonFaxTipKey == 5)
                                                           .Count() > 0
                                                              ? p.FIRMA_TELEFON_FAX.Where(
                                                                  x => x.FirmaTelefonFaxTipKey == 5)
                                                                 .First()
                                                                 .FirmaTelefonFax
                                                              : "",
                        Adres = p.FIRMA_ADRES.Count() > 0 ? p.FIRMA_ADRES.First().FirmaAdres : "",
                        VergiDaireAdi = p.TT_VERGI_DAIRE == null ? null : p.TT_VERGI_DAIRE.VergiDairesiAdi,
                        p.VergiNo,
                        p.TerkinTarihi,
                        FirmaSahis = p.FIRMA_SAHIS,
                        TuccarAski = p.TUCCAR_ASKI
                    });

                #endregion

                #region koşullar

                if (!string.IsNullOrEmpty(pSicilNoBaslangic) || !string.IsNullOrEmpty(pSicilNoBitis))
                {
                    if (!string.IsNullOrEmpty(pSicilNoBaslangic) && string.IsNullOrEmpty(pSicilNoBitis))
                    {
                        int baslangic;
                        if (!int.TryParse(pSicilNoBaslangic, out baslangic))
                        {
                            PageHelper.MessageBox(this, "Sicil numara girişi hatalıdır!");
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
                                    p => Convert.ToInt32(p.SicilNo) >= baslangic && Convert.ToInt32(p.SicilNo) <= bitis);
                        }
                        else
                        {
                            PageHelper.MessageBox(this, "Sicil numara girişi hatalıdır!");
                            return;
                        }
                    }
                }

                if (!string.IsNullOrEmpty(pUnvan))
                {
                    sonuc = sonuc.Where(p => p.Unvan.ToLower(CultureInfo.CurrentCulture).Contains(pUnvan));
                }

                switch (pUyeDurumu)
                {
                    case "2":
                        sonuc = sonuc.Where(p => p.FirmaSahis != null);
                        break;
                    case "3":
                        sonuc = sonuc.Where(p => p.FirmaSahis == null);
                        break;
                }

                switch (pTerkinDurumu)
                {
                    case "2":
                        sonuc = sonuc.Where(p => p.TerkinTarihi == null);
                        break;
                    case "3":
                        sonuc = sonuc.Where(p => p.TerkinTarihi != null);
                        break;
                }

                switch (pAskiDurumu)
                {
                    case "2":
                        sonuc = sonuc.Where(p => p.TuccarAski == null || p.TuccarAski.Last().BitisTarihi != null);
                        break;
                    case "3":
                        sonuc = sonuc.Where(p => p.TuccarAski != null && p.TuccarAski.Last().BitisTarihi == null);
                        break;
                }

                #endregion

                GridViewAdres.DataSource = sonuc;
                PageHelper.SessionData = GridViewAdres.DataSource;
                GridViewAdres.DataBind();
            }
        }

        #endregion
    }
}
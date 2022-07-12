using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web.UI;
using DevExpress.Utils;
using DevExpress.Web.ASPxGridView;
using DevExpress.Web.ASPxPopupControl;
using TicaretBorsasi_Project.Class.Helper;
using TicaretBorsasi_Project.Data;

namespace TicaretBorsasi_Project.Program.MerkezBorsa.TuccarIslemleri
{
    public partial class TuccarAdresEtiketiIslemleri : Page
    {
        #region Properties

        public List<int> AdresEtiketList
        {
            get
            {
                if (ViewState["AdresEtiketList"] == null)
                {
                    ViewState["AdresEtiketList"] = new List<int>();
                }

                return (List<int>) ViewState["AdresEtiketList"];
            }
        }

        #endregion

        #region Events

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                SetInitials();
            }

            Ara();
            AdresEtiketButtonAktifPasif();
        }

        protected void ButtonRapor_Click(object sender, EventArgs e)
        {
            switch (ComboBoxRapor.SelectedIndex)
            {
                case 0:
                    GridViewExporterAdresEtiketBasilacak.WriteXlsxToResponse("Adres Etiket Bilgileri");
                    break;
                case 1:
                    GridViewExporterAdresEtiketBasilacak.WritePdfToResponse("Adres Etiket Bilgileri");
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

        protected void ButtonListeYazdir_Click(object sender, EventArgs e)
        {
            Session["KeyList"] = Ara(true);

            PopUpOlustur();
        }

        protected void ButtonSecimliListeYazdir_Click(object sender, EventArgs e)
        {
            string keylist = "";

            foreach (int sicilkey in AdresEtiketList)
            {
                keylist += "," + sicilkey;
            }

            if (keylist.Length > 0)
            {
                keylist = keylist.Remove(0, 1);
            }

            Session["KeyList"] = keylist;

            PopUpOlustur();
        }

        protected void GridViewAdresEtiketAra_RowCommand(object sender, ASPxGridViewRowCommandEventArgs e)
        {
            int key = Convert.ToInt32(e.CommandArgs.CommandArgument);

            if (!AdresEtiketList.Contains(key))
            {
                AdresEtiketList.Add(key);
            }

            ViewState["AdresEtiketList"] = AdresEtiketList;
            AdresEtiketListDoldur();
            AdresEtiketButtonAktifPasif();
        }

        protected void GridViewAdresEtiketBasilacak_RowCommand(object sender, ASPxGridViewRowCommandEventArgs e)
        {
            int key = Convert.ToInt32(e.CommandArgs.CommandArgument);

            AdresEtiketList.Remove(key);

            ViewState["AdresEtiketList"] = AdresEtiketList;
            AdresEtiketListDoldur();
            AdresEtiketButtonAktifPasif();
        }

        #endregion

        #region Methods

        private void SetInitials()
        {
            LabelBaslik.Text = "ADRES ETİKETİ İŞLEMLERİ";
        }

        private string Ara(bool keylistegetir = false)
        {
            string keylist = "";
            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                string pSicilNoBaslangic = SpinEditSicilNoBaslangic.Text.Trim();
                string pSicilNoBitis = SpinEditSicilNoBitis.Text.Trim();
                string pMeslekGrupBaslangic = SpinEditMeslekGrupBaslangic.Text.Trim();
                string pMeslekGrupBitis = SpinEditMeslekGrupBitis.Text.Trim();
                string pUnvan = TextBoxUnvan.Text.Trim().ToLower(CultureInfo.CurrentCulture);
                string pTerkinDurumu = RadioButtonListTerkinSecim.SelectedItem.Value.ToString();
                string pDokumTipi = ComboBoxDokumTipi.SelectedItem.Value.ToString();

                GridViewAdresEtiketAra.DataSource = null;
                var sonuc =
                    entity.TUCCAR_SICIL.Include("TT_MESLEK_GRUP").Include("FIRMA_SAHIS").AsNoTracking().ToList().Select(p => new
                        {
                            p.TuccarSicilKey,
                            MeslekGrupKod = p.TT_MESLEK_GRUP.Kod,
                            p.SicilNo,
                            p.Unvan,
                            p.TerkinTarihi,
                            GercekMi = p.FIRMA_SAHIS.Count() == 1 ? true : false,
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
                                sonuc = sonuc.OrderBy(p => p.Unvan);
                                break;
                            case "2":
                                sonuc = sonuc.OrderBy(p => p.SicilNo);
                                break;
                        }
                        break;
                    case "2":
                        switch (ComboBoxSirala.SelectedItem.Value.ToString())
                        {
                            default:
                            case "1":
                                sonuc = sonuc.OrderByDescending(p => p.Unvan);
                                break;
                            case "2":
                                sonuc = sonuc.OrderByDescending(p => p.SicilNo);
                                break;
                        }
                        break;
                }

                #endregion

                #region koşullar

                if (!string.IsNullOrEmpty(pSicilNoBaslangic) || !string.IsNullOrEmpty(pSicilNoBitis))
                {
                    if (!string.IsNullOrEmpty(pSicilNoBaslangic) && string.IsNullOrEmpty(pSicilNoBitis))
                    {
                        int baslangic;
                        if (!int.TryParse(pSicilNoBaslangic, out baslangic))
                        {
                            if (!keylistegetir)
                            {
                                PageHelper.MessageBox(this, "Sicil numara girişi hatalıdır!");
                            }

                            return "";
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
                            if (!keylistegetir)
                            {
                                PageHelper.MessageBox(this, "Sicil numara girişi hatalıdır!");
                            }

                            return "";
                        }
                    }
                }

                if (!string.IsNullOrEmpty(pMeslekGrupBaslangic) || !string.IsNullOrEmpty(pMeslekGrupBitis))
                {
                    if (!string.IsNullOrEmpty(pMeslekGrupBaslangic) && string.IsNullOrEmpty(pMeslekGrupBitis))
                    {
                        int baslangic;
                        if (!int.TryParse(pMeslekGrupBaslangic, out baslangic))
                        {
                            if (!keylistegetir)
                            {
                                PageHelper.MessageBox(this, "Meslek grup kodu girişi hatalıdır!");
                            }

                            return "";
                        }

                        sonuc = sonuc.Where(p => p.MeslekGrupKod == pMeslekGrupBaslangic);
                    }
                    else
                    {
                        int baslangic;
                        int bitis;
                        if (int.TryParse(pMeslekGrupBaslangic, out baslangic) &&
                            int.TryParse(pMeslekGrupBitis, out bitis))
                        {
                            sonuc =
                                sonuc.Where(
                                    p =>
                                    Convert.ToInt32(p.MeslekGrupKod) >= baslangic &&
                                    Convert.ToInt32(p.MeslekGrupKod) <= bitis);
                        }
                        else
                        {
                            if (!keylistegetir)
                            {
                                PageHelper.MessageBox(this, "Meslek grup kodu girişi hatalıdır!");
                            }

                            return "";
                        }
                    }
                }

                if (!string.IsNullOrEmpty(pUnvan))
                {
                    sonuc = sonuc.Where(p => p.Unvan.ToLower(CultureInfo.CurrentCulture).Contains(pUnvan));
                }

                switch (pTerkinDurumu)
                {
                    case "1":
                        sonuc = sonuc.Where(p => p.TerkinTarihi == null);
                        break;
                }

                switch (pDokumTipi)
                {
                    default:
                    case "1":
                        sonuc = sonuc.Where(p => p.GercekMi);
                        break;
                    case "2":
                        sonuc = sonuc.Where(p => !p.GercekMi);
                        break;
                }

                #endregion

                GridViewAdresEtiketAra.DataSource = sonuc;
                GridViewAdresEtiketAra.DataBind();

                AdresEtiketListDoldur();

                foreach (int sicilkey in sonuc.Select(p => p.TuccarSicilKey))
                {
                    keylist += "," + sicilkey;
                }

                if (keylist.Length > 0)
                {
                    keylist = keylist.Remove(0, 1);
                }
            }

            return keylist;
        }

        private void AdresEtiketListDoldur()
        {
            using (var entity = new DBEntities())
            {
                var sonuc =
                    entity.TUCCAR_SICIL
                          .Where(p => AdresEtiketList.Contains(p.TuccarSicilKey))
                          .ToList()
                          .Select(p => new
                              {
                                  p.TuccarSicilKey,
                                  p.SicilNo,
                                  p.Unvan
                              });

                GridViewAdresEtiketBasilacak.DataSource = null;
                GridViewAdresEtiketBasilacak.DataSource = sonuc;
                GridViewAdresEtiketBasilacak.DataBind();
            }
        }

        private void AdresEtiketButtonAktifPasif()
        {
            if (AdresEtiketList.Count() > 0)
            {
                ButtonSecimliListeYazdir.Enabled = true;
            }
            else
            {
                ButtonSecimliListeYazdir.Enabled = false;
            }
        }

        private void PopUpOlustur()
        {
            PopupControlRapor.Windows.Clear();
            var popupRapor = new PopupWindow
                {
                    ShowOnPageLoad = true,
                    Modal = true,
                    ShowCloseButton = DefaultBoolean.True,
                    AutoUpdatePosition = true,
                    ContentUrl = "PopUp/RaporPopUp.aspx?Rapor=AdresEtiketleri",
                    Maximized = true,
                    ContentUrlIFrameTitle = "AdresEtiketleri",
                };
            PopupControlRapor.Windows.Add(popupRapor);
        }

        #endregion
    }
}
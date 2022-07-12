using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Security;
using System.Web.UI;
using DevExpress.Web.ASPxClasses;
using DevExpress.Web.ASPxEditors;
using DevExpress.Web.ASPxGridView;
using DevExpress.Web.Data;
using TicaretBorsasi_Project.Class.Helper;
using TicaretBorsasi_Project.Data;

namespace TicaretBorsasi_Project.User_Control.Ortak
{
    public partial class TuccarSicilBilgiKayitUserControl : UserControl
    {
        #region Properties

        private int TabIndex
        {
            get
            {
                int sonuc = 0;
                object index = Session["TabIndex"];
                if (index == null)
                {
                    return 0;
                }
                else
                {
                    int.TryParse(index.ToString(), out sonuc);
                }
                return sonuc;
            }
            set { Session["TabIndex"] = value; }
        }

        private bool? Detay
        {
            get
            {
                if (Session["Detay"] == null)
                {
                    return false;
                }
                else
                {
                    return true;
                }
            }
            set { Session["Detay"] = value; }
        }

        private int TuccarSicilKey
        {
            get
            {
                string key = Request.QueryString["Key"];
                if (Session["TuccarSicilKey"] == null || key != Session["TuccarSicilKey"].ToString())
                {
                    TabIndex = 0;
                    Detay = null;
                    FirmaYetkiliKey = null;
                    FirmaAdresKey = null;
                    FirmaTelefonFaxKey = null;
                    FirmaYonetimKey = null;
                    FirmaFaaliyetKey = null;
                    FirmaUyariKey = null;
                    FirmaKayitliOdaKey = null;
                    FirmaDigerFaaliyetKodKey = null;
                    Session["TuccarSicilKey"] = key;
                }

                int keysonuc;
                int.TryParse(key, out keysonuc);
                return keysonuc;
            }
        }

        private int? FirmaYetkiliKey
        {
            get
            {
                int keysonuc = 0;
                object key = Session["FirmaYetkiliKey"];
                if (key == null)
                {
                    return 0;
                }
                else
                {
                    int.TryParse(key.ToString(), out keysonuc);
                }
                return keysonuc;
            }
            set { Session["FirmaYetkiliKey"] = value; }
        }

        private int? FirmaAdresKey
        {
            get
            {
                int keysonuc = 0;
                object key = Session["FirmaAdresKey"];
                if (key == null)
                {
                    return 0;
                }
                else
                {
                    int.TryParse(key.ToString(), out keysonuc);
                }
                return keysonuc;
            }
            set { Session["FirmaAdresKey"] = value; }
        }

        private int? FirmaTelefonFaxKey
        {
            get
            {
                int keysonuc = 0;
                object key = Session["FirmaTelefonFaxKey"];
                if (key == null)
                {
                    return 0;
                }
                else
                {
                    int.TryParse(key.ToString(), out keysonuc);
                }
                return keysonuc;
            }
            set { Session["FirmaTelefonFaxKey"] = value; }
        }

        private int? FirmaYonetimKey
        {
            get
            {
                int keysonuc = 0;
                object key = Session["FirmaYonetimKey"];
                if (key == null)
                {
                    return 0;
                }
                else
                {
                    int.TryParse(key.ToString(), out keysonuc);
                }
                return keysonuc;
            }
            set { Session["FirmaYonetimKey"] = value; }
        }

        private int? FirmaFaaliyetKey
        {
            get
            {
                int keysonuc = 0;
                object key = Session["FirmaFaaliyetKey"];
                if (key == null)
                {
                    return 0;
                }
                else
                {
                    int.TryParse(key.ToString(), out keysonuc);
                }
                return keysonuc;
            }
            set { Session["FirmaFaaliyetKey"] = value; }
        }

        private int? FirmaUyariKey
        {
            get
            {
                int keysonuc = 0;
                object key = Session["FirmaUyariKey"];
                if (key == null)
                {
                    return 0;
                }
                else
                {
                    int.TryParse(key.ToString(), out keysonuc);
                }
                return keysonuc;
            }
            set { Session["FirmaUyariKey"] = value; }
        }

        private int? FirmaKayitliOdaKey
        {
            get
            {
                int keysonuc = 0;
                object key = Session["FirmaKayitliOdaKey"];
                if (key == null)
                {
                    return 0;
                }
                else
                {
                    int.TryParse(key.ToString(), out keysonuc);
                }
                return keysonuc;
            }
            set { Session["FirmaKayitliOdaKey"] = value; }
        }

        private int? FirmaDigerFaaliyetKodKey
        {
            get
            {
                int keysonuc = 0;
                object key = Session["FirmaDigerFaaliyetKodKey"];
                if (key == null)
                {
                    return 0;
                }
                else
                {
                    int.TryParse(key.ToString(), out keysonuc);
                }
                return keysonuc;
            }
            set { Session["FirmaDigerFaaliyetKodKey"] = value; }
        }

        #endregion

        #region Events

        protected void Page_Load(object sender, EventArgs e)
        {
            SetInitials();
        }

        #region Tuccar Sicil Bilgi

        protected void ButtonDetayGoster_Click(object sender, EventArgs e)
        {
            TabIndex = 0;

            if (Detay == true)
            {
                Detay = null;
            }
            else
            {
                Detay = true;
            }

            Response.Redirect(Request.Url.AbsoluteUri);
        }

        protected void ButtonGeriIleri_Click(object sender, EventArgs e)
        {
            TabIndex = 0;
            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                int sicilno = Convert.ToInt32(PageHelper.SicilNoTamamlama(TextBoxSicilNo.Text));
                string butonadi = ((ASPxButton)sender).ID;
                var tuccarlistesi = entity.TUCCAR_SICIL.AsNoTracking().ToList().OrderBy(p => p.SicilNo);
                TUCCAR_SICIL _TUCCAR_SICIL = null;
                switch (butonadi)
                {
                    case "ButtonGeri":
                        _TUCCAR_SICIL = tuccarlistesi.LastOrDefault(p => Convert.ToInt32(p.SicilNo) < sicilno);
                        if (_TUCCAR_SICIL == null)
                        {
                            _TUCCAR_SICIL = tuccarlistesi.First();
                        }
                        break;
                    case "ButtonIleri":
                        _TUCCAR_SICIL = tuccarlistesi.FirstOrDefault(p => Convert.ToInt32(p.SicilNo) > sicilno);
                        if (_TUCCAR_SICIL == null)
                        {
                            _TUCCAR_SICIL = tuccarlistesi.Last();
                        }
                        break;
                }

                int key = _TUCCAR_SICIL.TuccarSicilKey;
                Response.Redirect(string.Format("TuccarSicilBilgiKayit.aspx?Key={0}", key));
            }
        }

        protected void ButtonAra_Click(object sender, EventArgs e)
        {
            TabIndex = 0;
            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                string sicilno = PageHelper.SicilNoTamamlama(TextBoxSicilNo.Text);
                TUCCAR_SICIL _TUCCAR_SICIL = entity.TUCCAR_SICIL.AsNoTracking().SingleOrDefault(p => p.SicilNo == sicilno);
                if (_TUCCAR_SICIL == null)
                {
                    PageControlSicilBilgi.TabPages[0].Visible = false;
                    PageHelper.MessageBox(this.Page, "Tüccar bulunamadı.");
                    PageControlSicilBilgi.TabPages[0].Visible = true;
                }
                else
                {
                    int key = _TUCCAR_SICIL.TuccarSicilKey;
                    Response.Redirect(string.Format("TuccarSicilBilgiKayit.aspx?Key={0}", key));
                }
            }
        }

        protected void ButtonKaydetGuncelle_Click(object sender, EventArgs e)
        {
            TabIndex = 0;
            TabSelect();

            using (var entity = new DBEntities())
            {
                #region validation

                string pTcKimlikNo = TextBoxTcKimlikNo.Text;
                string pSicilNo = PageHelper.SicilNoTamamlama(TextBoxSicilNo.Text);
                if (!PageHelper.TcKimlikDogrulama(pTcKimlikNo))
                {
                    PageHelper.MessageBox(this.Page, "Hatalı TC kimlik numarası girişi yaptınız!");
                    return;
                }

                if (TuccarSicilKey == 0 && pSicilNo == "000000")
                {
                    PageHelper.MessageBox(this.Page, "Lütfen sicil no girişi yapınız!");
                    return;
                }

                if (TuccarSicilKey == 0 && AyniSicilNoVarMi(pSicilNo))
                {
                    PageHelper.MessageBox(this.Page, "Aynı sicil noya sahip başka bir kayıt bulunmaktadır!");
                    return;
                }

                #endregion

                TUCCAR_SICIL _TUCCAR_SICIL;
                if (TuccarSicilKey == 0)
                {
                    _TUCCAR_SICIL = new TUCCAR_SICIL();
                }
                else
                {
                    _TUCCAR_SICIL = entity.TUCCAR_SICIL.Single(p => p.TuccarSicilKey == TuccarSicilKey);

                    if (pSicilNo != _TUCCAR_SICIL.SicilNo && AyniSicilNoVarMi(pSicilNo))
                    {
                        PageHelper.MessageBox(this.Page, "Aynı sicil noya sahip başka bir kayıt bulunmaktadır!");
                        return;
                    }
                }

                _TUCCAR_SICIL.SicilNo = PageHelper.SicilNoTamamlama(TextBoxSicilNo.Text);
                _TUCCAR_SICIL.Unvan = MemoUnvan.Text;
                _TUCCAR_SICIL.MeslekGrupKey = Convert.ToInt32(ComboBoxMeslekGrubu.SelectedItem.Value);
                _TUCCAR_SICIL.DereceKey = Convert.ToInt32(ComboBoxDerece.SelectedItem.Value);
                _TUCCAR_SICIL.DereceYil = string.IsNullOrEmpty(SpinEditDereceYil.Text)
                                              ? null
                                              : (short?)Convert.ToInt16(SpinEditDereceYil.Text);
                _TUCCAR_SICIL.MersisNo = TextBoxMersisNo.Text;
                _TUCCAR_SICIL.MerkezSubeMi = ComboBoxMerkezSubeMi.SelectedIndex == 0 ? true : false;
                _TUCCAR_SICIL.KayitTescilMi = ComboBoxKayitTescilMi.SelectedIndex == 0 ? true : false;
                _TUCCAR_SICIL.BolgeAdi = TextBoxBolgeAdi.Text;
                _TUCCAR_SICIL.IsciSayisi = SpinEditIsciSayisi.Text;
                _TUCCAR_SICIL.EpostaAdresi = TextBoxEpostaAdresi.Text;
                _TUCCAR_SICIL.WebAdresi = TextBoxWebAdresi.Text;
                _TUCCAR_SICIL.ResenKayitMi = CheckBoxResenKayitMi.Checked;
                _TUCCAR_SICIL.NaceKodu1 = TextBoxNaceKodu1.Text;
                _TUCCAR_SICIL.NaceKodu2 = TextBoxNaceKodu2.Text;
                _TUCCAR_SICIL.KurulusTurKey = Convert.ToInt32(ComboBoxKurulusTur.SelectedItem.Value);
                _TUCCAR_SICIL.SicilMemurluguKey = Convert.ToInt32(ComboBoxSicilMemurlugu.SelectedItem.Value);
                _TUCCAR_SICIL.SicilTarih = (DateTime?)DateEditSicilTarih.Value;
                _TUCCAR_SICIL.SicilKayitNo = TextBoxTicaretSicilNo.Text;
                _TUCCAR_SICIL.IlIlceKey = Convert.ToInt32(ComboBoxIlIlce.SelectedItem.Value);
                _TUCCAR_SICIL.KayitTarihi = (DateTime?)DateEditKayitTarihi.Value;
                _TUCCAR_SICIL.YKKTarihi = (DateTime?)DateEditYKKTarihi.Value;
                _TUCCAR_SICIL.YKKNo = TextBoxYKKNo.Text;
                _TUCCAR_SICIL.TerkinTarihi = (DateTime?)DateEditTerkinTarihi.Value;
                _TUCCAR_SICIL.TerkinYKKNo = TextBoxTerkinYKKNo.Text;
                _TUCCAR_SICIL.Sermaye = string.IsNullOrEmpty(SpinEditSermaye.Text)
                                            ? 0
                                            : Convert.ToDecimal(SpinEditSermaye.Value);
                _TUCCAR_SICIL.VergiDaireKey = ComboBoxVergiDairesi.SelectedIndex == -1
                                                  ? null
                                                  : (int?)Convert.ToInt32(ComboBoxVergiDairesi.SelectedItem.Value);
                _TUCCAR_SICIL.VergiNo = string.IsNullOrEmpty(SpinEditVergiNo.Text) ? null : SpinEditVergiNo.Text;
                _TUCCAR_SICIL.TCKimlikNo = TextBoxTcKimlikNo.Text;
                _TUCCAR_SICIL.VergiNoEski = TextBoxVergiNoEski.Text;
                _TUCCAR_SICIL.Aciklama = MemoAciklama.Text;

                MembershipUser user = Membership.GetUser(true);
                Guid userkey = user == null ? Guid.Empty : (Guid)user.ProviderUserKey;
                if (TuccarSicilKey == 0)
                {
                    _TUCCAR_SICIL.KayitKisiKey = userkey;
                    _TUCCAR_SICIL.KayitTarih = DateTime.Now;
                    entity.TUCCAR_SICIL.Add(_TUCCAR_SICIL);

                    //değişiklik kayıtları yapılıyor

                    #region Derece Değişiklik Kaydı

                    var _DERECE_DEGISIKLIK = new DERECE_DEGISIKLIK();

                    _DERECE_DEGISIKLIK.TuccarSicilKey = _TUCCAR_SICIL.TuccarSicilKey;
                    _DERECE_DEGISIKLIK.DereceKey = _TUCCAR_SICIL.DereceKey;
                    _DERECE_DEGISIKLIK.DereceVerilisYil = Convert.ToInt16(DateTime.Now.Year);
                    _DERECE_DEGISIKLIK.YKKTarih = _TUCCAR_SICIL.YKKTarihi;
                    _DERECE_DEGISIKLIK.YKKNo = _TUCCAR_SICIL.YKKNo;
                    _DERECE_DEGISIKLIK.KayitKisiKey = userkey;
                    _DERECE_DEGISIKLIK.KayitTarih = DateTime.Now;
                    entity.DERECE_DEGISIKLIK.Add(_DERECE_DEGISIKLIK);

                    #endregion

                    #region Unvan Değişiklik Kaydı

                    var _UNVAN_DEGISIKLIK = new UNVAN_DEGISIKLIK();

                    _UNVAN_DEGISIKLIK.TuccarSicilKey = _TUCCAR_SICIL.TuccarSicilKey;
                    _UNVAN_DEGISIKLIK.Unvan = _TUCCAR_SICIL.Unvan;
                    _UNVAN_DEGISIKLIK.Yil = Convert.ToInt16(DateTime.Now.Year);
                    _UNVAN_DEGISIKLIK.YKKTarih = _TUCCAR_SICIL.YKKTarihi;
                    _UNVAN_DEGISIKLIK.YKKNo = _TUCCAR_SICIL.YKKNo;
                    _UNVAN_DEGISIKLIK.KayitKisiKey = userkey;
                    _UNVAN_DEGISIKLIK.KayitTarih = DateTime.Now;
                    entity.UNVAN_DEGISIKLIK.Add(_UNVAN_DEGISIKLIK);

                    #endregion

                    #region Sermaye Değişiklik Kaydı

                    if (_TUCCAR_SICIL.Sermaye != null)
                    {
                        var _SERMAYE_DEGISIKLIK = new SERMAYE_DEGISIKLIK();

                        _SERMAYE_DEGISIKLIK.TuccarSicilKey = _TUCCAR_SICIL.TuccarSicilKey;
                        _SERMAYE_DEGISIKLIK.Sermaye = _TUCCAR_SICIL.Sermaye.Value;
                        _SERMAYE_DEGISIKLIK.Yil = Convert.ToInt16(DateTime.Now.Year);
                        _SERMAYE_DEGISIKLIK.YKKTarih = _TUCCAR_SICIL.YKKTarihi;
                        _SERMAYE_DEGISIKLIK.YKKNo = _TUCCAR_SICIL.YKKNo;
                        _SERMAYE_DEGISIKLIK.KayitKisiKey = userkey;
                        _SERMAYE_DEGISIKLIK.KayitTarih = DateTime.Now;
                        entity.SERMAYE_DEGISIKLIK.Add(_SERMAYE_DEGISIKLIK);
                    }

                    #endregion

                    #region Meslek Grubu Değişiklik Kaydı

                    var _MESLEK_GRUP_DEGISIKLIK = new MESLEK_GRUP_DEGISIKLIK();

                    _MESLEK_GRUP_DEGISIKLIK.TuccarSicilKey = _TUCCAR_SICIL.TuccarSicilKey;
                    _MESLEK_GRUP_DEGISIKLIK.MeslekGrupKey = _TUCCAR_SICIL.MeslekGrupKey.Value;
                    _MESLEK_GRUP_DEGISIKLIK.Yil = Convert.ToInt16(DateTime.Now.Year);
                    _MESLEK_GRUP_DEGISIKLIK.YKKTarih = _TUCCAR_SICIL.YKKTarihi;
                    _MESLEK_GRUP_DEGISIKLIK.YKKNo = _TUCCAR_SICIL.YKKNo;
                    _MESLEK_GRUP_DEGISIKLIK.KayitKisiKey = userkey;
                    _MESLEK_GRUP_DEGISIKLIK.KayitTarih = DateTime.Now;
                    entity.MESLEK_GRUP_DEGISIKLIK.Add(_MESLEK_GRUP_DEGISIKLIK);

                    #endregion
                }
                else
                {
                    _TUCCAR_SICIL.GuncelleKisiKey = userkey;
                    _TUCCAR_SICIL.GuncelleTarih = DateTime.Now;
                }

                entity.SaveChanges();

                Response.Redirect(string.Format("TuccarSicilBilgiKayit.aspx?Key={0}", _TUCCAR_SICIL.TuccarSicilKey));
            }
        }

        protected void ButtonIptal_Click(object sender, EventArgs e)
        {
            TabIndex = 0;
            Response.Redirect("TuccarSicilBilgiKayit.aspx");
        }

        protected void ButtonTemizle_Click(object sender, EventArgs e)
        {
            TabIndex = 0;
            Response.Redirect(Request.Url.AbsoluteUri);
        }

        #endregion

        #region Firma Sahis Bilgi

        protected void ButtonFirmaSahisBilgiGuncelle_Click(object sender, EventArgs e)
        {
            TabIndex = 1;
            TabSelect();

            using (var entity = new DBEntities())
            {
                bool ilkkayit = false;
                FIRMA_SAHIS _FIRMA_SAHIS = entity.FIRMA_SAHIS.SingleOrDefault(p => p.TuccarSicilKey == TuccarSicilKey);
                if (_FIRMA_SAHIS == null)
                {
                    ilkkayit = true;
                    _FIRMA_SAHIS = new FIRMA_SAHIS();
                    _FIRMA_SAHIS.TuccarSicilKey = TuccarSicilKey;
                }

                _FIRMA_SAHIS.Ad = TextBoxFirmaSahisBilgiAd.Text;
                _FIRMA_SAHIS.Soyad = TextBoxFirmaSahisBilgiSoyad.Text;
                _FIRMA_SAHIS.BabaAdi = TextBoxFirmaSahisBilgiBabaAdi.Text;
                _FIRMA_SAHIS.Uyruk = TextBoxFirmaSahisBilgiUyruk.Text;
                _FIRMA_SAHIS.DogumYeri = TextBoxFirmaSahisBilgiDogumYeri.Text;
                _FIRMA_SAHIS.DogumTarihi = Convert.ToDateTime(DateEditFirmaSahisBilgiDogumTarihi.Value);
                _FIRMA_SAHIS.OgrenimDurumTipKey = Convert.ToByte(ComboBoxFirmaSahisBilgiTahsilDurumu.SelectedItem.Value);
                _FIRMA_SAHIS.Tel = TextBoxFirmaSahisBilgiTel.Text;
                _FIRMA_SAHIS.Adres = MemoFirmaSahisBilgiAdres.Text;
                _FIRMA_SAHIS.TcKimlikNo = TextBoxFirmaSahisBilgiTel.Text;

                MembershipUser user = Membership.GetUser(true);
                Guid userkey = user == null ? Guid.Empty : (Guid)user.ProviderUserKey;
                if (ilkkayit)
                {
                    _FIRMA_SAHIS.KayitKisiKey = userkey;
                    _FIRMA_SAHIS.KayitTarih = DateTime.Now;
                    entity.FIRMA_SAHIS.Add(_FIRMA_SAHIS);
                }
                else
                {
                    _FIRMA_SAHIS.GuncelleKisiKey = userkey;
                    _FIRMA_SAHIS.GuncelleTarih = DateTime.Now;
                }

                entity.SaveChanges();
            }
        }

        protected void ButtonFirmaSahisBilgiIptal_Click(object sender, EventArgs e)
        {
            TabIndex = 1;
            TabSelect();
            FirmaSahisBilgiDataLoad();
        }

        protected void ButtonFirmaSahisBilgiSil_Click(object sender, EventArgs e)
        {
            TabIndex = 1;
            TabSelect();

            using (var entity = new DBEntities())
            {
                FIRMA_SAHIS _FIRMA_SAHIS = entity.FIRMA_SAHIS.SingleOrDefault(p => p.TuccarSicilKey == TuccarSicilKey);
                if (_FIRMA_SAHIS != null)
                {
                    entity.FIRMA_SAHIS.Remove(_FIRMA_SAHIS);
                }
                entity.SaveChanges();
            }

            FirmaSahisBilgiDataLoad();
        }

        #endregion

        #region Firma Adres Bilgi

        protected void ButtonFirmaAdresBilgiKaydetGuncelle_Click(object sender, EventArgs e)
        {
            TabIndex = 2;
            TabSelect();

            using (var entity = new DBEntities())
            {
                #region validation

                #endregion

                FIRMA_ADRES _FIRMA_ADRES;
                if (FirmaAdresKey == 0)
                {
                    _FIRMA_ADRES = new FIRMA_ADRES();
                }
                else
                {
                    _FIRMA_ADRES = entity.FIRMA_ADRES.SingleOrDefault(p => p.FirmaAdresKey == FirmaAdresKey);
                    if (_FIRMA_ADRES == null)
                    {
                        return;
                    }
                }

                _FIRMA_ADRES.FirmaAdres = MemoFirmaAdres.Text;
                _FIRMA_ADRES.TuccarSicilKey = TuccarSicilKey;
                if (ComboBoxFirmaAdresTip.SelectedIndex != -1)
                {
                    _FIRMA_ADRES.FirmaAdresTipKey = Convert.ToByte(ComboBoxFirmaAdresTip.SelectedItem.Value);
                }

                MembershipUser user = Membership.GetUser(true);
                Guid userkey = user == null ? Guid.Empty : (Guid)user.ProviderUserKey;
                if (FirmaAdresKey == 0)
                {
                    _FIRMA_ADRES.KayitKisiKey = userkey;
                    _FIRMA_ADRES.KayitTarih = DateTime.Now;
                    entity.FIRMA_ADRES.Add(_FIRMA_ADRES);
                }
                else
                {
                    _FIRMA_ADRES.GuncelleKisiKey = userkey;
                    _FIRMA_ADRES.GuncelleTarih = DateTime.Now;
                }

                entity.SaveChanges();
            }

            FirmaAdresKey = null;
            FirmaAdresBilgiDataLoad();
            SetInitials();
        }

        protected void ButtonFirmaAdresBilgiIptalTemizle_Click(object sender, EventArgs e)
        {
            TabIndex = 2;
            TabSelect();

            FirmaAdresKey = null;
            FirmaAdresBilgiDataLoad();
            SetInitials();
        }

        protected void GridViewFirmaAdresBilgi_RowDeleting(object sender, ASPxDataDeletingEventArgs e)
        {
            TabIndex = 2;
            using (var entity = new DBEntities())
            {
                int deletedkey = Convert.ToInt32(e.Keys[0]);
                FIRMA_ADRES deleteddata = entity.FIRMA_ADRES.Single(p => p.FirmaAdresKey == deletedkey);
                entity.FIRMA_ADRES.Remove(deleteddata);

                try
                {
                    if (FirmaAdresKey != 0)
                    {
                        GridViewFirmaAdresBilgi.JSProperties["cpErrorMessage"] = true;
                    }
                    else
                    {
                        entity.SaveChanges();
                        GridViewFirmaAdresBilgi.JSProperties["cpErrorMessage"] = false;
                    }
                }
                catch
                {
                    GridViewFirmaAdresBilgi.JSProperties["cpErrorMessage"] = true;
                }
            }

            FirmaAdresBilgiDataLoad();
            e.Cancel = true;
        }

        protected void GridViewFirmaAdresBilgi_CustomButtonCallback(object sender,
                                                                    ASPxGridViewCustomButtonCallbackEventArgs e)
        {
            TabIndex = 2;
            TabSelect();

            int index = e.VisibleIndex;
            int firmaadreskey = Convert.ToInt32(GridViewFirmaAdresBilgi.GetRowValues(index, new[] { "FirmaAdresKey" }));

            FirmaAdresKey = firmaadreskey;
            ASPxWebControl.RedirectOnCallback(string.Format("TuccarSicilBilgiKayit.aspx?Key={0}", TuccarSicilKey));
        }

        #endregion

        #region Firma Telefon/Fax Bilgi

        protected void ButtonFirmaTelefonFaxBilgiKaydetGuncelle_Click(object sender, EventArgs e)
        {
            TabIndex = 3;
            TabSelect();

            using (var entity = new DBEntities())
            {
                #region validation

                #endregion

                FIRMA_TELEFON_FAX _FIRMA_TELEFON_FAX;
                if (FirmaTelefonFaxKey == 0)
                {
                    _FIRMA_TELEFON_FAX = new FIRMA_TELEFON_FAX();
                }
                else
                {
                    _FIRMA_TELEFON_FAX =
                        entity.FIRMA_TELEFON_FAX.SingleOrDefault(p => p.FirmaTelefonFaxKey == FirmaTelefonFaxKey);
                    if (_FIRMA_TELEFON_FAX == null)
                    {
                        return;
                    }
                }

                _FIRMA_TELEFON_FAX.FirmaTelefonFax = TextBoxFirmaTelefonFax.Text;

                if (ComboBoxFirmaTelefonFaxTip.SelectedIndex != -1)
                {
                    _FIRMA_TELEFON_FAX.FirmaTelefonFaxTipKey =
                        Convert.ToByte(ComboBoxFirmaTelefonFaxTip.SelectedItem.Value);
                }

                _FIRMA_TELEFON_FAX.TuccarSicilKey = TuccarSicilKey;

                MembershipUser user = Membership.GetUser(true);
                Guid userkey = user == null ? Guid.Empty : (Guid)user.ProviderUserKey;
                if (FirmaTelefonFaxKey == 0)
                {
                    _FIRMA_TELEFON_FAX.KayitKisiKey = userkey;
                    _FIRMA_TELEFON_FAX.KayitTarih = DateTime.Now;
                    entity.FIRMA_TELEFON_FAX.Add(_FIRMA_TELEFON_FAX);
                }
                else
                {
                    _FIRMA_TELEFON_FAX.GuncelleKisiKey = userkey;
                    _FIRMA_TELEFON_FAX.GuncelleTarih = DateTime.Now;
                }

                entity.SaveChanges();
            }

            FirmaTelefonFaxKey = null;
            FirmaTelefonFaxBilgiDataLoad();
            SetInitials();
        }

        protected void ButtonFirmaTelefonFaxBilgiIptalTemizle_Click(object sender, EventArgs e)
        {
            TabIndex = 3;
            TabSelect();

            FirmaTelefonFaxKey = null;
            FirmaTelefonFaxBilgiDataLoad();
            SetInitials();
        }

        protected void GridViewFirmaTelefonFaxBilgi_RowDeleting(object sender, ASPxDataDeletingEventArgs e)
        {
            TabIndex = 3;

            using (var entity = new DBEntities())
            {
                int deletedkey = Convert.ToInt32(e.Keys[0]);
                FIRMA_TELEFON_FAX deleteddata = entity.FIRMA_TELEFON_FAX.Single(p => p.FirmaTelefonFaxKey == deletedkey);
                entity.FIRMA_TELEFON_FAX.Remove(deleteddata);

                try
                {
                    if (FirmaTelefonFaxKey != 0)
                    {
                        GridViewFirmaTelefonFaxBilgi.JSProperties["cpErrorMessage"] = true;
                    }
                    else
                    {
                        entity.SaveChanges();
                        GridViewFirmaTelefonFaxBilgi.JSProperties["cpErrorMessage"] = false;
                    }
                }
                catch
                {
                    GridViewFirmaTelefonFaxBilgi.JSProperties["cpErrorMessage"] = true;
                }
            }

            FirmaTelefonFaxBilgiDataLoad();
            e.Cancel = true;
        }

        protected void GridViewFirmaTelefonFaxBilgi_CustomButtonCallback(object sender,
                                                                         ASPxGridViewCustomButtonCallbackEventArgs e)
        {
            TabIndex = 3;
            TabSelect();

            int index = e.VisibleIndex;
            int firmatelefonfaxkey =
                Convert.ToInt32(GridViewFirmaTelefonFaxBilgi.GetRowValues(index, new[] { "FirmaTelefonFaxKey" }));

            FirmaTelefonFaxKey = firmatelefonfaxkey;
            ASPxWebControl.RedirectOnCallback(string.Format("TuccarSicilBilgiKayit.aspx?Key={0}", TuccarSicilKey));
        }

        #endregion

        #region Firma Yetkili Bilgi

        protected void ButtonFirmaYetkiliBilgiKaydetGuncelle_Click(object sender, EventArgs e)
        {
            TabIndex = 4;
            TabSelect();

            using (var entity = new DBEntities())
            {
                #region validation

                #endregion

                FIRMA_YETKILI _FIRMA_YETKILI;
                if (FirmaYetkiliKey == 0)
                {
                    _FIRMA_YETKILI = new FIRMA_YETKILI();
                }
                else
                {
                    _FIRMA_YETKILI = entity.FIRMA_YETKILI.SingleOrDefault(p => p.FirmaYetkiliKey == FirmaYetkiliKey);
                    if (_FIRMA_YETKILI == null)
                    {
                        return;
                    }
                }

                _FIRMA_YETKILI.AdSoyad = TextBoxFirmaYetkiliBilgiAdSoyad.Text;
                _FIRMA_YETKILI.TuccarSicilKey = TuccarSicilKey;

                MembershipUser user = Membership.GetUser(true);
                Guid userkey = user == null ? Guid.Empty : (Guid)user.ProviderUserKey;
                if (FirmaYetkiliKey == 0)
                {
                    _FIRMA_YETKILI.KayitKisiKey = userkey;
                    _FIRMA_YETKILI.KayitTarih = DateTime.Now;
                    entity.FIRMA_YETKILI.Add(_FIRMA_YETKILI);
                }
                else
                {
                    _FIRMA_YETKILI.GuncelleKisiKey = userkey;
                    _FIRMA_YETKILI.GuncelleTarih = DateTime.Now;
                }

                entity.SaveChanges();
            }

            FirmaYetkiliKey = null;
            FirmaYetkiliBilgiDataLoad();
            SetInitials();
        }

        protected void ButtonFirmaYetkiliBilgiIptalTemizle_Click(object sender, EventArgs e)
        {
            TabIndex = 4;
            TabSelect();

            FirmaYetkiliKey = null;
            FirmaYetkiliBilgiDataLoad();
            SetInitials();
        }

        protected void GridViewFirmaYetkiliBilgi_RowDeleting(object sender, ASPxDataDeletingEventArgs e)
        {
            TabIndex = 4;

            using (var entity = new DBEntities())
            {
                int deletedkey = Convert.ToInt32(e.Keys[0]);
                FIRMA_YETKILI deleteddata = entity.FIRMA_YETKILI.Single(p => p.FirmaYetkiliKey == deletedkey);
                entity.FIRMA_YETKILI.Remove(deleteddata);

                try
                {
                    if (FirmaYetkiliKey != 0)
                    {
                        GridViewFirmaYetkiliBilgi.JSProperties["cpErrorMessage"] = true;
                    }
                    else
                    {
                        entity.SaveChanges();
                        GridViewFirmaYetkiliBilgi.JSProperties["cpErrorMessage"] = false;
                    }
                }
                catch
                {
                    GridViewFirmaYetkiliBilgi.JSProperties["cpErrorMessage"] = true;
                }
            }

            FirmaYetkiliBilgiDataLoad();
            e.Cancel = true;
        }

        protected void GridViewFirmaYetkiliBilgi_CustomButtonCallback(object sender,
                                                                      ASPxGridViewCustomButtonCallbackEventArgs e)
        {
            TabIndex = 4;
            TabSelect();

            int index = e.VisibleIndex;
            int firmayetkilikey =
                Convert.ToInt32(GridViewFirmaYetkiliBilgi.GetRowValues(index, new[] { "FirmaYetkiliKey" }));

            FirmaYetkiliKey = firmayetkilikey;
            ASPxWebControl.RedirectOnCallback(string.Format("TuccarSicilBilgiKayit.aspx?Key={0}", TuccarSicilKey));
        }

        #endregion

        #region Firma Yonetim Bilgi

        protected void ButtonFirmaYonetimBilgiKaydetGuncelle_Click(object sender, EventArgs e)
        {
            TabIndex = 5;
            TabSelect();

            using (var entity = new DBEntities())
            {
                #region validation

                #endregion

                FIRMA_YONETIM _FIRMA_YONETIM;
                if (FirmaYonetimKey == 0)
                {
                    _FIRMA_YONETIM = new FIRMA_YONETIM();
                }
                else
                {
                    _FIRMA_YONETIM = entity.FIRMA_YONETIM.SingleOrDefault(p => p.FirmaYonetimKey == FirmaYonetimKey);
                    if (_FIRMA_YONETIM == null)
                    {
                        return;
                    }
                }

                _FIRMA_YONETIM.AdSoyad = TextBoxFirmaYonetimBilgiAdSoyad.Text;
                _FIRMA_YONETIM.Unvan = TextBoxFirmaYonetimBilgiUnvan.Text;
                _FIRMA_YONETIM.TuccarSicilKey = TuccarSicilKey;

                MembershipUser user = Membership.GetUser(true);
                Guid userkey = user == null ? Guid.Empty : (Guid)user.ProviderUserKey;
                if (FirmaYonetimKey == 0)
                {
                    _FIRMA_YONETIM.KayitKisiKey = userkey;
                    _FIRMA_YONETIM.KayitTarih = DateTime.Now;
                    entity.FIRMA_YONETIM.Add(_FIRMA_YONETIM);
                }
                else
                {
                    _FIRMA_YONETIM.GuncelleKisiKey = userkey;
                    _FIRMA_YONETIM.GuncelleTarih = DateTime.Now;
                }

                entity.SaveChanges();
            }

            FirmaYonetimKey = null;
            FirmaYonetimBilgiDataLoad();
            SetInitials();
        }

        protected void ButtonFirmaYonetimBilgiIptalTemizle_Click(object sender, EventArgs e)
        {
            TabIndex = 5;
            TabSelect();

            FirmaYonetimKey = null;
            FirmaYonetimBilgiDataLoad();
            SetInitials();
        }

        protected void GridViewFirmaYonetimBilgi_RowDeleting(object sender, ASPxDataDeletingEventArgs e)
        {
            TabIndex = 5;

            using (var entity = new DBEntities())
            {
                int deletedkey = Convert.ToInt32(e.Keys[0]);
                FIRMA_YONETIM deleteddata = entity.FIRMA_YONETIM.Single(p => p.FirmaYonetimKey == deletedkey);
                entity.FIRMA_YONETIM.Remove(deleteddata);

                try
                {
                    if (FirmaYonetimKey != 0)
                    {
                        GridViewFirmaYonetimBilgi.JSProperties["cpErrorMessage"] = true;
                    }
                    else
                    {
                        entity.SaveChanges();
                        GridViewFirmaYonetimBilgi.JSProperties["cpErrorMessage"] = false;
                    }
                }
                catch
                {
                    GridViewFirmaYonetimBilgi.JSProperties["cpErrorMessage"] = true;
                }
            }

            FirmaYonetimBilgiDataLoad();
            e.Cancel = true;
        }

        protected void GridViewFirmaYonetimBilgi_CustomButtonCallback(object sender,
                                                                      ASPxGridViewCustomButtonCallbackEventArgs e)
        {
            TabIndex = 5;
            TabSelect();

            int index = e.VisibleIndex;
            int firmayonetimkey =
                Convert.ToInt32(GridViewFirmaYonetimBilgi.GetRowValues(index, new[] { "FirmaYonetimKey" }));

            FirmaYonetimKey = firmayonetimkey;
            ASPxWebControl.RedirectOnCallback(string.Format("TuccarSicilBilgiKayit.aspx?Key={0}", TuccarSicilKey));
        }

        #endregion

        #region Firma Faaliyet Bilgi

        protected void ButtonFirmaFaaliyetBilgiKaydetGuncelle_Click(object sender, EventArgs e)
        {
            TabIndex = 6;
            TabSelect();

            using (var entity = new DBEntities())
            {
                #region validation

                #endregion

                FIRMA_FAALIYET _FIRMA_FAALIYET;
                if (FirmaFaaliyetKey == 0)
                {
                    _FIRMA_FAALIYET = new FIRMA_FAALIYET();
                }
                else
                {
                    _FIRMA_FAALIYET = entity.FIRMA_FAALIYET.SingleOrDefault(p => p.FirmaFaaliyetKey == FirmaFaaliyetKey);
                    if (_FIRMA_FAALIYET == null)
                    {
                        return;
                    }
                }

                _FIRMA_FAALIYET.MaddeKodKey = Convert.ToInt32(ComboBoxFirmaFaaliyetBilgiMaddeKodu.SelectedItem.Value);
                _FIRMA_FAALIYET.Uretim = CheckBoxFirmaFaaliyetBilgiUretim.Checked;
                _FIRMA_FAALIYET.Bayi = CheckBoxFirmaFaaliyetBilgiBayii.Checked;
                _FIRMA_FAALIYET.Alim = CheckBoxFirmaFaaliyetBilgiAlim.Checked;
                _FIRMA_FAALIYET.Satim = CheckBoxFirmaFaaliyetBilgiSatim.Checked;
                _FIRMA_FAALIYET.Ithalat = CheckBoxFirmaFaaliyetBilgiIthalat.Checked;
                _FIRMA_FAALIYET.Ihracat = CheckBoxFirmaFaaliyetBilgiIhracat.Checked;
                _FIRMA_FAALIYET.TuccarSicilKey = TuccarSicilKey;

                MembershipUser user = Membership.GetUser(true);
                Guid userkey = user == null ? Guid.Empty : (Guid)user.ProviderUserKey;
                if (FirmaFaaliyetKey == 0)
                {
                    _FIRMA_FAALIYET.KayitKisiKey = userkey;
                    _FIRMA_FAALIYET.KayitTarih = DateTime.Now;
                    entity.FIRMA_FAALIYET.Add(_FIRMA_FAALIYET);
                }
                else
                {
                    _FIRMA_FAALIYET.GuncelleKisiKey = userkey;
                    _FIRMA_FAALIYET.GuncelleTarih = DateTime.Now;
                }

                entity.SaveChanges();
            }

            FirmaFaaliyetKey = null;
            FirmaFaaliyetBilgiDataLoad();
            SetInitials();
        }

        protected void ButtonFirmaFaaliyetBilgiIptalTemizle_Click(object sender, EventArgs e)
        {
            TabIndex = 6;
            TabSelect();

            FirmaFaaliyetKey = null;
            FirmaFaaliyetBilgiDataLoad();
            SetInitials();
        }

        protected void GridViewFirmaFaaliyetBilgi_RowDeleting(object sender, ASPxDataDeletingEventArgs e)
        {
            TabIndex = 6;

            using (var entity = new DBEntities())
            {
                int deletedkey = Convert.ToInt32(e.Keys[0]);
                FIRMA_FAALIYET deleteddata = entity.FIRMA_FAALIYET.Single(p => p.FirmaFaaliyetKey == deletedkey);
                entity.FIRMA_FAALIYET.Remove(deleteddata);

                try
                {
                    if (FirmaFaaliyetKey != 0)
                    {
                        GridViewFirmaFaaliyetBilgi.JSProperties["cpErrorMessage"] = true;
                    }
                    else
                    {
                        entity.SaveChanges();
                        GridViewFirmaFaaliyetBilgi.JSProperties["cpErrorMessage"] = false;
                    }
                }
                catch
                {
                    GridViewFirmaFaaliyetBilgi.JSProperties["cpErrorMessage"] = true;
                }
            }

            FirmaFaaliyetBilgiDataLoad();
            e.Cancel = true;
        }

        protected void GridViewFirmaFaaliyetBilgi_CustomButtonCallback(object sender,
                                                                       ASPxGridViewCustomButtonCallbackEventArgs e)
        {
            TabIndex = 6;
            TabSelect();

            int index = e.VisibleIndex;
            int firmafaaliyetkey =
                Convert.ToInt32(GridViewFirmaFaaliyetBilgi.GetRowValues(index, new[] { "FirmaFaaliyetKey" }));

            FirmaFaaliyetKey = firmafaaliyetkey;
            ASPxWebControl.RedirectOnCallback(string.Format("TuccarSicilBilgiKayit.aspx?Key={0}", TuccarSicilKey));
        }

        #endregion

        #region Firma Uyari Bilgi

        protected void ButtonFirmaUyariBilgiKaydetGuncelle_Click(object sender, EventArgs e)
        {
            TabIndex = 7;
            TabSelect();

            using (var entity = new DBEntities())
            {
                #region validation

                #endregion

                FIRMA_UYARI _FIRMA_UYARI;
                if (FirmaUyariKey == 0)
                {
                    _FIRMA_UYARI = new FIRMA_UYARI();
                }
                else
                {
                    _FIRMA_UYARI = entity.FIRMA_UYARI.SingleOrDefault(p => p.FirmaUyariKey == FirmaUyariKey);
                    if (_FIRMA_UYARI == null)
                    {
                        return;
                    }
                }

                _FIRMA_UYARI.FirmaUyari = MemoFirmaUyari.Text;
                _FIRMA_UYARI.FirmaUyariTarih = DateEditFirmaUyariTarihi.Value == null
                                                   ? null
                                                   : (DateTime?)Convert.ToDateTime(DateEditFirmaUyariTarihi.Value);
                _FIRMA_UYARI.Aktif = CheckBoxFirmaUyariAktif.Checked;
                _FIRMA_UYARI.TuccarSicilKey = TuccarSicilKey;

                MembershipUser user = Membership.GetUser(true);
                Guid userkey = user == null ? Guid.Empty : (Guid)user.ProviderUserKey;
                if (FirmaUyariKey == 0)
                {
                    _FIRMA_UYARI.KayitKisiKey = userkey;
                    _FIRMA_UYARI.KayitTarih = DateTime.Now;
                    entity.FIRMA_UYARI.Add(_FIRMA_UYARI);
                }
                else
                {
                    _FIRMA_UYARI.GuncelleKisiKey = userkey;
                    _FIRMA_UYARI.GuncelleTarih = DateTime.Now;
                }

                entity.SaveChanges();
            }

            FirmaUyariKey = null;
            FirmaUyariBilgiDataLoad();
            SetInitials();
        }

        protected void ButtonFirmaUyariBilgiIptalTemizle_Click(object sender, EventArgs e)
        {
            TabIndex = 7;
            TabSelect();

            FirmaUyariKey = null;
            FirmaUyariBilgiDataLoad();
            SetInitials();
        }

        protected void GridViewFirmaUyariBilgi_RowDeleting(object sender, ASPxDataDeletingEventArgs e)
        {
            TabIndex = 7;

            using (var entity = new DBEntities())
            {
                int deletedkey = Convert.ToInt32(e.Keys[0]);
                FIRMA_UYARI deleteddata = entity.FIRMA_UYARI.Single(p => p.FirmaUyariKey == deletedkey);
                entity.FIRMA_UYARI.Remove(deleteddata);

                try
                {
                    if (FirmaUyariKey != 0)
                    {
                        GridViewFirmaUyariBilgi.JSProperties["cpErrorMessage"] = true;
                    }
                    else
                    {
                        entity.SaveChanges();
                        GridViewFirmaUyariBilgi.JSProperties["cpErrorMessage"] = false;
                    }
                }
                catch
                {
                    GridViewFirmaUyariBilgi.JSProperties["cpErrorMessage"] = true;
                }
            }

            FirmaUyariBilgiDataLoad();
            e.Cancel = true;
        }

        protected void GridViewFirmaUyariBilgi_CustomButtonCallback(object sender,
                                                                    ASPxGridViewCustomButtonCallbackEventArgs e)
        {
            TabIndex = 7;
            TabSelect();

            int index = e.VisibleIndex;
            int firmauyarikey = Convert.ToInt32(GridViewFirmaUyariBilgi.GetRowValues(index, new[] { "FirmaUyariKey" }));

            FirmaUyariKey = firmauyarikey;
            ASPxWebControl.RedirectOnCallback(string.Format("TuccarSicilBilgiKayit.aspx?Key={0}", TuccarSicilKey));
        }

        #endregion

        #region Derece Degisiklik

        protected void ButtonDereceDegisikligiKaydet_Click(object sender, EventArgs e)
        {
            TabIndex = 8;
            TabSelect();

            using (var entity = new DBEntities())
            {
                #region validation

                #endregion

                var _DERECE_DEGISIKLIK = new DERECE_DEGISIKLIK();

                _DERECE_DEGISIKLIK.TuccarSicilKey = TuccarSicilKey;
                _DERECE_DEGISIKLIK.DereceKey = Convert.ToInt32(ComboBoxDereceDegisikligiDerece.SelectedItem.Value);
                _DERECE_DEGISIKLIK.DereceVerilisYil =
                    Convert.ToInt16(ComboBoxDereceDegisikligiDereceYil.SelectedItem.Text);
                _DERECE_DEGISIKLIK.YKKTarih = DateEditDereceDegisikligiYKKTarihi.Value == null
                                                  ? null
                                                  : (DateTime?)
                                                    Convert.ToDateTime(DateEditDereceDegisikligiYKKTarihi.Value);
                _DERECE_DEGISIKLIK.YKKNo = TextBoxDereceDegisikligiYKKNo.Text;

                MembershipUser user = Membership.GetUser(true);
                Guid userkey = user == null ? Guid.Empty : (Guid)user.ProviderUserKey;

                _DERECE_DEGISIKLIK.KayitKisiKey = userkey;
                _DERECE_DEGISIKLIK.KayitTarih = DateTime.Now;
                entity.DERECE_DEGISIKLIK.Add(_DERECE_DEGISIKLIK);

                TUCCAR_SICIL _TUCCAR_SICIL = entity.TUCCAR_SICIL.Single(p => p.TuccarSicilKey == TuccarSicilKey);
                _TUCCAR_SICIL.DereceKey = Convert.ToInt32(ComboBoxDereceDegisikligiDerece.SelectedItem.Value);
                _TUCCAR_SICIL.DereceYil = Convert.ToInt16(ComboBoxDereceDegisikligiDereceYil.SelectedItem.Text);
                _TUCCAR_SICIL.YKKTarihi = DateEditDereceDegisikligiYKKTarihi.Value == null
                                              ? null
                                              : (DateTime?)Convert.ToDateTime(DateEditDereceDegisikligiYKKTarihi.Value);
                _TUCCAR_SICIL.YKKNo = TextBoxDereceDegisikligiYKKNo.Text;

                entity.SaveChanges();
            }

            DereceDegisiklikDataLoad();
            TuccarSicilBilgiDataLoad();
            SetInitials();
        }

        protected void ButtonDereceDegisikligiTemizle_Click(object sender, EventArgs e)
        {
            TabIndex = 8;
            TabSelect();

            DereceDegisiklikDataLoad();
            SetInitials();
        }

        protected void GridViewDereceDegisikligi_RowDeleting(object sender, ASPxDataDeletingEventArgs e)
        {
            TabIndex = 8;

            using (var entity = new DBEntities())
            {
                int deletedkey = Convert.ToInt32(e.Keys[0]);
                DERECE_DEGISIKLIK deleteddata = entity.DERECE_DEGISIKLIK.Single(p => p.DereceDegisiklikKey == deletedkey);
                entity.DERECE_DEGISIKLIK.Remove(deleteddata);

                try
                {
                    entity.SaveChanges();
                    GridViewDereceDegisikligi.JSProperties["cpErrorMessage"] = false;
                }
                catch
                {
                    GridViewDereceDegisikligi.JSProperties["cpErrorMessage"] = true;
                }
            }

            DereceDegisiklikDataLoad();
            e.Cancel = true;
        }

        #endregion

        #region Unvan Degisiklik

        protected void ButtonUnvanDegisikligiKaydet_Click(object sender, EventArgs e)
        {
            TabIndex = 9;
            TabSelect();

            using (var entity = new DBEntities())
            {
                #region validation

                #endregion

                var _UNVAN_DEGISIKLIK = new UNVAN_DEGISIKLIK();

                _UNVAN_DEGISIKLIK.TuccarSicilKey = TuccarSicilKey;
                _UNVAN_DEGISIKLIK.Unvan = MemoUnvanDegisikligiUnvan.Text;
                _UNVAN_DEGISIKLIK.Yil = Convert.ToInt16(ComboBoxUnvanDegisikligiYil.SelectedItem.Text);
                _UNVAN_DEGISIKLIK.YKKTarih = DateEditUnvanDegisikligiYKKTarih.Value == null
                                                 ? null
                                                 : (DateTime?)
                                                   Convert.ToDateTime(DateEditUnvanDegisikligiYKKTarih.Value);
                _UNVAN_DEGISIKLIK.YKKNo = TextBoxUnvanDegisikligiYKKNo.Text;

                MembershipUser user = Membership.GetUser(true);
                Guid userkey = user == null ? Guid.Empty : (Guid)user.ProviderUserKey;

                _UNVAN_DEGISIKLIK.KayitKisiKey = userkey;
                _UNVAN_DEGISIKLIK.KayitTarih = DateTime.Now;
                entity.UNVAN_DEGISIKLIK.Add(_UNVAN_DEGISIKLIK);

                TUCCAR_SICIL _TUCCAR_SICIL = entity.TUCCAR_SICIL.Single(p => p.TuccarSicilKey == TuccarSicilKey);
                _TUCCAR_SICIL.Unvan = MemoUnvanDegisikligiUnvan.Text;

                entity.SaveChanges();
            }

            UnvanDegisiklikDataLoad();
            TuccarSicilBilgiDataLoad();
            SetInitials();
        }

        protected void ButtonUnvanDegisikligiTemizle_Click(object sender, EventArgs e)
        {
            TabIndex = 9;
            TabSelect();

            UnvanDegisiklikDataLoad();
            SetInitials();
        }

        protected void GridViewUnvanDegisikligi_RowDeleting(object sender, ASPxDataDeletingEventArgs e)
        {
            TabIndex = 5;

            using (var entity = new DBEntities())
            {
                int deletedkey = Convert.ToInt32(e.Keys[0]);
                UNVAN_DEGISIKLIK deleteddata = entity.UNVAN_DEGISIKLIK.Single(p => p.UnvanDegisiklikKey == deletedkey);
                entity.UNVAN_DEGISIKLIK.Remove(deleteddata);

                try
                {
                    entity.SaveChanges();
                    GridViewUnvanDegisikligi.JSProperties["cpErrorMessage"] = false;
                }
                catch
                {
                    GridViewUnvanDegisikligi.JSProperties["cpErrorMessage"] = true;
                }
            }

            UnvanDegisiklikDataLoad();
            e.Cancel = true;
        }

        #endregion

        #region Sermaye Degisiklik

        protected void ButtonSermayeDegisikligiKaydet_Click(object sender, EventArgs e)
        {
            TabIndex = 10;
            TabSelect();

            using (var entity = new DBEntities())
            {
                #region validation

                #endregion

                var _SERMAYE_DEGISIKLIK = new SERMAYE_DEGISIKLIK();

                _SERMAYE_DEGISIKLIK.TuccarSicilKey = TuccarSicilKey;
                _SERMAYE_DEGISIKLIK.Sermaye = Convert.ToDecimal(SpinEditSermayeDegisiklikSermaye.Value);
                _SERMAYE_DEGISIKLIK.Yil = Convert.ToInt16(ComboBoxSermayeDegisiklikSermayeYil.SelectedItem.Text);
                _SERMAYE_DEGISIKLIK.YKKTarih = DateEditSermayeDegisiklikYKKTarihi.Value == null
                                                   ? null
                                                   : (DateTime?)
                                                     Convert.ToDateTime(DateEditSermayeDegisiklikYKKTarihi.Value);
                _SERMAYE_DEGISIKLIK.YKKNo = TextBoxSermayeDegisiklikYKKNo.Text;

                MembershipUser user = Membership.GetUser(true);
                Guid userkey = user == null ? Guid.Empty : (Guid)user.ProviderUserKey;

                _SERMAYE_DEGISIKLIK.KayitKisiKey = userkey;
                _SERMAYE_DEGISIKLIK.KayitTarih = DateTime.Now;
                entity.SERMAYE_DEGISIKLIK.Add(_SERMAYE_DEGISIKLIK);

                TUCCAR_SICIL _TUCCAR_SICIL = entity.TUCCAR_SICIL.Single(p => p.TuccarSicilKey == TuccarSicilKey);
                _TUCCAR_SICIL.Sermaye = string.IsNullOrEmpty(SpinEditSermayeDegisiklikSermaye.Text)
                                            ? 0
                                            : Convert.ToDecimal(SpinEditSermayeDegisiklikSermaye.Value);

                entity.SaveChanges();
            }

            SermayeDegisiklikDataLoad();
            TuccarSicilBilgiDataLoad();
            SetInitials();
        }

        protected void ButtonSermayeDegisikligiTemizle_Click(object sender, EventArgs e)
        {
            TabIndex = 10;
            TabSelect();

            SermayeDegisiklikDataLoad();
            SetInitials();
        }

        protected void GridViewSermayeDegisikligi_RowDeleting(object sender, ASPxDataDeletingEventArgs e)
        {
            TabIndex = 10;

            using (var entity = new DBEntities())
            {
                int deletedkey = Convert.ToInt32(e.Keys[0]);
                SERMAYE_DEGISIKLIK deleteddata =
                    entity.SERMAYE_DEGISIKLIK.Single(p => p.SermayeDegisiklikKey == deletedkey);
                entity.SERMAYE_DEGISIKLIK.Remove(deleteddata);

                try
                {
                    entity.SaveChanges();
                    GridViewSermayeDegisikligi.JSProperties["cpErrorMessage"] = false;
                }
                catch
                {
                    GridViewSermayeDegisikligi.JSProperties["cpErrorMessage"] = true;
                }
            }

            SermayeDegisiklikDataLoad();
            e.Cancel = true;
        }

        #endregion

        #region Meslek Grubu Degisiklik

        protected void ButtonMeslekGrubuDegisikligiKaydet_Click(object sender, EventArgs e)
        {
            TabIndex = 11;
            TabSelect();

            using (var entity = new DBEntities())
            {
                #region validation

                #endregion

                var _MESLEK_GRUP_DEGISIKLIK = new MESLEK_GRUP_DEGISIKLIK();

                _MESLEK_GRUP_DEGISIKLIK.TuccarSicilKey = TuccarSicilKey;
                _MESLEK_GRUP_DEGISIKLIK.MeslekGrupKey =
                    Convert.ToInt32(ComboBoxMeslekGrubuDegisiklikMeslekGrubu.SelectedItem.Value);
                _MESLEK_GRUP_DEGISIKLIK.Yil =
                    Convert.ToInt16(ComboBoxMeslekGrubuDegisiklikMeslekGrubuYil.SelectedItem.Text);
                _MESLEK_GRUP_DEGISIKLIK.YKKTarih = DateEditMeslekGrubuDegisiklikYKKTarihi.Value == null
                                                       ? null
                                                       : (DateTime?)
                                                         Convert.ToDateTime(DateEditMeslekGrubuDegisiklikYKKTarihi.Value);
                _MESLEK_GRUP_DEGISIKLIK.YKKNo = TextBoxMeslekGrubuDegisiklikYKKNo.Text;

                MembershipUser user = Membership.GetUser(true);
                Guid userkey = user == null ? Guid.Empty : (Guid)user.ProviderUserKey;

                _MESLEK_GRUP_DEGISIKLIK.KayitKisiKey = userkey;
                _MESLEK_GRUP_DEGISIKLIK.KayitTarih = DateTime.Now;
                entity.MESLEK_GRUP_DEGISIKLIK.Add(_MESLEK_GRUP_DEGISIKLIK);

                TUCCAR_SICIL _TUCCAR_SICIL = entity.TUCCAR_SICIL.Single(p => p.TuccarSicilKey == TuccarSicilKey);
                _TUCCAR_SICIL.MeslekGrupKey =
                    Convert.ToInt32(ComboBoxMeslekGrubuDegisiklikMeslekGrubu.SelectedItem.Value);

                entity.SaveChanges();
            }

            MeslekGrubuDegisiklikDataLoad();
            TuccarSicilBilgiDataLoad();
            SetInitials();
        }

        protected void ButtonMeslekGrubuDegisikligiTemizle_Click(object sender, EventArgs e)
        {
            TabIndex = 11;
            TabSelect();

            MeslekGrubuDegisiklikDataLoad();
            SetInitials();
        }

        protected void GridViewMeslekGrubuDegisikligi_RowDeleting(object sender, ASPxDataDeletingEventArgs e)
        {
            TabIndex = 11;

            using (var entity = new DBEntities())
            {
                int deletedkey = Convert.ToInt32(e.Keys[0]);
                MESLEK_GRUP_DEGISIKLIK deleteddata =
                    entity.MESLEK_GRUP_DEGISIKLIK.Single(p => p.MeslekGrupDegisiklikKey == deletedkey);
                entity.MESLEK_GRUP_DEGISIKLIK.Remove(deleteddata);

                try
                {
                    entity.SaveChanges();
                    GridViewMeslekGrubuDegisikligi.JSProperties["cpErrorMessage"] = false;
                }
                catch
                {
                    GridViewMeslekGrubuDegisikligi.JSProperties["cpErrorMessage"] = true;
                }
            }

            MeslekGrubuDegisiklikDataLoad();
            e.Cancel = true;
        }

        #endregion

        #region Kayitli Oda Listesi

        protected void ButtonKayitliOdaListesiKaydetGuncelle_Click(object sender, EventArgs e)
        {
            TabIndex = 12;
            TabSelect();

            using (var entity = new DBEntities())
            {
                #region validation

                #endregion

                FIRMA_KAYITLI_ODA _FIRMA_KAYITLI_ODA;
                if (FirmaKayitliOdaKey == 0)
                {
                    _FIRMA_KAYITLI_ODA = new FIRMA_KAYITLI_ODA();
                }
                else
                {
                    _FIRMA_KAYITLI_ODA =
                        entity.FIRMA_KAYITLI_ODA.SingleOrDefault(p => p.FirmaKayitliOdaKey == FirmaKayitliOdaKey);
                    if (_FIRMA_KAYITLI_ODA == null)
                    {
                        return;
                    }
                }

                _FIRMA_KAYITLI_ODA.OdaBorsaAdi = TextBoxOdaBorsaAdi.Text;
                _FIRMA_KAYITLI_ODA.OdaBorsaKayitTarihi = DateEditOdaBorsaKayitTarihi.Value == null
                                                             ? null
                                                             : (DateTime?)
                                                               Convert.ToDateTime(DateEditOdaBorsaKayitTarihi.Value);
                _FIRMA_KAYITLI_ODA.Aciklama = MemoOdaBorsaAciklama.Text;
                _FIRMA_KAYITLI_ODA.OdaBorsaSicilNo = TextBoxOdaBorsaSicilNo.Text;
                _FIRMA_KAYITLI_ODA.TuccarSicilKey = TuccarSicilKey;

                MembershipUser user = Membership.GetUser(true);
                Guid userkey = user == null ? Guid.Empty : (Guid)user.ProviderUserKey;
                if (FirmaKayitliOdaKey == 0)
                {
                    _FIRMA_KAYITLI_ODA.KayitKisiKey = userkey;
                    _FIRMA_KAYITLI_ODA.KayitTarih = DateTime.Now;
                    entity.FIRMA_KAYITLI_ODA.Add(_FIRMA_KAYITLI_ODA);
                }
                else
                {
                    _FIRMA_KAYITLI_ODA.GuncelleKisiKey = userkey;
                    _FIRMA_KAYITLI_ODA.GuncelleTarih = DateTime.Now;
                }

                entity.SaveChanges();
            }

            FirmaKayitliOdaKey = null;
            FirmaKayitliOdaDataLoad();
            SetInitials();
        }

        protected void ButtonKayitliOdaListesiIptalTemizle_Click(object sender, EventArgs e)
        {
            TabIndex = 12;
            TabSelect();

            FirmaKayitliOdaKey = null;
            FirmaKayitliOdaDataLoad();
            SetInitials();
        }

        protected void GridViewKayitliOdaListesi_RowDeleting(object sender, ASPxDataDeletingEventArgs e)
        {
            TabIndex = 12;

            using (var entity = new DBEntities())
            {
                int deletedkey = Convert.ToInt32(e.Keys[0]);
                FIRMA_KAYITLI_ODA deleteddata = entity.FIRMA_KAYITLI_ODA.Single(p => p.FirmaKayitliOdaKey == deletedkey);
                entity.FIRMA_KAYITLI_ODA.Remove(deleteddata);

                try
                {
                    if (FirmaKayitliOdaKey != 0)
                    {
                        GridViewKayitliOdaListesi.JSProperties["cpErrorMessage"] = true;
                    }
                    else
                    {
                        entity.SaveChanges();
                        GridViewKayitliOdaListesi.JSProperties["cpErrorMessage"] = false;
                    }
                }
                catch
                {
                    GridViewKayitliOdaListesi.JSProperties["cpErrorMessage"] = true;
                }
            }

            FirmaKayitliOdaDataLoad();
            e.Cancel = true;
        }

        protected void GridViewKayitliOdaListesi_CustomButtonCallback(object sender,
                                                                      ASPxGridViewCustomButtonCallbackEventArgs e)
        {
            TabIndex = 12;
            TabSelect();

            int index = e.VisibleIndex;
            int firmakayitliodakey =
                Convert.ToInt32(GridViewKayitliOdaListesi.GetRowValues(index, new[] { "FirmaKayitliOdaKey" }));

            FirmaKayitliOdaKey = firmakayitliodakey;
            ASPxWebControl.RedirectOnCallback(string.Format("TuccarSicilBilgiKayit.aspx?Key={0}", TuccarSicilKey));
        }

        #endregion

        #region Diger Faaliyet Kodları

        protected void ButtonDigerFaaliyetKodlariKaydetGuncelle_Click(object sender, EventArgs e)
        {
            TabIndex = 13;
            TabSelect();

            using (var entity = new DBEntities())
            {
                #region validation

                #endregion

                FIRMA_DIGER_FAALIYET_KOD _FIRMA_DIGER_FAALIYET_KOD;
                if (FirmaDigerFaaliyetKodKey == 0)
                {
                    _FIRMA_DIGER_FAALIYET_KOD = new FIRMA_DIGER_FAALIYET_KOD();
                }
                else
                {
                    _FIRMA_DIGER_FAALIYET_KOD =
                        entity.FIRMA_DIGER_FAALIYET_KOD.SingleOrDefault(
                            p => p.FirmaDigerFaaliyetKodKey == FirmaDigerFaaliyetKodKey);
                    if (_FIRMA_DIGER_FAALIYET_KOD == null)
                    {
                        return;
                    }
                }

                _FIRMA_DIGER_FAALIYET_KOD.NaceKodu1 = TextBoxDigerFaaliyetKodlariNaceKodu1.Text;
                _FIRMA_DIGER_FAALIYET_KOD.NaceKodu2 = TextBoxDigerFaaliyetKodlariNaceKodu2.Text;
                _FIRMA_DIGER_FAALIYET_KOD.BaslangicTarihi = DateEditDigerFaaliyetKodlariBaslangicTarihi.Value == null
                                                                ? null
                                                                : (DateTime?)
                                                                  Convert.ToDateTime(
                                                                      DateEditDigerFaaliyetKodlariBaslangicTarihi.Value);
                _FIRMA_DIGER_FAALIYET_KOD.Aciklama = MemoDigerFaaliyetKodlariAciklama.Text;
                _FIRMA_DIGER_FAALIYET_KOD.TuccarSicilKey = TuccarSicilKey;

                MembershipUser user = Membership.GetUser(true);
                Guid userkey = user == null ? Guid.Empty : (Guid)user.ProviderUserKey;
                if (FirmaDigerFaaliyetKodKey == 0)
                {
                    _FIRMA_DIGER_FAALIYET_KOD.KayitKisiKey = userkey;
                    _FIRMA_DIGER_FAALIYET_KOD.KayitTarih = DateTime.Now;
                    entity.FIRMA_DIGER_FAALIYET_KOD.Add(_FIRMA_DIGER_FAALIYET_KOD);
                }
                else
                {
                    _FIRMA_DIGER_FAALIYET_KOD.GuncelleKisiKey = userkey;
                    _FIRMA_DIGER_FAALIYET_KOD.GuncelleTarih = DateTime.Now;
                }

                entity.SaveChanges();
            }

            FirmaDigerFaaliyetKodKey = null;
            FirmaDigerFaaliyetKodlariDataLoad();
            SetInitials();
        }

        protected void ButtonDigerFaaliyetKodlariIptalTemizle_Click(object sender, EventArgs e)
        {
            TabIndex = 13;
            TabSelect();

            FirmaDigerFaaliyetKodKey = null;
            FirmaDigerFaaliyetKodlariDataLoad();
            SetInitials();
        }

        protected void GridViewDigerFaaliyetKodlari_RowDeleting(object sender, ASPxDataDeletingEventArgs e)
        {
            TabIndex = 13;

            using (var entity = new DBEntities())
            {
                int deletedkey = Convert.ToInt32(e.Keys[0]);
                FIRMA_DIGER_FAALIYET_KOD deleteddata =
                    entity.FIRMA_DIGER_FAALIYET_KOD.Single(p => p.FirmaDigerFaaliyetKodKey == deletedkey);
                entity.FIRMA_DIGER_FAALIYET_KOD.Remove(deleteddata);

                try
                {
                    if (FirmaDigerFaaliyetKodKey != 0)
                    {
                        GridViewDigerFaaliyetKodlari.JSProperties["cpErrorMessage"] = true;
                    }
                    else
                    {
                        entity.SaveChanges();
                        GridViewDigerFaaliyetKodlari.JSProperties["cpErrorMessage"] = false;
                    }
                }
                catch
                {
                    GridViewDigerFaaliyetKodlari.JSProperties["cpErrorMessage"] = true;
                }
            }

            FirmaDigerFaaliyetKodlariDataLoad();
            e.Cancel = true;
        }

        protected void GridViewDigerFaaliyetKodlari_CustomButtonCallback(object sender,
                                                                         ASPxGridViewCustomButtonCallbackEventArgs e)
        {
            TabIndex = 13;
            TabSelect();

            int index = e.VisibleIndex;
            int firmadigerfaaliyetkodkey =
                Convert.ToInt32(GridViewDigerFaaliyetKodlari.GetRowValues(index, new[] { "FirmaDigerFaaliyetKodKey" }));

            FirmaDigerFaaliyetKodKey = firmadigerfaaliyetkodkey;
            ASPxWebControl.RedirectOnCallback(string.Format("TuccarSicilBilgiKayit.aspx?Key={0}", TuccarSicilKey));
        }

        #endregion

        #endregion

        #region Methods

        private void SetInitials()
        {
            if (!IsPostBack)
            {
                DataLoad();
            }

            if (TuccarSicilKey == 0)
            {
                LabelBaslik.Text = "TÜCCAR SİCİL KAYDET";
                LabelUnvan.Text = string.Empty;

                ButtonKaydet.Visible = true;
                ButtonTemizle.Visible = true;
                ButtonGuncelle.Visible = false;
                ButtonIptal.Visible = false;
                ButtonDetayGoster.Visible = false;
                divIslemler.Style.Value = "margin-left: 40%;";

                TabControl(false);
            }
            else
            {
                ComboBoxDerece.Enabled = false;
                SpinEditDereceYil.Enabled = false;
                DateEditYKKTarihi.Enabled = false;
                TextBoxYKKNo.Enabled = false;

                MemoUnvan.Enabled = false;

                SpinEditSermaye.Enabled = false;

                ComboBoxMeslekGrubu.Enabled = false;

                ButtonKaydet.Visible = false;
                ButtonTemizle.Visible = false;
                ButtonGuncelle.Visible = true;
                ButtonIptal.Visible = true;
                ButtonDetayGoster.Visible = true;
                divIslemler.Style.Value = "margin-left: 35%;";

                LabelBaslik.Text = "TÜCCAR SİCİL GÜNCELLE";

                TabSelect();


                if (Detay == true)
                {
                    TabControl(true);
                    ButtonDetayGoster.Text = "Detay Gizle";
                    using (var entity = new DBEntities())
                    {
                        entity.Configuration.AutoDetectChangesEnabled = false;

                        string Unvan =
                            entity.TUCCAR_SICIL.AsNoTracking().SingleOrDefault(p => p.TuccarSicilKey == TuccarSicilKey).Unvan;
                        LabelUnvan.Text = "\"" + Unvan + "\"";
                    }
                }
                else
                {
                    LabelUnvan.Text = string.Empty;
                    ButtonDetayGoster.Text = "Detay Göster";
                    TabControl(false);
                    return;
                }

                if (FirmaYetkiliKey == 0)
                {
                    ButtonFirmaYetkiliBilgiKaydet.Visible = true;
                    ButtonFirmaYetkiliBilgiTemizle.Visible = true;
                    ButtonFirmaYetkiliBilgiGuncelle.Visible = false;
                    ButtonFirmaYetkiliBilgiIptal.Visible = false;
                }
                else
                {
                    ButtonFirmaYetkiliBilgiKaydet.Visible = false;
                    ButtonFirmaYetkiliBilgiTemizle.Visible = false;
                    ButtonFirmaYetkiliBilgiGuncelle.Visible = true;
                    ButtonFirmaYetkiliBilgiIptal.Visible = true;
                }

                if (FirmaAdresKey == 0)
                {
                    ButtonFirmaAdresBilgiKaydet.Visible = true;
                    ButtonFirmaAdresBilgiTemizle.Visible = true;
                    ButtonFirmaAdresBilgiGuncelle.Visible = false;
                    ButtonFirmaAdresBilgiIptal.Visible = false;
                }
                else
                {
                    ButtonFirmaAdresBilgiKaydet.Visible = false;
                    ButtonFirmaAdresBilgiTemizle.Visible = false;
                    ButtonFirmaAdresBilgiGuncelle.Visible = true;
                    ButtonFirmaAdresBilgiIptal.Visible = true;
                }

                if (FirmaTelefonFaxKey == 0)
                {
                    ButtonFirmaTelefonFaxBilgiKaydet.Visible = true;
                    ButtonFirmaTelefonFaxBilgiTemizle.Visible = true;
                    ButtonFirmaTelefonFaxBilgiGuncelle.Visible = false;
                    ButtonFirmaTelefonFaxBilgiIptal.Visible = false;
                }
                else
                {
                    ButtonFirmaTelefonFaxBilgiKaydet.Visible = false;
                    ButtonFirmaTelefonFaxBilgiTemizle.Visible = false;
                    ButtonFirmaTelefonFaxBilgiGuncelle.Visible = true;
                    ButtonFirmaTelefonFaxBilgiIptal.Visible = true;
                }

                if (FirmaYonetimKey == 0)
                {
                    ButtonFirmaYonetimBilgiKaydet.Visible = true;
                    ButtonFirmaYonetimBilgiTemizle.Visible = true;
                    ButtonFirmaYonetimBilgiGuncelle.Visible = false;
                    ButtonFirmaYonetimBilgiIptal.Visible = false;
                }
                else
                {
                    ButtonFirmaYonetimBilgiKaydet.Visible = false;
                    ButtonFirmaYonetimBilgiTemizle.Visible = false;
                    ButtonFirmaYonetimBilgiGuncelle.Visible = true;
                    ButtonFirmaYonetimBilgiIptal.Visible = true;
                }

                if (FirmaFaaliyetKey == 0)
                {
                    ButtonFirmaFaaliyetBilgiKaydet.Visible = true;
                    ButtonFirmaFaaliyetBilgiTemizle.Visible = true;
                    ButtonFirmaFaaliyetBilgiGuncelle.Visible = false;
                    ButtonFirmaFaaliyetBilgiIptal.Visible = false;
                }
                else
                {
                    ButtonFirmaFaaliyetBilgiKaydet.Visible = false;
                    ButtonFirmaFaaliyetBilgiTemizle.Visible = false;
                    ButtonFirmaFaaliyetBilgiGuncelle.Visible = true;
                    ButtonFirmaFaaliyetBilgiIptal.Visible = true;
                }

                if (FirmaUyariKey == 0)
                {
                    ButtonFirmaUyariBilgiKaydet.Visible = true;
                    ButtonFirmaUyariBilgiTemizle.Visible = true;
                    ButtonFirmaUyariBilgiGuncelle.Visible = false;
                    ButtonFirmaUyariBilgiIptal.Visible = false;
                }
                else
                {
                    ButtonFirmaUyariBilgiKaydet.Visible = false;
                    ButtonFirmaUyariBilgiTemizle.Visible = false;
                    ButtonFirmaUyariBilgiGuncelle.Visible = true;
                    ButtonFirmaUyariBilgiIptal.Visible = true;
                }

                if (FirmaKayitliOdaKey == 0)
                {
                    ButtonKayitliOdaListesiKaydet.Visible = true;
                    ButtonKayitliOdaListesiTemizle.Visible = true;
                    ButtonKayitliOdaListesiGuncelle.Visible = false;
                    ButtonKayitliOdaListesiIptal.Visible = false;
                }
                else
                {
                    ButtonKayitliOdaListesiKaydet.Visible = false;
                    ButtonKayitliOdaListesiTemizle.Visible = false;
                    ButtonKayitliOdaListesiGuncelle.Visible = true;
                    ButtonKayitliOdaListesiIptal.Visible = true;
                }

                if (FirmaDigerFaaliyetKodKey == 0)
                {
                    ButtonDigerFaaliyetKodlariKaydet.Visible = true;
                    ButtonDigerFaaliyetKodlariTemizle.Visible = true;
                    ButtonDigerFaaliyetKodlariGuncelle.Visible = false;
                    ButtonDigerFaaliyetKodlariIptal.Visible = false;
                }
                else
                {
                    ButtonDigerFaaliyetKodlariKaydet.Visible = false;
                    ButtonDigerFaaliyetKodlariTemizle.Visible = false;
                    ButtonDigerFaaliyetKodlariGuncelle.Visible = true;
                    ButtonDigerFaaliyetKodlariIptal.Visible = true;
                }
            }
        }

        private void DataLoad()
        {
            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                if (!IsPostBack)
                {
                    List<TT_MESLEK_GRUP> listMESLEK_GRUP = entity.TT_MESLEK_GRUP.AsNoTracking().OrderBy(p => p.MeslekAdi).ToList();
                    List<TT_DERECE> listDERECE = entity.TT_DERECE.AsNoTracking().ToList();
                    List<TT_KURULUS_TUR> listKURULUS_TUR = entity.TT_KURULUS_TUR.AsNoTracking().OrderBy(p => p.Adi).ToList();
                    List<TT_SICIL_MEMURLUGU> listSICIL_MEMURLUGU = entity.TT_SICIL_MEMURLUGU.AsNoTracking().ToList();
                    List<TT_IL_ILCE> listIL_ILCE = entity.TT_IL_ILCE.AsNoTracking().ToList();
                    List<TT_VERGI_DAIRE> listVERGI_DAIRE = entity.TT_VERGI_DAIRE.AsNoTracking().OrderBy(p => p.VergiDairesiAdi).ToList();
                    List<TT_MADDE_KOD> listMADDE_KOD = entity.TT_MADDE_KOD.AsNoTracking().ToList();
                    List<TT_FIRMA_ADRES_TIP> listFIRMA_ADRES_TIP = entity.TT_FIRMA_ADRES_TIP.AsNoTracking().ToList();
                    List<TT_FIRMA_TELEFON_FAX_TIP> listFIRMA_TELEFON_FAX_TIP = entity.TT_FIRMA_TELEFON_FAX_TIP.AsNoTracking().ToList();
                    List<TT_OGRENIM_DURUM_TIP> listOGRENIM_DURUM_TIP = entity.TT_OGRENIM_DURUM_TIP.AsNoTracking().ToList();

                    var yillar = new List<int>();
                    for (int i = DateTime.Now.Year; i >= 1900; i--)
                    {
                        yillar.Add(i);
                    }

                    var listTelefonFax = new List<string>();
                    listTelefonFax.Add("TELEFON");
                    listTelefonFax.Add("FAX");

                    var listMerkezSube = new List<string>();
                    listMerkezSube.Add("MERKEZ");
                    listMerkezSube.Add("ŞUBE");

                    var listKayitTescil = new List<string>();
                    listKayitTescil.Add("KAYIT");
                    listKayitTescil.Add("TESCİL");

                    ComboBoxMeslekGrubu.DataSource = listMESLEK_GRUP;
                    ComboBoxMeslekGrubu.DataBind();

                    ComboBoxMeslekGrubuDegisiklikMeslekGrubu.DataSource = listMESLEK_GRUP;
                    ComboBoxMeslekGrubuDegisiklikMeslekGrubu.DataBind();

                    ComboBoxDerece.DataSource = listDERECE;
                    ComboBoxDerece.DataBind();

                    ComboBoxDereceDegisikligiDerece.DataSource = listDERECE;
                    ComboBoxDereceDegisikligiDerece.DataBind();

                    ComboBoxKurulusTur.DataSource = listKURULUS_TUR;
                    ComboBoxKurulusTur.DataBind();

                    ComboBoxSicilMemurlugu.DataSource = listSICIL_MEMURLUGU;
                    ComboBoxSicilMemurlugu.DataBind();

                    ComboBoxIlIlce.DataSource = listIL_ILCE;
                    ComboBoxIlIlce.DataBind();

                    ComboBoxVergiDairesi.DataSource = listVERGI_DAIRE;
                    ComboBoxVergiDairesi.DataBind();

                    ComboBoxFirmaFaaliyetBilgiMaddeKodu.DataSource = listMADDE_KOD;
                    ComboBoxFirmaFaaliyetBilgiMaddeKodu.DataBind();

                    ComboBoxFirmaAdresTip.DataSource = listFIRMA_ADRES_TIP;
                    ComboBoxFirmaAdresTip.DataBind();

                    ComboBoxFirmaTelefonFaxTip.DataSource = listFIRMA_TELEFON_FAX_TIP;
                    ComboBoxFirmaTelefonFaxTip.DataBind();

                    ComboBoxFirmaSahisBilgiTahsilDurumu.DataSource = listOGRENIM_DURUM_TIP;
                    ComboBoxFirmaSahisBilgiTahsilDurumu.DataBind();

                    ComboBoxMerkezSubeMi.DataSource = listMerkezSube;
                    ComboBoxMerkezSubeMi.DataBind();

                    ComboBoxKayitTescilMi.DataSource = listKayitTescil;
                    ComboBoxKayitTescilMi.DataBind();

                    ComboBoxDereceDegisikligiDereceYil.DataSource = yillar;
                    ComboBoxDereceDegisikligiDereceYil.DataBind();
                    ComboBoxDereceDegisikligiDereceYil.SelectedIndex = 0;

                    ComboBoxUnvanDegisikligiYil.DataSource = yillar;
                    ComboBoxUnvanDegisikligiYil.DataBind();
                    ComboBoxUnvanDegisikligiYil.SelectedIndex = 0;

                    ComboBoxSermayeDegisiklikSermayeYil.DataSource = yillar;
                    ComboBoxSermayeDegisiklikSermayeYil.DataBind();
                    ComboBoxSermayeDegisiklikSermayeYil.SelectedIndex = 0;

                    ComboBoxMeslekGrubuDegisiklikMeslekGrubuYil.DataSource = yillar;
                    ComboBoxMeslekGrubuDegisiklikMeslekGrubuYil.DataBind();
                    ComboBoxMeslekGrubuDegisiklikMeslekGrubuYil.SelectedIndex = 0;
                }
            }

            if (TuccarSicilKey != 0)
            {
                TuccarSicilBilgiDataLoad();

                if (Detay == true)
                {
                    FirmaSahisBilgiDataLoad();

                    FirmaAdresBilgiDataLoad();

                    FirmaTelefonFaxBilgiDataLoad();

                    FirmaYetkiliBilgiDataLoad();

                    FirmaYonetimBilgiDataLoad();

                    FirmaFaaliyetBilgiDataLoad();

                    FirmaUyariBilgiDataLoad();

                    DereceDegisiklikDataLoad();

                    UnvanDegisiklikDataLoad();

                    SermayeDegisiklikDataLoad();

                    MeslekGrubuDegisiklikDataLoad();

                    FirmaKayitliOdaDataLoad();

                    FirmaDigerFaaliyetKodlariDataLoad();
                }
            }
        }

        private void TabSelect()
        {
            if (!PageControlSicilBilgi.TabPages[TabIndex].Visible)
            {
                TabIndex = 0;
            }
            PageControlSicilBilgi.ActiveTabIndex = TabIndex;
        }

        private void TabControl(bool pDurum)
        {
            PageControlSicilBilgi.TabPages[1].Visible = pDurum;
            PageControlSicilBilgi.TabPages[2].Visible = pDurum;
            PageControlSicilBilgi.TabPages[3].Visible = pDurum;
            PageControlSicilBilgi.TabPages[4].Visible = pDurum;
            PageControlSicilBilgi.TabPages[5].Visible = pDurum;
            PageControlSicilBilgi.TabPages[6].Visible = pDurum;
            PageControlSicilBilgi.TabPages[7].Visible = pDurum;
            PageControlSicilBilgi.TabPages[8].Visible = pDurum;
            PageControlSicilBilgi.TabPages[9].Visible = pDurum;
            PageControlSicilBilgi.TabPages[10].Visible = pDurum;
            PageControlSicilBilgi.TabPages[11].Visible = pDurum;
            PageControlSicilBilgi.TabPages[12].Visible = pDurum;
            PageControlSicilBilgi.TabPages[13].Visible = pDurum;

            PageControlSicilBilgi.TabPages[1].ClientVisible = pDurum;
            PageControlSicilBilgi.TabPages[2].ClientVisible = pDurum;
            PageControlSicilBilgi.TabPages[3].ClientVisible = pDurum;
            PageControlSicilBilgi.TabPages[4].ClientVisible = pDurum;
            PageControlSicilBilgi.TabPages[5].ClientVisible = pDurum;
            PageControlSicilBilgi.TabPages[6].ClientVisible = pDurum;
            PageControlSicilBilgi.TabPages[7].ClientVisible = pDurum;
            PageControlSicilBilgi.TabPages[8].ClientVisible = pDurum;
            PageControlSicilBilgi.TabPages[9].ClientVisible = pDurum;
            PageControlSicilBilgi.TabPages[10].ClientVisible = pDurum;
            PageControlSicilBilgi.TabPages[11].ClientVisible = pDurum;
            PageControlSicilBilgi.TabPages[12].ClientVisible = pDurum;
            PageControlSicilBilgi.TabPages[13].ClientVisible = pDurum;
        }

        private void TuccarSicilBilgiDataLoad()
        {
            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                TUCCAR_SICIL _TUCCAR_SICIL =
                    entity.TUCCAR_SICIL
                          .Include("TUCCAR_ASKI")
                          .Include("FIRMA_UYARI")
                          .AsNoTracking()
                          .SingleOrDefault(p => p.TuccarSicilKey == TuccarSicilKey);
                if (_TUCCAR_SICIL == null)
                {
                    Response.Redirect("TuccarSicilBilgiKayit.aspx");
                    return;
                }

                #region Uyarı bilgileri

                string uyaritooltip = "";
                if (_TUCCAR_SICIL.FIRMA_UYARI.Any(p => p.Aktif))
                {
                    uyaritooltip += " Firma hakkında aktif uyarı kaydı bulunmaktadır.";
                }

                if (_TUCCAR_SICIL.TUCCAR_ASKI.Any(p => p.AskiTarihi != null && p.BitisTarihi == null))
                {
                    uyaritooltip += uyaritooltip.Length > 0
                                        ? Environment.NewLine + "Firma askıdadır."
                                        : "Firma askıdadır.";
                }

                if (_TUCCAR_SICIL.TerkinTarihi != null)
                {
                    uyaritooltip += uyaritooltip.Length > 0
                                        ? Environment.NewLine + "Firma terkin edilmiştir."
                                        : "Firma terkin edilmiştir.";
                }

                if (uyaritooltip.Length > 0)
                {
                    ImageUyari.Visible = true;
                    ImageUyari.ToolTip = uyaritooltip;
                }
                else
                {
                    ImageUyari.Visible = false;
                    ImageUyari.ToolTip = "";
                }

                #endregion

                TextBoxSicilNo.Text = _TUCCAR_SICIL.SicilNo;
                MemoUnvan.Text = _TUCCAR_SICIL.Unvan;
                ComboBoxMeslekGrubu.Items.FindByValue(_TUCCAR_SICIL.MeslekGrupKey.ToString()).Selected = true;
                ComboBoxDerece.Items.FindByValue(_TUCCAR_SICIL.DereceKey.ToString()).Selected = true;
                SpinEditDereceYil.Text = _TUCCAR_SICIL.DereceYil == null ? null : _TUCCAR_SICIL.DereceYil.ToString();
                TextBoxMersisNo.Text = _TUCCAR_SICIL.MersisNo;
                ComboBoxMerkezSubeMi.SelectedIndex = _TUCCAR_SICIL.MerkezSubeMi ? 0 : 1;
                ComboBoxKayitTescilMi.SelectedIndex = _TUCCAR_SICIL.KayitTescilMi ? 0 : 1;
                TextBoxBolgeAdi.Text = _TUCCAR_SICIL.BolgeAdi;
                SpinEditIsciSayisi.Text = _TUCCAR_SICIL.IsciSayisi;
                TextBoxEpostaAdresi.Text = _TUCCAR_SICIL.EpostaAdresi;
                TextBoxWebAdresi.Text = _TUCCAR_SICIL.WebAdresi;
                CheckBoxResenKayitMi.Checked = _TUCCAR_SICIL.ResenKayitMi;
                TextBoxNaceKodu1.Text = _TUCCAR_SICIL.NaceKodu1;
                TextBoxNaceKodu2.Text = _TUCCAR_SICIL.NaceKodu2;
                ComboBoxKurulusTur.Items.FindByValue(_TUCCAR_SICIL.KurulusTurKey.ToString()).Selected = true;
                ComboBoxSicilMemurlugu.Items.FindByValue(_TUCCAR_SICIL.SicilMemurluguKey.ToString()).Selected = true;
                DateEditSicilTarih.Value = _TUCCAR_SICIL.SicilTarih;
                TextBoxTicaretSicilNo.Text = _TUCCAR_SICIL.SicilKayitNo;
                ComboBoxIlIlce.Items.FindByValue(_TUCCAR_SICIL.IlIlceKey.ToString()).Selected = true;
                DateEditKayitTarihi.Value = _TUCCAR_SICIL.KayitTarihi;
                DateEditYKKTarihi.Value = _TUCCAR_SICIL.YKKTarihi;
                TextBoxYKKNo.Text = _TUCCAR_SICIL.YKKNo;
                DateEditTerkinTarihi.Value = _TUCCAR_SICIL.TerkinTarihi;
                TextBoxTerkinYKKNo.Text = _TUCCAR_SICIL.TerkinYKKNo;
                SpinEditSermaye.Value = _TUCCAR_SICIL.Sermaye;

                if (_TUCCAR_SICIL.VergiDaireKey != null)
                {
                    ComboBoxVergiDairesi.Items.FindByValue(_TUCCAR_SICIL.VergiDaireKey.ToString()).Selected = true;
                }

                SpinEditVergiNo.Value = _TUCCAR_SICIL.VergiNo;
                TextBoxTcKimlikNo.Text = _TUCCAR_SICIL.TCKimlikNo;
                TextBoxVergiNoEski.Text = _TUCCAR_SICIL.VergiNoEski;
                MemoAciklama.Text = _TUCCAR_SICIL.Aciklama;
            }
        }

        private void FirmaSahisBilgiDataLoad()
        {
            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                FIRMA_SAHIS _FIRMA_SAHIS = entity.FIRMA_SAHIS.AsNoTracking().SingleOrDefault(p => p.TuccarSicilKey == TuccarSicilKey);
                if (_FIRMA_SAHIS != null)
                {
                    TextBoxFirmaSahisBilgiAd.Text = _FIRMA_SAHIS.Ad;
                    TextBoxFirmaSahisBilgiSoyad.Text = _FIRMA_SAHIS.Soyad;
                    TextBoxFirmaSahisBilgiBabaAdi.Text = _FIRMA_SAHIS.BabaAdi;
                    TextBoxFirmaSahisBilgiUyruk.Text = _FIRMA_SAHIS.Uyruk;
                    TextBoxFirmaSahisBilgiDogumYeri.Text = _FIRMA_SAHIS.DogumYeri;
                    DateEditFirmaSahisBilgiDogumTarihi.Value = _FIRMA_SAHIS.DogumTarihi;
                    ComboBoxFirmaSahisBilgiTahsilDurumu.Items.FindByValue(_FIRMA_SAHIS.OgrenimDurumTipKey.ToString()).Selected = true;
                    TextBoxFirmaSahisBilgiTel.Text = _FIRMA_SAHIS.Tel;
                    MemoFirmaSahisBilgiAdres.Text = _FIRMA_SAHIS.Adres;
                    TextBoxFirmaSahisBilgiTel.Text = _FIRMA_SAHIS.TcKimlikNo;
                }
                else
                {
                    TextBoxFirmaSahisBilgiAd.Text = string.Empty;
                    TextBoxFirmaSahisBilgiSoyad.Text = string.Empty;
                    TextBoxFirmaSahisBilgiBabaAdi.Text = string.Empty;
                    TextBoxFirmaSahisBilgiUyruk.Text = string.Empty;
                    TextBoxFirmaSahisBilgiDogumYeri.Text = string.Empty;
                    DateEditFirmaSahisBilgiDogumTarihi.Value = null;
                    ComboBoxFirmaSahisBilgiTahsilDurumu.SelectedIndex = -1;
                    TextBoxFirmaSahisBilgiTel.Text = string.Empty;
                    MemoFirmaSahisBilgiAdres.Text = string.Empty;
                    TextBoxFirmaSahisBilgiTel.Text = string.Empty;
                }
            }
        }

        private void FirmaAdresBilgiDataLoad()
        {
            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                GridViewFirmaAdresBilgi.DataSource = null;
                GridViewFirmaAdresBilgi.DataSource =
                    entity.FIRMA_ADRES
                            .Include("TT_FIRMA_ADRES_TIP")
                            .AsNoTracking()
                            .Where(p => p.TuccarSicilKey == TuccarSicilKey)
                            .ToList();
                GridViewFirmaAdresBilgi.DataBind();

                if (FirmaAdresKey != 0)
                {
                    FIRMA_ADRES _FIRMA_ADRES = entity.FIRMA_ADRES.AsNoTracking().SingleOrDefault(p => p.FirmaAdresKey == FirmaAdresKey);
                    if (_FIRMA_ADRES != null)
                    {
                        MemoFirmaAdres.Text = _FIRMA_ADRES.FirmaAdres;
                        if (_FIRMA_ADRES.FirmaAdresTipKey != null)
                        {
                            ComboBoxFirmaAdresTip.Items.FindByValue(_FIRMA_ADRES.FirmaAdresTipKey.ToString()).Selected =
                                true;
                        }
                    }
                    else
                    {
                        MemoFirmaAdres.Text = string.Empty;
                        ComboBoxFirmaAdresTip.SelectedIndex = -1;
                    }
                }
                else
                {
                    MemoFirmaAdres.Text = string.Empty;
                    ComboBoxFirmaAdresTip.SelectedIndex = -1;
                }
            }
        }

        private void FirmaTelefonFaxBilgiDataLoad()
        {
            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                GridViewFirmaTelefonFaxBilgi.DataSource = null;
                GridViewFirmaTelefonFaxBilgi.DataSource = entity.
                    FIRMA_TELEFON_FAX
                    .Include("TT_FIRMA_TELEFON_FAX_TIP")
                    .AsNoTracking()
                    .Where(p => p.TuccarSicilKey == TuccarSicilKey).
                    Select(p =>
                           new
                           {
                               p.FirmaTelefonFaxKey,
                               p.FirmaTelefonFax,
                               p.TT_FIRMA_TELEFON_FAX_TIP.FirmaTelefonFaxTipAdi
                           }).ToList();
                GridViewFirmaTelefonFaxBilgi.DataBind();

                if (FirmaTelefonFaxKey != 0)
                {
                    FIRMA_TELEFON_FAX _FIRMA_TELEFON_FAX =
                        entity.FIRMA_TELEFON_FAX.AsNoTracking().SingleOrDefault(p => p.FirmaTelefonFaxKey == FirmaTelefonFaxKey);
                    if (_FIRMA_TELEFON_FAX != null)
                    {
                        TextBoxFirmaTelefonFax.Text = _FIRMA_TELEFON_FAX.FirmaTelefonFax;

                        if (_FIRMA_TELEFON_FAX.FirmaTelefonFaxTipKey != null)
                        {
                            ComboBoxFirmaTelefonFaxTip.Items.FindByValue(
                                _FIRMA_TELEFON_FAX.FirmaTelefonFaxTipKey.ToString()).Selected = true;
                        }
                    }
                    else
                    {
                        TextBoxFirmaTelefonFax.Text = string.Empty;
                        ComboBoxFirmaTelefonFaxTip.SelectedIndex = -1;
                    }
                }
                else
                {
                    TextBoxFirmaTelefonFax.Text = string.Empty;
                    ComboBoxFirmaTelefonFaxTip.SelectedIndex = -1;
                }
            }
        }

        private void FirmaYetkiliBilgiDataLoad()
        {
            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                GridViewFirmaYetkiliBilgi.DataSource = null;
                GridViewFirmaYetkiliBilgi.DataSource =
                    entity.FIRMA_YETKILI.AsNoTracking().Where(p => p.TuccarSicilKey == TuccarSicilKey).ToList().OrderBy(p => p.AdSoyad);
                GridViewFirmaYetkiliBilgi.DataBind();

                if (FirmaYetkiliKey != 0)
                {
                    FIRMA_YETKILI _FIRMA_YETKILI =
                        entity.FIRMA_YETKILI.AsNoTracking().SingleOrDefault(p => p.FirmaYetkiliKey == FirmaYetkiliKey);
                    if (_FIRMA_YETKILI != null)
                    {
                        TextBoxFirmaYetkiliBilgiAdSoyad.Text = _FIRMA_YETKILI.AdSoyad;
                    }
                    else
                    {
                        TextBoxFirmaYetkiliBilgiAdSoyad.Text = string.Empty;
                    }
                }
                else
                {
                    TextBoxFirmaYetkiliBilgiAdSoyad.Text = string.Empty;
                }
            }
        }

        private void FirmaYonetimBilgiDataLoad()
        {
            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                GridViewFirmaYonetimBilgi.DataSource = null;
                GridViewFirmaYonetimBilgi.DataSource =
                    entity.FIRMA_YONETIM.AsNoTracking().Where(p => p.TuccarSicilKey == TuccarSicilKey).ToList().OrderBy(p => p.AdSoyad);
                GridViewFirmaYonetimBilgi.DataBind();

                if (FirmaYonetimKey != 0)
                {
                    FIRMA_YONETIM _FIRMA_YONETIM =
                        entity.FIRMA_YONETIM.AsNoTracking().SingleOrDefault(p => p.FirmaYonetimKey == FirmaYonetimKey);
                    if (_FIRMA_YONETIM != null)
                    {
                        TextBoxFirmaYonetimBilgiAdSoyad.Text = _FIRMA_YONETIM.AdSoyad;
                        TextBoxFirmaYonetimBilgiUnvan.Text = _FIRMA_YONETIM.Unvan;
                    }
                    else
                    {
                        TextBoxFirmaYonetimBilgiAdSoyad.Text = string.Empty;
                        TextBoxFirmaYonetimBilgiUnvan.Text = string.Empty;
                    }
                }
                else
                {
                    TextBoxFirmaYonetimBilgiAdSoyad.Text = string.Empty;
                    TextBoxFirmaYonetimBilgiUnvan.Text = string.Empty;
                }
            }
        }

        private void FirmaFaaliyetBilgiDataLoad()
        {
            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                GridViewFirmaFaaliyetBilgi.DataSource = null;
                GridViewFirmaFaaliyetBilgi.DataSource = entity.FIRMA_FAALIYET
                                                                .Include("TT_MADDE_KOD")
                                                                .AsNoTracking()
                                                              .Where(p => p.TuccarSicilKey == TuccarSicilKey)
                                                              .Select(p =>
                                                                      new
                                                                      {
                                                                          p.FirmaFaaliyetKey,
                                                                          MaddeKoduAdi = p.TT_MADDE_KOD.Adi,
                                                                          p.Uretim,
                                                                          p.Bayi,
                                                                          p.Alim,
                                                                          p.Satim,
                                                                          p.Ithalat,
                                                                          p.Ihracat
                                                                      }).ToList().OrderBy(p => p.FirmaFaaliyetKey);
                GridViewFirmaFaaliyetBilgi.DataBind();

                if (FirmaFaaliyetKey != 0)
                {
                    FIRMA_FAALIYET _FIRMA_FAALIYET =
                        entity.FIRMA_FAALIYET.AsNoTracking().SingleOrDefault(p => p.FirmaFaaliyetKey == FirmaFaaliyetKey);
                    if (_FIRMA_FAALIYET != null)
                    {
                        ComboBoxFirmaFaaliyetBilgiMaddeKodu.Items.FindByValue(_FIRMA_FAALIYET.MaddeKodKey.ToString())
                                                           .Selected = true;
                        CheckBoxFirmaFaaliyetBilgiUretim.Checked = _FIRMA_FAALIYET.Uretim.Value;
                        CheckBoxFirmaFaaliyetBilgiBayii.Checked = _FIRMA_FAALIYET.Bayi.Value;
                        CheckBoxFirmaFaaliyetBilgiAlim.Checked = _FIRMA_FAALIYET.Alim.Value;
                        CheckBoxFirmaFaaliyetBilgiSatim.Checked = _FIRMA_FAALIYET.Satim.Value;
                        CheckBoxFirmaFaaliyetBilgiIthalat.Checked = _FIRMA_FAALIYET.Ithalat.Value;
                        CheckBoxFirmaFaaliyetBilgiIhracat.Checked = _FIRMA_FAALIYET.Ihracat.Value;
                    }
                    else
                    {
                        ComboBoxFirmaFaaliyetBilgiMaddeKodu.SelectedIndex = -1;
                        CheckBoxFirmaFaaliyetBilgiUretim.Checked = false;
                        CheckBoxFirmaFaaliyetBilgiBayii.Checked = false;
                        CheckBoxFirmaFaaliyetBilgiAlim.Checked = false;
                        CheckBoxFirmaFaaliyetBilgiSatim.Checked = false;
                        CheckBoxFirmaFaaliyetBilgiIthalat.Checked = false;
                        CheckBoxFirmaFaaliyetBilgiIhracat.Checked = false;
                    }
                }
                else
                {
                    ComboBoxFirmaFaaliyetBilgiMaddeKodu.SelectedIndex = -1;
                    CheckBoxFirmaFaaliyetBilgiUretim.Checked = false;
                    CheckBoxFirmaFaaliyetBilgiBayii.Checked = false;
                    CheckBoxFirmaFaaliyetBilgiAlim.Checked = false;
                    CheckBoxFirmaFaaliyetBilgiSatim.Checked = false;
                    CheckBoxFirmaFaaliyetBilgiIthalat.Checked = false;
                    CheckBoxFirmaFaaliyetBilgiIhracat.Checked = false;
                }
            }
        }

        private void FirmaUyariBilgiDataLoad()
        {
            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                GridViewFirmaUyariBilgi.DataSource = null;
                GridViewFirmaUyariBilgi.DataSource = entity.FIRMA_UYARI
                    .AsNoTracking()
                    .Where(p => p.TuccarSicilKey == TuccarSicilKey)
                                                           .Select(p =>
                                                                   new
                                                                   {
                                                                       p.FirmaUyariKey,
                                                                       p.FirmaUyari,
                                                                       p.FirmaUyariTarih,
                                                                       p.Aktif
                                                                   }).ToList().OrderBy(p => p.FirmaUyariKey);
                GridViewFirmaUyariBilgi.DataBind();

                if (FirmaUyariKey != 0)
                {
                    FIRMA_UYARI _FIRMA_UYARI = entity.FIRMA_UYARI.AsNoTracking().SingleOrDefault(p => p.FirmaUyariKey == FirmaUyariKey);
                    if (_FIRMA_UYARI != null)
                    {
                        MemoFirmaUyari.Text = _FIRMA_UYARI.FirmaUyari;
                        DateEditFirmaUyariTarihi.Value = _FIRMA_UYARI.FirmaUyariTarih;
                        CheckBoxFirmaUyariAktif.Checked = _FIRMA_UYARI.Aktif;
                    }
                    else
                    {
                        MemoFirmaUyari.Text = string.Empty;
                        DateEditFirmaUyariTarihi.Text = string.Empty;
                        CheckBoxFirmaUyariAktif.Checked = true;
                    }
                }
                else
                {
                    MemoFirmaUyari.Text = string.Empty;
                    DateEditFirmaUyariTarihi.Text = string.Empty;
                    CheckBoxFirmaUyariAktif.Checked = true;
                }
            }
        }

        private void DereceDegisiklikDataLoad()
        {
            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                GridViewDereceDegisikligi.DataSource = null;
                GridViewDereceDegisikligi.DataSource = entity.DERECE_DEGISIKLIK
                                                            .Include("TT_DERECE")
                                                            .AsNoTracking()
                                                             .Where(p => p.TuccarSicilKey == TuccarSicilKey)
                                                             .Select(p =>
                                                                     new
                                                                     {
                                                                         p.DereceDegisiklikKey,
                                                                         DereceAdi = p.TT_DERECE.Kod,
                                                                         p.DereceVerilisYil,
                                                                         p.YKKTarih,
                                                                         p.YKKNo
                                                                     }).ToList().OrderBy(p => p.DereceDegisiklikKey);
                GridViewDereceDegisikligi.DataBind();

                ComboBoxDereceDegisikligiDerece.SelectedIndex = -1;
                ComboBoxDereceDegisikligiDereceYil.SelectedIndex = 0;
                DateEditDereceDegisikligiYKKTarihi.Value = null;
                TextBoxDereceDegisikligiYKKNo.Text = string.Empty;
            }
        }

        private void UnvanDegisiklikDataLoad()
        {
            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                GridViewUnvanDegisikligi.DataSource = null;
                GridViewUnvanDegisikligi.DataSource = entity.UNVAN_DEGISIKLIK.AsNoTracking().Where(
                    p => p.TuccarSicilKey == TuccarSicilKey).Select(p =>
                                                                    new
                                                                    {
                                                                        p.UnvanDegisiklikKey,
                                                                        p.Unvan,
                                                                        p.Yil,
                                                                        UnvanDegisiklikTarih = p.YKKTarih,
                                                                        p.YKKNo
                                                                    }).ToList().OrderBy(p => p.UnvanDegisiklikKey);
                GridViewUnvanDegisikligi.DataBind();

                MemoUnvanDegisikligiUnvan.Text = string.Empty;
                ComboBoxUnvanDegisikligiYil.SelectedIndex = 0;
                DateEditUnvanDegisikligiYKKTarih.Value = null;
                TextBoxUnvanDegisikligiYKKNo.Text = string.Empty;
            }
        }

        private void SermayeDegisiklikDataLoad()
        {
            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                GridViewSermayeDegisikligi.DataSource = null;
                GridViewSermayeDegisikligi.DataSource = entity.SERMAYE_DEGISIKLIK.AsNoTracking().Where(
                    p => p.TuccarSicilKey == TuccarSicilKey).Select(p =>
                                                                    new
                                                                    {
                                                                        p.SermayeDegisiklikKey,
                                                                        p.Sermaye,
                                                                        p.Yil,
                                                                        SermayeDegisiklikTarih = p.YKKTarih,
                                                                        p.YKKNo,
                                                                    }).ToList().OrderBy(p => p.SermayeDegisiklikKey);
                GridViewSermayeDegisikligi.DataBind();

                SpinEditSermayeDegisiklikSermaye.Text = string.Empty;
                ComboBoxSermayeDegisiklikSermayeYil.SelectedIndex = 0;
                DateEditSermayeDegisiklikYKKTarihi.Value = null;
                TextBoxSermayeDegisiklikYKKNo.Text = string.Empty;
            }
        }

        private void MeslekGrubuDegisiklikDataLoad()
        {
            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                GridViewMeslekGrubuDegisikligi.DataSource = null;
                GridViewMeslekGrubuDegisikligi.DataSource = entity.MESLEK_GRUP_DEGISIKLIK
                                                                .Include("TT_MESLEK_GRUP")
                                                                .AsNoTracking()
                                                                  .Where(p => p.TuccarSicilKey == TuccarSicilKey)
                                                                  .Select(p =>
                                                                          new
                                                                          {
                                                                              p.MeslekGrupDegisiklikKey,
                                                                              MeslekGrubu =
                                                                          p.TT_MESLEK_GRUP.MeslekAdi,
                                                                              p.Yil,
                                                                              MeslekGrupDegisiklikTarih = p.YKKTarih,
                                                                              p.YKKNo,
                                                                          })
                                                                  .ToList()
                                                                  .OrderBy(p => p.MeslekGrupDegisiklikKey);
                GridViewMeslekGrubuDegisikligi.DataBind();

                ComboBoxMeslekGrubuDegisiklikMeslekGrubu.SelectedIndex = -1;
                ComboBoxMeslekGrubuDegisiklikMeslekGrubuYil.SelectedIndex = 0;
                DateEditMeslekGrubuDegisiklikYKKTarihi.Value = null;
                TextBoxMeslekGrubuDegisiklikYKKNo.Value = string.Empty;
            }
        }

        private void FirmaKayitliOdaDataLoad()
        {
            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                GridViewKayitliOdaListesi.DataSource = null;
                GridViewKayitliOdaListesi.DataSource = entity.FIRMA_KAYITLI_ODA
                    .AsNoTracking()
                    .Where(
                    p => p.TuccarSicilKey == TuccarSicilKey).Select(p =>
                                                                    new
                                                                    {
                                                                        p.FirmaKayitliOdaKey,
                                                                        p.OdaBorsaAdi,
                                                                        p.OdaBorsaSicilNo,
                                                                        p.OdaBorsaKayitTarihi,
                                                                        p.Aciklama,
                                                                    }).ToList().OrderBy(p => p.FirmaKayitliOdaKey);
                GridViewKayitliOdaListesi.DataBind();

                if (FirmaKayitliOdaKey != 0)
                {
                    FIRMA_KAYITLI_ODA _FIRMA_KAYITLI_ODA =
                        entity.FIRMA_KAYITLI_ODA.AsNoTracking().SingleOrDefault(p => p.FirmaKayitliOdaKey == FirmaKayitliOdaKey);
                    if (_FIRMA_KAYITLI_ODA != null)
                    {
                        TextBoxOdaBorsaAdi.Text = _FIRMA_KAYITLI_ODA.OdaBorsaAdi;
                        DateEditOdaBorsaKayitTarihi.Value = _FIRMA_KAYITLI_ODA.OdaBorsaKayitTarihi;
                        MemoOdaBorsaAciklama.Text = _FIRMA_KAYITLI_ODA.Aciklama;
                        TextBoxOdaBorsaSicilNo.Text = _FIRMA_KAYITLI_ODA.OdaBorsaSicilNo;
                    }
                    else
                    {
                        TextBoxOdaBorsaAdi.Text = string.Empty;
                        DateEditOdaBorsaKayitTarihi.Value = null;
                        MemoOdaBorsaAciklama.Text = string.Empty;
                        TextBoxOdaBorsaSicilNo.Text = string.Empty;
                    }
                }
                else
                {
                    TextBoxOdaBorsaAdi.Text = string.Empty;
                    DateEditOdaBorsaKayitTarihi.Value = null;
                    MemoOdaBorsaAciklama.Text = string.Empty;
                    TextBoxOdaBorsaSicilNo.Text = string.Empty;
                }
            }
        }

        private void FirmaDigerFaaliyetKodlariDataLoad()
        {
            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                GridViewDigerFaaliyetKodlari.DataSource = null;
                GridViewDigerFaaliyetKodlari.DataSource = entity.FIRMA_DIGER_FAALIYET_KOD
                    .AsNoTracking()
                    .Where(
                    p => p.TuccarSicilKey == TuccarSicilKey).Select(p =>
                                                                    new
                                                                    {
                                                                        p.FirmaDigerFaaliyetKodKey,
                                                                        NaceKodu = p.NaceKodu1 + " - " + p.NaceKodu2,
                                                                        p.BaslangicTarihi,
                                                                        p.Aciklama,
                                                                    })
                                                                .ToList()
                                                                .OrderBy(p => p.FirmaDigerFaaliyetKodKey);
                GridViewDigerFaaliyetKodlari.DataBind();

                if (FirmaDigerFaaliyetKodKey != 0)
                {
                    FIRMA_DIGER_FAALIYET_KOD _FIRMA_DIGER_FAALIYET_KOD =
                        entity.FIRMA_DIGER_FAALIYET_KOD.AsNoTracking().SingleOrDefault(
                            p => p.FirmaDigerFaaliyetKodKey == FirmaDigerFaaliyetKodKey);
                    if (_FIRMA_DIGER_FAALIYET_KOD != null)
                    {
                        TextBoxDigerFaaliyetKodlariNaceKodu1.Text = _FIRMA_DIGER_FAALIYET_KOD.NaceKodu1;
                        TextBoxDigerFaaliyetKodlariNaceKodu2.Text = _FIRMA_DIGER_FAALIYET_KOD.NaceKodu2;
                        DateEditDigerFaaliyetKodlariBaslangicTarihi.Value = _FIRMA_DIGER_FAALIYET_KOD.BaslangicTarihi;
                        MemoDigerFaaliyetKodlariAciklama.Text = _FIRMA_DIGER_FAALIYET_KOD.Aciklama;
                    }
                    else
                    {
                        TextBoxDigerFaaliyetKodlariNaceKodu1.Text = string.Empty;
                        TextBoxDigerFaaliyetKodlariNaceKodu2.Text = string.Empty;
                        DateEditDigerFaaliyetKodlariBaslangicTarihi.Value = null;
                        MemoDigerFaaliyetKodlariAciklama.Text = string.Empty;
                    }
                }
                else
                {
                    TextBoxDigerFaaliyetKodlariNaceKodu1.Text = string.Empty;
                    TextBoxDigerFaaliyetKodlariNaceKodu2.Text = string.Empty;
                    DateEditDigerFaaliyetKodlariBaslangicTarihi.Value = null;
                    MemoDigerFaaliyetKodlariAciklama.Text = string.Empty;
                }
            }
        }

        private bool AyniSicilNoVarMi(string pSicilNo)
        {
            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                int uyeler = entity.TUCCAR_SICIL.AsNoTracking().Count(p => p.SicilNo == pSicilNo);
                if (uyeler > 0)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
        }

        #endregion
    }
}
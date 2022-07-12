using DevExpress.Web.ASPxEditors;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Security;
using System.Web.UI;
using TicaretBorsasi_Project.Class.Helper;
using TicaretBorsasi_Project.Data;

namespace TicaretBorsasi_Project.Program.MerkezBorsa.BeyannameTescilIslemleri
{
    public partial class BeyannameTescilIslemleri : Page
    {
        #region Properties

        private int Key
        {
            get
            {
                string key = Request.QueryString["Key"];
                if (Session["Key"] == null || key != Session["Key"].ToString())
                {
                    Session["Key"] = key;
                }

                int keysonuc;
                int.TryParse(key, out keysonuc);
                return keysonuc;
            }
        }

        private byte? BeyannameTip
        {
            get
            {
                if (Session["BeyannameTip"] == null)
                {
                    return null;
                }
                else
                {
                    return Convert.ToByte(Session["BeyannameTip"]);
                }
            }
            set
            {
                Session["BeyannameTip"] = value;
            }
        }

        #endregion

        #region Events

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ComboBoxBeyannameTipi.Focus();
                DataLoad();
            }

            SetInitials();
        }

        protected void Page_LoadComplete(object sender, EventArgs e)
        {
            if (BeyannameTip == null)
            {
                ComboBoxBeyannameTipi.SelectedIndex = -1;
            }
            else
            {
                ComboBoxBeyannameTipi.Items.FindByValue(BeyannameTip.Value).Selected = true;
                PanelAktifPasif();
            }
        }

        protected void ButtonTescilAra_Click(object sender, EventArgs e)
        {
            TescilNoGetir();
        }

        protected void ButtonGeriIleri_Click(object sender, EventArgs e)
        {
            using (var entity = new DBEntities())
            {
                int tescilkodu = Convert.ToInt32(TextBoxTescilKodu.Text);
                string butonadi = ((ASPxButton)sender).ID;

                var beyanlistesi = entity.BEYANs.AsNoTracking().ToList();
                BEYAN _BEYAN = null;
                switch (butonadi)
                {
                    case "ButtonGeri":
                        _BEYAN = beyanlistesi.LastOrDefault(p => Convert.ToInt32(p.BeyanNo) < tescilkodu);
                        if (_BEYAN == null)
                        {
                            _BEYAN = beyanlistesi.First();
                        }
                        break;
                    case "ButtonIleri":
                        _BEYAN = beyanlistesi.LastOrDefault(p => Convert.ToInt32(p.BeyanNo) > tescilkodu);
                        if (_BEYAN == null)
                        {
                            _BEYAN = beyanlistesi.Last();
                        }
                        break;
                }

                int key = _BEYAN.BeyanKey;
                Response.Redirect(string.Format("BeyannameTescilIslemleri.aspx?Key={0}", key));
            }
        }

        protected void ButtonAra_Click(object sender, EventArgs e)
        {
            using (var entity = new DBEntities())
            {
                ASPxButton btn = sender as ASPxButton;
                string sicilno = "";
                switch (btn.ID)
                {
                    case "ButtonSicilAra":
                        MemoUnvan.Text = string.Empty;
                        sicilno = PageHelper.SicilNoTamamlama(TextBoxSicilNo.Text);
                        break;
                    case "ButtonAliciSicilAra":
                        MemoAliciUnvan.Text = string.Empty;
                        sicilno = PageHelper.SicilNoTamamlama(TextBoxAliciSicilNo.Text);
                        break;
                }

                var _TUCCAR_SICIL = entity.TUCCAR_SICIL.AsNoTracking().SingleOrDefault(p => p.SicilNo == sicilno);
                if (_TUCCAR_SICIL == null)
                {
                    switch (btn.ID)
                    {
                        case "ButtonSicilAra":
                            TextBoxSicilNo.Focus();
                            TextBoxSicilNo.Text = string.Empty;
                            break;
                        case "ButtonAliciSicilAra":
                            TextBoxAliciSicilNo.Focus();
                            TextBoxAliciSicilNo.Text = string.Empty;
                            break;
                    }
                    PageHelper.MessageBox(this, "Tüccar bulunamadı.");                    
                }
                else
                {
                    switch (btn.ID)
                    {
                        case "ButtonSicilAra":
                            MemoUnvan.Text = _TUCCAR_SICIL.Unvan;
                            SpinEditBeyanSatirNo.Focus();
                            break;
                        case "ButtonAliciSicilAra":
                            MemoAliciUnvan.Text = _TUCCAR_SICIL.Unvan;
                            SpinEditVergiNo.Focus();break;
                    }

                }
            }
        }

        protected void ButtonKaydetGuncelle_Click(object sender, EventArgs e)
        {
            using (var entity = new DBEntities())
            {
                #region validation

                var _TuccarSicil = entity.TUCCAR_SICIL.AsNoTracking().SingleOrDefault(p => p.SicilNo == PageHelper.SicilNoTamamlama(TextBoxSicilNo.Text));
                int? pTuccarSicilKey = null;

                if (_TuccarSicil == null)
                {
                    PageHelper.MessageBox(this, "Lütfen sicil no girişi yapınız.");
                    return;
                }
                else
                {
                    pTuccarSicilKey = (int?)_TuccarSicil.TuccarSicilKey;
                }

                var _TuccarSicilAlici = entity.TUCCAR_SICIL.AsNoTracking().SingleOrDefault(p => p.SicilNo == PageHelper.SicilNoTamamlama(TextBoxSicilNo.Text));
                int? pTuccarSicilAliciKey = null;

                if (_TuccarSicilAlici == null)
                {
                    PageHelper.MessageBox(this, "Lütfen alıcı sicil no girişi yapınız.");
                    return;
                }
                else
                {
                    pTuccarSicilAliciKey = (int?)_TuccarSicilAlici.TuccarSicilKey;
                }

                string pTescilno = PageHelper.SicilNoTamamlama(TextBoxTescilKodu.Text);
                int? pSube = ComboBoxSube.SelectedIndex == -1 ? null : (int?)Convert.ToInt32(ComboBoxSube.SelectedItem.Value);
                int? pYil = Convert.ToInt32(ComboBoxYili.SelectedItem.Value);

                if (pSube == null || pYil == null)
                {
                    PageHelper.MessageBox(this, "Lütfen şube ve yıl bilgilerini giriniz.");
                    return;
                }

                var kayit = entity.BEYANs.AsNoTracking().FirstOrDefault(p => p.BeyanNo == pTescilno && p.BorsaSubeKey == pSube && p.BeyanTarihi.Value.Year == pYil);
                if (kayit != null)
                {
                    PageHelper.MessageBox(this, "Aynı tescil noya sahip başka bir kayıt var.");
                    return;
                }

                #endregion

                BEYAN _BEYAN;
                if (Key == 0)
                {
                    _BEYAN = new BEYAN();
                }
                else
                {
                    _BEYAN = entity.BEYANs.Single(p => p.BeyanKey == Key);
                }

                _BEYAN.BorsaSubeKey = pSube;
                _BEYAN.BeyanNo = pTescilno;
                _BEYAN.BeyanTarihi = DateEditBeyanTarihi.Date;
                _BEYAN.TuccarSicilKey = pTuccarSicilKey;
                _BEYAN.BeyanSatirNo = SpinEditBeyanSatirNo.Text;
                SpinEditToplamSatir.Text = entity.BEYANs.Count(p => p.BeyanNo == _BEYAN.BeyanNo && p.BorsaSubeKey == _BEYAN.BorsaSubeKey).ToString();
                _BEYAN.SatisSekliKey = Convert.ToInt32(ComboBoxSatisSekli.SelectedItem.Value);
                _BEYAN.BeyanSatirNo = PageHelper.SatirNoTamamlama(SpinEditSayisi.Text);
                _BEYAN.BeyannameKarsiFirmaTuccarSicilKey = pTuccarSicilAliciKey;
                //TextBoxAliciSicilNo.Text = _BEYAN.TUCCAR_SICIL.SicilNo;
                //MemoAliciUnvan.Text = _BEYAN.TUCCAR_SICIL.Unvan;
                _BEYAN.TUCCAR_SICIL.VergiNo = SpinEditVergiNo.Text;
                _BEYAN.TUCCAR_SICIL.VergiDaireKey = Convert.ToInt32(ComboBoxVergiDairesi.SelectedItem.Value);
                //TextBoxEmtiaAdi.Text = _BEYAN.mad.Adi;
                _BEYAN.BeyanMiktar = Convert.ToDecimal(SpinEditMiktar.Text);
                _BEYAN.BirimTipKey = Convert.ToByte(ComboBoxBirim.Items);
                _BEYAN.BirimFiyat = Convert.ToDecimal(SpinEditFiyat.Text);
                _BEYAN.BeyanSatisTutari = Convert.ToDecimal(SpinEditTutar.Text);
                _BEYAN.BeyanFaturaNo = SpinEditFaturaNo.Text;
                _BEYAN.BeyanFaturaTarihi = DateEditFaturaTarihi.Date;
                _BEYAN.Mensei = TextBoxMensei.Text;
                //??ComboBoxYili.Items.FindByText(_BEYAN.yi
                _BEYAN.TescilMiktar = Convert.ToDecimal(SpinEditTescilUcreti.Text);
                _BEYAN.TeslimTarihi = DateEditTeslimTarihi.Date;
                _BEYAN.MaddeKodKey = Convert.ToInt32(ComboBoxEmtia.SelectedItem.Value);
                _BEYAN.OzelSartTanimlama = MemoOzelSartlar.Text;
                _BEYAN.CanliHayvanAdet = Convert.ToInt16(SpinEditAdet.Text);
                _BEYAN.TeslimMahalli = TextBoxTeslimMahalli.Text;
                //SpinEditKalan.Text = _BEYAN.;

                MembershipUser user = Membership.GetUser(true);
                Guid userkey = user == null ? Guid.Empty : (Guid)user.ProviderUserKey;
                if (Key == 0)
                {
                    _BEYAN.KayitKisiKey = userkey;
                    _BEYAN.KayitTarih = DateTime.Now;
                    entity.BEYANs.Add(_BEYAN);
                }
                else
                {
                    _BEYAN.GuncelleKisiKey = userkey;
                    _BEYAN.GuncelleTarih = DateTime.Now;
                }

                entity.SaveChanges();

                Response.Redirect(string.Format("BeyannameTescilIslemleri.aspx?Key={0}", _BEYAN.BeyanKey));
            }
        }

        protected void ButtonIptal_Click(object sender, EventArgs e)
        {
            Response.Redirect("BeyannameTescilIslemleri.aspx");
        }

        protected void ButtonTemizle_Click(object sender, EventArgs e)
        {
            Response.Redirect(Request.Url.AbsoluteUri);
        }

        protected void TextBoxTescilKodu_TextChanged(object sender, EventArgs e)
        {
            TescilNoGetir();
        }

        protected void TextBoxSicilNo_TextChanged(object sender, EventArgs e)
        {
            using (var entity = new DBEntities())
            {
                ASPxTextBox txt = sender as ASPxTextBox;
                string sicilno = "";
                switch (txt.ID)
                {
                    case "TextBoxSicilNo":
                        MemoUnvan.Text = string.Empty;
                        sicilno = PageHelper.SicilNoTamamlama(TextBoxSicilNo.Text);
                        break;
                    case "TextBoxAliciSicilNo":
                        MemoAliciUnvan.Text = string.Empty;
                        sicilno = PageHelper.SicilNoTamamlama(TextBoxAliciSicilNo.Text);
                        break;
                }

                var _TUCCAR_SICIL = entity.TUCCAR_SICIL.AsNoTracking().SingleOrDefault(p => p.SicilNo == sicilno);
                if (_TUCCAR_SICIL == null)
                {
                    PageHelper.MessageBox(this, "Tüccar bulunamadı.");
                    txt.Focus();
                    txt.Text = string.Empty;
                }
                else
                {
                    switch (txt.ID)
                    {
                        case "TextBoxSicilNo":
                            MemoUnvan.Text = _TUCCAR_SICIL.Unvan;
                            SpinEditBeyanSatirNo.Focus();
                            break;
                        case "TextBoxAliciSicilNo":
                            MemoAliciUnvan.Text = _TUCCAR_SICIL.Unvan;
                            SpinEditVergiNo.Focus();
                            break;
                    }
                }
            }
        }

        protected void ComboBoxBeyannameTipi_SelectedIndexChanged(object sender, EventArgs e)
        {
            BeyannameTip = Convert.ToByte(ComboBoxBeyannameTipi.SelectedItem.Value);
            PanelAktifPasif();
            ComboBoxSube.Focus();
        }

        #endregion

        #region Methods

        private void SetInitials()
        {
            LabelBaslik.Text = "BEYANNAME TESCİL İŞLEMLERİ";

            if (Key == 0)
            {
                PanelKaydet.Visible = true;
                PanelGuncelle.Visible = false;
                divIslemler.Style.Value = "margin-left: 40%;";
            }
            else
            {
                PanelKaydet.Visible = false;
                PanelGuncelle.Visible = true;
                divIslemler.Style.Value = "margin-left: 35%;";
            }

            PanelAktifPasif();
        }

        private void DataLoad()
        {
            using (var entity = new DBEntities())
            {
                List<TT_BEYAN_TIP> listBEYAN_TIP = entity.TT_BEYAN_TIP.AsNoTracking().OrderBy(p => p.BeyanTipKey).ToList();
                List<TT_VERGI_DAIRE> listVERGI_DAIRE = entity.TT_VERGI_DAIRE.AsNoTracking().OrderBy(p => p.VergiDairesiAdi).ToList();
                List<TT_BORSA_SUBE> listBORSA_SUBE = entity.TT_BORSA_SUBE.AsNoTracking().OrderBy(p => p.Kod).ToList();
                List<TT_SATIS_SEKLI> listSATIS_SEKLI = entity.TT_SATIS_SEKLI.AsNoTracking().OrderBy(p => p.Kod).ToList();
                List<TT_BIRIM_TIP> list_BIRIM_TIP = entity.TT_BIRIM_TIP.AsNoTracking().ToList();
                List<TT_MADDE_KOD> list_MADDE_KOD = entity.TT_MADDE_KOD.AsNoTracking().ToList();

                ComboBoxBeyannameTipi.DataSource = listBEYAN_TIP;
                ComboBoxBeyannameTipi.DataBind();

                ComboBoxVergiDairesi.DataSource = listVERGI_DAIRE;
                ComboBoxVergiDairesi.DataBind();

                ComboBoxSube.DataSource = listBORSA_SUBE;
                ComboBoxSube.DataBind();

                ComboBoxSatisSekli.DataSource = listSATIS_SEKLI;
                ComboBoxSatisSekli.DataBind();

                ComboBoxBirim.DataSource = list_BIRIM_TIP;
                ComboBoxBirim.DataBind();

                ComboBoxEmtia.DataSource = list_MADDE_KOD;
                ComboBoxEmtia.DataBind();

                var listYil = new List<string>();
                for (int i = DateTime.Now.Year; i > 1900; i--)
                {
                    listYil.Add(i.ToString());
                }
                ComboBoxYili.DataSource = listYil;
                ComboBoxYili.DataBind();
                ComboBoxYili.SelectedIndex = 0;

            }

            DateEditBeyanTarihi.Date = DateTime.Now.Date;
            SpinEditBeyanSatirNo.Text = "1";
            SpinEditToplamSatir.Text = "1";

            if (Key != 0)
            {
                using (var entity = new DBEntities())
                {
                    BEYAN _BEYAN = entity.BEYANs.Include("TUCCAR_SICIL").Include("TT_MADDE_KOD").AsNoTracking().SingleOrDefault(p => p.BeyanKey == Key);
                    if (_BEYAN == null)
                    {
                        Response.Redirect("BeyannameTescilIslemleri.aspx");
                        return;
                    }

                    ComboBoxBeyannameTipi.Items.FindByValue(_BEYAN.BeyanTipKey).Selected = true;
                    ComboBoxSube.Items.FindByValue(_BEYAN.BorsaSubeKey).Selected = true;
                    TextBoxTescilKodu.Text = _BEYAN.BeyanNo;
                    DateEditBeyanTarihi.Date = _BEYAN.BeyanTarihi.Value;
                    MemoUnvan.Text = _BEYAN.TUCCAR_SICIL.Unvan;
                    TextBoxSicilNo.Text = _BEYAN.TUCCAR_SICIL.SicilNo;
                    SpinEditBeyanSatirNo.Text = _BEYAN.BeyanSatirNo;
                    SpinEditToplamSatir.Text = entity.BEYANs.Count(p => p.BeyanNo == _BEYAN.BeyanNo && p.BorsaSubeKey == _BEYAN.BorsaSubeKey).ToString();
                    ComboBoxSatisSekli.Items.FindByValue(_BEYAN.SatisSekliKey).Selected = true;
                    //??SpinEditSayisi.Text=_BEYAN.say;
                    TextBoxAliciSicilNo.Text = _BEYAN.TUCCAR_SICIL.SicilNo;
                    MemoAliciUnvan.Text = _BEYAN.TUCCAR_SICIL.Unvan;
                    SpinEditVergiNo.Text = _BEYAN.TUCCAR_SICIL.VergiNo;
                    ComboBoxVergiDairesi.Items.FindByValue(_BEYAN.TUCCAR_SICIL.VergiDaireKey).Selected = true;
                    TextBoxEmtiaAdi.Text = _BEYAN.TT_MADDE_KOD.Adi;
                    SpinEditMiktar.Text = _BEYAN.BeyanMiktar.ToString();
                    ComboBoxBirim.Items.FindByValue(_BEYAN.BirimTipKey).Selected = true;
                    SpinEditFiyat.Text = _BEYAN.BirimFiyat.ToString();
                    SpinEditTutar.Text = _BEYAN.BeyanSatisTutari.ToString();
                    SpinEditFaturaNo.Text = _BEYAN.BeyanFaturaNo;
                    DateEditFaturaTarihi.Text = _BEYAN.BeyanFaturaTarihi == null ? null : _BEYAN.BeyanFaturaTarihi.Value.ToString();
                    TextBoxMensei.Text = _BEYAN.Mensei;
                    //??ComboBoxYili.Items.FindByText(_BEYAN.yi
                    SpinEditTescilUcreti.Text = _BEYAN.TescilMiktar.ToString();
                    DateEditTeslimTarihi.Date = _BEYAN.TeslimTarihi.Value;
                    ComboBoxEmtia.Items.FindByValue(_BEYAN.MaddeKodKey).Selected = true;
                    MemoOzelSartlar.Text = _BEYAN.OzelSartTanimlama;
                    SpinEditAdet.Text = _BEYAN.CanliHayvanAdet.ToString();
                    TextBoxTeslimMahalli.Text = _BEYAN.TeslimMahalli;
                    SpinEditTescilToplam.Text = entity.BEYANs.AsNoTracking().Where(p => p.BeyanNo == _BEYAN.BeyanNo && p.BorsaSubeKey == _BEYAN.BorsaSubeKey).Sum(p => p.TescilMiktar).ToString();
                    SpinEditBeyannameToplam.Text = entity.BEYANs.AsNoTracking().Where(p => p.BeyanNo == _BEYAN.BeyanNo && p.BorsaSubeKey == _BEYAN.BorsaSubeKey).Sum(p => p.BeyanMiktar).ToString();
                    //SpinEditKalan.Text = _BEYAN.;
                }
            }
        }

        private void PanelAktifPasif()
        {
            if (ComboBoxBeyannameTipi.SelectedIndex == -1)
            {
                PanelTescil.Enabled = false;

            }
            else
            {
                PanelTescil.Enabled = true;
            }
        }

        private bool AyniTescilNoVarMi(string pSicilNo)
        {
            using (var entity = new DBEntities())
            {
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

        private void TescilNoGetir()
        {
            using (var entity = new DBEntities())
            {
                string pTescilno = PageHelper.SicilNoTamamlama(TextBoxTescilKodu.Text);
                int? pSube = ComboBoxSube.SelectedIndex == -1 ? null : (int?)Convert.ToInt32(ComboBoxSube.SelectedItem.Value);
                int? pYil = Convert.ToInt32(ComboBoxYili.SelectedItem.Value);

                if (pSube == null || pYil == null)
                {
                    PageHelper.MessageBox(this, "Lütfen şube ve yıl bilgilerini giriniz.");
                    return;
                }

                var _BEYAN = entity.BEYANs.AsNoTracking().FirstOrDefault(p => p.BeyanNo == pTescilno && p.BorsaSubeKey == pSube && p.BeyanTarihi.Value.Year == pYil);
                if (_BEYAN == null)
                {
                    PageHelper.MessageBox(this, "Tescil no bulunamadı.");
                    TextBoxTescilKodu.Focus();
                    TextBoxTescilKodu.Text = string.Empty;
                }
                else
                {
                    Response.Redirect(string.Format("BeyannameTescilIslemleri.aspx?Key={0}", _BEYAN.BeyanKey));
                }
            }
        }

        #endregion

    }
}
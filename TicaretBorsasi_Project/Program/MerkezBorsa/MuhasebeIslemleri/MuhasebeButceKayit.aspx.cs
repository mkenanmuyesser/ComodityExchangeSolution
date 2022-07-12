using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Security;
using System.Web.UI;
using TicaretBorsasi_Project.Class.Helper;
using TicaretBorsasi_Project.Data;

namespace TicaretBorsasi_Project.Program.MerkezBorsa.MuhasebeIslemleri
{
    public partial class MuhasebeButceKayit : Page
    {
        #region Properties

        private int HesapPlaniKey
        {
            get
            {
                string key = Request.QueryString["Key"];
                int keysonuc;
                int.TryParse(key, out keysonuc);
                return keysonuc;
            }
        }

        #endregion

        #region Events

        protected void Page_Load(object sender, EventArgs e)
        {
            SetInitials();
        }

        protected void ButtonAra_Click(object sender, EventArgs e)
        {
            HESAP_PLANI _HESAP_PLANI = HesapNoVarMi();
            if (_HESAP_PLANI == null)
            {
                PageHelper.MessageBox(this, "Hesap no bulunamadı.");
            }
            else
            {
                int key = _HESAP_PLANI.HesapPlaniKey;                
                Response.Redirect(string.Format("MuhasebeButceKayit.aspx?Key={0}", key));
            }
        }

        protected void ButtonKaydetGuncelle_Click(object sender, EventArgs e)
        {
            using (var entity = new DBEntities())
            {

                int pMuhasebeTipKey = Convert.ToInt32(ComboBoxMuhasebeTip.SelectedItem.Value);
                string pHesapKodu = TextBoxIlgiliKasaHesabi.Text.Replace("_", "").Replace(" ", "").Trim();
                byte pMuhasebeDurumTipKey = Convert.ToByte(ComboBoxMuhasebeDurumTip.SelectedItem.Value);
                decimal pButceMiktar = Convert.ToDecimal(SpinEditButceMiktar.Text);

                #region validation

                if (string.IsNullOrEmpty(pHesapKodu))
                {
                    PageHelper.MessageBox(this, "Yanlış hesap numarası girilmiştir.");
                    return;
                }

                if (HesapNoVarMi() == null)
                {
                    PageHelper.MessageBox(this, "Hesap no bulunamadı.");
                    return;
                }

                #endregion

                HESAP_PLANI _HESAP_PLANI;
                if (HesapPlaniKey == 0)
                {
                    _HESAP_PLANI = new HESAP_PLANI();
                }
                else
                {
                    _HESAP_PLANI = entity.HESAP_PLANI.SingleOrDefault(p => p.HesapPlaniKey == HesapPlaniKey);
                    if (_HESAP_PLANI == null)
                    {
                        Response.Redirect("MuhasebeButceKayit.aspx");
                        return;
                    }
                }

                _HESAP_PLANI.MuhasebeTipKey = pMuhasebeTipKey;
                _HESAP_PLANI.HesapKodu = pHesapKodu;
                _HESAP_PLANI.Borc1_ = pMuhasebeTipKey == 1 ? 0.01m : 0.02m;
                _HESAP_PLANI.Borc2_ = pButceMiktar;

                MembershipUser user = Membership.GetUser(true);
                Guid userkey = user == null ? Guid.Empty : (Guid)user.ProviderUserKey;
                if (HesapPlaniKey == 0)
                {
                    _HESAP_PLANI.KayitKisiKey = userkey;
                    _HESAP_PLANI.KayitTarih = DateTime.Now;
                    entity.HESAP_PLANI.Add(_HESAP_PLANI);
                }
                else
                {
                    _HESAP_PLANI.GuncelleKisiKey = userkey;
                    _HESAP_PLANI.GuncelleTarih = DateTime.Now;
                }

                entity.SaveChanges();

                Response.Redirect(string.Format("MuhasebeButceKayit.aspx?Key={0}", _HESAP_PLANI.HesapPlaniKey));
            }
        }

        protected void ButtonIptal_Click(object sender, EventArgs e)
        {
            Response.Redirect("MuhasebeButceKayit.aspx");
        }

        protected void ButtonTemizle_Click(object sender, EventArgs e)
        {
            Response.Redirect(Request.Url.AbsoluteUri);
        }

        #endregion

        #region Methods

        private void SetInitials()
        {

            ButtonKaydet.Visible = false;
            ButtonTemizle.Visible = false;
            ButtonGuncelle.Visible = false;
            ButtonIptal.Visible = false;

            ComboBoxMuhasebeDurumTip.Enabled = false;
            SpinEditButceMiktar.Enabled = false;

            if (!IsPostBack)
            {
                DataLoad();
            }

            if (HesapPlaniKey == 0)
            {
                LabelBaslik.Text = "BÜTÇE KAYDET";
            }
            else
            {
                HESAP_PLANI _HESAP_PLANI = HesapNoVarMi();

                ComboBoxMuhasebeDurumTip.Enabled = true;
                SpinEditButceMiktar.Enabled = true;

                bool butcekaydivarmi = _HESAP_PLANI.Borc1_ == 0.01m || _HESAP_PLANI.Borc1_ == 0.02m;
                if (_HESAP_PLANI == null || !butcekaydivarmi)
                {
                    LabelBaslik.Text = "BÜTÇE KAYDET";

                    ButtonKaydet.Visible = true;
                    ButtonTemizle.Visible = true;
                    ButtonGuncelle.Visible = false;
                    ButtonIptal.Visible = false;
                }
                else
                {
                    LabelBaslik.Text = "BÜTÇE GÜNCELLE";

                    ButtonKaydet.Visible = false;
                    ButtonTemizle.Visible = false;
                    ButtonGuncelle.Visible = true;
                    ButtonIptal.Visible = true;
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
                    List<TT_MUHASEBE_TIP> listMUHASEBE_TIP = entity.TT_MUHASEBE_TIP.AsNoTracking().ToList();
                    List<TT_MUHASEBE_DURUM_TIP> listMUHASEBE_DURUM_TIP = entity.TT_MUHASEBE_DURUM_TIP.AsNoTracking().ToList();
                    var yillar = new List<int>();
                    for (int i = DateTime.Now.Year; i >= 1900; i--)
                    {
                        yillar.Add(i);
                    }

                    ComboBoxMuhasebeTip.DataSource = listMUHASEBE_TIP;
                    ComboBoxMuhasebeTip.DataBind();

                    ComboBoxMuhasebeDurumTip.DataSource = listMUHASEBE_DURUM_TIP;
                    ComboBoxMuhasebeDurumTip.DataBind();

                    ComboBoxYil.DataSource = yillar;
                    ComboBoxYil.DataBind();
                    ComboBoxYil.SelectedIndex = 0;


                    if (HesapPlaniKey != 0)
                    {
                        HESAP_PLANI _HESAP_PLANI = entity.HESAP_PLANI.SingleOrDefault(p => p.HesapPlaniKey == HesapPlaniKey);
                        ComboBoxMuhasebeTip.Items.FindByValue(_HESAP_PLANI.MuhasebeTipKey).Selected = true;
                        TextBoxIlgiliKasaHesabi.Text = _HESAP_PLANI.HesapKodu;
                        LabelHesapAdi.Text = _HESAP_PLANI.HesapAdi;
                        ComboBoxMuhasebeDurumTip.Items.FindByValue(_HESAP_PLANI.Borc1_ == 0.01m ? 1 : 2).Selected = true;
                        SpinEditButceMiktar.Text = _HESAP_PLANI.Borc2_.ToString();
                    }
                }
            }
        }

        private HESAP_PLANI HesapNoVarMi()
        {
            Int16 pYil = Convert.ToInt16(ComboBoxYil.SelectedItem.Value);
            int pMuhasebeTipKey = Convert.ToInt32(ComboBoxMuhasebeTip.SelectedItem.Value);
            string pHesapKodu = TextBoxIlgiliKasaHesabi.Text.Replace("_", "").Replace(" ", "").Trim();

            HESAP_PLANI _HESAP_PLANI = null;
            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                _HESAP_PLANI = _HESAP_PLANI = entity.HESAP_PLANI.AsNoTracking().SingleOrDefault(p =>
                                                                                (p.Yil == null || p.Yil == pYil) &&
                                                                                p.MuhasebeTipKey == pMuhasebeTipKey &&
                                                                                p.HesapKodu == pHesapKodu);
            }

            return _HESAP_PLANI;
        }

        #endregion
    }
}
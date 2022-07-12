using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Security;
using System.Web.UI;
using TicaretBorsasi_Project.Class.Helper;
using TicaretBorsasi_Project.Data;

namespace TicaretBorsasi_Project.Program.MerkezBorsa.MuhasebeIslemleri
{
    public partial class MuhasebeHesapPlaniKayit : Page
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

        protected void ButtonKaydetGuncelle_Click(object sender, EventArgs e)
        {
            using (var entity = new DBEntities())
            {
                int pMuhasebeTipKey = Convert.ToInt32(ComboBoxMuhasebeTip.SelectedItem.Value);
                string pHesapKodu = TextBoxHesapNo.Text.Replace("_", "").Replace(" ", "").Trim();
                string pHesapAdi = TextBoxHesapAdi.Text;

                #region validation

                if (HesapPlaniKey == 0 && AyniKayitVarMi(pHesapKodu, entity))
                {
                    PageHelper.MessageBox(this, "Aynı hesap no kaydı bulunmaktadır.");
                    return;
                }

                if (pHesapKodu.Length == 0 || !(pHesapKodu.Length == 3 || pHesapKodu.Length == 5 || pHesapKodu.Length == 10))
                {
                    PageHelper.MessageBox(this, "Lütfen hesap no alanını uygun şekilde doldurunuz.");
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
                        Response.Redirect("MuhasebeHesapPlaniKayit.aspx");
                        return;
                    }
                }

                _HESAP_PLANI.MuhasebeTipKey = pMuhasebeTipKey;
                _HESAP_PLANI.HesapKodu = pHesapKodu;
                _HESAP_PLANI.HesapAdi = pHesapAdi;

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

                Response.Redirect(string.Format("MuhasebeHesapPlaniKayit.aspx?Key={0}", _HESAP_PLANI.HesapPlaniKey));
            }
        }

        protected void ButtonIptal_Click(object sender, EventArgs e)
        {
            Response.Redirect("MuhasebeHesapPlaniKayit.aspx");
        }

        protected void ButtonTemizle_Click(object sender, EventArgs e)
        {
            Response.Redirect(Request.Url.AbsoluteUri);
        }

        #endregion

        #region Methods

        private void SetInitials()
        {
            if (HesapPlaniKey == 0)
            {
                LabelBaslik.Text = "HESAP KAYDET";

                ButtonKaydet.Visible = true;
                ButtonTemizle.Visible = true;
                ButtonGuncelle.Visible = false;
                ButtonIptal.Visible = false;
            }
            else
            {
                LabelBaslik.Text = "HESAP GÜNCELLE";

                ButtonKaydet.Visible = false;
                ButtonTemizle.Visible = false;
                ButtonGuncelle.Visible = true;
                ButtonIptal.Visible = true;
            }

            if (!IsPostBack)
            {
                DataLoad();
            }
        }

        private void DataLoad()
        {
            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                if (!IsPostBack)
                {
                    List<TT_MUHASEBE_TIP> listMUHASEBE_TIP = entity.TT_MUHASEBE_TIP.ToList();
                    ComboBoxMuhasebeTip.DataSource = listMUHASEBE_TIP;
                    ComboBoxMuhasebeTip.DataBind();

                    if (HesapPlaniKey != 0)
                    {
                        HESAP_PLANI _HESAP_PLANI = entity.HESAP_PLANI.AsNoTracking().Single(p => p.HesapPlaniKey == HesapPlaniKey);

                        ComboBoxMuhasebeTip.Items.FindByValue(_HESAP_PLANI.MuhasebeTipKey.ToString()).Selected = true;
                        TextBoxHesapNo.Text = _HESAP_PLANI.HesapKodu;
                        TextBoxHesapAdi.Text = _HESAP_PLANI.HesapAdi;
                    }
                }
            }
        }

        private bool AyniKayitVarMi(string pHesapKodu, DBEntities entity)
        {
            int hesapplanlari = entity.HESAP_PLANI.AsNoTracking().Count(p => p.HesapKodu == pHesapKodu);
            if (hesapplanlari > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        #endregion
    }
}
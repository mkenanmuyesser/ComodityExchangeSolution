using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Security;
using System.Web.UI;
using TicaretBorsasi_Project.Class.Helper;
using TicaretBorsasi_Project.Data;

namespace TicaretBorsasi_Project.Program.MerkezBorsa.MuhasebeIslemleri
{
    public partial class MuhasebeFisKayit : Page
    {
        #region Properties

        private int YevmiyeKey
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
                byte pFisTipKey = Convert.ToByte(ComboBoxFisTip.SelectedItem.Value);
                DateTime pFisTarih = DateEditTarih.Date;
                string pFisNo = TextBoxFisNo.Text;
                string pSatirNo = "0001";
                string HesapNo = TextBoxIlgiliKasaHesabi.Text.Replace("_", "").Replace(" ", "").Trim();
                var HesapPlani = entity.HESAP_PLANI.AsNoTracking().FirstOrDefault(p => p.MuhasebeTipKey == pMuhasebeTipKey && p.HesapKodu == HesapNo);
                decimal pAlacak = Convert.ToDecimal(SpinEditMeblag.Text);
                decimal pBorc = 0;
                string pAciklama = MemoAciklama.Text;

                #region validation

                if (string.IsNullOrEmpty(HesapNo) || HesapPlani == null)
                {
                    PageHelper.MessageBox(this, "Yanlış hesap numarası girilmiştir.");
                    return;
                }

                //aynı fis no kullanılmışmı bak!bu kısım yazılacak

                #endregion

                YEVMIYE _YEVMIYE;
                if (YevmiyeKey == 0)
                {
                    _YEVMIYE = new YEVMIYE();
                }
                else
                {
                    _YEVMIYE = entity.YEVMIYEs.SingleOrDefault(p => p.YevmiyeKey == YevmiyeKey);
                    if (_YEVMIYE == null)
                    {
                        Response.Redirect("MuhasebeFisKayit.aspx");
                        return;
                    }
                }

                _YEVMIYE.MuhasebeTipKey = pMuhasebeTipKey;
                _YEVMIYE.FisTipKey = pFisTipKey;
                _YEVMIYE.FisTarih = pFisTarih;
                _YEVMIYE.FisNo = pFisNo;
                _YEVMIYE.SatirNo = pSatirNo;
                _YEVMIYE.HesapPlaniKey = HesapPlani.HesapPlaniKey; ;
                _YEVMIYE.Alacak = pAlacak;
                _YEVMIYE.Borc = pBorc;
                _YEVMIYE.Aciklama = pAciklama;

                MembershipUser user = Membership.GetUser(true);
                Guid userkey = user == null ? Guid.Empty : (Guid)user.ProviderUserKey;
                if (YevmiyeKey == 0)
                {
                    _YEVMIYE.KayitKisiKey = userkey;
                    _YEVMIYE.KayitTarih = DateTime.Now;
                    entity.YEVMIYEs.Add(_YEVMIYE);
                }
                else
                {
                    _YEVMIYE.GuncelleKisiKey = userkey;
                    _YEVMIYE.GuncelleTarih = DateTime.Now;
                }

                entity.SaveChanges();

                Response.Redirect(string.Format("MuhasebeFisKayit.aspx?Key={0}", _YEVMIYE.YevmiyeKey));
            }
        }

        protected void ButtonIptal_Click(object sender, EventArgs e)
        {
            Response.Redirect("MuhasebeFisKayit.aspx");
        }

        protected void ButtonTemizle_Click(object sender, EventArgs e)
        {
            Response.Redirect(Request.Url.AbsoluteUri);
        }

        #endregion

        #region Methods

        private void SetInitials()
        {
            if (YevmiyeKey == 0)
            {
                LabelBaslik.Text = "FİŞ KAYDET";

                ButtonKaydet.Visible = true;
                ButtonTemizle.Visible = true;
                ButtonGuncelle.Visible = false;
                ButtonIptal.Visible = false;
            }
            else
            {
                LabelBaslik.Text = "FİŞ GÜNCELLE";

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
                    List<TT_MUHASEBE_TIP> listMUHASEBE_TIP = entity.TT_MUHASEBE_TIP.AsNoTracking().ToList();
                    List<TT_FIS_TIP> listFIS_TIP = entity.TT_FIS_TIP.AsNoTracking().Take(3).ToList();

                    ComboBoxMuhasebeTip.DataSource = listMUHASEBE_TIP;
                    ComboBoxMuhasebeTip.DataBind();

                    ComboBoxFisTip.DataSource = listFIS_TIP;
                    ComboBoxFisTip.DataBind();


                    if (YevmiyeKey != 0)
                    {
                        YEVMIYE _YEVMIYE = entity.YEVMIYEs.Include("HESAP_PLANI").SingleOrDefault(p => p.YevmiyeKey == YevmiyeKey);

                        ComboBoxMuhasebeTip.Items.FindByValue(_YEVMIYE.MuhasebeTipKey.ToString()).Selected = true;
                        ComboBoxFisTip.Items.FindByValue(_YEVMIYE.FisTipKey.ToString()).Selected = true;
                        DateEditTarih.Date = _YEVMIYE.FisTarih;
                        TextBoxFisNo.Text = _YEVMIYE.FisNo;
                        TextBoxIlgiliKasaHesabi.Text = _YEVMIYE.HESAP_PLANI.HesapKodu;
                        SpinEditMeblag.Text = _YEVMIYE.Alacak.ToString();
                        MemoAciklama.Text = _YEVMIYE.Aciklama;
                    }
                }
            }
        }

        //private bool AyniKayitVarMi(string pHesapKodu, DBEntities entity)
        //{
        //    int hesapplanlari = entity.YEVMIYEs.AsNoTracking().Count(p => p.HesapKodu == pHesapKodu);
        //    if (hesapplanlari > 0)
        //    {
        //        return true;
        //    }
        //    else
        //    {
        //        return false;
        //    }
        //}

        #endregion
    }
}
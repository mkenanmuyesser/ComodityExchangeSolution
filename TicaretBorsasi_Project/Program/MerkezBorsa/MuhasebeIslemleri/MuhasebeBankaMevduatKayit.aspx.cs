using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Security;
using System.Web.UI;
using TicaretBorsasi_Project.Class.Helper;
using TicaretBorsasi_Project.Data;

namespace TicaretBorsasi_Project.Program.MerkezBorsa.MuhasebeIslemleri
{
    public partial class MuhasebeBankaMevduatKayit : Page
    {
        #region Properties

        private int BankaMevduatKey
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
                string pBankaHesapNo = TextBoxBankaHesapNo.Text;
                string pBankaAdi = TextBoxBankaAdi.Text;
                decimal pVadeliYatanMeblag = Convert.ToDecimal(SpinEditVadeliYatanMeblag.Text);
                DateTime pVadeBasi = DateEditVadeBasi.Date;
                DateTime pVadeSonu = DateEditVadeSonu.Date;
                double pFaizYuzdesi = Convert.ToDouble(SpinEditFaizYuzdesi.Text);
                double pStopajYuzdesi = Convert.ToDouble(SpinEditStopajYuzdesi.Text);

                #region validation


                #endregion

                BANKA_MEVDUAT _BANKA_MEVDUAT;
                if (BankaMevduatKey == 0)
                {
                    _BANKA_MEVDUAT = new BANKA_MEVDUAT();
                }
                else
                {
                    _BANKA_MEVDUAT = entity.BANKA_MEVDUAT.SingleOrDefault(p => p.BankaMevduatKey == BankaMevduatKey);
                    if (_BANKA_MEVDUAT == null)
                    {
                        Response.Redirect("MuhasebeBankaMevduatKayit.aspx");
                        return;
                    }
                }

                _BANKA_MEVDUAT.BankaHesapNo = pBankaHesapNo;
                _BANKA_MEVDUAT.BankaAdi = pBankaAdi;
                _BANKA_MEVDUAT.VadeliYatanMeblag = pVadeliYatanMeblag;
                _BANKA_MEVDUAT.VadeBasi = pVadeBasi;
                _BANKA_MEVDUAT.VadeSonu = pVadeSonu;
                _BANKA_MEVDUAT.FaizYuzdesi = pFaizYuzdesi;
                _BANKA_MEVDUAT.StopajYuzdesi = pStopajYuzdesi;

                MembershipUser user = Membership.GetUser(true);
                Guid userkey = user == null ? Guid.Empty : (Guid)user.ProviderUserKey;
                if (BankaMevduatKey == 0)
                {
                    _BANKA_MEVDUAT.KayitKisiKey = userkey;
                    _BANKA_MEVDUAT.KayitTarih = DateTime.Now;
                    entity.BANKA_MEVDUAT.Add(_BANKA_MEVDUAT);
                }
                else
                {
                    _BANKA_MEVDUAT.GuncelleKisiKey = userkey;
                    _BANKA_MEVDUAT.GuncelleTarih = DateTime.Now;
                }

                entity.SaveChanges();

                Response.Redirect(string.Format("MuhasebeBankaMevduatKayit.aspx?Key={0}", _BANKA_MEVDUAT.BankaMevduatKey));
            }
        }

        protected void ButtonIptal_Click(object sender, EventArgs e)
        {
            Response.Redirect("MuhasebeBankaMevduatKayit.aspx");
        }

        protected void ButtonTemizle_Click(object sender, EventArgs e)
        {
            Response.Redirect(Request.Url.AbsoluteUri);
        }

        #endregion

        #region Methods

        private void SetInitials()
        {
            if (BankaMevduatKey == 0)
            {
                LabelBaslik.Text = "BANKA MEVDUAT KAYDET";

                ButtonKaydet.Visible = true;
                ButtonTemizle.Visible = true;
                ButtonGuncelle.Visible = false;
                ButtonIptal.Visible = false;
            }
            else
            {
                LabelBaslik.Text = "BANKA MEVDUAT GÜNCELLE";

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
                    if (BankaMevduatKey != 0)
                    {
                        BANKA_MEVDUAT _BANKA_MEVDUAT = entity.BANKA_MEVDUAT.SingleOrDefault(p => p.BankaMevduatKey == BankaMevduatKey);

                        TextBoxBankaHesapNo.Text = _BANKA_MEVDUAT.BankaHesapNo;
                        TextBoxBankaAdi.Text = _BANKA_MEVDUAT.BankaAdi;
                        SpinEditVadeliYatanMeblag.Text = _BANKA_MEVDUAT.VadeliYatanMeblag.ToString();
                        DateEditVadeBasi.Date = _BANKA_MEVDUAT.VadeBasi;
                        DateEditVadeSonu.Date = _BANKA_MEVDUAT.VadeSonu;
                        SpinEditFaizYuzdesi.Text = _BANKA_MEVDUAT.FaizYuzdesi.ToString();
                        SpinEditStopajYuzdesi.Text = _BANKA_MEVDUAT.StopajYuzdesi.ToString();
                    }
                }
            }
        }

        private void Hesapla()
        {
            decimal pVadeliYatanMeblag = Convert.ToDecimal(SpinEditVadeliYatanMeblag.Text);
            DateTime pVadeBasi = DateEditVadeBasi.Date;
            DateTime pVadeSonu = DateEditVadeSonu.Date;
            double pFaizYuzdesi = Convert.ToDouble(SpinEditFaizYuzdesi.Text);
            double pStopajYuzdesi = Convert.ToDouble(SpinEditStopajYuzdesi.Text);

            LabelAidatGunu.Text = "";
            LabelFaiz.Text = "";
            LabelStopaj.Text = "";
            LabelVadeSonuNetFaiz.Text = "";
            LabelAnaParaFaizToplami.Text = "";
        }

        #endregion
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Security;
using System.Web.UI;
using TicaretBorsasi_Project.Class.Helper;
using TicaretBorsasi_Project.Data;

namespace TicaretBorsasi_Project.Program.MerkezBorsa.TuccarIslemleri
{
    public partial class TuccarUyeAidatCezaOranlari : Page
    {
        #region Properties

        #endregion

        #region Events

        protected void Page_Load(object sender, EventArgs e)
        {
            SetInitials();
        }

        protected void ComboBoxYil_SelectedIndexChanged(object sender, EventArgs e)
        {
            DataLoad();
        }

        protected void ButtonKaydetGuncelle_Click(object sender, EventArgs e)
        {
            using (var entity = new DBEntities())
            {
                short pYil = Convert.ToInt16(ComboBoxYil.SelectedItem.Value);

                #region validation

                #endregion

                TT_DERECE_CEZA_ORAN data = entity.TT_DERECE_CEZA_ORAN.SingleOrDefault(p => p.Yil == pYil);

                TT_DERECE_CEZA_ORAN _TT_DERECE_CEZA_ORAN;
                bool yenikayit = false;
                if (data == null)
                {
                    _TT_DERECE_CEZA_ORAN = new TT_DERECE_CEZA_ORAN();
                    _TT_DERECE_CEZA_ORAN.Yil = pYil;
                    yenikayit = true;
                }
                else
                {
                    _TT_DERECE_CEZA_ORAN = data;
                    yenikayit = false;
                }

                _TT_DERECE_CEZA_ORAN.Ay1 = Convert.ToDecimal(SpinEditOcak.Text);
                _TT_DERECE_CEZA_ORAN.Ay2 = Convert.ToDecimal(SpinEditSubat.Text);
                _TT_DERECE_CEZA_ORAN.Ay3 = Convert.ToDecimal(SpinEditMart.Text);
                _TT_DERECE_CEZA_ORAN.Ay4 = Convert.ToDecimal(SpinEditNisan.Text);
                _TT_DERECE_CEZA_ORAN.Ay5 = Convert.ToDecimal(SpinEditMayis.Text);
                _TT_DERECE_CEZA_ORAN.Ay6 = Convert.ToDecimal(SpinEditHaziran.Text);
                _TT_DERECE_CEZA_ORAN.Ay7 = Convert.ToDecimal(SpinEditTemmuz.Text);
                _TT_DERECE_CEZA_ORAN.Ay8 = Convert.ToDecimal(SpinEditAgustos.Text);
                _TT_DERECE_CEZA_ORAN.Ay9 = Convert.ToDecimal(SpinEditEylul.Text);
                _TT_DERECE_CEZA_ORAN.Ay10 = Convert.ToDecimal(SpinEditEkim.Text);
                _TT_DERECE_CEZA_ORAN.Ay11 = Convert.ToDecimal(SpinEditKasim.Text);
                _TT_DERECE_CEZA_ORAN.Ay12 = Convert.ToDecimal(SpinEditAralik.Text);
                _TT_DERECE_CEZA_ORAN.Taksit1 = Convert.ToByte(ComboBoxTaksit1Ay.SelectedItem.Value);
                _TT_DERECE_CEZA_ORAN.Taksit2 = Convert.ToByte(ComboBoxTaksit2Ay.SelectedItem.Value);

                MembershipUser user = Membership.GetUser(true);
                Guid userkey = user == null ? Guid.Empty : (Guid) user.ProviderUserKey;
                if (yenikayit)
                {
                    _TT_DERECE_CEZA_ORAN.KayitKisiKey = userkey;
                    _TT_DERECE_CEZA_ORAN.KayitTarih = DateTime.Now;
                    entity.TT_DERECE_CEZA_ORAN.Add(_TT_DERECE_CEZA_ORAN);
                }
                else
                {
                    _TT_DERECE_CEZA_ORAN.GuncelleKisiKey = userkey;
                    _TT_DERECE_CEZA_ORAN.GuncelleTarih = DateTime.Now;
                }

                entity.SaveChanges();
            }

            DataLoad();
        }

        protected void ButtonIptal_Click(object sender, EventArgs e)
        {
            Response.Redirect(Request.Url.AbsoluteUri);
        }

        protected void ButtonTemizle_Click(object sender, EventArgs e)
        {
            Temizle();
        }

        #endregion

        #region Methods

        private void SetInitials()
        {
            LabelBaslik.Text = "ÜYE AİDAT CEZA ORANLARI";
            if (!IsPostBack)
            {
                DataLoad();
            }
        }

        private void DataLoad()
        {
            if (!IsPostBack)
            {
                var yillar = new List<int>();
                for (int i = DateTime.Now.Year; i >= 1900; i--)
                {
                    yillar.Add(i);
                }

                ComboBoxYil.DataSource = yillar;
                ComboBoxYil.DataBind();
                ComboBoxYil.SelectedIndex = 0;
            }
            short yil = Convert.ToInt16(ComboBoxYil.SelectedItem.Value);

            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                TT_DERECE_CEZA_ORAN data = entity.TT_DERECE_CEZA_ORAN.AsNoTracking().SingleOrDefault(p => p.Yil == yil);
                if (data == null)
                {
                    PageHelper.MessageBox(this, "Seçilen yıla ait ceza oranı tanımlanmamıştır.");

                    ButtonKaydet.Visible = true;
                    ButtonTemizle.Visible = true;
                    ButtonGuncelle.Visible = false;
                    ButtonIptal.Visible = false;
                    divIslemler.Style.Value = "margin-left: 40%;";

                    Temizle();
                }
                else
                {
                    ButtonKaydet.Visible = false;
                    ButtonTemizle.Visible = false;
                    ButtonGuncelle.Visible = true;
                    ButtonIptal.Visible = true;
                    divIslemler.Style.Value = "margin-left: 35%;";

                    SpinEditOcak.Text = data.Ay1.ToString();
                    SpinEditSubat.Text = data.Ay2.ToString();
                    SpinEditMart.Text = data.Ay3.ToString();
                    SpinEditNisan.Text = data.Ay4.ToString();
                    SpinEditMayis.Text = data.Ay5.ToString();
                    SpinEditHaziran.Text = data.Ay6.ToString();
                    SpinEditTemmuz.Text = data.Ay7.ToString();
                    SpinEditAgustos.Text = data.Ay8.ToString();
                    SpinEditEylul.Text = data.Ay9.ToString();
                    SpinEditEkim.Text = data.Ay10.ToString();
                    SpinEditKasim.Text = data.Ay11.ToString();
                    SpinEditAralik.Text = data.Ay12.ToString();

                    ComboBoxTaksit1Ay.Items.FindByValue(data.Taksit1.ToString()).Selected = true;
                    ComboBoxTaksit2Ay.Items.FindByValue(data.Taksit2.ToString()).Selected = true;
                }
            }
        }

        private void Temizle()
        {
            SpinEditOcak.Text = string.Empty;
            SpinEditSubat.Text = string.Empty;
            SpinEditMart.Text = string.Empty;
            SpinEditNisan.Text = string.Empty;
            SpinEditMayis.Text = string.Empty;
            SpinEditHaziran.Text = string.Empty;
            SpinEditTemmuz.Text = string.Empty;
            SpinEditAgustos.Text = string.Empty;
            SpinEditEylul.Text = string.Empty;
            SpinEditEkim.Text = string.Empty;
            SpinEditKasim.Text = string.Empty;
            SpinEditAralik.Text = string.Empty;

            ComboBoxTaksit1Ay.SelectedIndex = -1;
            ComboBoxTaksit2Ay.SelectedIndex = -1;
        }

        #endregion
    }
}
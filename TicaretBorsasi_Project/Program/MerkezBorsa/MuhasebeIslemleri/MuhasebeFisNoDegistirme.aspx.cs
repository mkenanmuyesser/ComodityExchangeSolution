using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Security;
using System.Web.UI;
using TicaretBorsasi_Project.Class.Helper;
using TicaretBorsasi_Project.Data;

namespace TicaretBorsasi_Project.Program.MerkezBorsa.MuhasebeIslemleri
{
    public partial class MuhasebeFisNoDegistirme : Page
    {
        #region Properties

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

                #region validation


                #endregion

                bool ilkkayit = true;
                Int16 pYil = Convert.ToInt16(ComboBoxYil.SelectedItem.Value);
                int pMuhasebeTipKey = Convert.ToInt32(ComboBoxMuhasebeTip.SelectedItem.Value);
                byte pFisTipKey = Convert.ToByte(ComboBoxFisTip.SelectedItem.Value);

                FIS_NO _FIS_NO = entity.FIS_NO.SingleOrDefault(p => p.Yil == pYil && p.MuhasebeTipKey == pMuhasebeTipKey && p.FisTipKey == pFisTipKey);
                if (_FIS_NO == null)
                {
                    _FIS_NO = new FIS_NO();
                }
                else
                {
                    ilkkayit = false;
                }

                _FIS_NO.Yil = pYil;
                _FIS_NO.MuhasebeTipKey = pMuhasebeTipKey;
                _FIS_NO.FisTipKey = pFisTipKey;
                _FIS_NO.OcakNo = Convert.ToInt32(SpinEditOcak.Text);
                _FIS_NO.SubatNo = Convert.ToInt32(SpinEditSubat.Text);
                _FIS_NO.MartNo = Convert.ToInt32(SpinEditMart.Text);
                _FIS_NO.NisanNo = Convert.ToInt32(SpinEditNisan.Text);
                _FIS_NO.MayisNo = Convert.ToInt32(SpinEditMayis.Text);
                _FIS_NO.HaziranNo = Convert.ToInt32(SpinEditHaziran.Text);
                _FIS_NO.TemmuzNo = Convert.ToInt32(SpinEditTemmuz.Text);
                _FIS_NO.AgustosNo = Convert.ToInt32(SpinEditAgustos.Text);
                _FIS_NO.EylulNo = Convert.ToInt32(SpinEditEylul.Text);
                _FIS_NO.EkimNo = Convert.ToInt32(SpinEditEkim.Text);
                _FIS_NO.KasimNo = Convert.ToInt32(SpinEditKasim.Text);
                _FIS_NO.AralikNo = Convert.ToInt32(SpinEditAralik.Text);

                MembershipUser user = Membership.GetUser(true);
                Guid userkey = user == null ? Guid.Empty : (Guid)user.ProviderUserKey;
                if (ilkkayit)
                {
                    _FIS_NO.KayitKisiKey = userkey;
                    _FIS_NO.KayitTarih = DateTime.Now;
                    entity.FIS_NO.Add(_FIS_NO);
                }
                else
                {
                    _FIS_NO.GuncelleKisiKey = userkey;
                    _FIS_NO.GuncelleTarih = DateTime.Now;
                }

                entity.SaveChanges();
            }
        }

        protected void ButtonIptal_Click(object sender, EventArgs e)
        {
            Response.Redirect(Request.Url.AbsoluteUri);
        }

        protected void ComboBoxMuhasebeTip_SelectedIndexChanged(object sender, EventArgs e)
        {
            DataLoad();
        }

        protected void ComboBoxFisTip_SelectedIndexChanged(object sender, EventArgs e)
        {
            DataLoad();
        }

        #endregion

        #region Methods

        private void SetInitials()
        {
            LabelBaslik.Text = "FİŞ NO DEĞİŞTİRME";

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

                List<TT_MUHASEBE_TIP> listMUHASEBE_TIP = entity.TT_MUHASEBE_TIP.AsNoTracking().ToList();
                List<TT_FIS_TIP> listFIS_TIP = entity.TT_FIS_TIP.AsNoTracking().Take(3).ToList();
                var yillar = new List<int>();
                for (int i = DateTime.Now.Year; i >= 1900; i--)
                {
                    yillar.Add(i);
                }

                ComboBoxMuhasebeTip.DataSource = listMUHASEBE_TIP;
                ComboBoxMuhasebeTip.DataBind();

                ComboBoxFisTip.DataSource = listFIS_TIP;
                ComboBoxFisTip.DataBind();

                ComboBoxYil.DataSource = yillar;
                ComboBoxYil.DataBind();
                ComboBoxYil.SelectedIndex = 0;

                Int16 pYil = Convert.ToInt16(ComboBoxYil.SelectedItem.Value);
                int? pMuhasebeTipKey = ComboBoxMuhasebeTip.SelectedIndex == -1 ? null : (int?)Convert.ToInt32(ComboBoxMuhasebeTip.SelectedItem.Value);
                byte? pFisTipKey = ComboBoxFisTip.SelectedIndex == -1 ? null : (byte?)Convert.ToByte(ComboBoxFisTip.SelectedItem.Value);

                FIS_NO _FIS_NO = entity.FIS_NO.SingleOrDefault(p => p.Yil == pYil && p.MuhasebeTipKey == pMuhasebeTipKey && p.FisTipKey == pFisTipKey);
                if (_FIS_NO == null)
                {
                    SpinEditOcak.Text = "0";
                    SpinEditSubat.Text = "0";
                    SpinEditMart.Text = "0";
                    SpinEditNisan.Text = "0";
                    SpinEditMayis.Text = "0";
                    SpinEditHaziran.Text = "0";
                    SpinEditTemmuz.Text = "0";
                    SpinEditAgustos.Text = "0";
                    SpinEditEylul.Text = "0";
                    SpinEditEkim.Text = "0";
                    SpinEditKasim.Text = "0";
                    SpinEditAralik.Text = "0";
                }
                else
                {
                    SpinEditOcak.Text = _FIS_NO.OcakNo.ToString();
                    SpinEditSubat.Text = _FIS_NO.SubatNo.ToString();
                    SpinEditMart.Text = _FIS_NO.MartNo.ToString();
                    SpinEditNisan.Text = _FIS_NO.NisanNo.ToString();
                    SpinEditMayis.Text = _FIS_NO.MayisNo.ToString();
                    SpinEditHaziran.Text = _FIS_NO.HaziranNo.ToString();
                    SpinEditTemmuz.Text = _FIS_NO.TemmuzNo.ToString();
                    SpinEditAgustos.Text = _FIS_NO.AgustosNo.ToString();
                    SpinEditEylul.Text = _FIS_NO.EylulNo.ToString();
                    SpinEditEkim.Text = _FIS_NO.EkimNo.ToString();
                    SpinEditKasim.Text = _FIS_NO.KasimNo.ToString();
                    SpinEditAralik.Text = _FIS_NO.AralikNo.ToString();                   
                }

            }
        }
        #endregion

    }
}
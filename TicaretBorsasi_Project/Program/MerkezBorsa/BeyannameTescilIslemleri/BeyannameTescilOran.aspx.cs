using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Security;
using System.Web.UI;
using TicaretBorsasi_Project.Data;

namespace TicaretBorsasi_Project.Program.MerkezBorsa.BeyannameTescilIslemleri
{
    public partial class BeyannameTescilOran : Page
    {
        #region Properties

        #endregion

        #region Events

        protected void Page_Load(object sender, EventArgs e)
        {
            SetInitials();
        }

        protected void ButtonGuncelle_Click(object sender, EventArgs e)
        {
            using (var entity = new DBEntities())
            {
                bool ilkkayit = false;
                TESCIL_ORAN _TESCIL_ORAN = entity.TESCIL_ORAN.FirstOrDefault();
                if (_TESCIL_ORAN == null)
                {
                    ilkkayit = true;
                    _TESCIL_ORAN = new TESCIL_ORAN();
                }

                _TESCIL_ORAN.TescilOrani = Convert.ToDecimal(SpinEditTescilOran.Text);
                _TESCIL_ORAN.SimsarOrani = Convert.ToDecimal(SpinEditSimsarOran.Text);
                _TESCIL_ORAN.Stopaj = Convert.ToDecimal(SpinEditStopaj.Text);
                _TESCIL_ORAN.FonPayi = Convert.ToDecimal(SpinEditFonPayi.Text);
                _TESCIL_ORAN.MeraFonu = Convert.ToDecimal(SpinEditMeraFonu.Text);
                _TESCIL_ORAN.Tavan = Convert.ToDecimal(SpinEditTavan.Text);
                _TESCIL_ORAN.TahsilatTipKey = Convert.ToByte(ComboBoxTahsilatTipi.SelectedItem.Value);
                _TESCIL_ORAN.MuhasebeTipKey = Convert.ToInt32(ComboBoxMuhasebeTipi.SelectedItem.Value);
                _TESCIL_ORAN.Satis = Convert.ToDecimal(SpinEditSatis.Text);

                MembershipUser user = Membership.GetUser(true);
                Guid userkey = user == null ? Guid.Empty : (Guid) user.ProviderUserKey;
                if (ilkkayit)
                {
                    _TESCIL_ORAN.KayitKisiKey = userkey;
                    _TESCIL_ORAN.KayitTarih = DateTime.Now;
                    entity.TESCIL_ORAN.Add(_TESCIL_ORAN);
                }
                else
                {
                    _TESCIL_ORAN.GuncelleKisiKey = userkey;
                    _TESCIL_ORAN.GuncelleTarih = DateTime.Now;
                }

                entity.SaveChanges();
            }
        }

        protected void ButtonIptal_Click(object sender, EventArgs e)
        {
            DataLoad();
        }

        #endregion

        #region Methods

        private void SetInitials()
        {
            LabelBaslik.Text = "TESCİL ORANLARI";

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
                    List<TT_TAHSILAT_TIP> listTAHSILAT_TIP = entity.TT_TAHSILAT_TIP.AsNoTracking().ToList();
                    List<TT_MUHASEBE_TIP> listMUHASEBE_TIP = entity.TT_MUHASEBE_TIP.AsNoTracking().ToList();

                    ComboBoxTahsilatTipi.DataSource = listTAHSILAT_TIP;
                    ComboBoxTahsilatTipi.DataBind();

                    ComboBoxMuhasebeTipi.DataSource = listMUHASEBE_TIP;
                    ComboBoxMuhasebeTipi.DataBind();
                }


                TESCIL_ORAN _TESCIL_ORAN = entity.TESCIL_ORAN.AsNoTracking().FirstOrDefault();
                if (_TESCIL_ORAN == null)
                {
                    SpinEditTescilOran.Text = string.Empty;
                    SpinEditSimsarOran.Text = string.Empty;
                    SpinEditStopaj.Text = string.Empty;
                    SpinEditFonPayi.Text = string.Empty;
                    SpinEditMeraFonu.Text = string.Empty;
                    SpinEditTavan.Text = string.Empty;
                    ComboBoxTahsilatTipi.SelectedIndex = -1;
                    ComboBoxMuhasebeTipi.SelectedIndex = -1;
                    SpinEditSatis.Text = string.Empty;
                }
                else
                {
                    SpinEditTescilOran.Text = _TESCIL_ORAN.TescilOrani.ToString();
                    SpinEditSimsarOran.Text = _TESCIL_ORAN.SimsarOrani.ToString();
                    SpinEditStopaj.Text = _TESCIL_ORAN.Stopaj.ToString();
                    SpinEditFonPayi.Text = _TESCIL_ORAN.FonPayi.ToString();
                    SpinEditMeraFonu.Text = _TESCIL_ORAN.MeraFonu.ToString();
                    SpinEditTavan.Text = _TESCIL_ORAN.Tavan.ToString();
                    ComboBoxTahsilatTipi.Items.FindByValue(_TESCIL_ORAN.TahsilatTipKey.ToString()).Selected = true;
                    ComboBoxMuhasebeTipi.Items.FindByValue(_TESCIL_ORAN.MuhasebeTipKey.ToString()).Selected = true;
                    SpinEditSatis.Text = _TESCIL_ORAN.Satis.ToString();
                }
            }
        }

        #endregion
    }
}
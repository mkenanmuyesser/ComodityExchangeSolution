using System;
using System.Collections.Generic;
using System.Web.UI;
using TicaretBorsasi_Project.Data;
using System.Linq;
using System.Web.Security;

namespace TicaretBorsasi_Project.Program.MerkezBorsa.MuhasebeIslemleri
{
    public partial class MuhasebeTasdikFasilAktarma : Page
    {
        #region Properties

        #endregion

        #region Events

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                SetInitials();
            }
        }

        protected void ComboBoxTasdikFasilAktarmaTip_SelectedIndexChanged(object sender, EventArgs e)
        {
            DataLoad();
        }

        protected void ButtonKaydetGuncelle_Click(object sender, EventArgs e)
        {
            using (var entity = new DBEntities())
            {
                #region validation

                #endregion

                byte pTip = Convert.ToByte(ComboBoxTasdikFasilAktarmaTip.SelectedItem.Value);

                var _TASDIK_FASIL_AKTARMA_ACIKLAMA = entity.TASDIK_FASIL_AKTARMA_ACIKLAMA.Single(p => p.TasdikFasilAktarmaTipKey == pTip);

                _TASDIK_FASIL_AKTARMA_ACIKLAMA.Aciklama = MemoTasdikFasil.Text;


                MembershipUser user = Membership.GetUser(true);
                Guid userkey = user == null ? Guid.Empty : (Guid)user.ProviderUserKey;
                _TASDIK_FASIL_AKTARMA_ACIKLAMA.GuncelleKisiKey = userkey;
                _TASDIK_FASIL_AKTARMA_ACIKLAMA.GuncelleTarih = DateTime.Now;

                entity.SaveChanges();
            }
        }

        protected void ButtonIptal_Click(object sender, EventArgs e)
        {
            Response.Redirect("MuhasebeTasdikFasilAktarma.aspx");
        }

        protected void ButtonTemizle_Click(object sender, EventArgs e)
        {
            Response.Redirect(Request.Url.AbsoluteUri);
        }

        #endregion

        #region Methods

        private void SetInitials()
        {
            LabelBaslik.Text = "TASDİK VE FASIL AKTARMA AÇIKLAMALARI";

            using (var entity = new DBEntities())
            {
                List<TT_TASDIK_FASIL_AKTARMA_TIP> listBEYAN_TIP = entity.TT_TASDIK_FASIL_AKTARMA_TIP.AsNoTracking().ToList();
                ComboBoxTasdikFasilAktarmaTip.DataSource = listBEYAN_TIP;
                ComboBoxTasdikFasilAktarmaTip.DataBind();

                ComboBoxTasdikFasilAktarmaTip.SelectedIndex = 0;
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
                byte pTip = Convert.ToByte(ComboBoxTasdikFasilAktarmaTip.SelectedItem.Value);
                MemoTasdikFasil.Text = entity.TASDIK_FASIL_AKTARMA_ACIKLAMA.AsNoTracking().Single(p => p.TasdikFasilAktarmaTipKey == pTip).Aciklama;
            }
        }

        #endregion
    }
}
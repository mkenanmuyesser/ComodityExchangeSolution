using System;
using System.Linq;
using System.Web.Security;
using System.Web.UI;
using DevExpress.Web.ASPxClasses;
using DevExpress.Web.ASPxGridView;
using DevExpress.Web.Data;
using TicaretBorsasi_Project.Class.Helper;
using TicaretBorsasi_Project.Data;

namespace TicaretBorsasi_Project.Program.SalonSatis.MuhtelifIslemler
{
    public partial class OtomatikSatisAyarlari : Page
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

            DataLoad();
        }

        protected void ButtonKaydetGuncelle_Click(object sender, EventArgs e)
        {
            //using (var entity = new DBEntities())
            //{
            //    string pSatisOrganizasyonH = TextBoxSatisOrganizasyonH.Text.Replace("_", "").Trim();
            //    string pTescil = TextBoxTescil.Text.Replace("_", "").Trim();
            //    string pMeraFonu = TextBoxMeraFonu.Text.Replace("_", "").Trim();

            //    #region validation

            //    if ((!string.IsNullOrEmpty(pSatisOrganizasyonH) && pSatisOrganizasyonH.Length != 5) ||
            //        (!string.IsNullOrEmpty(pTescil) && pTescil.Length != 5) ||
            //        (!string.IsNullOrEmpty(pMeraFonu) && pMeraFonu.Length != 5))
            //    {
            //        PageHelper.MessageBox(this.Page, "Lütfen girilen değerleri kontrol ediniz.");
            //        return;
            //    }

            //    #endregion

            //    TT_BORSA_SUBE data;
            //    if (Key == 0)
            //    {
            //        data = new TT_BORSA_SUBE();
            //    }
            //    else
            //    {
            //        data = entity.TT_BORSA_SUBE.SingleOrDefault(p => p.BorsaSubeKey == Key);
            //        if (data == null)
            //        {
            //            Response.Redirect("OtomatikSatisAyarlari.aspx");
            //        }
            //    }

            //    data.Kod = TextBoxKod.Text;
            //    data.BorsaSubeAdi = TextBoxSubeAdi.Text;
            //    data.BorsaSubeSimsariyeKodu = pSatisOrganizasyonH;
            //    data.BorsaSubeTesciliyeKodu = pTescil;
            //    data.BorsaSubeMeraFonuKodu = pMeraFonu;

            //    MembershipUser user = Membership.GetUser(true);
            //    Guid userkey = user == null ? Guid.Empty : (Guid)user.ProviderUserKey;
            //    if (Key == 0)
            //    {
            //        data.KayitKisiKey = userkey;
            //        data.KayitTarih = DateTime.Now;
            //        entity.TT_BORSA_SUBE.Add(data);
            //    }
            //    else
            //    {
            //        data.GuncelleKisiKey = userkey;
            //        data.GuncelleTarih = DateTime.Now;
            //    }

            //    entity.SaveChanges();
            //}

            Response.Redirect("OtomatikSatisAyarlari.aspx");
        }

        protected void ButtonIptalTemizle_Click(object sender, EventArgs e)
        {
            Response.Redirect("OtomatikSatisAyarlari.aspx");
        }

        #endregion

        #region Methods

        private void SetInitials()
        {
            LabelBaslik.Text = "OTOMATİK SATIŞ AYARLARI";
        }

        private void DataLoad()
        {
            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                if ( !IsPostBack)
                {
                    //TT_BORSA_SUBE data = entity.TT_BORSA_SUBE.AsNoTracking().Single();

                    //TextBoxKod.Text = data.Kod;
                    //TextBoxSubeAdi.Text = data.BorsaSubeAdi;
                    //TextBoxSatisOrganizasyonH.Text = data.BorsaSubeSimsariyeKodu;
                    //TextBoxTescil.Text = data.BorsaSubeTesciliyeKodu;
                    //TextBoxMeraFonu.Text = data.BorsaSubeMeraFonuKodu;
                }
            }
        }

        #endregion
    }
}
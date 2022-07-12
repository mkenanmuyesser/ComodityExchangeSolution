using System;
using System.Linq;
using System.Web.Security;
using System.Web.UI;
using DevExpress.Web.ASPxClasses;
using DevExpress.Web.ASPxGridView;
using DevExpress.Web.Data;
using TicaretBorsasi_Project.Data;

namespace TicaretBorsasi_Project.Program.MerkezBorsa.MuhasebeIslemleri
{
    public partial class MuhasebeAdIslemleri : Page
    {
        #region Properties

        private int Key
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
            if (!IsPostBack)
            {
                SetInitials();
            }

            DataLoad();
        }

        protected void ButtonRapor_Click(object sender, EventArgs e)
        {
            switch (ComboBoxRapor.SelectedIndex)
            {
                case 0:
                    GridViewExporterMuhasebeAd.WriteXlsxToResponse("Muhasebe Bilgileri");
                    break;
                case 1:
                    GridViewExporterMuhasebeAd.WritePdfToResponse("Muhasebe Bilgileri");
                    break;
                default:
                    break;
            }
        }

        protected void ButtonKaydetGuncelle_Click(object sender, EventArgs e)
        {
            using (var entity = new DBEntities())
            {
                #region validation

                #endregion

                TT_MUHASEBE_TIP data;
                if (Key == 0)
                {
                    data = new TT_MUHASEBE_TIP();
                }
                else
                {
                    data = entity.TT_MUHASEBE_TIP.SingleOrDefault(p => p.MuhasebeTipKey == Key);
                    if (data == null)
                    {
                        Response.Redirect("MuhasebeAdIslemleri.aspx");
                    }
                }

                data.Kod = TextBoxMuhasebeKodu.Text;
                data.Adi = TextBoxMuhasebeAdi.Text;

                MembershipUser user = Membership.GetUser(true);
                Guid userkey = user == null ? Guid.Empty : (Guid) user.ProviderUserKey;
                if (Key == 0)
                {
                    data.KayitKisiKey = userkey;
                    data.KayitTarih = DateTime.Now;
                    entity.TT_MUHASEBE_TIP.Add(data);
                }
                else
                {
                    data.GuncelleKisiKey = userkey;
                    data.GuncelleTarih = DateTime.Now;
                }

                entity.SaveChanges();
            }

            Response.Redirect("MuhasebeAdIslemleri.aspx");
        }

        protected void ButtonIptalTemizle_Click(object sender, EventArgs e)
        {
            Response.Redirect("MuhasebeAdIslemleri.aspx");
        }

        protected void GridViewMuhasebeAd_RowDeleting(object sender, ASPxDataDeletingEventArgs e)
        {
            using (var entity = new DBEntities())
            {
                int deletedkey = Convert.ToInt32(e.Keys[0]);
                TT_MUHASEBE_TIP deleteddata = entity.TT_MUHASEBE_TIP.Single(p => p.MuhasebeTipKey == deletedkey);
                entity.TT_MUHASEBE_TIP.Remove(deleteddata);

                try
                {
                    if (Key != 0)
                    {
                        GridViewMuhasebeAd.JSProperties["cpErrorMessage"] = true;
                    }
                    else
                    {
                        entity.SaveChanges();
                        GridViewMuhasebeAd.JSProperties["cpErrorMessage"] = false;
                    }
                }
                catch
                {
                    GridViewMuhasebeAd.JSProperties["cpErrorMessage"] = true;
                }
            }

            DataLoad();
            e.Cancel = true;
        }

        protected void GridViewMuhasebeAd_CustomButtonCallback(object sender,
                                                               ASPxGridViewCustomButtonCallbackEventArgs e)
        {
            int index = e.VisibleIndex;
            int key = Convert.ToInt32(GridViewMuhasebeAd.GetRowValues(index, new[] {"MuhasebeTipKey"}));
            ASPxWebControl.RedirectOnCallback(string.Format("MuhasebeAdIslemleri.aspx?Key={0}", key));
        }

        #endregion

        #region Methods

        private void SetInitials()
        {
            if (Key == 0)
            {
                ButtonKaydet.Visible = true;
                ButtonTemizle.Visible = true;
                ButtonGuncelle.Visible = false;
                ButtonIptal.Visible = false;
            }
            else
            {
                ButtonKaydet.Visible = false;
                ButtonTemizle.Visible = false;
                ButtonGuncelle.Visible = true;
                ButtonIptal.Visible = true;
            }

            LabelBaslik.Text = "MUHASEBE AD İŞLEMLERİ";
        }

        private void DataLoad()
        {
            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;
                
                GridViewMuhasebeAd.DataSource = null;
                GridViewMuhasebeAd.DataSource = entity.TT_MUHASEBE_TIP.AsNoTracking().OrderBy(p => p.Kod).ToList();
                GridViewMuhasebeAd.DataBind();

                if (Key != 0 && !IsPostBack)
                {
                    TT_MUHASEBE_TIP data = entity.TT_MUHASEBE_TIP.AsNoTracking().Single(p => p.MuhasebeTipKey == Key);

                    TextBoxMuhasebeKodu.Text = data.Kod;
                    TextBoxMuhasebeAdi.Text = data.Adi;
                }
            }
        }

        #endregion
    }
}
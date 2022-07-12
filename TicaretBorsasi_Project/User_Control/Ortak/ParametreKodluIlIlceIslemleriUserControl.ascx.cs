using System;
using System.Linq;
using System.Web.Security;
using System.Web.UI;
using DevExpress.Web.ASPxClasses;
using DevExpress.Web.ASPxGridView;
using DevExpress.Web.Data;
using TicaretBorsasi_Project.Data;

namespace TicaretBorsasi_Project.User_Control.Ortak
{
    public partial class ParametreKodluIlIlceIslemleriUserControl : System.Web.UI.UserControl
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
                    GridViewExporterIlIlce.WriteXlsxToResponse("İl İlçe Bilgileri");
                    break;
                case 1:
                    GridViewExporterIlIlce.WritePdfToResponse("İl İlçe Bilgileri");
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

                TT_IL_ILCE data;
                if (Key == 0)
                {
                    data = new TT_IL_ILCE();
                }
                else
                {
                    data = entity.TT_IL_ILCE.SingleOrDefault(p => p.IlIlceKey == Key);
                    if (data == null)
                    {
                        Response.Redirect("IlIlceIslemleri.aspx");
                    }
                }

                data.Kod = TextBoxKod.Text;
                data.TobbKodu = TextBoxTobbKodu.Text;
                data.IlIlceAdi = TextBoxIlIlceAd.Text;

                MembershipUser user = Membership.GetUser(true);
                Guid userkey = user == null ? Guid.Empty : (Guid)user.ProviderUserKey;
                if (Key == 0)
                {
                    data.KayitKisiKey = userkey;
                    data.KayitTarih = DateTime.Now;
                    entity.TT_IL_ILCE.Add(data);
                }
                else
                {
                    data.GuncelleKisiKey = userkey;
                    data.GuncelleTarih = DateTime.Now;
                }

                entity.SaveChanges();
            }

            Response.Redirect("IlIlceIslemleri.aspx");
        }

        protected void ButtonIptalTemizle_Click(object sender, EventArgs e)
        {
            Response.Redirect("IlIlceIslemleri.aspx");
        }

        protected void GridViewIlIlce_RowDeleting(object sender, ASPxDataDeletingEventArgs e)
        {
            using (var entity = new DBEntities())
            {
                int deletedkey = Convert.ToInt32(e.Keys[0]);
                TT_IL_ILCE deleteddata = entity.TT_IL_ILCE.Single(p => p.IlIlceKey == deletedkey);
                entity.TT_IL_ILCE.Remove(deleteddata);

                try
                {
                    if (Key != 0)
                    {
                        GridViewIlIlce.JSProperties["cpErrorMessage"] = true;
                    }
                    else
                    {
                        entity.SaveChanges();
                        GridViewIlIlce.JSProperties["cpErrorMessage"] = false;
                    }
                }
                catch
                {
                    GridViewIlIlce.JSProperties["cpErrorMessage"] = true;
                }
            }

            DataLoad();
            e.Cancel = true;
        }

        protected void GridViewIlIlce_CustomButtonCallback(object sender, ASPxGridViewCustomButtonCallbackEventArgs e)
        {
            int index = e.VisibleIndex;
            int key = Convert.ToInt32(GridViewIlIlce.GetRowValues(index, new[] { "IlIlceKey" }));
            string sayfa = Request.Url.AbsolutePath.Replace(Request.Url.Segments[4], "");
            ASPxWebControl.RedirectOnCallback(string.Format("{0}IlIlceIslemleri.aspx?Key={1}",sayfa, key));
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

            LabelBaslik.Text = "İL İLÇE İŞLEMLERİ";
        }

        private void DataLoad()
        {
            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                GridViewIlIlce.DataSource = null;
                GridViewIlIlce.DataSource = entity.TT_IL_ILCE.AsNoTracking().OrderBy(p => p.Kod).ToList();
                GridViewIlIlce.DataBind();

                if (Key != 0 && !IsPostBack)
                {
                    TT_IL_ILCE data = entity.TT_IL_ILCE.AsNoTracking().Single(p => p.IlIlceKey == Key);

                    TextBoxKod.Text = data.Kod;
                    TextBoxTobbKodu.Text = data.TobbKodu;
                    TextBoxIlIlceAd.Text = data.IlIlceAdi;
                }
            }
        }

        #endregion
    }
}
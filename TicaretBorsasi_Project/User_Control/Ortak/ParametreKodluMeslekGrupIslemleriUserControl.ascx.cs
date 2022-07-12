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
    public partial class ParametreKodluMeslekGrupIslemleriUserControl : System.Web.UI.UserControl
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
                    GridViewExporterMeslekGrup.WriteXlsxToResponse("Meslek Grup Bilgileri");
                    break;
                case 1:
                    GridViewExporterMeslekGrup.WritePdfToResponse("Meslek Grup Bilgileri");
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

                TT_MESLEK_GRUP data;
                if (Key == 0)
                {
                    data = new TT_MESLEK_GRUP();
                }
                else
                {
                    data = entity.TT_MESLEK_GRUP.SingleOrDefault(p => p.MeslekGrupKey == Key);
                    if (data == null)
                    {
                        Response.Redirect("MeslekGrupIslemleri.aspx");
                    }
                }

                data.Kod = TextBoxKod.Text;
                data.MeslekAdi = TextBoxMeslekAdi.Text;

                MembershipUser user = Membership.GetUser(true);
                Guid userkey = user == null ? Guid.Empty : (Guid)user.ProviderUserKey;
                if (Key == 0)
                {
                    data.KayitKisiKey = userkey;
                    data.KayitTarih = DateTime.Now;
                    entity.TT_MESLEK_GRUP.Add(data);
                }
                else
                {
                    data.GuncelleKisiKey = userkey;
                    data.GuncelleTarih = DateTime.Now;
                }

                entity.SaveChanges();
            }

            Response.Redirect("MeslekGrupIslemleri.aspx");
        }

        protected void ButtonIptalTemizle_Click(object sender, EventArgs e)
        {
            Response.Redirect("MeslekGrupIslemleri.aspx");
        }

        protected void GridViewMeslekGrup_RowDeleting(object sender, ASPxDataDeletingEventArgs e)
        {
            using (var entity = new DBEntities())
            {
                int deletedkey = Convert.ToInt32(e.Keys[0]);
                TT_MESLEK_GRUP deleteddata = entity.TT_MESLEK_GRUP.Single(p => p.MeslekGrupKey == deletedkey);
                entity.TT_MESLEK_GRUP.Remove(deleteddata);

                try
                {
                    if (Key != 0)
                    {
                        GridViewMeslekGrup.JSProperties["cpErrorMessage"] = true;
                    }
                    else
                    {
                        entity.SaveChanges();
                        GridViewMeslekGrup.JSProperties["cpErrorMessage"] = false;
                    }
                }
                catch
                {
                    GridViewMeslekGrup.JSProperties["cpErrorMessage"] = true;
                }
            }

            DataLoad();
            e.Cancel = true;
        }

        protected void GridViewMeslekGrup_CustomButtonCallback(object sender, ASPxGridViewCustomButtonCallbackEventArgs e)
        {
            int index = e.VisibleIndex;
            int key = Convert.ToInt32(GridViewMeslekGrup.GetRowValues(index, new[] { "MeslekGrupKey" }));
            string sayfa = Request.Url.AbsolutePath.Replace(Request.Url.Segments[4], "");
            ASPxWebControl.RedirectOnCallback(string.Format("{0}MeslekGrupIslemleri.aspx?Key={1}", sayfa, key));
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

            LabelBaslik.Text = "MESLEK GRUP İŞLEMLERİ";
        }

        private void DataLoad()
        {
            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                GridViewMeslekGrup.DataSource = null;
                GridViewMeslekGrup.DataSource = entity.TT_MESLEK_GRUP.AsNoTracking().OrderBy(p => p.Kod).ToList();
                GridViewMeslekGrup.DataBind();

                if (Key != 0 && !IsPostBack)
                {
                    TT_MESLEK_GRUP data = entity.TT_MESLEK_GRUP.AsNoTracking().Single(p => p.MeslekGrupKey == Key);

                    TextBoxKod.Text = data.Kod;
                    TextBoxMeslekAdi.Text = data.MeslekAdi;
                }
            }
        }

        #endregion
    }
}
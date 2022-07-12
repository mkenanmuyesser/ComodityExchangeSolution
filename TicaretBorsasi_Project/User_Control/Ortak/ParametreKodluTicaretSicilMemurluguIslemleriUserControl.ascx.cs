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
    public partial class ParametreKodluTicaretSicilMemurluguIslemleriUserControl : System.Web.UI.UserControl
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
                    GridViewExporterSicilMemurlugu.WriteXlsxToResponse("Ticaret Sicil Memurluğu Bilgileri");
                    break;
                case 1:
                    GridViewExporterSicilMemurlugu.WritePdfToResponse("Ticaret Sicil Memurluğu Bilgileri");
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

                TT_SICIL_MEMURLUGU data;
                if (Key == 0)
                {
                    data = new TT_SICIL_MEMURLUGU();
                }
                else
                {
                    data = entity.TT_SICIL_MEMURLUGU.SingleOrDefault(p => p.SicilMemurluguKey == Key);
                    if (data == null)
                    {
                        Response.Redirect("TicaretSicilMemurluguIslemleri.aspx");
                    }
                }

                data.Kod = TextBoxKod.Text;
                data.Adi = TextBoxSicilMemurluguAdi.Text;

                MembershipUser user = Membership.GetUser(true);
                Guid userkey = user == null ? Guid.Empty : (Guid)user.ProviderUserKey;
                if (Key == 0)
                {
                    data.KayitKisiKey = userkey;
                    data.KayitTarih = DateTime.Now;
                    entity.TT_SICIL_MEMURLUGU.Add(data);
                }
                else
                {
                    data.GuncelleKisiKey = userkey;
                    data.GuncelleTarih = DateTime.Now;
                }

                entity.SaveChanges();
            }

            Response.Redirect("TicaretSicilMemurluguIslemleri.aspx");
        }

        protected void ButtonIptalTemizle_Click(object sender, EventArgs e)
        {
            Response.Redirect("TicaretSicilMemurluguIslemleri.aspx");
        }

        protected void GridViewSicilMemurlugu_RowDeleting(object sender, ASPxDataDeletingEventArgs e)
        {
            using (var entity = new DBEntities())
            {
                int deletedkey = Convert.ToInt32(e.Keys[0]);
                TT_SICIL_MEMURLUGU deleteddata = entity.TT_SICIL_MEMURLUGU.Single(p => p.SicilMemurluguKey == deletedkey);
                entity.TT_SICIL_MEMURLUGU.Remove(deleteddata);

                try
                {
                    if (Key != 0)
                    {
                        GridViewSicilMemurlugu.JSProperties["cpErrorMessage"] = true;
                    }
                    else
                    {
                        entity.SaveChanges();
                        GridViewSicilMemurlugu.JSProperties["cpErrorMessage"] = false;
                    }
                }
                catch
                {
                    GridViewSicilMemurlugu.JSProperties["cpErrorMessage"] = true;
                }
            }

            DataLoad();
            e.Cancel = true;
        }

        protected void GridViewSicilMemurlugu_CustomButtonCallback(object sender,
                                                                   ASPxGridViewCustomButtonCallbackEventArgs e)
        {
            int index = e.VisibleIndex;
            int key = Convert.ToInt32(GridViewSicilMemurlugu.GetRowValues(index, new[] { "SicilMemurluguKey" }));
            string sayfa = Request.Url.AbsolutePath.Replace(Request.Url.Segments[4], "");
            ASPxWebControl.RedirectOnCallback(string.Format("{0}TicaretSicilMemurluguIslemleri.aspx?Key={1}", sayfa, key));
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

            LabelBaslik.Text = "TİCARET SİCİL MEMURLUĞU İŞLEMLERİ";
        }

        private void DataLoad()
        {
            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                GridViewSicilMemurlugu.DataSource = null;
                GridViewSicilMemurlugu.DataSource = entity.TT_SICIL_MEMURLUGU.AsNoTracking().OrderBy(p => p.Kod).ToList();
                GridViewSicilMemurlugu.DataBind();

                if (Key != 0 && !IsPostBack)
                {
                    TT_SICIL_MEMURLUGU data = entity.TT_SICIL_MEMURLUGU.AsNoTracking().Single(p => p.SicilMemurluguKey == Key);

                    TextBoxKod.Text = data.Kod;
                    TextBoxSicilMemurluguAdi.Text = data.Adi;
                }
            }
        }

        #endregion
    }
}
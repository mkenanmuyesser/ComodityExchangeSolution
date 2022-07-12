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
    public partial class ParametreKodluKurulusTurIslemleriUserControl : System.Web.UI.UserControl
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
                    GridViewExporterKurulusTur.WriteXlsxToResponse("Kuruluş Türleri Bilgileri");
                    break;
                case 1:
                    GridViewExporterKurulusTur.WritePdfToResponse("Kuruluş Türleri Bilgileri");
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

                TT_KURULUS_TUR data;
                if (Key == 0)
                {
                    data = new TT_KURULUS_TUR();
                }
                else
                {
                    data = entity.TT_KURULUS_TUR.SingleOrDefault(p => p.KurulusTurKey == Key);
                    if (data == null)
                    {
                        Response.Redirect("KurulusTurIslemleri.aspx");
                    }
                }

                data.Kod = TextBoxKod.Text;
                data.TobbKodu = TextBoxTobbKodu.Text;
                data.Adi = TextBoxKurulusTuruAdi.Text;

                MembershipUser user = Membership.GetUser(true);
                Guid userkey = user == null ? Guid.Empty : (Guid)user.ProviderUserKey;
                if (Key == 0)
                {
                    data.KayitKisiKey = userkey;
                    data.KayitTarih = DateTime.Now;
                    entity.TT_KURULUS_TUR.Add(data);
                }
                else
                {
                    data.GuncelleKisiKey = userkey;
                    data.GuncelleTarih = DateTime.Now;
                }

                entity.SaveChanges();
            }

            Response.Redirect("KurulusTurIslemleri.aspx");
        }

        protected void ButtonIptalTemizle_Click(object sender, EventArgs e)
        {
            Response.Redirect("KurulusTurIslemleri.aspx");
        }

        protected void GridViewKurulusTur_RowDeleting(object sender, ASPxDataDeletingEventArgs e)
        {
            using (var entity = new DBEntities())
            {
                int deletedkey = Convert.ToInt32(e.Keys[0]);
                TT_KURULUS_TUR deleteddata = entity.TT_KURULUS_TUR.Single(p => p.KurulusTurKey == deletedkey);
                entity.TT_KURULUS_TUR.Remove(deleteddata);

                try
                {
                    if (Key != 0)
                    {
                        GridViewKurulusTur.JSProperties["cpErrorMessage"] = true;
                    }
                    else
                    {
                        entity.SaveChanges();
                        GridViewKurulusTur.JSProperties["cpErrorMessage"] = false;
                    }
                }
                catch
                {
                    GridViewKurulusTur.JSProperties["cpErrorMessage"] = true;
                }
            }

            DataLoad();
            e.Cancel = true;
        }

        protected void GridViewKurulusTur_CustomButtonCallback(object sender,
                                                               ASPxGridViewCustomButtonCallbackEventArgs e)
        {
            int index = e.VisibleIndex;
            int key = Convert.ToInt32(GridViewKurulusTur.GetRowValues(index, new[] { "KurulusTurKey" }));
            string sayfa = Request.Url.AbsolutePath.Replace(Request.Url.Segments[4], "");
            ASPxWebControl.RedirectOnCallback(string.Format("{0}KurulusTurIslemleri.aspx?Key={1}", sayfa, key));
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

            LabelBaslik.Text = "KURULUŞ TÜRLERİ İŞLEMLERİ";
        }

        private void DataLoad()
        {
            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                GridViewKurulusTur.DataSource = null;
                GridViewKurulusTur.DataSource = entity.TT_KURULUS_TUR.AsNoTracking().OrderBy(p => p.Kod).ToList();
                GridViewKurulusTur.DataBind();

                if (Key != 0 && !IsPostBack)
                {
                    TT_KURULUS_TUR data = entity.TT_KURULUS_TUR.AsNoTracking().Single(p => p.KurulusTurKey == Key);

                    TextBoxKod.Text = data.Kod;
                    TextBoxTobbKodu.Text = data.TobbKodu;
                    TextBoxKurulusTuruAdi.Text = data.Adi;
                }
            }
        }

        #endregion
    }
}
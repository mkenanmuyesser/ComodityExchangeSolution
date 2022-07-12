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
    public partial class ParametreKodluVergiDaireIslemleriUserControl : System.Web.UI.UserControl
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
                    GridViewExporterVergiDaire.WriteXlsxToResponse("Vergi Dairesi Bilgileri");
                    break;
                case 1:
                    GridViewExporterVergiDaire.WritePdfToResponse("Vergi Dairesi Bilgileri");
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

                TT_VERGI_DAIRE data;
                if (Key == 0)
                {
                    data = new TT_VERGI_DAIRE();
                }
                else
                {
                    data = entity.TT_VERGI_DAIRE.SingleOrDefault(p => p.VergiDaireKey == Key);
                    if (data == null)
                    {
                        Response.Redirect("VergiDaireIslemleri.aspx");
                    }
                }

                data.Kod = TextBoxKod.Text;
                data.TobbNo = TextBoxTobbNo.Text;
                data.VergiDairesiAdi = TextBoxVergiDairesiAdi.Text;

                MembershipUser user = Membership.GetUser(true);
                Guid userkey = user == null ? Guid.Empty : (Guid)user.ProviderUserKey;
                if (Key == 0)
                {
                    data.KayitKisiKey = userkey;
                    data.KayitTarih = DateTime.Now;
                    entity.TT_VERGI_DAIRE.Add(data);
                }
                else
                {
                    data.GuncelleKisiKey = userkey;
                    data.GuncelleTarih = DateTime.Now;
                }

                entity.SaveChanges();
            }

            Response.Redirect("VergiDaireIslemleri.aspx");
        }

        protected void ButtonIptalTemizle_Click(object sender, EventArgs e)
        {
            Response.Redirect("VergiDaireIslemleri.aspx");
        }
        
        protected void GridViewVergiDaire_RowDeleting(object sender, ASPxDataDeletingEventArgs e)
        {
            using (var entity = new DBEntities())
            {
                int deletedkey = Convert.ToInt32(e.Keys[0]);
                TT_VERGI_DAIRE deleteddata = entity.TT_VERGI_DAIRE.Single(p => p.VergiDaireKey == deletedkey);
                entity.TT_VERGI_DAIRE.Remove(deleteddata);

                try
                {
                    if (Key != 0)
                    {
                        GridViewVergiDaire.JSProperties["cpErrorMessage"] = true;
                    }
                    else
                    {
                        entity.SaveChanges();
                        GridViewVergiDaire.JSProperties["cpErrorMessage"] = false;
                    }
                }
                catch
                {
                    GridViewVergiDaire.JSProperties["cpErrorMessage"] = true;
                }
            }

            DataLoad();
            e.Cancel = true;
        }

        protected void GridViewVergiDaire_CustomButtonCallback(object sender,
                                                               ASPxGridViewCustomButtonCallbackEventArgs e)
        {
            int index = e.VisibleIndex;
            int key = Convert.ToInt32(GridViewVergiDaire.GetRowValues(index, new[] { "VergiDaireKey" }));
            string sayfa = Request.Url.AbsolutePath.Replace(Request.Url.Segments[4], "");
            ASPxWebControl.RedirectOnCallback(string.Format("{0}VergiDaireIslemleri.aspx?Key={1}",sayfa, key));
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

            LabelBaslik.Text = "VERGİ DAİRESİ İŞLEMLERİ";
        }

        private void DataLoad()
        {
            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                GridViewVergiDaire.DataSource = null;
                GridViewVergiDaire.DataSource = entity.TT_VERGI_DAIRE.AsNoTracking().OrderBy(p => p.Kod).ToList();
                GridViewVergiDaire.DataBind();

                if (Key != 0 && !IsPostBack)
                {
                    TT_VERGI_DAIRE data = entity.TT_VERGI_DAIRE.AsNoTracking().Single(p => p.VergiDaireKey == Key);

                    TextBoxKod.Text = data.Kod;
                    TextBoxTobbNo.Text = data.TobbNo;
                    TextBoxVergiDairesiAdi.Text = data.VergiDairesiAdi;
                }
            }
        }

        #endregion
    }
}
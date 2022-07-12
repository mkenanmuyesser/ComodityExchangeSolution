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
    public partial class ParametreKodluDereceIslemleriUserControl : System.Web.UI.UserControl
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
                    GridViewExporterDerece.WriteXlsxToResponse("Derece Bilgileri");
                    break;
                case 1:
                    GridViewExporterDerece.WritePdfToResponse("Derece Bilgileri");
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

                TT_DERECE data;
                if (Key == 0)
                {
                    data = new TT_DERECE();
                }
                else
                {
                    data = entity.TT_DERECE.SingleOrDefault(p => p.DereceKey == Key);
                    if (data == null)
                    {
                        Response.Redirect("DereceIslemleri.aspx");
                    }
                }

                data.Kod = TextBoxKod.Text;
                data.MuhasebeKodu = TextBoxMuhasebeKodu.Text;
                data.Kaydiye = Convert.ToDecimal(SpinEditKaydiye.Text);
                data.Aidat = Convert.ToDecimal(SpinEditAidat.Text);

                MembershipUser user = Membership.GetUser(true);
                Guid userkey = user == null ? Guid.Empty : (Guid)user.ProviderUserKey;
                if (Key == 0)
                {
                    data.KayitKisiKey = userkey;
                    data.KayitTarih = DateTime.Now;
                    entity.TT_DERECE.Add(data);
                }
                else
                {
                    data.GuncelleKisiKey = userkey;
                    data.GuncelleTarih = DateTime.Now;
                }

                entity.SaveChanges();
            }

            Response.Redirect("DereceIslemleri.aspx");
        }

        protected void ButtonIptalTemizle_Click(object sender, EventArgs e)
        {
            Response.Redirect("DereceIslemleri.aspx");
        }

        protected void GridViewDerece_RowDeleting(object sender, ASPxDataDeletingEventArgs e)
        {
            using (var entity = new DBEntities())
            {
                int deletedkey = Convert.ToInt32(e.Keys[0]);
                TT_DERECE deleteddata = entity.TT_DERECE.Single(p => p.DereceKey == deletedkey);
                entity.TT_DERECE.Remove(deleteddata);

                try
                {
                    if (Key != 0)
                    {
                        GridViewDerece.JSProperties["cpErrorMessage"] = true;
                    }
                    else
                    {
                        entity.SaveChanges();
                        GridViewDerece.JSProperties["cpErrorMessage"] = false;
                    }
                }
                catch
                {
                    GridViewDerece.JSProperties["cpErrorMessage"] = true;
                }
            }

            DataLoad();
            e.Cancel = true;
        }

        protected void GridViewDerece_CustomButtonCallback(object sender, ASPxGridViewCustomButtonCallbackEventArgs e)
        {
            int index = e.VisibleIndex;
            int key = Convert.ToInt32(GridViewDerece.GetRowValues(index, new[] { "DereceKey" }));
            string sayfa = Request.Url.AbsolutePath.Replace(Request.Url.Segments[4], "");
            ASPxWebControl.RedirectOnCallback(string.Format("{0}DereceIslemleri.aspx?Key={1}", sayfa, key));
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

            LabelBaslik.Text = "DERECE İŞLEMLERİ";
        }

        private void DataLoad()
        {
            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                GridViewDerece.DataSource = null;
                GridViewDerece.DataSource = entity.TT_DERECE.AsNoTracking().OrderBy(p => p.Kod).ToList();
                GridViewDerece.DataBind();

                if (Key != 0 && !IsPostBack)
                {
                    TT_DERECE data = entity.TT_DERECE.AsNoTracking().Single(p => p.DereceKey == Key);

                    TextBoxKod.Text = data.Kod;
                    TextBoxMuhasebeKodu.Text = data.MuhasebeKodu;
                    SpinEditKaydiye.Text = data.Kaydiye.ToString();
                    SpinEditAidat.Text = data.Aidat.ToString();
                }
            }
        }

        #endregion
    }
}
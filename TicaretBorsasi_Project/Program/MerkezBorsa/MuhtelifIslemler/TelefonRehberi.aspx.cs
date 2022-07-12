using System;
using System.Linq;
using System.Web.Security;
using System.Web.UI;
using DevExpress.Web.ASPxClasses;
using DevExpress.Web.ASPxGridView;
using DevExpress.Web.Data;
using TicaretBorsasi_Project.Data;

namespace TicaretBorsasi_Project.Program.MerkezBorsa.MuhtelifIslemler
{
    public partial class TelefonRehberi : Page
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
                    GridViewExporterTelefonRehberi.WriteXlsxToResponse("Telefon Rehberi");
                    break;
                case 1:
                    GridViewExporterTelefonRehberi.WritePdfToResponse("Telefon Rehberi");
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

                REHBER data;
                if (Key == 0)
                {
                    data = new REHBER();
                }
                else
                {
                    data = entity.REHBERs.SingleOrDefault(p => p.RehberKey == Key);
                    if (data == null)
                    {
                        Response.Redirect("TelefonRehberi.aspx");
                    }
                }

                data.Adi = TextBoxAdi.Text;
                data.Soyadi = TextBoxSoyadi.Text;
                data.Tel1 = TextBoxTelefon1.Text;
                data.Tel2 = TextBoxTelefon2.Text;
                data.Tel3 = TextBoxTelefon3.Text;
                data.Fax = TextBoxFax.Text;
                data.Email = TextBoxEposta.Text;
                data.Aciklama = MemoAciklama.Text;

                MembershipUser user = Membership.GetUser(true);
                Guid userkey = user == null ? Guid.Empty : (Guid) user.ProviderUserKey;
                if (Key == 0)
                {
                    data.KayitKisiKey = userkey;
                    data.KayitTarih = DateTime.Now;
                    entity.REHBERs.Add(data);
                }
                else
                {
                    data.GuncelleKisiKey = userkey;
                    data.GuncelleTarih = DateTime.Now;
                }

                entity.SaveChanges();
            }

            Response.Redirect("TelefonRehberi.aspx");
        }

        protected void ButtonIptalTemizle_Click(object sender, EventArgs e)
        {
            Response.Redirect("TelefonRehberi.aspx");
        }

        protected void GridViewTelefonRehberi_RowDeleting(object sender, ASPxDataDeletingEventArgs e)
        {
            using (var entity = new DBEntities())
            {
                int deletedkey = Convert.ToInt32(e.Keys[0]);
                REHBER deleteddata = entity.REHBERs.Single(p => p.RehberKey == deletedkey);
                entity.REHBERs.Remove(deleteddata);

                try
                {
                    if (Key != 0)
                    {
                        GridViewTelefonRehberi.JSProperties["cpErrorMessage"] = true;
                    }
                    else
                    {
                        entity.SaveChanges();
                        GridViewTelefonRehberi.JSProperties["cpErrorMessage"] = false;
                    }
                }
                catch
                {
                    GridViewTelefonRehberi.JSProperties["cpErrorMessage"] = true;
                }
            }

            DataLoad();
            e.Cancel = true;
        }

        protected void GridViewTelefonRehberi_CustomButtonCallback(object sender,
                                                                   ASPxGridViewCustomButtonCallbackEventArgs e)
        {
            int index = e.VisibleIndex;
            int key = Convert.ToInt32(GridViewTelefonRehberi.GetRowValues(index, new[] {"RehberKey"}));
            ASPxWebControl.RedirectOnCallback(string.Format("TelefonRehberi.aspx?Key={0}", key));
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

            LabelBaslik.Text = "TELEFON REHBERİ";
        }

        private void DataLoad()
        {
            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                GridViewTelefonRehberi.DataSource = null;
                GridViewTelefonRehberi.DataSource = entity.REHBERs.AsNoTracking().OrderBy(p => p.Adi).ToList();
                GridViewTelefonRehberi.DataBind();

                if (Key != 0 && !IsPostBack)
                {
                    REHBER data = entity.REHBERs.AsNoTracking().Single(p => p.RehberKey == Key);

                    TextBoxAdi.Text = data.Adi;
                    TextBoxSoyadi.Text = data.Soyadi;
                    TextBoxTelefon1.Text = data.Tel1;
                    TextBoxTelefon2.Text = data.Tel2;
                    TextBoxTelefon3.Text = data.Tel3;
                    TextBoxFax.Text = data.Fax;
                    TextBoxEposta.Text = data.Email;
                    MemoAciklama.Text = data.Aciklama;
                }
            }
        }

        #endregion
    }
}
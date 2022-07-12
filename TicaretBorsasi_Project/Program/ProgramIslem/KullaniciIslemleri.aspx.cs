using System;
using System.Linq;
using System.Web.Security;
using System.Web.UI;
using DevExpress.Web.ASPxClasses;
using DevExpress.Web.ASPxGridView;
using DevExpress.Web.Data;
using TicaretBorsasi_Project.Class.Helper;
using TicaretBorsasi_Project.Data;

namespace TicaretBorsasi_Project.Program.ProgramIslem
{
    public partial class KullaniciIslemleri : Page
    {
        #region Properties

        private Guid Key
        {
            get
            {
                string key = Request.QueryString["Key"];
                Guid keysonuc;
                Guid.TryParse(key, out keysonuc);
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
                    GridViewExporterKullaniciIslem.WriteXlsxToResponse("Kullanıcı Bilgileri");
                    break;
                case 1:
                    GridViewExporterKullaniciIslem.WritePdfToResponse("Kullanıcı Bilgileri");
                    break;
                default:
                    break;
            }
        }

        protected void ButtonKaydetGuncelle_Click(object sender, EventArgs e)
        {
            string kullaniciAdi = TextBoxKullaniciAdi.Text;
            string sifre = TextBoxSifre.Text;
            bool aktifmi = CheckBoxAktif.Checked;
            string roladi = ComboBoxRoller.SelectedItem.Text;

            #region validation

            #endregion

            aspnet_Membership data;
            if (Key == Guid.Empty)
            {
                MembershipCreateStatus durum;
                Membership.CreateUser(kullaniciAdi, sifre, null, null, null, aktifmi, out durum);

                if (durum != MembershipCreateStatus.Success)
                {
                    PageHelper.MessageBox(this, "Kullanıcı oluşturulamadı!");
                    return;
                }

                Roles.AddUserToRole(kullaniciAdi, roladi);
            }
            else
            {
                MembershipUser kullanici = Membership.GetUser(Key);
                if (kullanici == null)
                {
                    Response.Redirect("KullaniciIslemleri.aspx");
                }
                else
                {
                    try
                    {
                        kullanici.ChangePassword(kullanici.GetPassword(), sifre);
                        kullanici.IsApproved = aktifmi;

                        Membership.UpdateUser(kullanici);

                        if (Roles.GetRolesForUser(kullaniciAdi).Count() != 0)
                        {
                            string oncekirol = Roles.GetRolesForUser(kullaniciAdi)[0];
                            Roles.RemoveUserFromRole(kullaniciAdi, oncekirol);
                        }

                        Roles.AddUserToRole(kullaniciAdi, roladi);
                    }
                    catch
                    {
                        PageHelper.MessageBox(this, "Kullanıcı güncelleme işlemi başarısız!");
                        return;
                    }
                }
            }

            Response.Redirect("KullaniciIslemleri.aspx");
        }

        protected void ButtonIptalTemizle_Click(object sender, EventArgs e)
        {
            Response.Redirect("KullaniciIslemleri.aspx");
        }

        protected void GridViewKullaniciIslem_RowDeleting(object sender, ASPxDataDeletingEventArgs e)
        {
            Guid deletedkey = Guid.Parse(e.Keys[0].ToString());

            try
            {
                if (deletedkey == Guid.Empty)
                {
                    GridViewKullaniciIslem.JSProperties["cpErrorMessage"] = true;
                }
                else
                {
                    MembershipUser kullanici = Membership.GetUser(deletedkey);
                    if (!Membership.DeleteUser(kullanici.UserName))
                    {
                        GridViewKullaniciIslem.JSProperties["cpErrorMessage"] = false;
                    }
                }
            }
            catch
            {
                GridViewKullaniciIslem.JSProperties["cpErrorMessage"] = true;
            }

            DataLoad();
            e.Cancel = true;
        }

        protected void GridViewKullaniciIslem_CustomButtonCallback(object sender,
                                                                   ASPxGridViewCustomButtonCallbackEventArgs e)
        {
            int index = e.VisibleIndex;
            Guid key = Guid.Parse(GridViewKullaniciIslem.GetRowValues(index, new[] {"UserId"}).ToString());
            ASPxWebControl.RedirectOnCallback(string.Format("KullaniciIslemleri.aspx?Key={0}", key));
        }

        #endregion

        #region Methods

        private void SetInitials()
        {
            string[] rolList = Roles.GetAllRoles();
            ComboBoxRoller.DataSource = rolList;
            ComboBoxRoller.DataBind();


            if (Key == Guid.Empty)
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

            LabelBaslik.Text = "KULLANICI VE YETKİ İŞLEMLERİ";
        }

        private void DataLoad()
        {
            using (var entity = new DBEntities())
            {
                GridViewKullaniciIslem.DataSource = null;
                GridViewKullaniciIslem.DataSource =
                    entity.aspnet_Users.Include("aspnet_Membership")
                          .Where(p => p.UserName != "SuperAdmin")
                          .OrderBy(p => p.UserName)
                          .ToList();
                GridViewKullaniciIslem.DataBind();

                if (Key != Guid.Empty && !IsPostBack)
                {
                    aspnet_Membership kullanici =
                        entity.aspnet_Membership.Include("aspnet_Users")
                              .Include("aspnet_Users.aspnet_Roles")
                              .SingleOrDefault(p => p.UserId == Key);
                    if (kullanici == null)
                    {
                        Response.Redirect("KullaniciIslemleri.aspx");
                    }
                    else
                    {
                        TextBoxKullaniciAdi.Text = kullanici.aspnet_Users.UserName;
                        TextBoxSifre.Text = kullanici.Password;
                        CheckBoxAktif.Checked = kullanici.IsApproved;

                        aspnet_Roles rol = kullanici.aspnet_Users.aspnet_Roles.SingleOrDefault();
                        if (rol != null)
                        {
                            ComboBoxRoller.Items.FindByText(rol.RoleName).Selected = true;
                        }
                    }
                }
            }
        }

        #endregion

        protected void GridViewKullaniciIslem_HtmlRowPrepared(object sender, ASPxGridViewTableRowEventArgs e)
        {
            if (e.Row.Cells.Count == 7 && e.KeyValue != null)
            {
                using (var entity = new DBEntities())
                {
                    string kullaniciAdi =
                        Membership.GetAllUsers()
                                  .Cast<MembershipUser>()
                                  .Single(p => p.ProviderUserKey.Equals(e.KeyValue))
                                  .UserName;

                    string roladi = Roles.GetRolesForUser(kullaniciAdi).Count() == 0
                                        ? ""
                                        : Roles.GetRolesForUser(kullaniciAdi)[0];
                    e.Row.Cells[2].Text = roladi;
                }

                e.Row.Cells[3].Text = "*****";
            }
        }
    }
}
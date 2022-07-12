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
    public partial class RolIslemleri : Page
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
                    GridViewExporterRolIslem.WriteXlsxToResponse("Rol Bilgileri");
                    break;
                case 1:
                    GridViewExporterRolIslem.WritePdfToResponse("Rol Bilgileri");
                    break;
                default:
                    break;
            }
        }

        protected void ButtonKaydetGuncelle_Click(object sender, EventArgs e)
        {
            string rolAdi = TextBoxRolAdi.Text;

            #region validation

            #endregion

            if (Key == Guid.Empty)
            {
                try
                {
                    Roles.CreateRole(rolAdi);
                }
                catch
                {
                    PageHelper.MessageBox(this, "Rol oluşturulamadı!");
                    return;
                }
            }
            else
            {
                using (var entity = new DBEntities())
                {
                    aspnet_Roles rol = entity.aspnet_Roles.SingleOrDefault(p => p.RoleId == Key);
                    if (rol == null)
                    {
                        Response.Redirect("RolIslemleri.aspx");
                    }
                    else
                    {
                        try
                        {
                            rol.RoleName = rolAdi;
                            entity.SaveChanges();
                        }
                        catch
                        {
                            PageHelper.MessageBox(this, "Rol güncelleme işlemi başarısız!");
                            return;
                        }
                    }
                }
            }

            Response.Redirect("RolIslemleri.aspx");
        }

        protected void ButtonIptalTemizle_Click(object sender, EventArgs e)
        {
            Response.Redirect("RolIslemleri.aspx");
        }

        protected void GridViewRolIslem_RowDeleting(object sender, ASPxDataDeletingEventArgs e)
        {
            Guid deletedkey = Guid.Parse(e.Keys[0].ToString());

            try
            {
                if (deletedkey == Guid.Empty)
                {
                    GridViewRolIslem.JSProperties["cpErrorMessage"] = true;
                }
                else
                {
                    using (var entity = new DBEntities())
                    {
                        aspnet_Roles rol = entity.aspnet_Roles.SingleOrDefault(p => p.RoleId == deletedkey);
                        entity.aspnet_Roles.Remove(rol);
                        entity.SaveChanges();
                        GridViewRolIslem.JSProperties["cpErrorMessage"] = false;
                    }
                }
            }
            catch
            {
                GridViewRolIslem.JSProperties["cpErrorMessage"] = true;
            }

            DataLoad();
            e.Cancel = true;
        }

        protected void GridViewRolIslem_CustomButtonCallback(object sender, ASPxGridViewCustomButtonCallbackEventArgs e)
        {
            int index = e.VisibleIndex;
            Guid key = Guid.Parse(GridViewRolIslem.GetRowValues(index, new[] {"RoleId"}).ToString());
            ASPxWebControl.RedirectOnCallback(string.Format("RolIslemleri.aspx?Key={0}", key));
        }

        #endregion

        #region Methods

        private void SetInitials()
        {
            //TreeviewMerkezBorsa.ExpandAll();
            //TreeviewProgramIslem.ExpandAll();     

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

            LabelBaslik.Text = "ROL TANIMLAMALARI";
        }

        private void DataLoad()
        {
            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                GridViewRolIslem.DataSource = null;
                GridViewRolIslem.DataSource = entity.aspnet_Roles.AsNoTracking().OrderBy(p => p.RoleName).ToList();
                GridViewRolIslem.DataBind();

                if (Key != Guid.Empty && !IsPostBack)
                {
                    aspnet_Roles rol = entity.aspnet_Roles.AsNoTracking().SingleOrDefault(p => p.RoleId == Key);
                    if (rol == null)
                    {
                        Response.Redirect("RolIslemleri.aspx");
                    }
                    else
                    {
                        TextBoxRolAdi.Text = rol.RoleName;
                    }
                }
            }
        }

        #endregion
    }
}
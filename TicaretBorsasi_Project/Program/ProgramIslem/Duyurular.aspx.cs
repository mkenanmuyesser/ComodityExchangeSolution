using System;
using System.Linq;
using System.Web.Security;
using System.Web.UI;
using DevExpress.Web.ASPxClasses;
using DevExpress.Web.ASPxGridView;
using DevExpress.Web.Data;
using TicaretBorsasi_Project.Data;

namespace TicaretBorsasi_Project.Program.ProgramIslem
{
    public partial class Duyurular : Page
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

        protected void ButtonKaydetGuncelle_Click(object sender, EventArgs e)
        {
            using (var entity = new DBEntities())
            {
                #region validation

                #endregion

                DUYURU _DUYURU;
                if (Key == 0)
                {
                    _DUYURU = new DUYURU();
                }
                else
                {
                    _DUYURU = entity.DUYURUs.Single(p => p.ProgramDuyuruKey == Key);
                }

                _DUYURU.ProgramDuyuruTarih = DateEditDuyuruTarihi.Date;
                _DUYURU.ProgramDuyuru = MemoDuyuru.Text;
                _DUYURU.ProgramDuyuruAktif = CheckBoxAktif.Checked;

                MembershipUser user = Membership.GetUser(true);
                Guid userkey = user == null ? Guid.Empty : (Guid) user.ProviderUserKey;
                if (Key == 0)
                {
                    _DUYURU.KayitKisiKey = userkey;
                    _DUYURU.KayitTarih = DateTime.Now;
                    entity.DUYURUs.Add(_DUYURU);
                }
                else
                {
                    _DUYURU.GuncelleKisiKey = userkey;
                    _DUYURU.GuncelleTarih = DateTime.Now;
                }

                entity.SaveChanges();
            }

            Response.Redirect("Duyurular.aspx");
        }

        protected void ButtonIptalTemizle_Click(object sender, EventArgs e)
        {
            Response.Redirect("Duyurular.aspx");
        }

        protected void ButtonRapor_Click(object sender, EventArgs e)
        {
            switch (ComboBoxRapor.SelectedIndex)
            {
                case 0:
                    GridViewExporterDuyurular.WriteXlsxToResponse("Duyuru Bilgileri");
                    break;
                case 1:
                    GridViewExporterDuyurular.WritePdfToResponse("Duyuru Bilgileri");
                    break;
                default:
                    break;
            }
        }

        protected void GridViewDuyurular_RowDeleting(object sender, ASPxDataDeletingEventArgs e)
        {
            using (var entity = new DBEntities())
            {
                int deletedkey = Convert.ToInt32(e.Keys[0]);
                DUYURU deleteddata = entity.DUYURUs.Single(p => p.ProgramDuyuruKey == deletedkey);
                entity.DUYURUs.Remove(deleteddata);

                try
                {
                    entity.SaveChanges();
                    GridViewDuyurular.JSProperties["cpErrorMessage"] = false;
                }
                catch
                {
                    GridViewDuyurular.JSProperties["cpErrorMessage"] = true;
                }
            }

            DataLoad();
            e.Cancel = true;
        }

        protected void GridViewDuyurular_CustomButtonCallback(object sender, ASPxGridViewCustomButtonCallbackEventArgs e)
        {
            int index = e.VisibleIndex;
            int key = Convert.ToInt32(GridViewDuyurular.GetRowValues(index, new[] {"ProgramDuyuruKey"}));
            ASPxWebControl.RedirectOnCallback(string.Format("Duyurular.aspx?Key={0}", key));
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

            LabelBaslik.Text = "PROGRAM AYARLARI";
        }

        private void DataLoad()
        {
            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                GridViewDuyurular.DataSource = null;
                GridViewDuyurular.DataSource = entity.DUYURUs.AsNoTracking().OrderBy(p => p.ProgramDuyuruTarih).ToList();
                GridViewDuyurular.DataBind();

                if (Key != 0 && !IsPostBack)
                {
                    DUYURU duyuru = entity.DUYURUs.AsNoTracking().SingleOrDefault(p => p.ProgramDuyuruKey == Key);
                    if (duyuru == null)
                    {
                        Response.Redirect("Duyurular.aspx");
                    }
                    else
                    {
                        DateEditDuyuruTarihi.Value = duyuru.ProgramDuyuruTarih;
                        MemoDuyuru.Text = duyuru.ProgramDuyuru;
                        CheckBoxAktif.Checked = duyuru.ProgramDuyuruAktif;
                    }
                }
            }
        }

        #endregion
    }
}
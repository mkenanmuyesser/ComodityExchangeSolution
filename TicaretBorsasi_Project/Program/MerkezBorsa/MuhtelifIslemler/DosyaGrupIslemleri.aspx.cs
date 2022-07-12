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
    public partial class DosyaGrupIslemleri : Page
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
                    GridViewExporterDosyaGrup.WriteXlsxToResponse("Dosya Grup Bilgileri");
                    break;
                case 1:
                    GridViewExporterDosyaGrup.WritePdfToResponse("Dosya Grup Bilgileri");
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

                TT_DOSYA_GRUP data;
                if (Key == 0)
                {
                    data = new TT_DOSYA_GRUP();
                }
                else
                {
                    data = entity.TT_DOSYA_GRUP.SingleOrDefault(p => p.DosyaGrupKey == Key);
                    if (data == null)
                    {
                        Response.Redirect("DosyaGrupIslemleri.aspx");
                    }
                }

                data.Kod = TextBoxKod.Text;
                data.DosyaGrupAdi = TextBoxDosyaGrupAdi.Text;

                MembershipUser user = Membership.GetUser(true);
                Guid userkey = user == null ? Guid.Empty : (Guid) user.ProviderUserKey;
                if (Key == 0)
                {
                    data.KayitKisiKey = userkey;
                    data.KayitTarih = DateTime.Now;
                    entity.TT_DOSYA_GRUP.Add(data);
                }
                else
                {
                    data.GuncelleKisiKey = userkey;
                    data.GuncelleTarih = DateTime.Now;
                }

                entity.SaveChanges();
            }

            Response.Redirect("DosyaGrupIslemleri.aspx");
        }

        protected void ButtonIptalTemizle_Click(object sender, EventArgs e)
        {
            Response.Redirect("DosyaGrupIslemleri.aspx");
        }

        protected void GridViewDosyaGrup_RowDeleting(object sender, ASPxDataDeletingEventArgs e)
        {
            using (var entity = new DBEntities())
            {
                int deletedkey = Convert.ToInt32(e.Keys[0]);
                TT_DOSYA_GRUP deleteddata = entity.TT_DOSYA_GRUP.Single(p => p.DosyaGrupKey == deletedkey);
                entity.TT_DOSYA_GRUP.Remove(deleteddata);

                try
                {
                    if (Key != 0)
                    {
                        GridViewDosyaGrup.JSProperties["cpErrorMessage"] = true;
                    }
                    else
                    {
                        entity.SaveChanges();
                        GridViewDosyaGrup.JSProperties["cpErrorMessage"] = false;
                    }
                }
                catch
                {
                    GridViewDosyaGrup.JSProperties["cpErrorMessage"] = true;
                }
            }

            DataLoad();
            e.Cancel = true;
        }

        protected void GridViewDosyaGrup_CustomButtonCallback(object sender,
                                                              ASPxGridViewCustomButtonCallbackEventArgs e)
        {
            int index = e.VisibleIndex;
            int key = Convert.ToInt32(GridViewDosyaGrup.GetRowValues(index, new[] {"DosyaGrupKey"}));
            ASPxWebControl.RedirectOnCallback(string.Format("DosyaGrupIslemleri.aspx?Key={0}", key));
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

            LabelBaslik.Text = "DOSYA GRUP İŞLEMLERİ";
        }

        private void DataLoad()
        {
            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                GridViewDosyaGrup.DataSource = null;
                GridViewDosyaGrup.DataSource = entity.TT_DOSYA_GRUP.AsNoTracking().OrderBy(p => p.Kod).ToList();
                GridViewDosyaGrup.DataBind();

                if (Key != 0 && !IsPostBack)
                {
                    TT_DOSYA_GRUP data = entity.TT_DOSYA_GRUP.AsNoTracking().Single(p => p.DosyaGrupKey == Key);

                    TextBoxKod.Text = data.Kod;
                    TextBoxDosyaGrupAdi.Text = data.DosyaGrupAdi;
                }
            }
        }

        #endregion
    }
}
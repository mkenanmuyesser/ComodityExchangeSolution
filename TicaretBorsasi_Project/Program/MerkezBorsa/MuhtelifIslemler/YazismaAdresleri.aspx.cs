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
    public partial class YazismaAdresleri : Page
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
                    GridViewExporterYazismaAdres.WriteXlsxToResponse("Yazışma Adres Bilgileri");
                    break;
                case 1:
                    GridViewExporterYazismaAdres.WritePdfToResponse("Yazışma Adres Bilgileri");
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

                TT_YAZISMA_ADRES data;
                if (Key == 0)
                {
                    data = new TT_YAZISMA_ADRES();
                }
                else
                {
                    data = entity.TT_YAZISMA_ADRES.SingleOrDefault(p => p.YazismaAdresKey == Key);
                    if (data == null)
                    {
                        Response.Redirect("YazismaAdresleri.aspx");
                    }
                }

                data.Kod = TextBoxKod.Text;
                data.YazismaAdresAdi = TextBoxYazismaAdres.Text;

                MembershipUser user = Membership.GetUser(true);
                Guid userkey = user == null ? Guid.Empty : (Guid) user.ProviderUserKey;
                if (Key == 0)
                {
                    data.KayitKisiKey = userkey;
                    data.KayitTarih = DateTime.Now;
                    entity.TT_YAZISMA_ADRES.Add(data);
                }
                else
                {
                    data.GuncelleKisiKey = userkey;
                    data.GuncelleTarih = DateTime.Now;
                }

                entity.SaveChanges();
            }

            Response.Redirect("YazismaAdresleri.aspx");
        }

        protected void ButtonIptalTemizle_Click(object sender, EventArgs e)
        {
            Response.Redirect("YazismaAdresleri.aspx");
        }

        protected void GridViewYazismaAdres_RowDeleting(object sender, ASPxDataDeletingEventArgs e)
        {
            using (var entity = new DBEntities())
            {
                int deletedkey = Convert.ToInt32(e.Keys[0]);
                TT_YAZISMA_ADRES deleteddata = entity.TT_YAZISMA_ADRES.Single(p => p.YazismaAdresKey == deletedkey);
                entity.TT_YAZISMA_ADRES.Remove(deleteddata);

                try
                {
                    if (Key != 0)
                    {
                        GridViewYazismaAdres.JSProperties["cpErrorMessage"] = true;
                    }
                    else
                    {
                        entity.SaveChanges();
                        GridViewYazismaAdres.JSProperties["cpErrorMessage"] = false;
                    }
                }
                catch
                {
                    GridViewYazismaAdres.JSProperties["cpErrorMessage"] = true;
                }
            }

            DataLoad();
            e.Cancel = true;
        }

        protected void GridViewYazismaAdres_CustomButtonCallback(object sender,
                                                                 ASPxGridViewCustomButtonCallbackEventArgs e)
        {
            int index = e.VisibleIndex;
            int key = Convert.ToInt32(GridViewYazismaAdres.GetRowValues(index, new[] {"YazismaAdresKey"}));
            ASPxWebControl.RedirectOnCallback(string.Format("YazismaAdresleri.aspx?Key={0}", key));
        }

        #endregion

        #region Methods

        private void SetInitials()
        {
            LabelBaslik.Text = "YAZIŞMA ADRESLERİ";

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
        }

        private void DataLoad()
        {
            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                GridViewYazismaAdres.DataSource = null;
                GridViewYazismaAdres.DataSource = entity.TT_YAZISMA_ADRES.AsNoTracking().OrderBy(p => p.Kod).ToList();
                GridViewYazismaAdres.DataBind();

                if (Key != 0 && !IsPostBack)
                {
                    TT_YAZISMA_ADRES data = entity.TT_YAZISMA_ADRES.AsNoTracking().Single(p => p.YazismaAdresKey == Key);

                    TextBoxKod.Text = data.Kod;
                    TextBoxYazismaAdres.Text = data.YazismaAdresAdi;
                }
            }
        }

        #endregion
    }
}
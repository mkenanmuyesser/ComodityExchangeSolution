using System;
using System.Linq;
using System.Web.Security;
using System.Web.UI;
using DevExpress.Web.ASPxClasses;
using DevExpress.Web.ASPxGridView;
using DevExpress.Web.Data;
using TicaretBorsasi_Project.Data;

namespace TicaretBorsasi_Project.Program.SalonSatis.TuccarIslemleri
{
    public partial class TuccarKoltukTanimlari : Page
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
                    GridViewExporterKoltukTanim.WriteXlsxToResponse("Koltuk Tanım Bilgileri");
                    break;
                case 1:
                    GridViewExporterKoltukTanim.WritePdfToResponse("Koltuk Tanım Bilgileri");
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

                TT_IL_ILCE data;
                if (Key == 0)
                {
                    data = new TT_IL_ILCE();
                }
                else
                {
                    data = entity.TT_IL_ILCE.SingleOrDefault(p => p.IlIlceKey == Key);
                    if (data == null)
                    {
                        Response.Redirect("TuccarKoltukTanimlari.aspx");
                    }
                }

                //data.Kod = TextBoxKod.Text;
                //data.TobbKodu = TextBoxTobbKodu.Text;
                //data.IlIlceAdi = TextBoxIlIlceAd.Text;

                MembershipUser user = Membership.GetUser(true);
                Guid userkey = user == null ? Guid.Empty : (Guid) user.ProviderUserKey;
                if (Key == 0)
                {
                    data.KayitKisiKey = userkey;
                    data.KayitTarih = DateTime.Now;
                    entity.TT_IL_ILCE.Add(data);
                }
                else
                {
                    data.GuncelleKisiKey = userkey;
                    data.GuncelleTarih = DateTime.Now;
                }

                entity.SaveChanges();
            }

            Response.Redirect("TuccarKoltukTanimlari.aspx");
        }

        protected void ButtonIptalTemizle_Click(object sender, EventArgs e)
        {
            Response.Redirect("TuccarKoltukTanimlari.aspx");
        }

        protected void GridViewKoltukTanim_RowDeleting(object sender, ASPxDataDeletingEventArgs e)
        {
            using (var entity = new DBEntities())
            {
                int deletedkey = Convert.ToInt32(e.Keys[0]);
                TT_IL_ILCE deleteddata = entity.TT_IL_ILCE.Single(p => p.IlIlceKey == deletedkey);
                entity.TT_IL_ILCE.Remove(deleteddata);

                try
                {
                    if (Key != 0)
                    {
                        GridViewKoltukTanim.JSProperties["cpErrorMessage"] = true;
                    }
                    else
                    {
                        entity.SaveChanges();
                        GridViewKoltukTanim.JSProperties["cpErrorMessage"] = false;
                    }
                }
                catch
                {
                    GridViewKoltukTanim.JSProperties["cpErrorMessage"] = true;
                }
            }

            DataLoad();
            e.Cancel = true;
        }

        protected void GridViewKoltukTanim_CustomButtonCallback(object sender, ASPxGridViewCustomButtonCallbackEventArgs e)
        {
            int index = e.VisibleIndex;
            int key = Convert.ToInt32(GridViewKoltukTanim.GetRowValues(index, new[] { "IlIlceKey" }));
            ASPxWebControl.RedirectOnCallback(string.Format("TuccarKoltukTanimlari.aspx?Key={0}", key));
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

            LabelBaslik.Text = "KOLTUK TANIM İŞLEMLERİ";
        }

        private void DataLoad()
        {
            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                GridViewKoltukTanim.DataSource = null;
                GridViewKoltukTanim.DataSource = entity.TT_IL_ILCE.AsNoTracking().OrderBy(p => p.Kod).ToList();
                GridViewKoltukTanim.DataBind();

                ComboBoxSicilNoUnvan.DataSource = entity.TUCCAR_SICIL.
                                                         AsNoTracking().
                                                         OrderBy(p => p.SicilNo).
                                                         Select(p => new
                                                         {
                                                             p.TuccarSicilKey,
                                                             SicilNoUnvan = (p.SicilNo.Trim() + " - " + p.Unvan)
                                                         }).
                                                         ToList();
                ComboBoxSicilNoUnvan.DataBind();

                if (Key != 0 && !IsPostBack)
                {
                   
                }
            }
        }

        #endregion
    }
}
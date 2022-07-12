using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Security;
using System.Web.UI;
using DevExpress.Web.ASPxClasses;
using DevExpress.Web.ASPxGridView;
using DevExpress.Web.Data;
using TicaretBorsasi_Project.Data;

namespace TicaretBorsasi_Project.Program.MerkezBorsa.BeyannameTescilIslemleri
{
    public partial class BeyannameSatisSekilleri : Page
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
                    GridViewExporterSatisSekilleri.WriteXlsxToResponse("Satış Şekilleri");
                    break;
                case 1:
                    GridViewExporterSatisSekilleri.WritePdfToResponse("Satış Şekilleri");
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

                TT_SATIS_SEKLI data;
                if (Key == 0)
                {
                    data = new TT_SATIS_SEKLI();
                }
                else
                {
                    data = entity.TT_SATIS_SEKLI.SingleOrDefault(p => p.SatisSekliKey == Key);
                    if (data == null)
                    {
                        Response.Redirect("BeyannameSatisSekilleri.aspx");
                    }
                }

                data.Kod = TextBoxKod.Text;
                data.SatisSekliUzunAdi = TextBoxUzunAd.Text;
                data.SatisSekliAdi = TextBoxKisaAd.Text;
                data.SatanKey = Convert.ToByte(ComboBoxS.SelectedItem.Value);
                data.AlanKey = Convert.ToByte(ComboBoxA.SelectedItem.Value);
                data.StopajKey = Convert.ToByte(ComboBoxStopaj.SelectedItem.Value);
                data.TescilKey = Convert.ToByte(ComboBoxTescil.SelectedItem.Value);
                data.SimsarKey = Convert.ToByte(ComboBoxSohU.SelectedItem.Value);
                data.TipKey = Convert.ToByte(ComboBoxTip.SelectedItem.Value);

                MembershipUser user = Membership.GetUser(true);
                Guid userkey = user == null ? Guid.Empty : (Guid)user.ProviderUserKey;
                if (Key == 0)
                {
                    data.KayitKisiKey = userkey;
                    data.KayitTarih = DateTime.Now;
                    entity.TT_SATIS_SEKLI.Add(data);
                }
                else
                {
                    data.GuncelleKisiKey = userkey;
                    data.GuncelleTarih = DateTime.Now;
                }

                entity.SaveChanges();
            }

            Response.Redirect("BeyannameSatisSekilleri.aspx");
        }

        protected void ButtonIptalTemizle_Click(object sender, EventArgs e)
        {
            Response.Redirect("BeyannameSatisSekilleri.aspx");
        }

        protected void GridViewSatisSekilleri_RowDeleting(object sender, ASPxDataDeletingEventArgs e)
        {
            using (var entity = new DBEntities())
            {
                int deletedkey = Convert.ToInt32(e.Keys[0]);
                TT_SATIS_SEKLI deleteddata = entity.TT_SATIS_SEKLI.Single(p => p.SatisSekliKey == deletedkey);
                entity.TT_SATIS_SEKLI.Remove(deleteddata);

                try
                {
                    if (Key != 0)
                    {
                        GridViewSatisSekilleri.JSProperties["cpErrorMessage"] = true;
                    }
                    else
                    {
                        entity.SaveChanges();
                        GridViewSatisSekilleri.JSProperties["cpErrorMessage"] = false;
                    }
                }
                catch
                {
                    GridViewSatisSekilleri.JSProperties["cpErrorMessage"] = true;
                }
            }

            DataLoad();
            e.Cancel = true;
        }

        protected void GridViewSatisSekilleri_CustomButtonCallback(object sender, ASPxGridViewCustomButtonCallbackEventArgs e)
        {
            int index = e.VisibleIndex;
            int key = Convert.ToInt32(GridViewSatisSekilleri.GetRowValues(index, new[] { "SatisSekliKey" }));
            ASPxWebControl.RedirectOnCallback(string.Format("BeyannameSatisSekilleri.aspx?Key={0}", key));
        }

        #endregion

        #region Methods

        private void SetInitials()
        {
            LabelBaslik.Text = "SATIŞ ŞEKİLLERİ";

            using (var entity = new DBEntities())
            {
                List<TT_ALIS_SATIS_TIP> ListAlisSatis =
                    entity.TT_ALIS_SATIS_TIP.AsNoTracking().ToList().TakeWhile(p => p.AlisSatisTipKey <= 3).ToList();
                List<TT_ALIS_SATIS_TIP> ListMustahsilTuccar =
                    entity.TT_ALIS_SATIS_TIP.AsNoTracking().ToList().SkipWhile(p => p.AlisSatisTipKey <= 3).ToList();

                ComboBoxS.DataSource = ListMustahsilTuccar;
                ComboBoxS.DataBind();

                ComboBoxA.DataSource = ListMustahsilTuccar;
                ComboBoxA.DataBind();

                ComboBoxStopaj.DataSource = ListAlisSatis;
                ComboBoxStopaj.DataBind();

                ComboBoxTescil.DataSource = ListAlisSatis;
                ComboBoxTescil.DataBind();

                ComboBoxSohU.DataSource = ListAlisSatis;
                ComboBoxSohU.DataBind();

                ComboBoxTip.DataSource = ListAlisSatis;
                ComboBoxTip.DataBind();
            }

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

                GridViewSatisSekilleri.DataSource = null;
                GridViewSatisSekilleri.DataSource = entity.TT_SATIS_SEKLI
                    .Include("TT_ALIS_SATIS_TIP")
                    .AsNoTracking()
                    .Select(p => new
                    {
                        p.SatisSekliKey,
                        p.Kod,
                        p.SatisSekliAdi,
                        p.SatisSekliUzunAdi,
                        S = p.TT_ALIS_SATIS_TIP.AlisSatisTipAdi.Substring(0, 1),
                        A = p.TT_ALIS_SATIS_TIP1.AlisSatisTipAdi.Substring(0, 1),
                        Stopaj = p.TT_ALIS_SATIS_TIP2.AlisSatisTipAdi,
                        Tescil = p.TT_ALIS_SATIS_TIP3.AlisSatisTipAdi,
                        Soh = p.TT_ALIS_SATIS_TIP4.AlisSatisTipAdi,
                        Tip = p.TT_ALIS_SATIS_TIP5.AlisSatisTipAdi.Substring(0, 1),
                    }).OrderBy(p => p.Kod).ToList();
                GridViewSatisSekilleri.DataBind();

                if (Key != 0 && !IsPostBack)
                {
                    TT_SATIS_SEKLI data = entity.TT_SATIS_SEKLI.AsNoTracking().Single(p => p.SatisSekliKey == Key);

                    TextBoxKod.Text = data.Kod;
                    TextBoxUzunAd.Text = data.SatisSekliUzunAdi;
                    TextBoxKisaAd.Text = data.SatisSekliAdi;
                    ComboBoxS.Items.FindByValue(data.SatanKey).Selected = true;
                    ComboBoxA.Items.FindByValue(data.AlanKey).Selected = true;
                    ComboBoxStopaj.Items.FindByValue(data.StopajKey).Selected = true;
                    ComboBoxTescil.Items.FindByValue(data.TescilKey).Selected = true;
                    ComboBoxSohU.Items.FindByValue(data.SimsarKey).Selected = true;
                    ComboBoxTip.Items.FindByValue(data.TipKey).Selected = true;
                }
            }
        }

        #endregion
    }
}
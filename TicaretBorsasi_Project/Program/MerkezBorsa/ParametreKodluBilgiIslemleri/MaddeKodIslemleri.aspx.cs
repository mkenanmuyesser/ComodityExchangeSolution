using System;
using System.Linq;
using System.Web.Security;
using System.Web.UI;
using DevExpress.Web.ASPxClasses;
using DevExpress.Web.ASPxGridView;
using DevExpress.Web.Data;
using TicaretBorsasi_Project.Data;

namespace TicaretBorsasi_Project.Program.MerkezBorsa.ParametreKodluBilgiIslemleri
{
    public partial class MaddeKodIslemleri : Page
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
                    GridViewExporterMaddeKodu.WriteXlsxToResponse("Madde Kodu Bilgileri");
                    break;
                case 1:
                    GridViewExporterMaddeKodu.WritePdfToResponse("Madde Kodu Bilgileri");
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

                TT_MADDE_KOD data;
                if (Key == 0)
                {
                    data = new TT_MADDE_KOD();
                }
                else
                {
                    data = entity.TT_MADDE_KOD.SingleOrDefault(p => p.MaddeKodKey == Key);
                    if (data == null)
                    {
                        Response.Redirect("MaddeKodIslemleri.aspx");
                    }
                }

                data.Kod = TextBoxKod.Text;
                data.TobbKodu = TextBoxTobbKodu.Text;
                data.Adi = TextBoxAdi.Text;
                data.Stopaj = CheckBoxStopaj.Checked;
                data.MeraFonu = CheckBoxMeraFonu.Checked;
                data.MaddeKoduFonu = CheckBoxMaddeKoduFonu.Checked;
                data.Fire = Convert.ToDecimal(SpinEditFire.Text);
                data.LabGrubu = Convert.ToDecimal(SpinEditLabGrubu.Text);
                data.TmoGrubu = Convert.ToDecimal(SpinEditTmoGrubu.Text);
                data.BirimKg = Convert.ToDecimal(SpinEditBirimKg.Text);
                data.StopajYuzdesi = Convert.ToDecimal(SpinEditStopajYuzdesi.Text);

                MembershipUser user = Membership.GetUser(true);
                Guid userkey = user == null ? Guid.Empty : (Guid)user.ProviderUserKey;
                if (Key == 0)
                {
                    data.KayitKisiKey = userkey;
                    data.KayitTarih = DateTime.Now;
                    entity.TT_MADDE_KOD.Add(data);
                }
                else
                {
                    data.GuncelleKisiKey = userkey;
                    data.GuncelleTarih = DateTime.Now;
                }

                entity.SaveChanges();
            }

            Response.Redirect("MaddeKodIslemleri.aspx");
        }

        protected void ButtonIptalTemizle_Click(object sender, EventArgs e)
        {
            Response.Redirect("MaddeKodIslemleri.aspx");
        }

        protected void GridViewMaddeKodu_RowDeleting(object sender, ASPxDataDeletingEventArgs e)
        {
            using (var entity = new DBEntities())
            {
                int deletedkey = Convert.ToInt32(e.Keys[0]);
                TT_MADDE_KOD deleteddata = entity.TT_MADDE_KOD.Single(p => p.MaddeKodKey == deletedkey);
                entity.TT_MADDE_KOD.Remove(deleteddata);

                try
                {
                    if (Key != 0)
                    {
                        GridViewMaddeKodu.JSProperties["cpErrorMessage"] = true;
                    }
                    else
                    {
                        entity.SaveChanges();
                        GridViewMaddeKodu.JSProperties["cpErrorMessage"] = false;
                    }
                }
                catch
                {
                    GridViewMaddeKodu.JSProperties["cpErrorMessage"] = true;
                }
            }

            DataLoad();
            e.Cancel = true;
        }

        protected void GridViewMaddeKodu_CustomButtonCallback(object sender, ASPxGridViewCustomButtonCallbackEventArgs e)
        {
            int index = e.VisibleIndex;
            int key = Convert.ToInt32(GridViewMaddeKodu.GetRowValues(index, new[] { "MaddeKodKey" }));
            string sayfa = Request.Url.AbsolutePath.Replace(Request.Url.Segments[4], "");
            ASPxWebControl.RedirectOnCallback(string.Format("{0}MaddeKodIslemleri.aspx?Key={1}", sayfa, key));
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

            LabelBaslik.Text = "MADDE KODU İŞLEMLERİ";
        }

        private void DataLoad()
        {
            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                GridViewMaddeKodu.DataSource = null;
                GridViewMaddeKodu.DataSource = entity.TT_MADDE_KOD.AsNoTracking().OrderBy(p => p.Kod).ToList();
                GridViewMaddeKodu.DataBind();

                if (Key != 0 && !IsPostBack)
                {
                    TT_MADDE_KOD data = entity.TT_MADDE_KOD.AsNoTracking().Single(p => p.MaddeKodKey == Key);

                    TextBoxKod.Text = data.Kod;
                    TextBoxTobbKodu.Text = data.TobbKodu;
                    TextBoxAdi.Text = data.Adi;
                    CheckBoxStopaj.Checked = (bool)data.Stopaj;
                    CheckBoxMeraFonu.Checked = (bool)data.MeraFonu;
                    CheckBoxMaddeKoduFonu.Checked = (bool)data.MaddeKoduFonu;
                    SpinEditFire.Text = data.Fire.ToString();
                    SpinEditLabGrubu.Text = data.LabGrubu.ToString();
                    SpinEditTmoGrubu.Text = data.TmoGrubu.ToString();
                    SpinEditBirimKg.Text = data.BirimKg.ToString();
                    SpinEditStopajYuzdesi.Text = data.StopajYuzdesi.ToString();
                }
            }
        }

        #endregion
    }
}
using System;
using System.Linq;
using System.Web.Security;
using System.Web.UI;
using DevExpress.Web.ASPxClasses;
using DevExpress.Web.ASPxGridView;
using DevExpress.Web.Data;
using TicaretBorsasi_Project.Class.Helper;
using TicaretBorsasi_Project.Data;

namespace TicaretBorsasi_Project.Program.SalonSatis.SatisIslemleri
{
    public partial class TMOBaslangicAlimFiyatlari : Page
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
                    GridViewExporterTMOBaslangicAlimFiyatlari.WriteXlsxToResponse("TMO Başlangıç Alım Fiyatları");
                    break;
                case 1:
                    GridViewExporterTMOBaslangicAlimFiyatlari.WritePdfToResponse("TMO Başlangıç Alım Fiyatları");
                    break;
                default:
                    break;
            }
        }

        protected void ButtonKaydetGuncelle_Click(object sender, EventArgs e)
        {
            //using (var entity = new DBEntities())
            //{
            //    string pSatisOrganizasyonH = TextBoxSatisOrganizasyonH.Text.Replace("_", "").Trim();
            //    string pTescil = TextBoxTescil.Text.Replace("_", "").Trim();
            //    string pMeraFonu = TextBoxMeraFonu.Text.Replace("_", "").Trim();

            //    #region validation

            //    if ((!string.IsNullOrEmpty(pSatisOrganizasyonH) && pSatisOrganizasyonH.Length != 5) ||
            //        (!string.IsNullOrEmpty(pTescil) && pTescil.Length != 5) ||
            //        (!string.IsNullOrEmpty(pMeraFonu) && pMeraFonu.Length != 5))
            //    {
            //        PageHelper.MessageBox(this.Page, "Lütfen girilen değerleri kontrol ediniz.");
            //        return;
            //    }

            //    #endregion

            //    TT_BORSA_SUBE data;
            //    if (Key == 0)
            //    {
            //        data = new TT_BORSA_SUBE();
            //    }
            //    else
            //    {
            //        data = entity.TT_BORSA_SUBE.SingleOrDefault(p => p.BorsaSubeKey == Key);
            //        if (data == null)
            //        {
            //            Response.Redirect("TartiUcretleri.aspx");
            //        }
            //    }

            //    data.Kod = TextBoxKod.Text;
            //    data.BorsaSubeAdi = TextBoxSubeAdi.Text;
            //    data.BorsaSubeSimsariyeKodu = pSatisOrganizasyonH;
            //    data.BorsaSubeTesciliyeKodu = pTescil;
            //    data.BorsaSubeMeraFonuKodu = pMeraFonu;

            //    MembershipUser user = Membership.GetUser(true);
            //    Guid userkey = user == null ? Guid.Empty : (Guid)user.ProviderUserKey;
            //    if (Key == 0)
            //    {
            //        data.KayitKisiKey = userkey;
            //        data.KayitTarih = DateTime.Now;
            //        entity.TT_BORSA_SUBE.Add(data);
            //    }
            //    else
            //    {
            //        data.GuncelleKisiKey = userkey;
            //        data.GuncelleTarih = DateTime.Now;
            //    }

            //    entity.SaveChanges();
            //}

            Response.Redirect("TMOBaslangicAlimFiyatlari.aspx");
        }

        protected void ButtonIptalTemizle_Click(object sender, EventArgs e)
        {
            Response.Redirect("TMOBaslangicAlimFiyatlari.aspx");
        }

        protected void GridViewTMOBaslangicAlimFiyatlari_RowDeleting(object sender, ASPxDataDeletingEventArgs e)
        {
            using (var entity = new DBEntities())
            {
                int deletedkey = Convert.ToInt32(e.Keys[0]);
                TT_BORSA_SUBE deleteddata = entity.TT_BORSA_SUBE.Single(p => p.BorsaSubeKey == deletedkey);
                entity.TT_BORSA_SUBE.Remove(deleteddata);

                try
                {
                    if (Key != 0)
                    {
                        GridViewTMOBaslangicAlimFiyatlari.JSProperties["cpErrorMessage"] = true;
                    }
                    else
                    {
                        entity.SaveChanges();
                        GridViewTMOBaslangicAlimFiyatlari.JSProperties["cpErrorMessage"] = false;
                    }
                }
                catch
                {
                    GridViewTMOBaslangicAlimFiyatlari.JSProperties["cpErrorMessage"] = true;
                }
            }

            DataLoad();
            e.Cancel = true;
        }

        protected void GridViewTMOBaslangicAlimFiyatlari_CustomButtonCallback(object sender, ASPxGridViewCustomButtonCallbackEventArgs e)
        {
            int index = e.VisibleIndex;
            int key = Convert.ToInt32(GridViewTMOBaslangicAlimFiyatlari.GetRowValues(index, new[] { "BorsaSubeKey" }));
            ASPxWebControl.RedirectOnCallback(string.Format("TMOBaslangicAlimFiyatlari.aspx?Key={0}", key));
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

            LabelBaslik.Text = "TMO BAŞLANGIÇ ALIM FİYATLARI";

            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                //ComboBoxMaddeKoduAdi.DataSource = entity.TT_MADDE_KOD.AsNoTracking().Select(p => new
                //{
                //    p.MaddeKodKey,
                //    MaddeKoduAdi = (p.Kod.Trim() + " - " + p.Adi)
                //}).ToList();
                //ComboBoxMaddeKoduAdi.DataBind();
            }

        }

        private void DataLoad()
        {
            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                GridViewTMOBaslangicAlimFiyatlari.DataSource = null;
                GridViewTMOBaslangicAlimFiyatlari.DataSource = entity.TT_BORSA_SUBE.AsNoTracking().Select(p => new
                {
                    p.BorsaSubeKey,
                    p.Kod,
                    p.BorsaSubeAdi,
                    BorsaSubeSimsariyeKodu =
                                                                                string.IsNullOrEmpty(
                                                                                    p.BorsaSubeSimsariyeKodu)
                                                                                    ? ""
                                                                                    : p.BorsaSubeSimsariyeKodu
                                                                                       .Substring(0, 3) + "_" +
                                                                                      p.BorsaSubeSimsariyeKodu
                                                                                       .Substring(3, 2),
                    BorsaSubeTesciliyeKodu =
                                                                                string.IsNullOrEmpty(
                                                                                    p.BorsaSubeTesciliyeKodu)
                                                                                    ? ""
                                                                                    : p.BorsaSubeTesciliyeKodu
                                                                                       .Substring(0, 3) + "_" +
                                                                                      p.BorsaSubeTesciliyeKodu
                                                                                       .Substring(3, 2),
                    BorsaSubeMeraFonuKodu =
                                                                                string.IsNullOrEmpty(
                                                                                    p.BorsaSubeMeraFonuKodu)
                                                                                    ? ""
                                                                                    : p.BorsaSubeMeraFonuKodu
                                                                                       .Substring(0, 3) + "_" +
                                                                                      p.BorsaSubeMeraFonuKodu
                                                                                       .Substring(3, 2),
                }).OrderBy(p => p.Kod).ToList();
                GridViewTMOBaslangicAlimFiyatlari.DataBind();

                if (Key != 0 && !IsPostBack)
                {
                    TT_BORSA_SUBE data = entity.TT_BORSA_SUBE.AsNoTracking().Single(p => p.BorsaSubeKey == Key);

                    //TextBoxKod.Text = data.Kod;
                    //TextBoxSubeAdi.Text = data.BorsaSubeAdi;
                    //TextBoxSatisOrganizasyonH.Text = data.BorsaSubeSimsariyeKodu;
                    //TextBoxTescil.Text = data.BorsaSubeTesciliyeKodu;
                    //TextBoxMeraFonu.Text = data.BorsaSubeMeraFonuKodu;
                }
            }
        }

        #endregion
    }
}
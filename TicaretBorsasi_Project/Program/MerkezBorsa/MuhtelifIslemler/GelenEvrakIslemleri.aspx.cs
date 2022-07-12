using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Security;
using System.Web.UI;
using DevExpress.Web.ASPxClasses;
using DevExpress.Web.ASPxGridView;
using DevExpress.Web.Data;
using TicaretBorsasi_Project.Data;

namespace TicaretBorsasi_Project.Program.MerkezBorsa.MuhtelifIslemler
{
    public partial class GelenEvrakIslemleri : Page
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
                    GridViewExporterGelenGidenEvrak.WriteXlsxToResponse("Giden Evrak Bilgileri");
                    break;
                case 1:
                    GridViewExporterGelenGidenEvrak.WritePdfToResponse("Giden Evrak Bilgileri");
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

                GELEN_GIDEN_EVRAK data;
                if (Key == 0)
                {
                    data = new GELEN_GIDEN_EVRAK();
                }
                else
                {
                    data = entity.GELEN_GIDEN_EVRAK.SingleOrDefault(p => p.GelenGidenEvrakKey == Key);
                    if (data == null)
                    {
                        Response.Redirect("GidenEvrakIslemleri.aspx");
                    }
                }

                data.DosyaGrupKey = Convert.ToInt32(ComboBoxDosyaGrubu.SelectedItem.Value);
                data.EvrakSiraNo = Convert.ToInt32(TextBoxEvrakSiraNo.Text);
                data.KayitTarihi = DateEditKayitTarihi.Date;
                data.AdSoyad = TextBoxAdSoyad.Text;
                data.Adres = MemoAdres.Text;
                data.IlIlceKey = Convert.ToInt32(ComboBoxIlIlce.SelectedItem.Value);
                data.EvrakTarihi = DateEditEvrakTarihi.Date;
                data.EvrakNo = TextBoxEvrakNo.Text;
                data.YaziOzeti = MemoYaziOzeti.Text;
                data.EvrakTipKey = 1;

                MembershipUser user = Membership.GetUser(true);
                Guid userkey = user == null ? Guid.Empty : (Guid) user.ProviderUserKey;
                if (Key == 0)
                {
                    data.KayitKisiKey = userkey;
                    data.KayitTarih = DateTime.Now;
                    entity.GELEN_GIDEN_EVRAK.Add(data);
                }
                else
                {
                    data.GuncelleKisiKey = userkey;
                    data.GuncelleTarih = DateTime.Now;
                }

                entity.SaveChanges();
            }

            Response.Redirect("GidenEvrakIslemleri.aspx");
        }

        protected void ButtonIptalTemizle_Click(object sender, EventArgs e)
        {
            Response.Redirect("GidenEvrakIslemleri.aspx");
        }

        protected void GridViewGelenGidenEvrak_RowDeleting(object sender, ASPxDataDeletingEventArgs e)
        {
            using (var entity = new DBEntities())
            {
                int deletedkey = Convert.ToInt32(e.Keys[0]);
                GELEN_GIDEN_EVRAK deleteddata = entity.GELEN_GIDEN_EVRAK.Single(p => p.GelenGidenEvrakKey == deletedkey);
                entity.GELEN_GIDEN_EVRAK.Remove(deleteddata);

                try
                {
                    if (Key != 0)
                    {
                        GridViewGelenGidenEvrak.JSProperties["cpErrorMessage"] = true;
                    }
                    else
                    {
                        entity.SaveChanges();
                        GridViewGelenGidenEvrak.JSProperties["cpErrorMessage"] = false;
                    }
                }
                catch
                {
                    GridViewGelenGidenEvrak.JSProperties["cpErrorMessage"] = true;
                }
            }

            DataLoad();
            e.Cancel = true;
        }

        protected void GridViewGelenGidenEvrak_CustomButtonCallback(object sender,
                                                                    ASPxGridViewCustomButtonCallbackEventArgs e)
        {
            int index = e.VisibleIndex;
            int key = Convert.ToInt32(GridViewGelenGidenEvrak.GetRowValues(index, new[] {"GelenGidenEvrakKey"}));
            ASPxWebControl.RedirectOnCallback(string.Format("GidenEvrakIslemleri.aspx?Key={0}", key));
        }

        #endregion

        #region Methods

        private void SetInitials()
        {
            LabelBaslik.Text = "GELEN EVRAK İŞLEMLERİ";

            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                List<TT_DOSYA_GRUP> _TT_DOSYA_GRUP = entity.TT_DOSYA_GRUP.AsNoTracking().ToList();
                List<TT_IL_ILCE> _TT_IL_ILCE = entity.TT_IL_ILCE.AsNoTracking().ToList();

                ComboBoxDosyaGrubu.DataSource = _TT_DOSYA_GRUP;
                ComboBoxDosyaGrubu.DataBind();

                ComboBoxIlIlce.DataSource = _TT_IL_ILCE;
                ComboBoxIlIlce.DataBind();
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

                GridViewGelenGidenEvrak.DataSource = null;
                GridViewGelenGidenEvrak.DataSource =
                    entity.GELEN_GIDEN_EVRAK.Include("TT_DOSYA_GRUP")
                          .Include("TT_IL_ILCE")
                          .Include("TT_EVRAK_TIP")
                          .AsNoTracking()
                          .Select(p => new
                              {
                                  p.GelenGidenEvrakKey,
                                  p.EvrakSiraNo,
                                  p.TT_DOSYA_GRUP.DosyaGrupAdi,
                                  p.KayitTarihi,
                                  p.AdSoyad,
                                  p.Adres,
                                  Sehir = p.TT_IL_ILCE.IlIlceAdi,
                                  p.EvrakTarihi,
                                  p.EvrakNo,
                                  p.YaziOzeti
                              }).OrderBy(p => p.EvrakSiraNo).ToList();
                GridViewGelenGidenEvrak.DataBind();

                if (Key != 0 && !IsPostBack)
                {
                    GELEN_GIDEN_EVRAK data = entity.GELEN_GIDEN_EVRAK.AsNoTracking().Single(p => p.GelenGidenEvrakKey == Key);

                    ComboBoxDosyaGrubu.Items.FindByValue(data.DosyaGrupKey).Selected = true;
                    TextBoxEvrakSiraNo.Text = data.EvrakSiraNo.ToString();
                    DateEditKayitTarihi.Value = data.KayitTarihi;
                    TextBoxAdSoyad.Text = data.AdSoyad;
                    MemoAdres.Text = data.Adres;
                    ComboBoxIlIlce.Items.FindByValue(data.IlIlceKey).Selected = true;
                    DateEditEvrakTarihi.Value = data.EvrakTarihi;
                    TextBoxEvrakNo.Text = data.EvrakNo;
                    MemoYaziOzeti.Text = data.YaziOzeti;
                }
            }
        }

        #endregion
    }
}
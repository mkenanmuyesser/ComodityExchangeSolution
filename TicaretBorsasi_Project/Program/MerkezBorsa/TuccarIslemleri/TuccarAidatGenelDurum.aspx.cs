using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using DevExpress.Web.ASPxEditors;
using TicaretBorsasi_Project.Class.CustomType;
using TicaretBorsasi_Project.Class.CustomType.MerkezBorsa;
using TicaretBorsasi_Project.Class.Helper;
using TicaretBorsasi_Project.Data;

namespace TicaretBorsasi_Project.Program.MerkezBorsa.TuccarIslemleri
{
    public partial class TuccarAidatGenelDurum : Page
    {
        #region Properties

        private int Key
        {
            get
            {
                string key = Request.QueryString["Key"];
                if (Session["TuccarSicilKey"] == null || key != Session["TuccarSicilKey"].ToString())
                {
                    Session["TuccarSicilKey"] = key;
                }

                int keysonuc;
                int.TryParse(key, out keysonuc);
                return keysonuc;
            }
        }

        #endregion

        #region Events

        protected void Page_Load(object sender, EventArgs e)
        {
            SetInitials();
        }

        protected void ButtonRapor_Click(object sender, EventArgs e)
        {
            GridViewAidatGenelDurum.DataSource = PageHelper.SessionData;
            GridViewAidatGenelDurum.DataBind();

            switch (ComboBoxRapor.SelectedIndex)
            {
                case 0:
                    GridViewExporterAidatGenelDurum.WriteXlsxToResponse("Üye Aidat Genel Durum");
                    break;
                case 1:
                    GridViewExporterAidatGenelDurum.WritePdfToResponse("Üye Aidat Genel Durum");
                    break;
                default:
                    break;
            }
        }

        protected void ButtonGeriIleri_Click(object sender, EventArgs e)
        {
            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                int sicilno = Convert.ToInt32(PageHelper.SicilNoTamamlama(TextBoxSicilNo.Text));
                string butonadi = ((ASPxButton) sender).ID;
                var tuccarlistesi = entity.TUCCAR_SICIL.AsNoTracking().ToList().OrderBy(p => p.SicilNo);
                TUCCAR_SICIL _TUCCAR_SICIL = null;
                switch (butonadi)
                {
                    case "ButtonGeri":
                        _TUCCAR_SICIL = tuccarlistesi.LastOrDefault(p => Convert.ToInt32(p.SicilNo) < sicilno);
                        if (_TUCCAR_SICIL == null)
                        {
                            _TUCCAR_SICIL = tuccarlistesi.First();
                        }
                        break;
                    case "ButtonIleri":
                        _TUCCAR_SICIL = tuccarlistesi.FirstOrDefault(p => Convert.ToInt32(p.SicilNo) > sicilno);
                        if (_TUCCAR_SICIL == null)
                        {
                            _TUCCAR_SICIL = tuccarlistesi.Last();
                        }
                        break;
                }

                int key = _TUCCAR_SICIL.TuccarSicilKey;
                Response.Redirect(string.Format("TuccarAidatGenelDurum.aspx?Key={0}", key));
            }
        }

        protected void ButtonAra_Click(object sender, EventArgs e)
        {
            using (var entity = new DBEntities())
            {
                string sicilno = PageHelper.SicilNoTamamlama(TextBoxSicilNo.Text);
                TUCCAR_SICIL _TUCCAR_SICIL = entity.TUCCAR_SICIL.SingleOrDefault(p => p.SicilNo == sicilno);
                if (_TUCCAR_SICIL == null)
                {
                    PageHelper.MessageBox(this, "Tüccar bulunamadı.");
                }
                else
                {
                    int key = _TUCCAR_SICIL.TuccarSicilKey;
                    Response.Redirect(string.Format("TuccarAidatGenelDurum.aspx?Key={0}", key));
                }
            }
        }

        #endregion

        #region Methods

        private void SetInitials()
        {
            LabelBaslik.Text = "ÜYE AİDAT GENEL DURUMU";

            if (!IsPostBack)
            {
                PageHelper.SessionData = null;
            }
            else
            {
                GridViewAidatGenelDurum.DataSource = PageHelper.SessionData;
                GridViewAidatGenelDurum.DataBind();
            }

            DataLoad();
        }

        private void DataLoad()
        {
            GridViewAidatGenelDurum.DataSource = null;

            if (Key != 0)
            {
                using (var entity = new DBEntities())
                {
                    entity.Configuration.AutoDetectChangesEnabled = false;

                    TUCCAR_SICIL _TUCCAR_SICIL =
                        entity.TUCCAR_SICIL.Include("FIRMA_SAHIS")
                              .Include("TT_MESLEK_GRUP")
                              .Include("TUCCAR_ASKI")
                              .Include("TT_DERECE")
                              .AsNoTracking()
                              .SingleOrDefault(p => p.TuccarSicilKey == Key);
                    if (_TUCCAR_SICIL == null)
                    {
                        Response.Redirect("TuccarAidatGenelDurum.aspx");
                        return;
                    }

                    TextBoxSicilNo.Text = _TUCCAR_SICIL.SicilNo;
                    TextBoxMeslekGrubu.Text = _TUCCAR_SICIL.TT_MESLEK_GRUP.MeslekAdi;
                    MemoUnvan.Text = _TUCCAR_SICIL.Unvan;
                    LabelDurum.Text =
                        _TUCCAR_SICIL.TUCCAR_ASKI.Where(p => p.AskiTarihi != null && p.BitisTarihi == null).Count() > 0
                            ? "ASKI"
                            : "FAAL";

                    List<AIDAT_TAKIP> AIDAT_TAKIPList =
                        entity.AIDAT_TAKIP.AsNoTracking().Where(p => p.TuccarSicilKey == _TUCCAR_SICIL.TuccarSicilKey)
                              .OrderByDescending(p => p.Yil)
                              .ToList();
                    var AidatTaksitTypeList = new List<AidatTaksitType>();
                    foreach (AIDAT_TAKIP aidatodemebilgi in AIDAT_TAKIPList)
                    {
                        var taksit1bilgi = new AidatTaksitType
                            {
                                TuccarSicilKey = Key,
                                Donem = aidatodemebilgi.Yil.ToString() + " - 1",
                                DereceAdi = _TUCCAR_SICIL.TT_DERECE.Kod,
                                AidatTutar = aidatodemebilgi.AidatMiktar.Value/2m,
                                OdenenCeza =
                                    aidatodemebilgi.Taksit1CezaMiktar == null
                                        ? 0
                                        : aidatodemebilgi.Taksit1CezaMiktar.Value,
                                OdemeTarihi =
                                    aidatodemebilgi.Taksit1CezaTarihi == null ? null : aidatodemebilgi.Taksit1CezaTarihi,
                                Aciklama = aidatodemebilgi.Taksit1OdemeAciklama
                            };

                        var taksit2bilgi = new AidatTaksitType
                            {
                                TuccarSicilKey = Key,
                                Donem = aidatodemebilgi.Yil.ToString() + " - 2",
                                DereceAdi = _TUCCAR_SICIL.TT_DERECE.Kod,
                                AidatTutar = aidatodemebilgi.AidatMiktar.Value/2m,
                                OdenenCeza =
                                    aidatodemebilgi.Taksit2CezaMiktar == null
                                        ? 0
                                        : aidatodemebilgi.Taksit2CezaMiktar.Value,
                                OdemeTarihi =
                                    aidatodemebilgi.Taksit2CezaTarihi == null ? null : aidatodemebilgi.Taksit2CezaTarihi,
                                Aciklama = aidatodemebilgi.Taksit2OdemeAciklama
                            };

                        AidatTaksitTypeList.Add(taksit1bilgi);
                        AidatTaksitTypeList.Add(taksit2bilgi);
                    }

                    GridViewAidatGenelDurum.DataSource = AidatTaksitTypeList;
                }
            }

            PageHelper.SessionData = GridViewAidatGenelDurum.DataSource;
            GridViewAidatGenelDurum.DataBind();
        }

        #endregion
    }
}
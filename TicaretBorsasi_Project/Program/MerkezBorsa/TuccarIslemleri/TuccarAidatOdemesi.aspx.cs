using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using DevExpress.Web.ASPxClasses;
using DevExpress.Web.ASPxEditors;
using DevExpress.Web.ASPxGridView;
using TicaretBorsasi_Project.Class.Business;
using TicaretBorsasi_Project.Class.CustomType;
using TicaretBorsasi_Project.Class.CustomType.MerkezBorsa;
using TicaretBorsasi_Project.Class.Helper;
using TicaretBorsasi_Project.Data;

namespace TicaretBorsasi_Project.Program.MerkezBorsa.TuccarIslemleri
{
    public partial class TuccarAidatOdemesi : Page
    {
        #region Properties

        private int Key
        {
            get
            {
                string key = Request.QueryString["Key"];
                if (Session["Key"] == null || key != Session["Key"].ToString())
                {
                    Session["Key"] = key;
                }

                int keysonuc;
                int.TryParse(key, out keysonuc);
                return keysonuc;
            }
        }

        private short Yil
        {
            get
            {
                string key = Request.QueryString["Yil"];

                short keysonuc;
                short.TryParse(key, out keysonuc);
                return keysonuc;
            }
        }

        private List<AidatCezaHesapType> AidatOdemeList
        {
            get
            {
                if (Session["AidatOdemeList"] == null)
                {
                    return new List<AidatCezaHesapType>();
                }
                else
                {
                    return (List<AidatCezaHesapType>) Session["AidatOdemeList"];
                }
            }
        }

        #endregion

        #region Events

        protected void Page_Load(object sender, EventArgs e)
        {
            SetInitials();
        }

        protected void ButtonGeriIleri_Click(object sender, EventArgs e)
        {
            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                int sicilno = Convert.ToInt32(TextBoxTuccarSicilNo.Text);
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
                Response.Redirect(string.Format("TuccarAidatOdemesi.aspx?Key={0}", key));
            }
        }

        protected void ButtonAra_Click(object sender, EventArgs e)
        {
            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                string sicilno = TextBoxTuccarSicilNo.Text;
                TUCCAR_SICIL _TUCCAR_SICIL = entity.TUCCAR_SICIL.AsNoTracking().SingleOrDefault(p => p.SicilNo == sicilno);
                if (_TUCCAR_SICIL == null)
                {
                    PageHelper.MessageBox(this, "Tüccar bulunamadı.");
                }
                else
                {
                    int key = _TUCCAR_SICIL.TuccarSicilKey;
                    Response.Redirect(string.Format("TuccarAidatOdemesi.aspx?Key={0}", key));
                }
            }
        }

        protected void ButtonRapor_Click(object sender, EventArgs e)
        {
            GridViewAidatOdeme.DataSource = PageHelper.SessionData;
            GridViewAidatOdeme.DataBind();

            switch (ComboBoxRapor.SelectedIndex)
            {
                case 0:
                    GridViewExporterAidatOdeme.WriteXlsxToResponse("Tüccar Aidat Bilgileri");
                    break;
                case 1:
                    GridViewExporterAidatOdeme.WritePdfToResponse("Tüccar Aidat Bilgileri");
                    break;
                default:
                    break;
            }
        }

        protected void GridViewAidatOdeme_CustomButtonCallback(object sender,
                                                               ASPxGridViewCustomButtonCallbackEventArgs e)
        {
            int index = e.VisibleIndex;
            short aidatyili = Convert.ToInt16(GridViewAidatOdeme.GetRowValues(index, new[] {"AidatYili"}));
            //ödeme işlemleri 
            using (var entity = new DBEntities())
            {
                TUCCAR_SICIL _TUCCAR_SICIL =
                    entity.TUCCAR_SICIL.Include("TUCCAR_ASKI")
                          .Include("TT_MESLEK_GRUP")
                          .SingleOrDefault(p => p.TuccarSicilKey == Key);
                AIDAT_TAKIP _AIDAT_TAKIP =
                    entity.AIDAT_TAKIP.SingleOrDefault(p => p.TuccarSicilKey == Key && p.Yil == aidatyili);
                if (_AIDAT_TAKIP == null)
                {
                    _AIDAT_TAKIP = new AIDAT_TAKIP();
                }

                //_AIDAT_TAKIP.Taksit1CezaAciklama = "";
                //_AIDAT_TAKIP.Taksit1CezaMiktar = 0;
                //_AIDAT_TAKIP.Taksit1CezaTarihi = new DateTime();

                //_AIDAT_TAKIP.Taksit2CezaAciklama = "";
                //_AIDAT_TAKIP.Taksit2CezaMiktar = 0;
                //_AIDAT_TAKIP.Taksit2CezaTarihi = new DateTime();

                //entity.SaveChanges();
            }

            //ve refresh
            ASPxWebControl.RedirectOnCallback(Request.Url.AbsoluteUri + "&Yil=" + aidatyili);
        }

        //protected void GridViewAidatOdeme_RowDeleting(object sender, ASPxDataDeletingEventArgs e)
        //{
        //    using (var entity = new DBEntities())
        //    {
        //        Guid deletedkey = Guid.Parse(e.Keys[0].ToString());
        //        AidatCezaHesapType data = AidatOdemeList.Single(p => p.Key == deletedkey);
        //        AidatOdemeList.Remove(data);

        //        Session["AidatCezaList"] = AidatOdemeList;
        //    }

        //    e.Cancel = true;
        //    DataLoad();
        //}

        #endregion

        #region Methods

        private void SetInitials()
        {
            LabelBaslik.Text = "TÜCCAR AİDAT ÖDEMESİ";

            if (Yil == 0)
            {
                GridViewAidatOdeme.Enabled = true;
                PanelOdeme.Visible = false;
            }
            else
            {
                GridViewAidatOdeme.Enabled = false;
                PanelOdeme.Visible = true;
            }

            if (!IsPostBack)
            {
                PageHelper.SessionData = null;
                DataLoad();
            }
        }

        private void DataLoad()
        {
            if (Key != 0)
            {
                using (var entity = new DBEntities())
                {
                    entity.Configuration.AutoDetectChangesEnabled = false;

                    TUCCAR_SICIL _TUCCAR_SICIL =
                        entity.TUCCAR_SICIL.Include("TUCCAR_ASKI")
                              .Include("TT_MESLEK_GRUP")
                              .AsNoTracking()
                              .SingleOrDefault(p => p.TuccarSicilKey == Key);
                    if (_TUCCAR_SICIL == null)
                    {
                        Response.Redirect("TuccarAidatOdemesi.aspx");
                        return;
                    }

                    bool askida = _TUCCAR_SICIL.TUCCAR_ASKI.Any(p => p.BitisTarihi == null);
                    bool terkin = _TUCCAR_SICIL.TerkinTarihi != null;

                    TextBoxTuccarSicilNo.Text = _TUCCAR_SICIL.SicilNo;
                    MemoUnvan.Text = _TUCCAR_SICIL.Unvan;
                    TextBoxMeslekGrubu.Text = _TUCCAR_SICIL.TT_MESLEK_GRUP.MeslekAdi;
                    LabelTuccarDurum.Text = terkin ? "TERKİN" : (askida ? "ASKIDA" : "FAAL");

                    List<AIDAT_TAKIP> AIDAT_TAKIPList =
                        entity.AIDAT_TAKIP.AsNoTracking().Where(p => p.TuccarSicilKey == _TUCCAR_SICIL.TuccarSicilKey).ToList();
                    short? sonodemeyil = AIDAT_TAKIPList.Max(p => p.Yil);
                    short mincezayil = entity.TT_DERECE_CEZA_ORAN.AsNoTracking().Min(p => p.Yil.Value);
                    //aidat hesabı gride ekleniyor
                    short AidatYiliBaslangic = sonodemeyil == null
                                                   ? (_TUCCAR_SICIL.KayitTarihi == null
                                                          ? mincezayil
                                                          : Convert.ToInt16(_TUCCAR_SICIL.KayitTarihi.Value.Year))
                                                   : sonodemeyil.Value;
                    short AidatYiliBitis = Convert.ToInt16(DateTime.Now.Year);

                    Session["AidatOdemeList"] = null;

                    for (short pAidatYili = AidatYiliBaslangic; pAidatYili <= AidatYiliBitis; pAidatYili++)
                    {
                        AIDAT_TAKIP _AIDAT_TAKIP = AIDAT_TAKIPList.SingleOrDefault(p => p.Yil == pAidatYili);
                        if (_AIDAT_TAKIP != null)
                        {
                            //o seneki derecesini bul ve taksitleri çıkart
                            TT_DERECE _TT_DERECE =
                                entity.TT_DERECE.AsNoTracking().SingleOrDefault(p => p.DereceKey == _AIDAT_TAKIP.DereceKey);

                            //eğer ödendiyse o taksit sıfırlanacak, o sene ödendiyse o satır hiç gösterilmeyecek
                            if (_AIDAT_TAKIP.Taksit1OdemeTarihi != null || _AIDAT_TAKIP.Taksit2OdemeTarihi != null)
                            {
                                decimal pTaksit1 = _AIDAT_TAKIP.Taksit1OdemeMiktar == 0
                                                       ? (_TT_DERECE.Aidat.Value/2m)
                                                       : 0;
                                decimal pTaksit2 = _AIDAT_TAKIP.Taksit2OdemeMiktar == 0
                                                       ? (_TT_DERECE.Aidat.Value/2m)
                                                       : 0;


                                AidatCezaHesapType hesap = AidatBS.Hesapla(pAidatYili, pTaksit1, pTaksit2);

                                List<AidatCezaHesapType> liste = AidatOdemeList;
                                liste.Add(hesap);
                                Session["AidatOdemeList"] = liste;
                            }
                        }
                    }
                }
            }

            GridViewAidatOdeme.DataSource = null;
            GridViewAidatOdeme.DataSource = AidatOdemeList;
            PageHelper.SessionData = GridViewAidatOdeme.DataSource;
            GridViewAidatOdeme.DataBind();
        }

        #endregion
    }
}
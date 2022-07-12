using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using DevExpress.Web.ASPxEditors;
using TicaretBorsasi_Project.Class.Helper;
using TicaretBorsasi_Project.Data;

namespace TicaretBorsasi_Project.Program.MerkezBorsa.TuccarIslemleri
{
    public partial class TuccarStopajTahsilatKontrolu : Page
    {
        #region Properties

        private int TuccarSicilKey
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

        protected void ButtonGeriIleri_Click(object sender, EventArgs e)
        {
            using (var entity = new DBEntities())
            {
                int sicilno = Convert.ToInt32(PageHelper.SicilNoTamamlama(TextBoxSicilNo.Text));
                string butonadi = ((ASPxButton) sender).ID;
                IOrderedEnumerable<TUCCAR_SICIL> tuccarlistesi = entity.TUCCAR_SICIL.ToList().OrderBy(p => p.SicilNo);
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
                Response.Redirect(string.Format("TuccarStopajTahsilatKontrolu.aspx?Key={0}", key));
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
                    Response.Redirect(string.Format("TuccarStopajTahsilatKontrolu.aspx?Key={0}", key));
                }
            }
        }

        #endregion

        #region Methods

        private void SetInitials()
        {
            LabelBaslik.Text = "STOPAJ TAHSİLAT KONTROLÜ";

            if (!IsPostBack)
            {
                DataLoad();
            }
        }

        private void DataLoad()
        {
            int yil = DateTime.Now.Year;
            int eskiyil = yil - 1;
            LabelEskiYil.Text = (yil - 1).ToString() + " ARALIK";
            LabelYil.Text = yil.ToString() + " OCAK";

            if (TuccarSicilKey != 0)
            {
                using (var entity = new DBEntities())
                {
                    entity.Configuration.AutoDetectChangesEnabled = false;

                    TUCCAR_SICIL _TUCCAR_SICIL =
                        entity.TUCCAR_SICIL
                        .Include("TT_VERGI_DAIRE")
                        .Include("TUCCAR_ASKI")
                        .AsNoTracking()
                        .SingleOrDefault(p => p.TuccarSicilKey == TuccarSicilKey);
                    if (_TUCCAR_SICIL == null)
                    {
                        Response.Redirect("TuccarStopajTahsilatKontrolu.aspx");
                        return;
                    }

                    string unvan = _TUCCAR_SICIL.Unvan;
                    bool askida = _TUCCAR_SICIL.TUCCAR_ASKI.Any(p => p.BitisTarihi == null);
                    bool terkin = _TUCCAR_SICIL.TerkinTarihi != null;

                    TextBoxSicilNo.Text = _TUCCAR_SICIL.SicilNo;
                    MemoUnvan.Text = unvan;
                    LabelDurum.Text = terkin ? "TERKİN" : (askida ? "ASKIDA" : "FAAL");
                    TextBoxVergiDairesi.Text = _TUCCAR_SICIL.TT_VERGI_DAIRE.VergiDairesiAdi;

                    Temizle();

                    List<BEYAN> beyanlar =
                        entity.BEYANs.AsNoTracking().Where(
                            p => p.BeyanTarihi != null && p.TuccarSicilKey == _TUCCAR_SICIL.TuccarSicilKey).ToList();

                    if (!beyanlar.Any())
                    {
                        PageHelper.MessageBox(this, "Üyenin Alış Beyannamesi Stopaj Tahakkuku ve/veya Tahsilatı Yoktur!");
                        return;
                    }

                    #region label

                    #region tahakkuk

                    List<BEYAN> beyanlartahakkuk = beyanlar;

                    LabelEskiYilAralikTahakkuk.Text =
                        beyanlartahakkuk.Where(
                            p => p.BeyanTarihi.Value.Year == eskiyil && p.BeyanTarihi.Value.Month == 12)
                                        .Sum(p => p.BeyanMiktar)
                                        .ToString();
                    LabelOcakTahakkuk.Text =
                        beyanlartahakkuk.Where(p => p.BeyanTarihi.Value.Year == yil && p.BeyanTarihi.Value.Month == 1)
                                        .Sum(p => p.BeyanMiktar)
                                        .ToString();
                    LabelSubatTahakkuk.Text =
                        beyanlartahakkuk.Where(p => p.BeyanTarihi.Value.Year == yil && p.BeyanTarihi.Value.Month == 2)
                                        .Sum(p => p.BeyanMiktar)
                                        .ToString();
                    LabelMartTahakkuk.Text =
                        beyanlartahakkuk.Where(p => p.BeyanTarihi.Value.Year == yil && p.BeyanTarihi.Value.Month == 3)
                                        .Sum(p => p.BeyanMiktar)
                                        .ToString();
                    LabelNisanTahakkuk.Text =
                        beyanlartahakkuk.Where(p => p.BeyanTarihi.Value.Year == yil && p.BeyanTarihi.Value.Month == 4)
                                        .Sum(p => p.BeyanMiktar)
                                        .ToString();
                    LabelMayisTahakkuk.Text =
                        beyanlartahakkuk.Where(p => p.BeyanTarihi.Value.Year == yil && p.BeyanTarihi.Value.Month == 5)
                                        .Sum(p => p.BeyanMiktar)
                                        .ToString();
                    LabelHaziranTahakkuk.Text =
                        beyanlartahakkuk.Where(p => p.BeyanTarihi.Value.Year == yil && p.BeyanTarihi.Value.Month == 6)
                                        .Sum(p => p.BeyanMiktar)
                                        .ToString();
                    LabelTemmuzTahakkuk.Text =
                        beyanlartahakkuk.Where(p => p.BeyanTarihi.Value.Year == yil && p.BeyanTarihi.Value.Month == 7)
                                        .Sum(p => p.BeyanMiktar)
                                        .ToString();
                    LabelAgustosTahakkuk.Text =
                        beyanlartahakkuk.Where(p => p.BeyanTarihi.Value.Year == yil && p.BeyanTarihi.Value.Month == 8)
                                        .Sum(p => p.BeyanMiktar)
                                        .ToString();
                    LabelEylulTahakkuk.Text =
                        beyanlartahakkuk.Where(p => p.BeyanTarihi.Value.Year == yil && p.BeyanTarihi.Value.Month == 9)
                                        .Sum(p => p.BeyanMiktar)
                                        .ToString();
                    LabelEkimTahakkuk.Text =
                        beyanlartahakkuk.Where(p => p.BeyanTarihi.Value.Year == yil && p.BeyanTarihi.Value.Month == 10)
                                        .Sum(p => p.BeyanMiktar)
                                        .ToString();
                    LabelKasimTahakkuk.Text =
                        beyanlartahakkuk.Where(p => p.BeyanTarihi.Value.Year == yil && p.BeyanTarihi.Value.Month == 11)
                                        .Sum(p => p.BeyanMiktar)
                                        .ToString();
                    LabelAralikTahakkuk.Text =
                        beyanlartahakkuk.Where(p => p.BeyanTarihi.Value.Year == yil && p.BeyanTarihi.Value.Month == 12)
                                        .Sum(p => p.BeyanMiktar)
                                        .ToString();
                    LabelToplamTahakkuk.Text =
                        beyanlartahakkuk.Where(
                            p =>
                            p.BeyanTarihi.Value.Year == yil ||
                            (p.BeyanTarihi.Value.Year == eskiyil && p.BeyanTarihi.Value.Month == 12))
                                        .Sum(p => p.BeyanMiktar)
                                        .ToString();

                    #endregion

                    #region tahsilat

                    List<BEYAN> beyanlartahsilat = beyanlar;

                    LabelEskiYilAralikTahsilat.Text =
                        beyanlartahsilat.Where(
                            p => p.BeyanTarihi.Value.Year == eskiyil && p.BeyanTarihi.Value.Month == 12)
                                        .Sum(p => p.BeyanMiktar)
                                        .ToString();
                    LabelOcakTahsilat.Text =
                        beyanlartahsilat.Where(p => p.BeyanTarihi.Value.Year == yil && p.BeyanTarihi.Value.Month == 1)
                                        .Sum(p => p.BeyanMiktar)
                                        .ToString();
                    LabelSubatTahsilat.Text =
                        beyanlartahsilat.Where(p => p.BeyanTarihi.Value.Year == yil && p.BeyanTarihi.Value.Month == 2)
                                        .Sum(p => p.BeyanMiktar)
                                        .ToString();
                    LabelMartTahsilat.Text =
                        beyanlartahsilat.Where(p => p.BeyanTarihi.Value.Year == yil && p.BeyanTarihi.Value.Month == 3)
                                        .Sum(p => p.BeyanMiktar)
                                        .ToString();
                    LabelNisanTahsilat.Text =
                        beyanlartahsilat.Where(p => p.BeyanTarihi.Value.Year == yil && p.BeyanTarihi.Value.Month == 4)
                                        .Sum(p => p.BeyanMiktar)
                                        .ToString();
                    LabelMayisTahsilat.Text =
                        beyanlartahsilat.Where(p => p.BeyanTarihi.Value.Year == yil && p.BeyanTarihi.Value.Month == 5)
                                        .Sum(p => p.BeyanMiktar)
                                        .ToString();
                    LabelHaziranTahsilat.Text =
                        beyanlartahsilat.Where(p => p.BeyanTarihi.Value.Year == yil && p.BeyanTarihi.Value.Month == 6)
                                        .Sum(p => p.BeyanMiktar)
                                        .ToString();
                    LabelTemmuzTahsilat.Text =
                        beyanlartahsilat.Where(p => p.BeyanTarihi.Value.Year == yil && p.BeyanTarihi.Value.Month == 7)
                                        .Sum(p => p.BeyanMiktar)
                                        .ToString();
                    LabelAgustosTahsilat.Text =
                        beyanlartahsilat.Where(p => p.BeyanTarihi.Value.Year == yil && p.BeyanTarihi.Value.Month == 8)
                                        .Sum(p => p.BeyanMiktar)
                                        .ToString();
                    LabelEylulTahsilat.Text =
                        beyanlartahsilat.Where(p => p.BeyanTarihi.Value.Year == yil && p.BeyanTarihi.Value.Month == 9)
                                        .Sum(p => p.BeyanMiktar)
                                        .ToString();
                    LabelEkimTahsilat.Text =
                        beyanlartahsilat.Where(p => p.BeyanTarihi.Value.Year == yil && p.BeyanTarihi.Value.Month == 10)
                                        .Sum(p => p.BeyanMiktar)
                                        .ToString();
                    LabelKasimTahsilat.Text =
                        beyanlartahsilat.Where(p => p.BeyanTarihi.Value.Year == yil && p.BeyanTarihi.Value.Month == 11)
                                        .Sum(p => p.BeyanMiktar)
                                        .ToString();
                    LabelAralikTahsilat.Text =
                        beyanlartahsilat.Where(p => p.BeyanTarihi.Value.Year == yil && p.BeyanTarihi.Value.Month == 12)
                                        .Sum(p => p.BeyanMiktar)
                                        .ToString();
                    LabelToplamTahsilat.Text =
                        beyanlartahsilat.Where(
                            p =>
                            p.BeyanTarihi.Value.Year == yil ||
                            (p.BeyanTarihi.Value.Year == eskiyil && p.BeyanTarihi.Value.Month == 12))
                                        .Sum(p => p.BeyanMiktar)
                                        .ToString();

                    #endregion

                    #region bakiye

                    List<BEYAN> beyanlarbakiye = beyanlar;

                    LabelEskiYilAralikBakiye.Text =
                        beyanlarbakiye.Where(p => p.BeyanTarihi.Value.Year == eskiyil && p.BeyanTarihi.Value.Month == 12)
                                      .Sum(p => p.BeyanMiktar)
                                      .ToString();
                    LabelOcakBakiye.Text =
                        beyanlarbakiye.Where(p => p.BeyanTarihi.Value.Year == yil && p.BeyanTarihi.Value.Month == 1)
                                      .Sum(p => p.BeyanMiktar)
                                      .ToString();
                    LabelSubatBakiye.Text =
                        beyanlarbakiye.Where(p => p.BeyanTarihi.Value.Year == yil && p.BeyanTarihi.Value.Month == 2)
                                      .Sum(p => p.BeyanMiktar)
                                      .ToString();
                    LabelMartBakiye.Text =
                        beyanlarbakiye.Where(p => p.BeyanTarihi.Value.Year == yil && p.BeyanTarihi.Value.Month == 3)
                                      .Sum(p => p.BeyanMiktar)
                                      .ToString();
                    LabelNisanBakiye.Text =
                        beyanlarbakiye.Where(p => p.BeyanTarihi.Value.Year == yil && p.BeyanTarihi.Value.Month == 4)
                                      .Sum(p => p.BeyanMiktar)
                                      .ToString();
                    LabelMayisBakiye.Text =
                        beyanlarbakiye.Where(p => p.BeyanTarihi.Value.Year == yil && p.BeyanTarihi.Value.Month == 5)
                                      .Sum(p => p.BeyanMiktar)
                                      .ToString();
                    LabelHaziranBakiye.Text =
                        beyanlarbakiye.Where(p => p.BeyanTarihi.Value.Year == yil && p.BeyanTarihi.Value.Month == 6)
                                      .Sum(p => p.BeyanMiktar)
                                      .ToString();
                    LabelTemmuzBakiye.Text =
                        beyanlarbakiye.Where(p => p.BeyanTarihi.Value.Year == yil && p.BeyanTarihi.Value.Month == 7)
                                      .Sum(p => p.BeyanMiktar)
                                      .ToString();
                    LabelAgustosBakiye.Text =
                        beyanlarbakiye.Where(p => p.BeyanTarihi.Value.Year == yil && p.BeyanTarihi.Value.Month == 8)
                                      .Sum(p => p.BeyanMiktar)
                                      .ToString();
                    LabelEylulBakiye.Text =
                        beyanlarbakiye.Where(p => p.BeyanTarihi.Value.Year == yil && p.BeyanTarihi.Value.Month == 9)
                                      .Sum(p => p.BeyanMiktar)
                                      .ToString();
                    LabelEkimBakiye.Text =
                        beyanlarbakiye.Where(p => p.BeyanTarihi.Value.Year == yil && p.BeyanTarihi.Value.Month == 10)
                                      .Sum(p => p.BeyanMiktar)
                                      .ToString();
                    LabelKasimBakiye.Text =
                        beyanlarbakiye.Where(p => p.BeyanTarihi.Value.Year == yil && p.BeyanTarihi.Value.Month == 11)
                                      .Sum(p => p.BeyanMiktar)
                                      .ToString();
                    LabelAralikBakiye.Text =
                        beyanlarbakiye.Where(p => p.BeyanTarihi.Value.Year == yil && p.BeyanTarihi.Value.Month == 12)
                                      .Sum(p => p.BeyanMiktar)
                                      .ToString();
                    LabelToplamBakiye.Text =
                        beyanlarbakiye.Where(
                            p =>
                            p.BeyanTarihi.Value.Year == yil ||
                            (p.BeyanTarihi.Value.Year == eskiyil && p.BeyanTarihi.Value.Month == 12))
                                      .Sum(p => p.BeyanMiktar)
                                      .ToString();

                    #endregion

                    #endregion
                }
            }
        }

        private void Temizle()
        {
            #region tahakkuk

            LabelEskiYilAralikTahakkuk.Text = string.Empty;
            LabelOcakTahakkuk.Text = string.Empty;
            LabelSubatTahakkuk.Text = string.Empty;
            LabelMartTahakkuk.Text = string.Empty;
            LabelNisanTahakkuk.Text = string.Empty;
            LabelMayisTahakkuk.Text = string.Empty;
            LabelHaziranTahakkuk.Text = string.Empty;
            LabelTemmuzTahakkuk.Text = string.Empty;
            LabelAgustosTahakkuk.Text = string.Empty;
            LabelEylulTahakkuk.Text = string.Empty;
            LabelEkimTahakkuk.Text = string.Empty;
            LabelKasimTahakkuk.Text = string.Empty;
            LabelAralikTahakkuk.Text = string.Empty;
            LabelToplamTahakkuk.Text = string.Empty;

            #endregion

            #region tahsilat

            LabelEskiYilAralikTahsilat.Text = string.Empty;
            LabelOcakTahsilat.Text = string.Empty;
            LabelSubatTahsilat.Text = string.Empty;
            LabelMartTahsilat.Text = string.Empty;
            LabelNisanTahsilat.Text = string.Empty;
            LabelMayisTahsilat.Text = string.Empty;
            LabelHaziranTahsilat.Text = string.Empty;
            LabelTemmuzTahsilat.Text = string.Empty;
            LabelAgustosTahsilat.Text = string.Empty;
            LabelEylulTahsilat.Text = string.Empty;
            LabelEkimTahsilat.Text = string.Empty;
            LabelKasimTahsilat.Text = string.Empty;
            LabelAralikTahsilat.Text = string.Empty;
            LabelToplamTahsilat.Text = string.Empty;

            #endregion

            #region bakiye

            LabelEskiYilAralikBakiye.Text = string.Empty;
            LabelOcakBakiye.Text = string.Empty;
            LabelSubatBakiye.Text = string.Empty;
            LabelMartBakiye.Text = string.Empty;
            LabelNisanBakiye.Text = string.Empty;
            LabelMayisBakiye.Text = string.Empty;
            LabelHaziranBakiye.Text = string.Empty;
            LabelTemmuzBakiye.Text = string.Empty;
            LabelAgustosBakiye.Text = string.Empty;
            LabelEylulBakiye.Text = string.Empty;
            LabelEkimBakiye.Text = string.Empty;
            LabelKasimBakiye.Text = string.Empty;
            LabelAralikBakiye.Text = string.Empty;
            LabelToplamBakiye.Text = string.Empty;

            #endregion
        }

        #endregion
    }
}
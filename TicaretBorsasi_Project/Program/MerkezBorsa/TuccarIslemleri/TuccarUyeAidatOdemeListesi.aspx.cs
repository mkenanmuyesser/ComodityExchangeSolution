using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using TicaretBorsasi_Project.Class.Helper;
using TicaretBorsasi_Project.Data;

namespace TicaretBorsasi_Project.Program.MerkezBorsa.TuccarIslemleri
{
    public partial class TuccarUyeAidatOdemeListesi : Page
    {
        #region Properties

        #endregion

        #region Events

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                SetInitials();
            }
            else
            {
                GridViewUyeAidatOdemeListesi.DataSource = PageHelper.SessionData;
                GridViewUyeAidatOdemeListesi.DataBind();
            }
        }

        protected void ButtonRapor_Click(object sender, EventArgs e)
        {
            GridViewUyeAidatOdemeListesi.DataSource = PageHelper.SessionData;
            GridViewUyeAidatOdemeListesi.DataBind();

            switch (ComboBoxRapor.SelectedIndex)
            {
                case 0:
                    GridViewExporterUyeAidatOdemeListesi.WriteXlsxToResponse("Üye Aidat Ödeme Listesi");
                    break;
                case 1:
                    GridViewExporterUyeAidatOdemeListesi.WritePdfToResponse("Üye Aidat Ödeme Listesi");
                    break;
                default:
                    break;
            }
        }

        protected void ButtonAra_Click(object sender, EventArgs e)
        {
            Ara();
        }

        protected void ButtonTemizle_Click(object sender, EventArgs e)
        {
            Response.Redirect(Request.Url.AbsoluteUri);
        }

        protected void ComboBoxListeTipi_SelectedIndexChanged(object sender, EventArgs e)
        {
            int pListeTipi = Convert.ToInt32(ComboBoxListeTipi.SelectedItem.Value);
            switch (pListeTipi)
            {
                default:
                case 1:
                case 2:
                case 3:
                    GridViewUyeAidatOdemeListesi.Columns["MeslekGrupAdi"].Visible = true;
                    GridViewUyeAidatOdemeListesi.Columns["Yil"].Visible = true;
                    GridViewUyeAidatOdemeListesi.Columns["DereceAdi"].Visible = true;
                    GridViewUyeAidatOdemeListesi.Columns["ToplamAidat"].Visible = true;
                    GridViewUyeAidatOdemeListesi.Columns["Kalan"].Visible = true;

                    GridViewUyeAidatOdemeListesi.Columns["Durum"].Visible = false;
                    GridViewUyeAidatOdemeListesi.Columns["Taksit 1"].Visible = false;
                    GridViewUyeAidatOdemeListesi.Columns["Taksit 2"].Visible = false;
                    break;
                case 4:
                    GridViewUyeAidatOdemeListesi.Columns["MeslekGrupAdi"].Visible = false;
                    GridViewUyeAidatOdemeListesi.Columns["Yil"].Visible = false;
                    GridViewUyeAidatOdemeListesi.Columns["DereceAdi"].Visible = false;
                    GridViewUyeAidatOdemeListesi.Columns["ToplamAidat"].Visible = false;
                    GridViewUyeAidatOdemeListesi.Columns["Kalan"].Visible = false;

                    GridViewUyeAidatOdemeListesi.Columns["Durum"].Visible = true;
                    GridViewUyeAidatOdemeListesi.Columns["Taksit 1"].Visible = true;
                    GridViewUyeAidatOdemeListesi.Columns["Taksit 2"].Visible = true;
                    break;
            }

            Ara();
        }

        #endregion

        #region Methods

        private void SetInitials()
        {
            LabelBaslik.Text = "ÜYE AİDAT VE ÖDEME LİSTESİ";
            PageHelper.SessionData = null;

            DataLoad();
        }

        private void DataLoad()
        {
            var yillar = new List<int>();
            for (int i = DateTime.Now.Year; i >= 1900; i--)
            {
                yillar.Add(i);
            }

            ComboBoxBaslangicAidatYil.DataSource = yillar;
            ComboBoxBaslangicAidatYil.DataBind();
            ComboBoxBaslangicAidatYil.SelectedIndex = 0;

            ComboBoxBitisAidatYil.DataSource = yillar;
            ComboBoxBitisAidatYil.DataBind();
            ComboBoxBitisAidatYil.SelectedIndex = 0;
        }

        private void Ara()
        {
            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                string pSicilNoBaslangic = SpinEditSicilNoBaslangic.Text.Trim();
                string pSicilNoBitis = SpinEditSicilNoBitis.Text.Trim();
                string pMeslekGrupBaslangic = SpinEditBaslangicMeslekGrubu.Text.Trim();
                string pMeslekGrupBitis = SpinEditBitisMeslekGrubu.Text.Trim();
                string pTerkinDurumu = RadioButtonListTerkinSecim.SelectedItem.Value.ToString();
                short pAidatYilBaslangic = Convert.ToInt16(ComboBoxBaslangicAidatYil.SelectedItem.Text);
                short pAidatYilBitis = Convert.ToInt16(ComboBoxBitisAidatYil.SelectedItem.Text);
                int pListeTipi = Convert.ToInt32(ComboBoxListeTipi.SelectedItem.Value);

                var pTaksitAylari =
                    entity.TT_DERECE_CEZA_ORAN.AsNoTracking().Where(p => p.Yil >= pAidatYilBaslangic && p.Yil <= pAidatYilBitis)
                          .Select(p =>
                                  new
                                      {
                                          p.Yil,
                                          p.Taksit1,
                                          p.Taksit2
                                      });

                GridViewUyeAidatOdemeListesi.DataSource = null;

                int counter = 1;
                var sonuc =
                    entity.AIDAT_TAKIP
                          .Include("TUCCAR_SICIL")
                          .Include("TUCCAR_SICIL.TT_MESLEK_GRUP")
                          .Include("TUCCAR_SICIL.TT_DERECE")
                          .Include("TUCCAR_SICIL.TUCCAR_ASKI")
                          .AsNoTracking()
                          .Where(p => p.Yil >= pAidatYilBaslangic && p.Yil <= pAidatYilBitis)
                          .ToList()
                          .Select(p => new
                              {
                                  p.AidatTakipKey,
                                  p.TUCCAR_SICIL.TerkinTarihi,
                                  MeslekGrupKod = p.TUCCAR_SICIL.TT_MESLEK_GRUP.Kod,
                                  Sira = 0,
                                  p.TUCCAR_SICIL.SicilNo,
                                  p.TUCCAR_SICIL.Unvan,
                                  MeslekGrupAdi = p.TUCCAR_SICIL.TT_MESLEK_GRUP.MeslekAdi,
                                  p.Yil,
                                  DereceAdi = p.TUCCAR_SICIL.TT_DERECE.Kod,
                                  ToplamAidat = p.AidatMiktar,
                                  Kalan = p.AidatMiktar.Value - (p.Taksit1OdemeMiktar.Value + p.Taksit2CezaMiktar.Value),
                                  Durum =
                                           p.TUCCAR_SICIL.TerkinTarihi != null
                                               ? "TERKİN"
                                               : (p.TUCCAR_SICIL.TUCCAR_ASKI.Any(x => x.BitisTarihi == null)
                                                      ? "ASKIDA"
                                                      : "FAAL"),
                                  OdemeTarihi1 = p.Taksit1OdemeTarihi,
                                  OdemeYilAy1 =
                                           p.Yil.Value.ToString() + "/" +
                                           (pTaksitAylari.SingleOrDefault(x => x.Yil == p.Yil) == null
                                                ? "?"
                                                : pTaksitAylari.SingleOrDefault(x => x.Yil == p.Yil).Taksit1.ToString()),
                                  OdenenAidat1 = p.Taksit1OdemeMiktar,
                                  OdenenCeza1 = p.Taksit1CezaMiktar,
                                  OdemeTarihi2 = p.Taksit2OdemeTarihi,
                                  OdemeYilAy2 =
                                           p.Yil.Value.ToString() + "/" +
                                           (pTaksitAylari.SingleOrDefault(x => x.Yil == p.Yil) == null
                                                ? "?"
                                                : pTaksitAylari.SingleOrDefault(x => x.Yil == p.Yil).Taksit2.ToString()),
                                  OdenenAidat2 = p.Taksit2OdemeMiktar,
                                  OdenenCeza2 = p.Taksit2CezaMiktar,
                              });

                #region koşullar

                if (!string.IsNullOrEmpty(pSicilNoBaslangic) || !string.IsNullOrEmpty(pSicilNoBitis))
                {
                    if (!string.IsNullOrEmpty(pSicilNoBaslangic) && string.IsNullOrEmpty(pSicilNoBitis))
                    {
                        int baslangic;
                        if (!int.TryParse(pSicilNoBaslangic, out baslangic))
                        {
                            PageHelper.MessageBox(this, "Sicil numara girişi hatalıdır!");
                            return;
                        }

                        for (int i = pSicilNoBaslangic.Length; i < 6; i++)
                        {
                            pSicilNoBaslangic = "0" + pSicilNoBaslangic;
                        }
                        sonuc = sonuc.Where(p => p.SicilNo == pSicilNoBaslangic);
                    }
                    else
                    {
                        int baslangic;
                        int bitis;
                        if (int.TryParse(pSicilNoBaslangic, out baslangic) && int.TryParse(pSicilNoBitis, out bitis))
                        {
                            sonuc =
                                sonuc.Where(
                                    p => Convert.ToInt32(p.SicilNo) >= baslangic && Convert.ToInt32(p.SicilNo) <= bitis);
                        }
                        else
                        {
                            PageHelper.MessageBox(this, "Sicil numara girişi hatalıdır!");
                            return;
                        }
                    }
                }

                if (!string.IsNullOrEmpty(pMeslekGrupBaslangic) || !string.IsNullOrEmpty(pMeslekGrupBitis))
                {
                    if (!string.IsNullOrEmpty(pMeslekGrupBaslangic) && string.IsNullOrEmpty(pMeslekGrupBitis))
                    {
                        int baslangic;
                        if (!int.TryParse(pMeslekGrupBaslangic, out baslangic))
                        {
                            PageHelper.MessageBox(this, "Meslek grup kodu girişi hatalıdır!");
                            return;
                        }

                        sonuc = sonuc.Where(p => p.MeslekGrupKod == pMeslekGrupBaslangic);
                    }
                    else
                    {
                        int baslangic;
                        int bitis;
                        if (int.TryParse(pMeslekGrupBaslangic, out baslangic) &&
                            int.TryParse(pMeslekGrupBitis, out bitis))
                        {
                            sonuc =
                                sonuc.Where(
                                    p =>
                                    Convert.ToInt32(p.MeslekGrupKod) >= baslangic &&
                                    Convert.ToInt32(p.MeslekGrupKod) <= bitis);
                        }
                        else
                        {
                            PageHelper.MessageBox(this, "Meslek grup kodu girişi hatalıdır!");
                            return;
                        }
                    }
                }

                switch (pTerkinDurumu)
                {
                    case "1":
                        sonuc = sonuc.Where(p => p.TerkinTarihi == null);
                        break;
                    case "2":
                        sonuc = sonuc.Where(p => p.TerkinTarihi != null);
                        break;
                }

                switch (pListeTipi)
                {
                    default:
                    case 1:
                        break;
                    case 2:
                        sonuc = sonuc.Where(p => p.Kalan > 0);
                        break;
                    case 3:
                        sonuc = sonuc.Where(p => p.Kalan == 0);
                        break;
                }

                #endregion

                sonuc = sonuc.Select(p => new
                    {
                        p.AidatTakipKey,
                        p.TerkinTarihi,
                        p.MeslekGrupKod,
                        Sira = counter++,
                        p.SicilNo,
                        p.Unvan,
                        p.MeslekGrupAdi,
                        p.Yil,
                        p.DereceAdi,
                        p.ToplamAidat,
                        p.Kalan,
                        p.Durum,
                        p.OdemeTarihi1,
                        p.OdemeYilAy1,
                        p.OdenenAidat1,
                        p.OdenenCeza1,
                        p.OdemeTarihi2,
                        p.OdemeYilAy2,
                        p.OdenenAidat2,
                        p.OdenenCeza2,
                    }).ToList();

                GridViewUyeAidatOdemeListesi.DataSource = sonuc;
                PageHelper.SessionData = GridViewUyeAidatOdemeListesi.DataSource;
                GridViewUyeAidatOdemeListesi.DataBind();
            }
        }

        #endregion
    }
}
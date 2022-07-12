using DevExpress.Web.ASPxGridView;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using TicaretBorsasi_Project.Class.Helper;
using TicaretBorsasi_Project.Data;

namespace TicaretBorsasi_Project.Program.MerkezBorsa.BeyannameTescilIslemleri
{
    public partial class BeyannameBorsaBeyanGelirleriKontrolu : Page
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
                GridViewBeyanGelirKontrol.DataSource = PageHelper.SessionData;
                GridViewBeyanGelirKontrol.DataBind();
            }

        }

        protected void ButtonRapor_Click(object sender, EventArgs e)
        {
            GridViewBeyanGelirKontrol.DataSource = PageHelper.SessionData;
            GridViewBeyanGelirKontrol.DataBind();

            switch (ComboBoxRapor.SelectedIndex)
            {
                case 0:
                    GridViewExporterBeyanGelirKontrol.WriteXlsxToResponse("Beyan Gelirleri Kontrolu");
                    break;
                case 1:
                    GridViewExporterBeyanGelirKontrol.WritePdfToResponse("Beyan Gelirleri Kontrolu");
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

        #endregion

        #region Methods

        private void SetInitials()
        {
            LabelBaslik.Text = "BORSA BEYAN GELİRLERİ KONTROLÜ";
            PageHelper.SessionData = null;

            DateEditBaslangic.Date = new DateTime(DateTime.Now.Year, 01, 01);
            DateEditBitis.Date = DateTime.Now;
        }

        private void Ara()
        {
            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                int pListeNevi = Convert.ToInt32(ComboBoxListeTipi.SelectedItem.Value);
                DateTime pBaslangic = DateEditBaslangic.Date;
                DateTime pBitis = DateEditBitis.Date;

                GridViewBeyanGelirKontrol.DataSource = null;
                var sonuc = entity.BEYANs
                    .Include("TUCCAR_SICIL")
                    .Include("TT_BORSA_SUBE")
                    .AsNoTracking()
                    .ToList().Select(p => new
                    {
                        p.TuccarSicilKey,
                        Sira = 0,
                        SubeKodu = Convert.ToInt32(p.TT_BORSA_SUBE.Kod),
                        Sube = p.TT_BORSA_SUBE.Kod + " - " + p.TT_BORSA_SUBE.BorsaSubeAdi,
                        p.TUCCAR_SICIL.SicilNo,
                        p.TUCCAR_SICIL.Unvan,
                        Tarih = p.BeyanTarihi,
                        p.BeyanKayitTipKey,
                        p.SimsariyeMiktar,
                        p.TescilMiktar,
                        p.BeyanMiktar,
                    }).Where(p => p.Tarih != null && p.Tarih >= pBaslangic && p.Tarih <= pBitis).GroupBy(
                    p => new
                        {
                            p.TuccarSicilKey,
                            p.Sira,
                            p.SubeKodu,
                            p.Sube,
                            p.SicilNo,
                            p.Unvan,
                        }).Select(p => new
                                    {
                                        p.Key.TuccarSicilKey,
                                        p.Key.Sira,
                                        p.Key.SubeKodu,
                                        p.Key.Sube,
                                        p.Key.SicilNo,
                                        p.Key.Unvan,
                                        SatOrgHTop = p.Sum(x => x.SimsariyeMiktar),
                                        TescilTop = p.Sum(x => x.TescilMiktar),
                                        TahakkukMuhTop = 0,
                                    })
                                .Distinct();

                #region koşullar

                //switch (pListeNevi)
                //{
                //    default:
                //    case 1:
                //        sonuc = sonuc.Where(p => p.BeyanKayitTipKey == 1);
                //        break;
                //    case 2:
                //        sonuc = sonuc.Where(p => p.BeyanKayitTipKey == 2);
                //        break;
                //}

                #endregion

                #region sıralama

                switch (ComboBoxSiralaArtanAzalan.SelectedItem.Value.ToString())
                {
                    default:
                    case "1":
                        switch (ComboBoxSirala.SelectedItem.Value.ToString())
                        {
                            default:
                            case "1":
                                sonuc = sonuc.OrderBy(p => p.SicilNo);
                                break;
                            case "2":
                                sonuc = sonuc.OrderBy(p => p.Unvan);
                                break;
                        }
                        break;
                    case "2":
                        switch (ComboBoxSirala.SelectedItem.Value.ToString())
                        {
                            default:
                            case "1":
                                sonuc = sonuc.OrderByDescending(p => p.SicilNo);
                                break;
                            case "2":
                                sonuc = sonuc.OrderByDescending(p => p.Unvan);
                                break;
                        }
                        break;
                }

                sonuc = sonuc.OrderBy(p => Convert.ToInt32(p.SubeKodu));

                #endregion

                #region gruplama

                foreach (GridViewDataColumn item in GridViewBeyanGelirKontrol.GetGroupedColumns())
                {
                    GridViewBeyanGelirKontrol.UnGroup(item);
                }

                GridViewBeyanGelirKontrol.GroupBy(GridViewBeyanGelirKontrol.Columns["Sube"]);

                #endregion

                int counter = 1;
                var data = sonuc.Select(p => new
                                    {
                                        p.TuccarSicilKey,
                                        Sira = counter++,
                                        p.SubeKodu,
                                        p.Sube,
                                        SicilNo = p.SicilNo.TrimStart('0'),
                                        p.Unvan,
                                        p.SatOrgHTop,
                                        p.TescilTop,
                                        p.TahakkukMuhTop,
                                    })
                                .ToList();

                GridViewBeyanGelirKontrol.DataSource = data;
                PageHelper.SessionData = GridViewBeyanGelirKontrol.DataSource;
                GridViewBeyanGelirKontrol.DataBind();

            }
        }

        #endregion
    }
}
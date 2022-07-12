using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using TicaretBorsasi_Project.Class.Helper;
using TicaretBorsasi_Project.Data;

namespace TicaretBorsasi_Project.User_Control.Ortak
{
    public partial class TuccarSicilMemurluguListesiUserControl : System.Web.UI.UserControl
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
                GridViewTicaretSicilMemurluğuListesi.DataSource = PageHelper.SessionData;
                GridViewTicaretSicilMemurluğuListesi.DataBind();
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

        protected void ButtonRapor_Click(object sender, EventArgs e)
        {
            GridViewTicaretSicilMemurluğuListesi.DataSource = PageHelper.SessionData;
            GridViewTicaretSicilMemurluğuListesi.DataBind();

            switch (ComboBoxRapor.SelectedIndex)
            {
                case 0:
                    GridViewExporterTicaretSicilMemurluğuListesi.WriteXlsxToResponse("Ticaret Sicil Memurluğu Listesi");
                    break;
                case 1:
                    GridViewExporterTicaretSicilMemurluğuListesi.WritePdfToResponse("Ticaret Sicil Memurluğu Listesi");
                    break;
                default:
                    break;
            }
        }

        #endregion

        #region Methods

        private void SetInitials()
        {
            LabelBaslik.Text = "TİCARET SİCİL MEMURLUĞU LİSTESİ";
            PageHelper.SessionData = null;

            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                List<TT_SICIL_MEMURLUGU> listSICIL_MEMURLUGU = entity.TT_SICIL_MEMURLUGU.AsNoTracking().ToList();

                listSICIL_MEMURLUGU.Insert(0, new TT_SICIL_MEMURLUGU
                {
                    SicilMemurluguKey = 0,
                    Adi = "TÜMÜ"
                });

                ComboBoxSicilMemurlugu.DataSource = listSICIL_MEMURLUGU;
                ComboBoxSicilMemurlugu.DataBind();

                ComboBoxSicilMemurlugu.SelectedIndex = 0;
            }
        }

        private void Ara()
        {
            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                string pTerkinDurumu = RadioButtonListTerkinSecim.SelectedItem.Value.ToString();
                string pAskiDurumu = RadioButtonListAskiSecim.SelectedItem.Value.ToString();
                int? pTicaretSicilMemurluguKey = ComboBoxSicilMemurlugu.SelectedIndex == -1 ||
                                                 ComboBoxSicilMemurlugu.SelectedIndex == 0
                                                     ? null
                                                     : (int?)Convert.ToInt32(ComboBoxSicilMemurlugu.SelectedItem.Value);

                GridViewTicaretSicilMemurluğuListesi.DataSource = null;

                int counter = 1;
                var sonuc = entity.TUCCAR_SICIL
                    .Include("TUCCAR_ASKI")
                    .AsNoTracking()
                    .ToList().Select(p => new
                    {
                        p.TuccarSicilKey,
                        Sira = counter++,
                        p.SicilNo,
                        p.Unvan,
                        KayitTarihi = p.SicilTarih,
                        KayitNo = p.SicilKayitNo,
                        p.TerkinTarihi,
                        TicaretSicilMemurluguKey = p.SicilMemurluguKey,
                        p.TUCCAR_ASKI
                    });

                #region koşullar

                switch (pTerkinDurumu)
                {
                    case "2":
                        sonuc = sonuc.Where(p => p.TerkinTarihi == null);
                        break;
                    case "3":
                        sonuc = sonuc.Where(p => p.TerkinTarihi != null);
                        break;
                }

                switch (pAskiDurumu)
                {
                    case "2":
                        sonuc =
                            sonuc.Where(
                                p =>
                                p.TUCCAR_ASKI != null && p.TUCCAR_ASKI.Count(x => x.BitisTarihi == null) > 0);
                        break;
                    case "3":
                        IEnumerable<int> askidakiler = sonuc.Where(
                            p =>
                            p.TUCCAR_ASKI != null && p.TUCCAR_ASKI.Count(x => x.BitisTarihi == null) > 0)
                                                            .Select(p => p.TuccarSicilKey);
                        sonuc = sonuc.Where(p => !askidakiler.Contains(p.TuccarSicilKey));
                        break;
                }

                if (pTicaretSicilMemurluguKey != null)
                {
                    sonuc = sonuc.Where(p => p.TicaretSicilMemurluguKey == pTicaretSicilMemurluguKey);
                }

                #endregion

                GridViewTicaretSicilMemurluğuListesi.DataSource = sonuc;
                PageHelper.SessionData = GridViewTicaretSicilMemurluğuListesi.DataSource;
                GridViewTicaretSicilMemurluğuListesi.DataBind();
            }
        }

        #endregion
    }
}
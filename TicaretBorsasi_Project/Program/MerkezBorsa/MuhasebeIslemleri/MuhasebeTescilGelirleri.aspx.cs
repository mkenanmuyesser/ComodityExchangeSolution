using System;
using System.Linq;
using System.Web.UI;
using TicaretBorsasi_Project.Data;

namespace TicaretBorsasi_Project.Program.MerkezBorsa.MuhasebeIslemleri
{
    public partial class MuhasebeTescilGelirleri : Page
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
            //Ara();
            switch (ComboBoxRapor.SelectedIndex)
            {
                case 0:
                    GridViewExporterTescilGelir.WriteXlsxToResponse("Beyanname Tescil Gelirleri");
                    break;
                case 1:
                    GridViewExporterTescilGelir.WritePdfToResponse("Beyanname Tescil Gelirleri");
                    break;
                default:
                    break;
            }
        }

        #endregion

        #region Methods

        private void SetInitials()
        {
            LabelBaslik.Text = "BEYANNAME TESCİL VE SAT. ORG. H. GELİRLERİ";

            DateEditBaslangic.Date = new DateTime(DateTime.Now.Year, 01, 01);
            DateEditBitis.Date = DateTime.Now;
        }

        private void Ara()
        {
            using (var entity = new DBEntities())
            {
                DateTime pBaslangic = DateEditBaslangic.Date;
                DateTime pBitis = DateEditBitis.Date;

                GridViewTescilGelir.DataSource = null;
                var sonuc = entity.BEYANs.Include("TUCCAR_SICIL").Include("TT_BORSA_SUBE").ToList().Select(p => new
                    {
                        p.BeyanKey,
                        SubeKodu = p.TT_BORSA_SUBE.Kod,
                        p.TUCCAR_SICIL.SicilNo,
                        p.TUCCAR_SICIL.Unvan,
                        Tarih = p.BeyanTarihi,
                        p.BeyanNo,
                    });

                #region koşullar

                sonuc = sonuc.Where(p => p.Tarih != null && p.Tarih >= pBaslangic && p.Tarih <= pBitis);

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
                            case "3":
                                sonuc = sonuc.OrderBy(p => p.BeyanNo);
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
                            case "3":
                                sonuc = sonuc.OrderByDescending(p => p.BeyanNo);
                                break;
                        }
                        break;
                }

                #endregion

                GridViewTescilGelir.DataSource = sonuc;
                GridViewTescilGelir.DataBind();

                //GridViewTahakkukBeyanYevmiye.GroupBy(GridViewTahakkukBeyanYevmiye.Columns[0]);
                //GridViewTuccarCariDefteri.ExpandAll();

                //if (sonuc.Count() > 0)
                //{
                //    raporDiv.Visible = true;
                //}
                //else
                //{
                //    raporDiv.Visible = false;
                //}
            }
        }

        #endregion
    }
}
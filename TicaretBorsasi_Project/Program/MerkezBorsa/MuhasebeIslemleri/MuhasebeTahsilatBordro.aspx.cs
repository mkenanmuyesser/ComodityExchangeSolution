using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using TicaretBorsasi_Project.Data;

namespace TicaretBorsasi_Project.Program.MerkezBorsa.MuhasebeIslemleri
{
    public partial class MuhasebeTahsilatBordro : Page
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
                    GridViewExporterTahsilatBordro.WriteXlsxToResponse("Tahsilat Bordrosu");
                    break;
                case 1:
                    GridViewExporterTahsilatBordro.WritePdfToResponse("Tahsilat Bordrosu");
                    break;
                default:
                    break;
            }
        }

        #endregion

        #region Methods

        private void SetInitials()
        {
            LabelBaslik.Text = "TAHSİLAT BORDROSU";

            DateEditBaslangic.Date = new DateTime(DateTime.Now.Year, 01, 01);
            DateEditBitis.Date = DateTime.Now;

            using (var entity = new DBEntities())
            {
                List<TT_MUHASEBE_TIP> listMUHASEBE_TIP = entity.TT_MUHASEBE_TIP.ToList();

                ComboBoxMuhasebeTip.DataSource = listMUHASEBE_TIP;
                ComboBoxMuhasebeTip.DataBind();
            }
        }

        private void Ara()
        {
            using (var entity = new DBEntities())
            {
                int pBordroNo = Convert.ToInt32(TextBoxBordroNo.Text);
                byte pMuhasebeTip = Convert.ToByte(ComboBoxMuhasebeTip.SelectedItem.Value);
                DateTime pBaslangic = DateEditBaslangic.Date;
                DateTime pBitis = DateEditBitis.Date;

                GridViewTahsilatBordro.DataSource = null;
                var sonuc = entity.BEYANs.Include("TUCCAR_SICIL").Include("TT_BORSA_SUBE").ToList().Select(p => new
                    {
                        p.BeyanKey,
                        Sira = 0,
                        SubeKodu = p.TT_BORSA_SUBE.Kod,
                        p.TUCCAR_SICIL.SicilNo,
                        p.TUCCAR_SICIL.Unvan,
                        Tarih = p.BeyanTarihi,
                        p.BeyanNo,
                    });

                #region koşullar

                sonuc = sonuc.Where(p => p.Tarih != null && p.Tarih >= pBaslangic && p.Tarih <= pBitis);

                #endregion

                int counter = 1;
                GridViewTahsilatBordro.DataSource = sonuc.Select(p => new
                    {
                        p.BeyanKey,
                        Sira = counter++,
                        p.SubeKodu,
                        p.SicilNo,
                        p.Unvan,
                        p.BeyanNo,
                    });
                GridViewTahsilatBordro.DataBind();

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
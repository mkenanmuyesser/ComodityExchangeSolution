using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using TicaretBorsasi_Project.Class.Helper;
using TicaretBorsasi_Project.Data;

namespace TicaretBorsasi_Project.Program.MerkezBorsa.BeyannameTescilIslemleri
{
    public partial class BeyannameTahsilatBordro : Page
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
                GridViewTahsilatBordro.DataSource = PageHelper.SessionData;
                GridViewTahsilatBordro.DataBind();
            }
        }

        protected void ButtonRapor_Click(object sender, EventArgs e)
        {
            GridViewTahsilatBordro.DataSource = PageHelper.SessionData;
            GridViewTahsilatBordro.DataBind();

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
            LabelBaslik.Text = "TAHSİLAT BORDROSU";
            PageHelper.SessionData = null;

            DateEditBaslangic.Date = new DateTime(DateTime.Now.Year, 01, 01);
            DateEditBitis.Date = DateTime.Now;

            using (var entity = new DBEntities())
            {
                List<TT_MUHASEBE_TIP> listMUHASEBE_TIP = entity.TT_MUHASEBE_TIP.AsNoTracking().ToList();

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
                var sonuc = entity.HESAP_PLANI.AsNoTracking().ToList().Select(p => new
                    {
                        p.HesapPlaniKey,
                        p.MuhasebeTipKey,
                        Sira = 0,
                        p.HesapKodu,
                        p.HesapAdi,
                        Tutar =
                         (p.AlacakOcak +
                         p.AlacakSubat +
                         p.AlacakMart +
                         p.AlacakNisan +
                         p.AlacakMayis +
                         p.AlacakHaziran +
                         p.AlacakTemmuz +
                         p.AlacakAgustos +
                         p.AlacakEylul +
                         p.AlacakEkim +
                         p.AlacakKasim +
                         p.AlacakAralik +
                         p.Alacak1_ +
                         p.Alacak2_) -
                        (p.BorcOcak +
                         p.BorcSubat +
                         p.BorcMart +
                         p.BorcNisan +
                         p.BorcMayis +
                         p.BorcHaziran +
                         p.BorcTemmuz +
                         p.BorcAgustos +
                         p.BorcEylul +
                         p.BorcEkim +
                         p.BorcKasim +
                         p.BorcAralik +
                         p.Borc1_ +
                         p.Borc2_)
                    });

                #region koşullar

                sonuc = sonuc.Where(p => p.HesapKodu.Length == 10);

                sonuc = sonuc.Where(p => p.MuhasebeTipKey == pMuhasebeTip);

                //sonuc = sonuc.Where(p => p.Tarih != null && p.Tarih >= pBaslangic && p.Tarih <= pBitis);

                #endregion

                int counter = 1;
                sonuc = sonuc.Select(p => new
                   {
                       p.HesapPlaniKey,
                       p.MuhasebeTipKey,
                       Sira = counter++,
                       p.HesapKodu,
                       p.HesapAdi,
                       p.Tutar,
                   });
                GridViewTahsilatBordro.DataSource = sonuc;
                PageHelper.SessionData = GridViewTahsilatBordro.DataSource;
                GridViewTahsilatBordro.DataBind();

            }
        }

        #endregion
    }
}
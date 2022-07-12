using System;
using System.Linq;
using System.Web.UI;
using TicaretBorsasi_Project.Class.Helper;
using TicaretBorsasi_Project.Data;

namespace TicaretBorsasi_Project.Program.MerkezBorsa.TuccarIslemleri
{
    public partial class TuccarSecimListesi : Page
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
                GridViewTuccarSecimListesi.DataSource = PageHelper.SessionData;
                GridViewTuccarSecimListesi.DataBind();
            }
        }

        protected void ButtonRapor_Click(object sender, EventArgs e)
        {
            GridViewTuccarSecimListesi.DataSource = PageHelper.SessionData;
            GridViewTuccarSecimListesi.DataBind();

            switch (ComboBoxRapor.SelectedIndex)
            {
                case 0:
                    GridViewExporterTuccarSecimListesi.WriteXlsxToResponse("Tüccar Seçim Listesi");
                    break;
                case 1:
                    GridViewExporterTuccarSecimListesi.WritePdfToResponse("Tüccar Seçim Listesi");
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
            LabelBaslik.Text = "TÜCCAR SEÇİM LİSTESİ";
            PageHelper.SessionData = null;

            DateEditSecimTarihi.Date = DateTime.Now.Date;
        }

        private void Ara()
        {
            //seçim tarihinin ve dokumtipinin koşulları neler sorulacak
            DateTime pSecimTarihi = DateEditSecimTarihi.Date;
            string pSicilNoBaslangic = SpinEditSicilNoBaslangic.Text.Trim();
            string pSicilNoBitis = SpinEditSicilNoBitis.Text.Trim();
            int pDokumTipi = Convert.ToInt32(ComboBoxDokumTipi.SelectedItem.Value);

            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;
                //int pDokumTipiKey = Convert.ToInt32(ComboBoxDokumTipi.SelectedItem.Value);

                GridViewTuccarSecimListesi.DataSource = null;

                int counter = 1;
                var sonuc = entity.TUCCAR_SICIL
                    .Include("TT_VERGI_DAIRE")
                    .AsNoTracking()
                    .ToList().Select(p => new
                    {
                        p.TuccarSicilKey,
                        Sira = counter++,
                        p.SicilNo,
                        p.Unvan,
                        VergiDairesiAdi = p.TT_VERGI_DAIRE == null ? "" : p.TT_VERGI_DAIRE.VergiDairesiAdi,
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

                switch (pDokumTipi)
                {
                    default:
                    case 1:

                        break;
                    case 2:

                        break;
                }

                #endregion

                GridViewTuccarSecimListesi.DataSource = sonuc;
                PageHelper.SessionData = GridViewTuccarSecimListesi.DataSource;
                GridViewTuccarSecimListesi.DataBind();
            }
        }

        #endregion
    }
}
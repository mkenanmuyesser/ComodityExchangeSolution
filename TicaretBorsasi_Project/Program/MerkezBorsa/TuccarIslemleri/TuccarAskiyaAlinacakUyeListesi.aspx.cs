using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using TicaretBorsasi_Project.Class.Helper;
using TicaretBorsasi_Project.Data;

namespace TicaretBorsasi_Project.Program.MerkezBorsa.TuccarIslemleri
{
    public partial class TuccarAskiyaAlinacakUyeListesi : Page
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
                GridViewAskiUyeArama.DataSource = PageHelper.SessionData;
                GridViewAskiUyeArama.DataBind();
            }
        }

        protected void ButtonRapor_Click(object sender, EventArgs e)
        {
            GridViewAskiUyeArama.DataSource = PageHelper.SessionData;
            GridViewAskiUyeArama.DataBind();

            switch (ComboBoxRapor.SelectedIndex)
            {
                case 0:
                    GridViewExporterAskiUyeArama.WriteXlsxToResponse("Askı Üye Bilgileri");
                    break;
                case 1:
                    GridViewExporterAskiUyeArama.WritePdfToResponse("Askı Üye Bilgileri");
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
            LabelBaslik.Text = "ASKIYA ALINACAK ÜYE LİSTELERİ";
            PageHelper.SessionData = null;

            var listYil = new List<string>();
            for (int i = DateTime.Now.Year; i > 1900; i--)
            {
                listYil.Add(i.ToString());
            }

            ComboBoxYil.DataSource = listYil;
            ComboBoxYil.DataBind();
            ComboBoxYil.SelectedIndex = 0;

            int yil = DateTime.Now.Year;
            DateEditBaslangic.Date = new DateTime(yil, 1, 1);
            DateEditBitis.Date = DateTime.Now;
        }

        private void Ara(bool tumdetay = false)
        {
            short pBeyanYili = Convert.ToInt16(ComboBoxYil.SelectedItem.Value);
            DateTime pBaslangic = DateEditBaslangic.Date;
            DateTime pBitis = DateEditBitis.Date;
            int pListeTipi = Convert.ToInt32(ComboBoxListeTipi.SelectedItem.Value);

            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                GridViewAskiUyeArama.DataSource = null;

                var sonuc =
                    entity.TUCCAR_SICIL.Include("TT_MESLEK_GRUP")
                          .Include("TT_KURULUS_TUR")
                          .Include("TT_VERGI_DAIRE")
                          .Include("TT_DERECE")
                          .Include("TT_IL_ILCE")
                          .Include("FIRMA_SAHIS")
                          .Include("FIRMA_YETKILI")
                          .Include("FIRMA_YONETIM")
                          .Include("FIRMA_TELEFON_FAX")
                          .Include("FIRMA_ADRES")
                          .Include("TUCCAR_ASKI")
                          .AsNoTracking()
                          .ToList()
                          .Select(p => new
                              {
                                  p.TuccarSicilKey,
                                  Sira = 0,
                                  p.SicilNo,
                                  p.Unvan,
                                  Islem1 = "",
                                  Islem2 = "",
                                  Aidat1 = "",
                                  Aidat2 = "",
                              });

                #region koşullar

                //pBeyanYili
                //sonuc = sonuc.Where(p => p. == );

                //pBaslangic ve pBitis
                //sonuc = sonuc.Where(p => p. == );


                switch (pListeTipi)
                {
                    default:
                    case 0:

                        break;
                    case 1:
                        //sonuc = sonuc.Where(p => p. == );
                        break;
                    case 2:
                        //sonuc = sonuc.Where(p => p. == );
                        break;
                    case 3:
                        //sonuc = sonuc.Where(p => p. == );
                        break;
                }

                #endregion

                int counter = 1;
                sonuc = sonuc.Select(p => new
                    {
                        p.TuccarSicilKey,
                        Sira = counter++,
                        p.SicilNo,
                        p.Unvan,
                        Islem1 = "",
                        Islem2 = "",
                        Aidat1 = "",
                        Aidat2 = "",
                    });

                GridViewAskiUyeArama.DataSource = sonuc;
                PageHelper.SessionData = GridViewAskiUyeArama.DataSource;
                GridViewAskiUyeArama.DataBind();
            }

            KolonAyarla(pBeyanYili);
        }

        private void KolonAyarla(int pYil)
        {
            GridViewAskiUyeArama.Columns["Islem1"].Caption = (pYil - 1) + " Yılı";
            GridViewAskiUyeArama.Columns["Aidat1"].Caption = (pYil - 1) + " Yılı";
            GridViewAskiUyeArama.Columns["Islem2"].Caption = pYil + " Yılı";
            GridViewAskiUyeArama.Columns["Aidat2"].Caption = pYil + " Yılı";
        }

        #endregion
    }
}
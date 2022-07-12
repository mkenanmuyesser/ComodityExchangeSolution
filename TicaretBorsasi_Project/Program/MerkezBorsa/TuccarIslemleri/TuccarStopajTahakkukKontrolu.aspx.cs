using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using DevExpress.Web.ASPxGridView;
using TicaretBorsasi_Project.Class.Helper;
using TicaretBorsasi_Project.Data;

namespace TicaretBorsasi_Project.Program.MerkezBorsa.TuccarIslemleri
{
    public partial class TuccarStopajTahakkukKontrolu : Page
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
                GridViewStopajArama.DataSource = PageHelper.SessionData;
                GridViewStopajArama.DataBind();
            }
        }

        protected void ButtonRapor_Click(object sender, EventArgs e)
        {
            GridViewStopajArama.DataSource = PageHelper.SessionData;
            GridViewStopajArama.DataBind();

            switch (ComboBoxRapor.SelectedIndex)
            {
                case 0:
                    GridViewExporterStopajArama.WriteXlsxToResponse("Stopaj Tahakkuk Bilgileri");
                    break;
                case 1:
                    GridViewExporterStopajArama.WritePdfToResponse("Stopaj Tahakkuk Bilgileri");
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
            LabelBaslik.Text = "STOPAJ TAHAKKUK KONTROLÜ";
            PageHelper.SessionData = null;

            var listAy = new List<string>();
            for (int i = 1; i <= 12; i++)
            {
                listAy.Add(i.ToString());
            }

            ComboBoxAy.DataSource = listAy;
            ComboBoxAy.DataBind();
            ComboBoxAy.SelectedIndex = 0;

            var listYil = new List<string>();
            for (int i = DateTime.Now.Year; i > 1900; i--)
            {
                listYil.Add(i.ToString());
            }

            ComboBoxYil.DataSource = listYil;
            ComboBoxYil.DataBind();
            ComboBoxYil.SelectedIndex = 0;

            TextBoxSicilNoBaslangic.Text = "000000";
            TextBoxSicilNoBitis.Text = "999999";
            TextBoxBaslangicVergiDaireKodu.Text = "0000";
            TextBoxBitisVergiDaireKodu.Text = "9999";
        }

        private void Ara()
        {
            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                byte pAy = Convert.ToByte(ComboBoxAy.SelectedItem.Text);
                short pYil = Convert.ToInt16(ComboBoxYil.SelectedItem.Text);
                string pSicilNoBaslangic = TextBoxSicilNoBaslangic.Text.Trim();
                string pSicilNoBitis = TextBoxSicilNoBitis.Text.Trim();
                string pVergiDaireBaslangic = TextBoxBaslangicVergiDaireKodu.Text.Trim();
                string pVergiDaireBitis = TextBoxBitisVergiDaireKodu.Text.Trim();

                GridViewStopajArama.DataSource = null;

                List<BEYAN> beyanlar =
                    entity.BEYANs.Where(
                        p =>
                        p.BeyanTarihi != null && p.BeyanTarihi.Value.Year == pYil && p.BeyanTarihi.Value.Month == pAy)
                          .ToList();
                var sonuc = entity.TUCCAR_SICIL
                    .Include("TT_VERGI_DAIRE")
                    .AsNoTracking()
                    .ToList().Select(p => new
                    {
                        p.TuccarSicilKey,
                        p.VergiDaireKey,
                        VergiDaireAdi = p.TT_VERGI_DAIRE.VergiDairesiAdi,
                        VergiDaireKod = p.TT_VERGI_DAIRE.Kod,
                        Sira = 0,
                        p.SicilNo,
                        p.Unvan,
                        p.VergiNo,
                        EskiVergiNo = p.VergiNoEski,
                        Tahakkuk = beyanlar.Where(x => x.TuccarSicilKey == p.TuccarSicilKey).Sum(x => x.BeyanMiktar),
                        BeyanTahsil =
                                                                                                   beyanlar.Where(
                                                                                                       x =>
                                                                                                       x
                                                                                                           .BeyannameKarsiFirmaTuccarSicilKey ==
                                                                                                       p.TuccarSicilKey)
                                                                                                           .Sum(
                                                                                                               x =>
                                                                                                               x
                                                                                                                   .BeyanMiktar),
                    });

                #region koşullar

                if (!string.IsNullOrEmpty(pVergiDaireBaslangic))
                {
                    sonuc = sonuc.Where(p => Convert.ToInt32(p.VergiDaireKod) >= Convert.ToInt32(pVergiDaireBaslangic));
                }

                if (!string.IsNullOrEmpty(pVergiDaireBitis))
                {
                    sonuc = sonuc.Where(p => Convert.ToInt32(p.VergiDaireKod) <= Convert.ToInt32(pVergiDaireBitis));
                }

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

                #endregion

                #region gruplama

                foreach (GridViewDataColumn item in GridViewStopajArama.GetGroupedColumns())
                {
                    GridViewStopajArama.UnGroup(item);
                }

                GridViewStopajArama.GroupBy(GridViewStopajArama.Columns["VergiDaireAdi"]);

                #endregion

                int counter = 1;
                sonuc = sonuc.Select(p => new
                    {
                        p.TuccarSicilKey,
                        p.VergiDaireKey,
                        p.VergiDaireAdi,
                        p.VergiDaireKod,
                        Sira = counter++,
                        p.SicilNo,
                        p.Unvan,
                        p.VergiNo,
                        p.EskiVergiNo,
                        p.Tahakkuk,
                        p.BeyanTahsil,
                    });

                GridViewStopajArama.DataSource = sonuc;
                PageHelper.SessionData = GridViewStopajArama.DataSource;
                GridViewStopajArama.DataBind();
            }
        }

        #endregion
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using DevExpress.Web.ASPxGridView;
using TicaretBorsasi_Project.Class.Helper;
using TicaretBorsasi_Project.Data;

namespace TicaretBorsasi_Project.Program.MerkezBorsa.TuccarIslemleri
{
    public partial class TuccarVergiDairesiUyeAidatDagilimiListesi : Page
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
                GridViewUyeAidatDagilimiListesi.DataSource = PageHelper.SessionData;
                GridViewUyeAidatDagilimiListesi.DataBind();
            }
        }

        protected void ButtonRapor_Click(object sender, EventArgs e)
        {
            GridViewUyeAidatDagilimiListesi.DataSource = PageHelper.SessionData;
            GridViewUyeAidatDagilimiListesi.DataBind();

            switch (ComboBoxRapor.SelectedIndex)
            {
                case 0:
                    GridViewExporterUyeAidatDagilimiListesi.WriteXlsxToResponse("Vergi Dairesi Üye Aidat Dağılımı");
                    break;
                case 1:
                    GridViewExporterUyeAidatDagilimiListesi.WritePdfToResponse("Vergi Dairesi Üye Aidat Dağılımı");
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
            LabelBaslik.Text = "VERGİ DAİRESİ ÜYE AİDAT DAĞILIMI";
            PageHelper.SessionData = null;

            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                List<TT_VERGI_DAIRE> listVERGI_DAIRE = entity.TT_VERGI_DAIRE.AsNoTracking().OrderBy(p => p.VergiDairesiAdi).ToList();
                listVERGI_DAIRE.Insert(0, new TT_VERGI_DAIRE
                    {
                        VergiDaireKey = 0,
                        VergiDairesiAdi = "TÜMÜ"
                    });

                ComboBoxVergiDairesi.DataSource = listVERGI_DAIRE;
                ComboBoxVergiDairesi.DataBind();
                ComboBoxVergiDairesi.SelectedIndex = 0;
            }
        }

        private void Ara()
        {
            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                int? pVergiDaireKey = ComboBoxVergiDairesi.SelectedIndex == -1 ||
                                      ComboBoxVergiDairesi.SelectedIndex == 0
                                          ? null
                                          : (int?) Convert.ToInt32(ComboBoxVergiDairesi.SelectedItem.Value);
                string pTerkinDurumu = RadioButtonListTerkinSecim.SelectedItem.Value.ToString();

                GridViewUyeAidatDagilimiListesi.DataSource = null;
                var sonuc = entity.TUCCAR_SICIL
                    .Include("TT_VERGI_DAIRE")
                    .AsNoTracking()
                    .ToList().Select(p => new
                    {
                        p.TuccarSicilKey,
                        p.VergiDaireKey,
                        p.TerkinTarihi,
                        Sira = 0,
                        p.SicilNo,
                        p.Unvan,
                        VergiDaireAdi = p.TT_VERGI_DAIRE == null ? null : p.TT_VERGI_DAIRE.VergiDairesiAdi,
                        p.VergiNo,
                    });

                #region koşullar

                if (pVergiDaireKey != null)
                {
                    sonuc = sonuc.Where(p => p.VergiDaireKey == pVergiDaireKey);
                }

                switch (pTerkinDurumu)
                {
                    case "2":
                        sonuc = sonuc.Where(p => p.TerkinTarihi == null);
                        break;
                    case "3":
                        sonuc = sonuc.Where(p => p.TerkinTarihi != null);
                        break;
                }

                #endregion

                #region gruplama

                foreach (GridViewDataColumn item in GridViewUyeAidatDagilimiListesi.GetGroupedColumns())
                {
                    GridViewUyeAidatDagilimiListesi.UnGroup(item);
                }

                switch (ComboBoxGrup.SelectedItem.Value.ToString())
                {
                    case "1":
                        GridViewUyeAidatDagilimiListesi.GroupBy(GridViewUyeAidatDagilimiListesi.Columns["VergiDaireAdi"]);
                        break;
                }

                #endregion

                int counter = 1;
                sonuc = sonuc.Select(p => new
                    {
                        p.TuccarSicilKey,
                        p.VergiDaireKey,
                        p.TerkinTarihi,
                        Sira = counter++,
                        p.SicilNo,
                        p.Unvan,
                        p.VergiDaireAdi,
                        p.VergiNo,
                    });

                GridViewUyeAidatDagilimiListesi.DataSource = sonuc;
                PageHelper.SessionData = GridViewUyeAidatDagilimiListesi.DataSource;
                GridViewUyeAidatDagilimiListesi.DataBind();
            }
        }

        #endregion
    }
}
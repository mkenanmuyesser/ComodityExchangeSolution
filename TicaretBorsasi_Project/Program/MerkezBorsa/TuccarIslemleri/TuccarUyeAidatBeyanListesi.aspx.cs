using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using TicaretBorsasi_Project.Class.CustomType;
using TicaretBorsasi_Project.Class.CustomType.MerkezBorsa;
using TicaretBorsasi_Project.Data;

namespace TicaretBorsasi_Project.Program.MerkezBorsa.TuccarIslemleri
{
    public partial class TuccarUyeAidatBeyanListesi : Page
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

            Ara();
        }


        protected void ComboBoxAidatYili_SelectedIndexChanged(object sender, EventArgs e)
        {
            Ara();
        }

        protected void ButtonRapor_Click(object sender, EventArgs e)
        {
            switch (ComboBoxRapor.SelectedIndex)
            {
                case 0:
                    GridViewExporterUyeAidatBeyanListesi.WriteXlsxToResponse("Üye Aidat Beyan Listesi");
                    break;
                case 1:
                    GridViewExporterUyeAidatBeyanListesi.WritePdfToResponse("Üye Aidat Beyan Listesi");
                    break;
                default:
                    break;
            }
        }

        #endregion

        #region Methods

        private void SetInitials()
        {
            LabelBaslik.Text = "ÜYE AİDAT BEYAN LİSTESİ";

            var listYil = new List<string>();
            for (int i = DateTime.Now.Year; i > 1900; i--)
            {
                listYil.Add(i.ToString());
            }

            ComboBoxAidatYili.DataSource = listYil;
            ComboBoxAidatYili.DataBind();
            ComboBoxAidatYili.SelectedIndex = 0;
        }

        private void Ara()
        {
            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                short pAidatYili = Convert.ToInt16(ComboBoxAidatYili.SelectedItem.Value);

                List<UyeAidatBeyanType> sonucAidatBeyanListe = entity.Database.SqlQuery(typeof(UyeAidatBeyanType),
                                                                                        "select D.Kod,COUNT(AIT.TuccarSicilKey) as UyeAdet,SUM(AIT.AidatMiktar/2) as Taksit1,SUM(AIT.AidatMiktar/2) as Taksit2,SUM(AIT.AidatMiktar) as Yekun " +
                                                                                        " from MERKEZ_BORSA.AIDAT_TAKIP as AIT " +
                                                                                        " inner join MERKEZ_BORSA.TUCCAR_SICIL as TS " +
                                                                                        " on AIT.TuccarSicilKey=TS.TuccarSicilKey " +
                                                                                        " inner join MERKEZ_BORSA.TT_DERECE as D " +
                                                                                        " on AIT.DereceKey=D.DereceKey " +
                                                                                        " where AIT.Yil = " +
                                                                                        pAidatYili.ToString() +
                                                                                        " group by D.Kod " +
                                                                                        " order by D.Kod ",
                                                                                        new object[] { }
                    ).Cast<UyeAidatBeyanType>().ToList();

                GridViewUyeAidatBeyanListesi.DataSource = sonucAidatBeyanListe;
                GridViewUyeAidatBeyanListesi.DataBind();
            }
        }

        #endregion
    }
}
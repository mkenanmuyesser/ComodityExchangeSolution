using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web.UI;
using TicaretBorsasi_Project.Class.CustomType;
using TicaretBorsasi_Project.Class.CustomType.MerkezBorsa;
using TicaretBorsasi_Project.Class.Query;
using TicaretBorsasi_Project.Data;

namespace TicaretBorsasi_Project.Program.MerkezBorsa.TuccarIslemleri
{
    public partial class TuccarUyeDagilimlari : Page
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

        protected void ButtonRapor_Click(object sender, EventArgs e)
        {
            switch (ComboBoxRapor.SelectedIndex)
            {
                case 0:
                    GridViewExporterUyeDagilim.WriteXlsxToResponse("Üye Dağılım Bilgileri");
                    break;
                case 1:
                    GridViewExporterUyeDagilim.WritePdfToResponse("Üye Dağılım  Bilgileri");
                    break;
                default:
                    break;
            }
        }

        protected void ComboBoxGrup_SelectedIndexChanged(object sender, EventArgs e)
        {
            Ara();
        }

        protected void RadioButtonList_SelectedIndexChanged(object sender, EventArgs e)
        {
            Ara();
        }

        #endregion

        #region Methods

        private void SetInitials()
        {
            LabelBaslik.Text = "ÜYE DAĞILIMLARI";
        }

        private void Ara()
        {
            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                GridViewUyeDagilim.DataSource = null;

                GridViewUyeDagilim.Columns["GercekUye1"].Caption = "Gerçek Kişi";
                GridViewUyeDagilim.Columns["TuzelUye1"].Caption = "Tüzel Kişi";

                switch (ComboBoxGrup.SelectedItem.Value.ToString())
                {
                    case "1":
                        List<UyeDagilimType> sonucVergiDaire = entity.Database.SqlQuery(typeof(UyeDagilimType), TuccarUyeDagilimQuery.VergiDaireQuery, new object[] { }).Cast<UyeDagilimType>().ToList();

                        GridViewUyeDagilim.DataSource = sonucVergiDaire;

                        GridViewUyeDagilim.Columns["Kod"].Visible = true;
                        GridViewUyeDagilim.Columns["Terkin"].Visible = false;
                        GridViewUyeDagilim.Columns["Faal"].Visible = false;
                        GridViewUyeDagilim.Columns["GercekUye1"].Visible = true;
                        GridViewUyeDagilim.Columns["GercekUye2"].Visible = false;
                        GridViewUyeDagilim.Columns["Toplam1"].Visible = false;
                        GridViewUyeDagilim.Columns["TuzelUye1"].Visible = true;
                        GridViewUyeDagilim.Columns["TuzelUye2"].Visible = false;
                        GridViewUyeDagilim.Columns["Toplam2"].Visible = true;

                        break;
                    case "2":
                        List<UyeDagilimType> sonucKurulusTur = entity.Database.SqlQuery(typeof(UyeDagilimType), TuccarUyeDagilimQuery.KurulusTurQuery, new object[] { }).Cast<UyeDagilimType>().ToList();

                        GridViewUyeDagilim.DataSource = sonucKurulusTur;

                        GridViewUyeDagilim.Columns["Kod"].Visible = true;
                        GridViewUyeDagilim.Columns["Terkin"].Visible = true;
                        GridViewUyeDagilim.Columns["Faal"].Visible = true;
                        GridViewUyeDagilim.Columns["GercekUye1"].Visible = false;
                        GridViewUyeDagilim.Columns["GercekUye2"].Visible = false;
                        GridViewUyeDagilim.Columns["Toplam1"].Visible = false;
                        GridViewUyeDagilim.Columns["TuzelUye1"].Visible = false;
                        GridViewUyeDagilim.Columns["TuzelUye2"].Visible = false;
                        GridViewUyeDagilim.Columns["Toplam2"].Visible = true;

                        break;
                    case "3":
                        List<UyeDagilimType> sonucMeslekGrup = entity.Database.SqlQuery(typeof(UyeDagilimType), TuccarUyeDagilimQuery.MeslekGrupQuery, new object[] { }).Cast<UyeDagilimType>().ToList();

                        GridViewUyeDagilim.DataSource = sonucMeslekGrup;

                        GridViewUyeDagilim.Columns["Kod"].Visible = true;
                        GridViewUyeDagilim.Columns["Terkin"].Visible = false;
                        GridViewUyeDagilim.Columns["Faal"].Visible = false;
                        GridViewUyeDagilim.Columns["GercekUye1"].Visible = true;
                        GridViewUyeDagilim.Columns["GercekUye2"].Visible = false;
                        GridViewUyeDagilim.Columns["Toplam1"].Visible = false;
                        GridViewUyeDagilim.Columns["TuzelUye1"].Visible = true;
                        GridViewUyeDagilim.Columns["TuzelUye2"].Visible = false;
                        GridViewUyeDagilim.Columns["Toplam2"].Visible = true;

                        break;
                    case "4":
                        List<UyeDagilimType> sonucDereceGrup = entity.Database.SqlQuery(typeof(UyeDagilimType), TuccarUyeDagilimQuery.DereceGrupQuery, new object[] { }).Cast<UyeDagilimType>().ToList();

                        GridViewUyeDagilim.DataSource = sonucDereceGrup;

                        GridViewUyeDagilim.Columns["Kod"].Visible = false;
                        GridViewUyeDagilim.Columns["Terkin"].Visible = false;
                        GridViewUyeDagilim.Columns["Faal"].Visible = false;
                        GridViewUyeDagilim.Columns["GercekUye1"].Visible = true;
                        GridViewUyeDagilim.Columns["GercekUye2"].Visible = true;
                        GridViewUyeDagilim.Columns["Toplam1"].Visible = true;
                        GridViewUyeDagilim.Columns["TuzelUye1"].Visible = true;
                        GridViewUyeDagilim.Columns["TuzelUye2"].Visible = true;
                        GridViewUyeDagilim.Columns["Toplam2"].Visible = true;

                        GridViewUyeDagilim.Columns["GercekUye1"].Caption = "Gerçek Üye";
                        GridViewUyeDagilim.Columns["TuzelUye1"].Caption = "Tüzel Üye";

                        break;
                    case "5":
                        List<UyeDagilimType> sonucIlIlceGrup = entity.Database.SqlQuery(typeof(UyeDagilimType), TuccarUyeDagilimQuery.IlIlceGrupQuery, new object[] { }).Cast<UyeDagilimType>().ToList();

                        GridViewUyeDagilim.DataSource = sonucIlIlceGrup;

                        GridViewUyeDagilim.Columns["Kod"].Visible = true;
                        GridViewUyeDagilim.Columns["Terkin"].Visible = false;
                        GridViewUyeDagilim.Columns["Faal"].Visible = false;
                        GridViewUyeDagilim.Columns["GercekUye1"].Visible = true;
                        GridViewUyeDagilim.Columns["GercekUye2"].Visible = false;
                        GridViewUyeDagilim.Columns["Toplam1"].Visible = false;
                        GridViewUyeDagilim.Columns["TuzelUye1"].Visible = true;
                        GridViewUyeDagilim.Columns["TuzelUye2"].Visible = false;
                        GridViewUyeDagilim.Columns["Toplam2"].Visible = true;

                        break;
                }

                GridViewUyeDagilim.DataBind();
            }
        }

        #endregion

    }
}
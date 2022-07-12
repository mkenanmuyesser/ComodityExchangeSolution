using DevExpress.DataAccess.Sql;
using System;
using System.Web.UI;
using TicaretBorsasi_Project.Report.MerkezBorsa;

namespace TicaretBorsasi_Project.Program.MerkezBorsa.MuhasebeIslemleri
{
    public partial class RaporMuhasebeIslemleri : Page
    {
        #region Properties

        private string Rapor
        {
            get
            {
                string rapor = Request.QueryString["Rapor"];
                return rapor;
            }
        }

        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            switch (Rapor)
            {
                case "YevmiyeDefteri":
                    var _YevmiyeDefteri = new YevmiyeDefteri();

                    if (!IsPostBack)
                    {
                        _YevmiyeDefteri.Parameters["MuhasebeTipKey"].Value = 1;
                        _YevmiyeDefteri.Parameters["Yil"].Value = DateTime.Now.Year;
                        _YevmiyeDefteri.Parameters["Baslangic"].Value = new DateTime(DateTime.Now.Year, 01, 01);
                        _YevmiyeDefteri.Parameters["Bitis"].Value = new DateTime(DateTime.Now.Year, 12, 31);
                    }

                    _YevmiyeDefteri.DisplayName = "Yevmiye Defteri";
                    DocumentViewerRapor.Report = _YevmiyeDefteri;
                    _YevmiyeDefteri.DataSourceDemanded += _YevmiyeDefteri_DataSourceDemanded;
                    break;
            }
        }

        void _YevmiyeDefteri_DataSourceDemanded(object sender, EventArgs e)
        {
            YevmiyeDefteri _YevmiyeDefteri = (sender as YevmiyeDefteri);
            var yazilacakparametreler = (_YevmiyeDefteri.DataSource as SqlDataSource).Queries[0].Parameters;
            var okunacakparametreler = _YevmiyeDefteri.Parameters;
            yazilacakparametreler[0].Value = okunacakparametreler[0].Value;
            yazilacakparametreler[1].Value = okunacakparametreler[1].Value;
            yazilacakparametreler[2].Value = okunacakparametreler[2].Value;
            yazilacakparametreler[3].Value = okunacakparametreler[3].Value;
        }
    }
}
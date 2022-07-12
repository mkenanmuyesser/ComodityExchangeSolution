using DevExpress.DataAccess.Sql;
using DevExpress.XtraReports.Parameters;
using System;
using System.Web.UI;
using TicaretBorsasi_Project.Class.CustomType;
using TicaretBorsasi_Project.Report.MerkezBorsa;

namespace TicaretBorsasi_Project.Program.MerkezBorsa.BeyannameTescilIslemleri
{
    public partial class RaporBeyannameTescilIslemleri : Page
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
                case "Istatistik":
                    var _Istatistik = new Istatistik();                   
                    
                    if (!IsPostBack)
                    {
                        _Istatistik.Parameters["BaslangicTarihi"].Value = new DateTime(DateTime.Now.Year, 01, 01);
                        _Istatistik.Parameters["BitisTarihi"].Value = new DateTime(DateTime.Now.Year, 01, 31);
                        _Istatistik.Parameters["BaslangicSubeKodu"].Value = "01";
                        _Istatistik.Parameters["BitisSubeKodu"].Value = "99";
                        _Istatistik.Parameters["BaslangicMaddeKodu"].Value = "010000";
                        _Istatistik.Parameters["BitisMaddeKodu"].Value = "999999";
                        _Istatistik.Parameters["SatisSekli"].Value = "Tümü";
                    }

                    _Istatistik.DisplayName = "Istatistik";
                    DocumentViewerRapor.Report = _Istatistik;
                    _Istatistik.DataSourceDemanded += _Istatistik_DataSourceDemanded;
                    break;
                case "IstatistikFoyu":
                    var _IstatistikFoyu = new IstatistikFoyu();

                    if (!IsPostBack)
                    {
                        _IstatistikFoyu.Parameters["BaslangicTarihi"].Value = new DateTime(DateTime.Now.Year, 01, 01);
                        _IstatistikFoyu.Parameters["BitisTarihi"].Value = new DateTime(DateTime.Now.Year, 01, 31);
                        _IstatistikFoyu.Parameters["MaddeKodu"].Value = "010000";
                        _IstatistikFoyu.Parameters["BaslangicSubeKod"].Value = "01";
                        _IstatistikFoyu.Parameters["BitisSubeKod"].Value = "99";
                    }

                    _IstatistikFoyu.DisplayName = "IstatistikFoyu";
                    DocumentViewerRapor.Report = _IstatistikFoyu;
                    _IstatistikFoyu.DataSourceDemanded += _IstatistikFoyu_DataSourceDemanded;
                    break;
                case "EnFazlaIslemGorenler":
                    var _EnFazlaIslemGorenler = new EnFazlaIslemGorenler();

                    if (!IsPostBack)
                    {
                        _EnFazlaIslemGorenler.Parameters["Baslangic"].Value = new DateTime(DateTime.Now.Year, 01, 01);
                        _EnFazlaIslemGorenler.Parameters["Bitis"].Value = DateTime.Today;
                        _EnFazlaIslemGorenler.Parameters["BaslangicSubeKod"].Value = "01";
                        _EnFazlaIslemGorenler.Parameters["BitisSubeKod"].Value = "99";
                        _EnFazlaIslemGorenler.Parameters["Cek"].Value = 5;
                    }

                    _EnFazlaIslemGorenler.DisplayName = "EnFazlaIslemGorenler";
                    DocumentViewerRapor.Report = _EnFazlaIslemGorenler;
                    _EnFazlaIslemGorenler.DataSourceDemanded += _EnFazlaIslemGorenler_DataSourceDemanded;
                    break;
                case "TescilDefteriBeyanSirali":
                    var _TescilDefteriBeyanSirali = new TescilDefteriBeyanSirali();

                    if (!IsPostBack)
                    {
                        _TescilDefteriBeyanSirali.Parameters["BaslangicTarihi"].Value = new DateTime(DateTime.Now.Year, 01, 01);
                        _TescilDefteriBeyanSirali.Parameters["BitisTarihi"].Value = new DateTime(DateTime.Now.Year, 01, 31);
                        _TescilDefteriBeyanSirali.Parameters["BaslangicSubeKodu"].Value = "01";
                        _TescilDefteriBeyanSirali.Parameters["BitisSubeKodu"].Value = "99";
                    }

                    _TescilDefteriBeyanSirali.DisplayName = "TescilDefteriBeyanSirali";
                    DocumentViewerRapor.Report = _TescilDefteriBeyanSirali;
                    _TescilDefteriBeyanSirali.DataSourceDemanded += _TescilDefteriBeyanSirali_DataSourceDemanded;
                    break;
                case "TescilDefteriFatMusNolu":
                    var _TescilDefteriFatMusNolu = new TescilDefteriFatMusNolu();

                    if (!IsPostBack)
                    {
                        _TescilDefteriFatMusNolu.Parameters["BaslangicTarihi"].Value = new DateTime(DateTime.Now.Year, 01, 01);
                        _TescilDefteriFatMusNolu.Parameters["BitisTarihi"].Value = new DateTime(DateTime.Now.Year, 01, 31);
                        _TescilDefteriFatMusNolu.Parameters["BaslangicSubeKodu"].Value = "01";
                        _TescilDefteriFatMusNolu.Parameters["BitisSubeKodu"].Value = "99";
                    }

                    _TescilDefteriFatMusNolu.DisplayName = "TescilDefteriFatMusNolu";
                    DocumentViewerRapor.Report = _TescilDefteriFatMusNolu;
                    _TescilDefteriFatMusNolu.DataSourceDemanded += _TescilDefteriFatMusNolu_DataSourceDemanded;
                    break;
                case "IhracaatBeyannamesi":
                    var _IhracaatBeyannamesi = new IhracaatBeyannamesi();

                    if (!IsPostBack)
                    {
                        _IhracaatBeyannamesi.Parameters["BaslangicTarihi"].Value = new DateTime(DateTime.Now.Year, 01, 01);
                        _IhracaatBeyannamesi.Parameters["BitisTarihi"].Value = new DateTime(DateTime.Now.Year, 01, 31);
                        _IhracaatBeyannamesi.Parameters["BaslangicSubeKodu"].Value = "01";
                        _IhracaatBeyannamesi.Parameters["BitisSubeKodu"].Value = "99";
                    }

                    _IhracaatBeyannamesi.DisplayName = "IhracaatBeyannamesi";
                    DocumentViewerRapor.Report = _IhracaatBeyannamesi;
                    _IhracaatBeyannamesi.DataSourceDemanded += _IhracaatBeyannamesi_DataSourceDemanded;
                    break;
            }
        }

        void _Istatistik_DataSourceDemanded(object sender, EventArgs e)
        {
            Istatistik _Istatistik = (sender as Istatistik);
            var yazilacakparametreler = (_Istatistik.DataSource as SqlDataSource).Queries[0].Parameters;
            var okunacakparametreler = _Istatistik.Parameters;
            yazilacakparametreler[0].Value = okunacakparametreler[0].Value;
            yazilacakparametreler[1].Value = okunacakparametreler[1].Value;
            yazilacakparametreler[2].Value = okunacakparametreler[2].Value;
            yazilacakparametreler[3].Value = okunacakparametreler[3].Value;
            yazilacakparametreler[4].Value = okunacakparametreler[4].Value;
            yazilacakparametreler[5].Value = okunacakparametreler[5].Value;
            yazilacakparametreler[6].Value = okunacakparametreler[6].Value;
        }

        void _IstatistikFoyu_DataSourceDemanded(object sender, EventArgs e)
        {
            IstatistikFoyu _IstatistikFoyu = (sender as IstatistikFoyu);
            var yazilacakparametreler = (_IstatistikFoyu.DataSource as SqlDataSource).Queries[0].Parameters;
            var okunacakparametreler = _IstatistikFoyu.Parameters;

            yazilacakparametreler[0].Value = okunacakparametreler[0].Value;
            yazilacakparametreler[1].Value = okunacakparametreler[1].Value;
            string maddekodu = okunacakparametreler[2].Value.ToString();
            yazilacakparametreler[2].Value = maddekodu;
            yazilacakparametreler[3].Value = maddekodu.Substring(2, 4) == "0000" ? maddekodu.Substring(0, 2) : (maddekodu.Substring(4, 2) == "00" ? maddekodu.Substring(0, 4) : maddekodu);
            yazilacakparametreler[4].Value = okunacakparametreler[3].Value;
            yazilacakparametreler[5].Value = okunacakparametreler[4].Value;
            }

        void _EnFazlaIslemGorenler_DataSourceDemanded(object sender, EventArgs e)
        {
            EnFazlaIslemGorenler _EnFazlaIslemGorenler = (sender as EnFazlaIslemGorenler);
            var yazilacakparametreler = (_EnFazlaIslemGorenler.DataSource as SqlDataSource).Queries[0].Parameters;
            var okunacakparametreler = _EnFazlaIslemGorenler.Parameters;

            yazilacakparametreler[0].Value = okunacakparametreler[0].Value;
            yazilacakparametreler[1].Value = okunacakparametreler[1].Value;
            yazilacakparametreler[2].Value = okunacakparametreler[2].Value;
            yazilacakparametreler[3].Value = okunacakparametreler[3].Value;
            yazilacakparametreler[4].Value = okunacakparametreler[4].Value;

        }

        void _IhracaatBeyannamesi_DataSourceDemanded(object sender, EventArgs e)
        {
            IhracaatBeyannamesi _IhracaatBeyannamesi = (sender as IhracaatBeyannamesi);
            var yazilacakparametreler = (_IhracaatBeyannamesi.DataSource as SqlDataSource).Queries[0].Parameters;
            var okunacakparametreler = _IhracaatBeyannamesi.Parameters;

            yazilacakparametreler[0].Value = okunacakparametreler[0].Value;
            yazilacakparametreler[1].Value = okunacakparametreler[1].Value;
            yazilacakparametreler[2].Value = okunacakparametreler[2].Value;
            yazilacakparametreler[3].Value = okunacakparametreler[3].Value;

        }

        void _TescilDefteriBeyanSirali_DataSourceDemanded(object sender, EventArgs e)
        {
            TescilDefteriBeyanSirali _TescilDefteriBeyanSirali = (sender as TescilDefteriBeyanSirali);
            var yazilacakparametreler = (_TescilDefteriBeyanSirali.DataSource as SqlDataSource).Queries[0].Parameters;
            var okunacakparametreler = _TescilDefteriBeyanSirali.Parameters;

            yazilacakparametreler[0].Value = okunacakparametreler[0].Value;
            yazilacakparametreler[1].Value = okunacakparametreler[1].Value;
            yazilacakparametreler[2].Value = okunacakparametreler[2].Value;
            yazilacakparametreler[3].Value = okunacakparametreler[3].Value;

        }

        void _TescilDefteriFatMusNolu_DataSourceDemanded(object sender, EventArgs e)
        {
            TescilDefteriFatMusNolu _TescilDefteriFatMusNolu = (sender as TescilDefteriFatMusNolu);
            var yazilacakparametreler = (_TescilDefteriFatMusNolu.DataSource as SqlDataSource).Queries[0].Parameters;
            var okunacakparametreler = _TescilDefteriFatMusNolu.Parameters;

            yazilacakparametreler[0].Value = okunacakparametreler[0].Value;
            yazilacakparametreler[1].Value = okunacakparametreler[1].Value;
            yazilacakparametreler[2].Value = okunacakparametreler[2].Value;
            yazilacakparametreler[3].Value = okunacakparametreler[3].Value;

        }

    }
}
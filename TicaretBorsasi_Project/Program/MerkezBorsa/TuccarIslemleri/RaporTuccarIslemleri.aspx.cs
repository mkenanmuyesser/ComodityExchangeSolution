using System;
using System.Web.UI;
using TicaretBorsasi_Project.Report.MerkezBorsa;

namespace TicaretBorsasi_Project.Program.MerkezBorsa.TuccarIslemleri
{
    public partial class RaporTuccarIslemleri : Page
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

        #region Events

        protected void Page_Load(object sender, EventArgs e)
        {
            switch (Rapor)
            {
                case "FaaliyetBelgeleri":
                    var _FaaliyetBelgeleri = new FaaliyetBelgeleri();
                    _FaaliyetBelgeleri.DisplayName = "FaaliyetBelgeleri";
                    DocumentViewerRapor.Report = _FaaliyetBelgeleri;
                    break;
            }
        }

        #endregion

    }
}
using System;
using System.Drawing.Printing;
using System.Web.UI;
using DevExpress.XtraReports.UI;
using TicaretBorsasi_Project.Report.MerkezBorsa;

namespace TicaretBorsasi_Project.Program.MerkezBorsa.TuccarIslemleri.PopUp
{
    public partial class RaporPopUp : Page
    {
        #region Properties

        private string Key
        {
            get
            {
                object keylist = Session["KeyList"];
                string keyler = "";
                if (keylist != null)
                {
                    keyler = keylist.ToString();
                }
                return keyler;
            }
        }

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
                case "AdresEtiketleri":
                    var _AdresEtiketleri = new AdresEtiketleri();
                    _AdresEtiketleri.DisplayName = "AdresEtiketleri";
                    _AdresEtiketleri.BeforePrint += report_BeforePrint;
                    DocumentViewerRapor.Report = _AdresEtiketleri;
                    break;
                default:

                    break;
            }
        }

        private void report_BeforePrint(object sender, PrintEventArgs e)
        {
            (sender as XtraReport).FilterString = "[TuccarSicilKey] In (" + Key + ")";
        }

        #endregion
    }
}
using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Utils;
using DevExpress.Web.ASPxNavBar;
using DevExpress.Web.ASPxPopupControl;

namespace TicaretBorsasi_Project.Master_Page
{
    public partial class MainMaster : MasterPage
    {
        private const string SideMenuMerkezBorsaBeyannameTescilIslemleri = "~/Data/MerkezBorsa/SideMenuBeyannameTescilIslemleri.xml";
        private const string SideMenuMerkezBorsaMuhasebeIslemleri = "~/Data/MerkezBorsa/SideMenuMuhasebeIslemleri.xml";
        private const string SideMenuMerkezBorsaBordroIslemleri = "~/Data/MerkezBorsa/SideMenuBordroIslemleri.xml";
        private const string SideMenuMerkezBorsaMuhtelifIslemler = "~/Data/MerkezBorsa/SideMenuMuhtelifIslemler.xml";
        private const string SideMenuMerkezBorsaParametreKodluBilgiIslemleri = "~/Data/MerkezBorsa/SideMenuParametreKodluBilgiIslemleri.xml";
        private const string SideMenuMerkezBorsaTuccarIslemleri = "~/Data/MerkezBorsa/SideMenuTuccarIslemleri.xml";

        private const string SideMenuSalonSatisLabSatisListeler = "~/Data/SalonSatis/SideMenuLabSatisListeler.xml";
        private const string SideMenuSalonSatisMuhtelifIslemler = "~/Data/SalonSatis/SideMenuMuhtelifIslemler.xml";
        private const string SideMenuSalonSatisParametreKodluBilgiIslemleri = "~/Data/SalonSatis/SideMenuParametreKodluBilgiIslemleri.xml";
        private const string SideMenuSalonSatisSatisIslemleri = "~/Data/SalonSatis/SideMenuSatisIslemleri.xml";
        private const string SideMenuSalonSatisTuccarIslemleri = "~/Data/SalonSatis/SideMenuTuccarIslemleri.xml";

        private const string SideMenuProgramIslemleri = "~/Data/ProgramIslem/SideMenuProgramIslemleri.xml";

        protected void Page_Load(object sender, EventArgs e)
        {
            var datasidemenu = new XmlDataSource
                   {
                       XPath = "/menu/*"
                   };
            NavBarAltMenu.DataSource = datasidemenu;

            ContentSplitter.GetPaneByName("ContentLeft").Visible = true;
            string path = Request.Url.AbsoluteUri;

            if (path.Contains("CanliHayvanBorsa"))
            {
            }
            else if (path.Contains("MerkezBorsa"))
            {
                if (path.Contains("BeyannameTescilIslemleri"))
                {
                    datasidemenu.DataFile = SideMenuMerkezBorsaBeyannameTescilIslemleri;
                    NavBarAltMenu.DataSource = datasidemenu;
                }
                else if (path.Contains("MuhasebeIslemleri"))
                {
                    datasidemenu.DataFile = SideMenuMerkezBorsaMuhasebeIslemleri;
                    NavBarAltMenu.DataSource = datasidemenu;
                }
                else if (path.Contains("BordroIslemleri"))
                {
                    datasidemenu.DataFile = SideMenuMerkezBorsaBordroIslemleri;
                    NavBarAltMenu.DataSource = datasidemenu;
                }
                else if (path.Contains("MuhtelifIslemler"))
                {
                    datasidemenu.DataFile = SideMenuMerkezBorsaMuhtelifIslemler;
                    NavBarAltMenu.DataSource = datasidemenu;
                }
                else if (path.Contains("ParametreKodluBilgiIslemleri"))
                {
                    datasidemenu.DataFile = SideMenuMerkezBorsaParametreKodluBilgiIslemleri;
                    NavBarAltMenu.DataSource = datasidemenu;
                }
                else if (path.Contains("TuccarIslemleri"))
                {
                    datasidemenu.DataFile = SideMenuMerkezBorsaTuccarIslemleri;
                    NavBarAltMenu.DataSource = datasidemenu;
                }
                else
                {
                    ContentSplitter.GetPaneByName("ContentLeft").Visible = false;
                    NavBarAltMenu.DataSource = null;
                    NavBarAltMenu.Visible = false;
                }
            }
            else if (path.Contains("ProgramIslem"))
            {
                datasidemenu.DataFile = SideMenuProgramIslemleri;
                NavBarAltMenu.DataSource = datasidemenu;
            }
            else if (path.Contains("SalonSatis"))
            {

                if (path.Contains("LabSatisListeler"))
                {
                    datasidemenu.DataFile = SideMenuSalonSatisLabSatisListeler;
                    NavBarAltMenu.DataSource = datasidemenu;
                }
                else if (path.Contains("MuhtelifIslemler"))
                {
                    datasidemenu.DataFile = SideMenuSalonSatisMuhtelifIslemler;
                    NavBarAltMenu.DataSource = datasidemenu;
                }
                else if (path.Contains("ParametreKodluBilgiIslemleri"))
                {
                    datasidemenu.DataFile = SideMenuSalonSatisParametreKodluBilgiIslemleri;
                    NavBarAltMenu.DataSource = datasidemenu;
                }
                else if (path.Contains("SatisIslemleri"))
                {
                    datasidemenu.DataFile = SideMenuSalonSatisSatisIslemleri;
                    NavBarAltMenu.DataSource = datasidemenu;
                }
                else if (path.Contains("TuccarIslemleri"))
                {
                    datasidemenu.DataFile = SideMenuSalonSatisTuccarIslemleri;
                    NavBarAltMenu.DataSource = datasidemenu;
                }
                else
                {
                    ContentSplitter.GetPaneByName("ContentLeft").Visible = false;
                    NavBarAltMenu.DataSource = null;
                    NavBarAltMenu.Visible = false;
                }

            }
            else if (path.Contains("SupurgeBorsa"))
            {
            }
            else if (path.Contains("ToprakTahlilLaboratuvar"))
            {
            }
            else
            {
                ContentSplitter.GetPaneByName("ContentLeft").Visible = false;
                NavBarAltMenu.DataSource = null;
                NavBarAltMenu.Visible = false;
            }

            NavBarAltMenu.DataBind();

            var datatopmenu = new XmlDataSource
                {
                    DataFile = "~/Data/TopMenu.xml",
                    XPath = "/items/*"
                };
            Menu.DataSource = datatopmenu;
            Menu.DataBind();
        }

    }
}
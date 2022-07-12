using System;
using System.Linq;
using System.Web.UI;
using TicaretBorsasi_Project.Data;

namespace TicaretBorsasi_Project.Master_Page
{
    public partial class RootMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            LabelFirma.Text = DateTime.Now.Year +
                              Server.HtmlDecode(" &copy; GAYRET BÝLGÝSAYAR HÝZMETLERÝ    Tel: (0216) 310 08 05");

            using (var entity = new DBEntities())
            {
                BORSA_BILGI data = entity.BORSA_BILGI.SingleOrDefault();
                if (data != null)
                {
                    LabelProgramBaslik.Text = data.ProgramBaslik;
                }
            }
            //Thread.CurrentThread.CurrentCulture = new CultureInfo("tr-TR");
            //Thread.CurrentThread.CurrentUICulture = new CultureInfo("tr-TR");
        }
    }
}
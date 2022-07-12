using System;
using System.Linq;
using System.Web.UI;
using TicaretBorsasi_Project.Data;

namespace TicaretBorsasi_Project.Program
{
    public partial class AnaMenu : Page
    {
        #region properties

        #endregion

        #region events

        protected void Page_Load(object sender, EventArgs e)
        {
            using (var entity = new DBEntities())
            {
                RepeaterDuyurular.DataSource =
                    entity.DUYURUs.Where(p => p.ProgramDuyuruAktif)
                          .ToList()
                          .OrderByDescending(p => p.ProgramDuyuruTarih)
                          .ToList();
                RepeaterDuyurular.DataBind();

                BORSA_BILGI data = entity.BORSA_BILGI.SingleOrDefault();

                if (data != null)
                {
                    BinaryImageResim.Value = data.ProgramLogo;
                }
            }
        }

        #endregion

        #region methods

        #endregion
    }
}
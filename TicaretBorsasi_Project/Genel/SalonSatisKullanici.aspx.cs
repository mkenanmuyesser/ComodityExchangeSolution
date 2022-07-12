using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TicaretBorsasi_Project.Data;

namespace TicaretBorsasi_Project.Genel
{
    public partial class SalonSatisKullanici : System.Web.UI.Page
    {
        #region properties

        #endregion

        #region events

        protected void Page_Load(object sender, EventArgs e)
        {
            using (var entity = new DBEntities())
            {
                BORSA_BILGI data = entity.BORSA_BILGI.SingleOrDefault();

                //if (data != null)
                //{
                //    BinaryImageLogo1.Value = data.ProgramLogo;
                //    BinaryImageLogo2.Value = data.ProgramLogo;
                //}
            }
        }

        #endregion

        #region methods

        #endregion
    }
}
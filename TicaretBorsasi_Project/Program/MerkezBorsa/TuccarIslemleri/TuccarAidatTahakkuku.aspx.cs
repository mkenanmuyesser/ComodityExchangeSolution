using System;
using System.Web.UI;
using TicaretBorsasi_Project.Class.Helper;

namespace TicaretBorsasi_Project.Program.MerkezBorsa.TuccarIslemleri
{
    public partial class TuccarAidatTahakkuku : Page
    {
        #region Properties

        #endregion

        #region Events

        protected void Page_Load(object sender, EventArgs e)
        {
            SetInitials();
        }

        protected void ButtonTahakkuk_Click(object sender, EventArgs e)
        {
            bool tarihdogrumu = ComboBoxTarihDogrulama.SelectedItem.Value == "E" ? true : false;
            bool islemdogrumu = ComboBoxIslemDogrulama.SelectedItem.Value == "E" ? true : false;

            #region validation

            if (!tarihdogrumu)
            {
                PageHelper.MessageBox(this, "Tarih işlemi doğrulanmadığı için işlem yapılamıyor.");
                return;
            }

            if (!islemdogrumu)
            {
                PageHelper.MessageBox(this, "Yapılacak işlem doğrulanmadığı için işlem yapılamıyor.");
                return;
            }

            #endregion
        }

        protected void ButtonIptal_Click(object sender, EventArgs e)
        {
            Response.Redirect(Request.Url.AbsoluteUri);
        }

        #endregion

        #region Methods

        private void SetInitials()
        {
            LabelBaslik.Text = "ÜYE AİDAT TAHAKKUKU";

            if (!IsPostBack)
            {
            }
        }

        private void DataLoad()
        {
        }

        #endregion
    }
}
using System;
using System.Web.Security;
using System.Web.UI;
using TicaretBorsasi_Project.Class.Helper;

namespace TicaretBorsasi_Project
{
    public partial class Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            LabelGiris.Text = "Ticaret Borsasý " + DateTime.Now.Year;
        }

        protected void ButtonGiris_Click(object sender, EventArgs e)
        {
            string kullaniciAdi = TextBoxKullaniciAdi.Text;
            string sifre = TextBoxSifre.Text;


            if (Membership.ValidateUser(kullaniciAdi, sifre))
            {
                if (string.IsNullOrEmpty(Request.QueryString["ReturnUrl"]))
                {
                    FormsAuthentication.SetAuthCookie(kullaniciAdi, false);
                    Response.Redirect("Program/AnaMenu.aspx");
                }
                else
                    FormsAuthentication.RedirectFromLoginPage(kullaniciAdi, false);
            }
            else
            {
                PageHelper.MessageBox(this, "Kullanýcý adý veya þifreniz yanlýþ!");
            }
        }
    }
}
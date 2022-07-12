using System;
using System.Web;
using DevExpress.Web.ASPxClasses;
using TicaretBorsasi_Project.Data;
using System.Web.Security;

namespace TicaretBorsasi_Project
{
    public class Global_asax : HttpApplication
    {
        private void Application_Start(object sender, EventArgs e)
        {
            ASPxWebControl.CallbackError += Application_Error;
        }

        private void Application_End(object sender, EventArgs e)
        {
            // Code that runs on application shutdown
        }

        private void Application_Error(object sender, EventArgs e)
        {
            using (var entity = new DBEntities())
            {
                Exception ex = Server.GetLastError();

                DateTime Tarih = DateTime.Now;
                string Message = ex.Message;
                string Source = ex.Source;
                string StackTrace = ex.StackTrace;
                string ExceptionType = ex.GetType().FullName;

                Guid? UserId = null;
                if (Membership.GetUser(true) != null)
                {
                    UserId = (Guid)Membership.GetUser(true).ProviderUserKey;
                }

                string Url = "";
                if (HttpContext.Current != null)
                {
                    Url = HttpContext.Current.Request.Url.AbsoluteUri;
                }

                LOG log = new LOG
                {
                    Tarih = Tarih,
                    Message = Message,
                    Source = Source,
                    StackTrace = StackTrace,
                    ExceptionType = ExceptionType,
                    UserId = UserId,
                    Url = Url,
                };
                entity.LOGs.Add(log);
                entity.SaveChanges();

                //Server.ClearError();
            }
        }

        private void Session_Start(object sender, EventArgs e)
        {
            // Code that runs when a new session is started
        }

        private void Session_End(object sender, EventArgs e)
        {
            // Code that runs when a session ends. 
            // Note: The Session_End event is raised only when the sessionstate mode
            // is set to InProc in the Web.config file. If session mode is set to StateServer 
            // or SQLServer, the event is not raised.
        }
    }
}
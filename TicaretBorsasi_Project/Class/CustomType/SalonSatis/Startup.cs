using Microsoft.Owin;
using Owin;
using TicaretBorsasi_Project.Class.CustomType.SalonSatis;

[assembly: OwinStartup(typeof(Startup))]

namespace TicaretBorsasi_Project.Class.CustomType.SalonSatis
{
    public class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            // Any connection or hub wire up and configuration should go here
            app.MapSignalR();
        }

    }
}
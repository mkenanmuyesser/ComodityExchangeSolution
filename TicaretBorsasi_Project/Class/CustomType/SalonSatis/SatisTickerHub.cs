using System;
using System.Collections.Concurrent;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNet.SignalR;
using Microsoft.AspNet.SignalR.Hubs;

namespace TicaretBorsasi_Project.Class.CustomType.SalonSatis
{
    [HubName("satisTicker")]
    public class SatisTickerHub : Hub
    {
        #region properties

        private readonly SatisTicker _satisTicker;

        #endregion

        #region init methods

        public SatisTickerHub() :
            this(SatisTicker.Instance)
        {

        }

        public SatisTickerHub(SatisTicker satisTicker)
        {
            _satisTicker = satisTicker;
        }

        public override Task OnConnected()
        {
            _satisTicker.KullaniciGiris(Context.ConnectionId);
            return base.OnConnected();
        }

        #endregion

        #region server methods

        #region satis methods

        public void SatisCevirimici()
        {
            _satisTicker.SatisCevirimici();            
        }

        public void SatisCevirimdisi()
        {
            _satisTicker.SatisCevirimdisi();
        }

        public void SatisBaslat(string pSatisKey,string pSatisBaslangicFiyati)
        {
            _satisTicker.SatisBaslat(Convert.ToInt32(pSatisKey),Convert.ToDecimal(pSatisBaslangicFiyati.Replace('.',',')));
        }

        public void SatisBitir()
        {
            _satisTicker.SatisBitir();
        }

        public void SatisKapat()
        {
            _satisTicker.SatisKapat();
        }

        #endregion

        #region kullanici methods

        public void KullaniciGiris()
        {
            _satisTicker.KullaniciGiris(Context.ConnectionId);
        }

        public void KullaniciKontrol()
        {
            _satisTicker.KullaniciKontrol(Context.ConnectionId);
        }

        public void KullaniciCikis()
        {
            _satisTicker.KullaniciCikis(Context.ConnectionId);
        }

        public void KullaniciTeklifVer()
        {
            _satisTicker.KullaniciTeklifVer(Context.ConnectionId);
        }

        public void KullaniciTeklifCek()
        {
            _satisTicker.KullaniciTeklifCek(Context.ConnectionId);
        }

        #endregion

        #endregion

    }
}
using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Threading;
using Microsoft.AspNet.SignalR;
using Microsoft.AspNet.SignalR.Hubs;
using System.Linq;
using TicaretBorsasi_Project.Data;
using TicaretBorsasi_Project.Class.Helper;
using System.Web.Security;
using System.Web;

namespace TicaretBorsasi_Project.Class.CustomType.SalonSatis
{
    public class SatisTicker
    {

        #region properties

        private readonly static Lazy<SatisTicker> _instance = new Lazy<SatisTicker>(
            () => new SatisTicker(GlobalHost.ConnectionManager.GetHubContext<SatisTickerHub>().Clients));

        private readonly object _zamanGuncelleLock = new object();
        private readonly object _satisDurumLock = new object();
        //private readonly ConcurrentDictionary<string, Stock> _stocks = new ConcurrentDictionary<string, Stock>();
        private readonly TimeSpan _sayacSuresi = TimeSpan.FromMilliseconds(SatisEkran.SayacSuresiGetir());
        private readonly decimal _artmaMiktari = SatisEkran.ArtmaMiktariGetir();
        private readonly decimal _dusmeMiktari = SatisEkran.DusmeMiktariGetir();

        private Timer _sunucuZamanlayici;
        private Timer _satisZamanlayici;
        private SatisEkran _satisEkran;
        public SatisEkran SatisEkran
        {
            get { return _satisEkran; }
            private set { _satisEkran = value; }
        }

        #endregion

        #region init methods

        public static SatisTicker Instance
        {
            get
            {
                return _instance.Value;
            }
        }

        private SatisTicker(IHubConnectionContext<dynamic> clients)
        {
            Clients = clients;
        }

        private IHubConnectionContext<dynamic> Clients
        {
            get;
            set;
        }

        #endregion

        #region server methods

        #region satis methods

        public void SatisCevirimici()
        {
            lock (_satisDurumLock)
            {
                SatisEkranOlustur();
                _satisEkran.SunucuDurum = SunucuDurum.Cevirimici;
                _sunucuZamanlayici = new Timer(SunucuZamanGuncelle, null, _sayacSuresi, _sayacSuresi);
                BroadcastSunucuZaman();
                BroadcastSatisEkran();
            }
        }

        public void SatisCevirimdisi()
        {
            lock (_satisDurumLock)
            {
                SatisBitir();

                _satisEkran.SunucuDurum = SunucuDurum.Cevirimdisi;
                if (_sunucuZamanlayici != null)
                {
                    _sunucuZamanlayici.Dispose();
                }

                BroadcastSatisEkran();
            }

        }

        public void SatisBaslat(int pSatisKey, decimal pSatisBaslangicFiyati)
        {
            lock (_satisDurumLock)
            {
                if (_satisEkran == null || _satisEkran.SunucuDurum == SunucuDurum.Cevirimdisi)
                {
                    //burada durdurulacak ve bilgi verilecek
                    throw new ApplicationException("Sunucu çevirimiçi değil");
                }
                else
                {
                    var _salonSatisAdmin = PageHelper.KullaniciGetir();
                    if (_salonSatisAdmin != null && PageHelper.KullaniciRolGetir().Contains("SalonSatisAdmin"))
                    {
                        //önceki teklifler vs varsa silinecek
                        //durum değişikliği yapılabilir.
                        using (var entity = new DBEntities())
                        {
                            //bitirilmiş satışmı değilmi bakılması gerek
                            var pSatis = entity.SATIS.
                                                AsNoTracking().
                                                Include("TEKLIFs").
                                                SingleOrDefault(p => p.SatisKey == pSatisKey);
                            if (pSatis != null)
                            {
                                foreach (var _TEKLIF in pSatis.TEKLIFs.ToList())
                                {
                                    var pTeklif = entity.TEKLIFs.Single(p => p.TeklifKey == _TEKLIF.TeklifKey);
                                    entity.TEKLIFs.Remove(pTeklif);
                                }
                                entity.SaveChanges();

                                _satisEkran = new SatisEkran
                                    {
                                        SunucuDurum = SunucuDurum.SatisAktifTeklifVerilmedi,
                                        AktifSatisKey = pSatisKey,
                                        BaslangicFiyat = pSatisBaslangicFiyati.ToString("N3"),
                                        SonFiyat = pSatisBaslangicFiyati.ToString("N3"),
                                        GenelTeklifOrtalama = pSatis.BaslangicFiyati.ToString("N3"),
                                        AktifKullanicilar = _satisEkran.AktifKullanicilar,
                                        TeklifVerenKullanicilar = new List<string>(),
                                        TekliftenCikanKullanicilar = new List<string>(),
                                        Sayac = 0,
                                    };

                                _satisZamanlayici = new Timer(EkranGuncelle, null, _sayacSuresi, _sayacSuresi);

                                BroadcastSatisBaslat();
                                BroadcastSatisEkran();
                            }
                            else
                            {
                                //burada durdurulacak ve bilgi verilecek
                                throw new ApplicationException("Satış bilgisi yok");
                            }
                        }
                    }
                    else
                    {
                        throw new ApplicationException("Giriş yapan kullanıcının yetkisi yok");
                    }
                }
            }
        }

        public void SatisBitir()
        {
            lock (_satisDurumLock)
            {
                if (_satisZamanlayici != null)
                {
                    _satisZamanlayici.Dispose();
                }

                _satisEkran.SunucuDurum = SunucuDurum.SatisBitirildi;

                BroadcastSatisEkran();
                BroadcastSatisBitir();
            }
        }

        public void SatisKapat()
        {
            lock (_satisDurumLock)
            {
                if (_satisZamanlayici != null)
                {
                    _satisZamanlayici.Dispose();
                }

                //önceki teklifler vs varsa silinecek
                using (var entity = new DBEntities())
                {
                    var pSatis = entity.SATIS.
                                        AsNoTracking().
                                        Include("TEKLIFs").
                                        SingleOrDefault(p => p.AktifMi &&
                                                             p.SatisKey == _satisEkran.AktifSatisKey);

                    if (pSatis != null)
                    {
                        foreach (var _TEKLIF in pSatis.TEKLIFs.ToList())
                        {
                            var pTeklif = entity.TEKLIFs.Single(p => p.TeklifKey == _TEKLIF.TeklifKey);
                            entity.TEKLIFs.Remove(pTeklif);
                        }
                        entity.SaveChanges();
                    }
                    else
                    {
                        //burada durdurulacak ve bilgi verilecek
                        throw new ApplicationException("Satış bilgisi yok");
                    }
                }
                _satisEkran.SonFiyat = _satisEkran.BaslangicFiyat;
                _satisEkran.Sayac = 0;
                _satisEkran.SunucuDurum = SunucuDurum.SatisKapatildi;

                BroadcastSatisEkran();
                BroadcastSatisKapat();
            }}

        #endregion

        #region kullanici methods

        public void KullaniciGiris(string pConnectionId)
        {
            SatisEkranOlustur();

            string kullaniciAdi = PageHelper.KullaniciGetir().UserName;
            var kullanicirolleri = PageHelper.KullaniciRolGetir();
            if (!_satisEkran.AktifKullanicilar.Contains(kullaniciAdi) && !kullanicirolleri.Contains("SalonSatisAdmin"))
            {
                _satisEkran.AktifKullanicilar.Add(kullaniciAdi);
            }
            BroadcastSatisEkran();

            BroadcastKullaniciKontrol(pConnectionId, KullaniciDurumGetir());
        }

        public void KullaniciKontrol(string pConnectionId)
        {
            BroadcastKullaniciKontrol(pConnectionId, KullaniciDurumGetir());
        }

        public void KullaniciCikis(string pConnectionId)
        {
            string kullaniciAdi = PageHelper.KullaniciGetir().UserName;
            if (_satisEkran != null && _satisEkran.AktifKullanicilar.Contains(kullaniciAdi))
                _satisEkran.AktifKullanicilar.Remove(kullaniciAdi);
         
            BroadcastSatisEkran();
        }

        public void KullaniciTeklifVer(string pConnectionId)
        {
            using (var entity = new DBEntities())
            {
                var pSatis = entity.SATIS.AsNoTracking().SingleOrDefault(p => p.SatisKey == _satisEkran.AktifSatisKey);
                if (pSatis != null)
                {
                    //daha önce teklif varmı?
                    Guid pKullaniciKey = (Guid)PageHelper.KullaniciGetir().ProviderUserKey;
                    string kullaniciAdi = PageHelper.KullaniciGetir().UserName;
                    var pTeklif = entity.TEKLIFs.SingleOrDefault(p => p.UserId == pKullaniciKey && p.SatisKey == _satisEkran.AktifSatisKey);
                    if (pTeklif == null)
                    {
                        TEKLIF _Teklif = new TEKLIF
                        {
                            TeklifKey = -1,
                            SatisKey = Convert.ToInt32(_satisEkran.AktifSatisKey),
                            UserId = pKullaniciKey,
                            AktifMi = true,
                        };
                        entity.TEKLIFs.Add(_Teklif);
                        entity.SaveChanges();
                        if (!_satisEkran.TeklifVerenKullanicilar.Contains(kullaniciAdi))
                            _satisEkran.TeklifVerenKullanicilar.Add(kullaniciAdi);

                        if (_satisEkran.TeklifVerenKullanicilar.Count() > 1)
                        {
                            _satisEkran.Sayac = 0;
                            _satisEkran.SunucuDurum = SunucuDurum.SatisAktifTeklifVerildiCogul;
                        }
                        else
                        {
                            _satisEkran.Sayac = 10;
                            _satisEkran.SunucuDurum = SunucuDurum.SatisAktifTeklifVerildiTekil;
                        }
                    }
                    else
                    {
                        //burada durdurulacak ve bilgi verilecek
                        throw new ApplicationException("Teklif bilgisi yok");
                    }
                }
                else
                {
                    //burada durdurulacak ve bilgi verilecek
                    throw new ApplicationException("Satış bilgisi yok");
                }
            }

            BroadcastSatisEkran();
            BroadcastKullaniciTeklifVer(pConnectionId);
            Console.Beep(9999, 500);
        }

        public void KullaniciTeklifCek(string pConnectionId)
        {
            using (var entity = new DBEntities())
            {
                var pSatis = entity.SATIS.AsNoTracking().SingleOrDefault(p => p.AktifMi && p.SatisKey == _satisEkran.AktifSatisKey);
                if (pSatis != null)
                {
                    if (_satisEkran.TeklifVerenKullanicilar.Count() == 2)
                    {
                        _satisEkran.Sayac = 10;
                        _satisEkran.SunucuDurum = SunucuDurum.SatisAktifTeklifVerildiTekil;
                    }
                    else if (_satisEkran.TeklifVerenKullanicilar.Count() == 1)
                    {
                        _satisEkran.Sayac = 0;
                        _satisEkran.SunucuDurum = SunucuDurum.SatisAktifTeklifVerildiTekil;
                    }

                    //daha önce teklif varmı?
                    Guid pKullaniciKey = (Guid)PageHelper.KullaniciGetir().ProviderUserKey;
                    string kullaniciAdi = PageHelper.KullaniciGetir().UserName;
                    var pTeklif = entity.TEKLIFs.SingleOrDefault(p => p.UserId == pKullaniciKey && p.SatisKey == _satisEkran.AktifSatisKey);
                    if (pTeklif != null)
                    {
                        pTeklif.AktifMi = false;
                        entity.SaveChanges();

                        if (_satisEkran.TeklifVerenKullanicilar.Contains(kullaniciAdi))
                        {
                            _satisEkran.TeklifVerenKullanicilar.Remove(kullaniciAdi);
                            if (!_satisEkran.TekliftenCikanKullanicilar.Contains(kullaniciAdi))
                            {
                                _satisEkran.TekliftenCikanKullanicilar.Add(kullaniciAdi);
                            }

                        }
                    }
                    else
                    {

                    }
                }
                else
                {

                }
            }

            BroadcastSatisEkran();
            BroadcastKullaniciTeklifCek(pConnectionId);
            Console.Beep(8888, 500);
        }

        #endregion

        #region ortak methods

        private void SatisEkranOlustur()
        {
            if (_satisEkran == null)
                _satisEkran = new SatisEkran();
        }

        private void SunucuZamanGuncelle(object state)
        {
            lock (_zamanGuncelleLock)
            {
                BroadcastSunucuZaman();
            }
        }

        private void EkranGuncelle(object state)
        {
            lock (_satisDurumLock)
            {
                switch (_satisEkran.SunucuDurum)
                {
                    case SunucuDurum.SatisAktifTeklifVerildiTekil:
                        if (_satisEkran.Sayac > 0)
                        {
                            _satisEkran.Sayac -= 1;
                        }
                        break;
                    case SunucuDurum.SatisAktifTeklifVerildiCogul:
                        _satisEkran.SonFiyat = (Convert.ToDecimal(_satisEkran.SonFiyat) + _artmaMiktari).ToString("N3");
                        _satisEkran.Sayac = 0;
                        break;
                    case SunucuDurum.SatisAktifTeklifVerilmedi:
                        _satisEkran.SonFiyat = (Convert.ToDecimal(_satisEkran.SonFiyat) - _dusmeMiktari).ToString("N3");
                        break;
                }

                if (Convert.ToDecimal(_satisEkran.SonFiyat) <= 0)
                {
                    _satisEkran.SonFiyat = "0";
                    SatisKapat();
                    return;
                }

                BroadcastSatisEkran();
                //aktif teklif sayısı 1 'e düşmüşse son kalan satışın sahibi olur.
                if (_satisEkran.SunucuDurum == SunucuDurum.SatisAktifTeklifVerildiTekil && _satisEkran.Sayac == 0 && _satisEkran.TeklifVerenKullanicilar.Count() == 1)
                {
                    _satisEkran.SunucuDurum = SunucuDurum.SatisBitirildi;
                    //son kalan kişiyi bul
                    string kullaniciadi = _satisEkran.TeklifVerenKullanicilar.First();
                    var kullanici = Membership.GetUser(kullaniciadi);

                    using (var entity = new DBEntities())
                    {
                        var pSatis = entity.SATIS.SingleOrDefault(p => p.SatisKey == _satisEkran.AktifSatisKey);
                        if (pSatis != null)
                        {
                            pSatis.UserId = Guid.Parse(kullanici.ProviderUserKey.ToString());
                            pSatis.BitisFiyati = Convert.ToDecimal(_satisEkran.SonFiyat);
                            pSatis.AktifMi = false;
                            entity.SaveChanges();
                        }
                        else
                        {
                            throw new ApplicationException("Satış bulunamadı");
                        }
                    }

                    SatisBitir();
                }
            }
        }

        private KullaniciDurum KullaniciDurumGetir()
        {
            KullaniciDurum pKullaniciDurum = KullaniciDurum.Pasif;
            if (_satisEkran.SunucuDurum == SunucuDurum.Cevirimdisi || _satisEkran.SunucuDurum == SunucuDurum.SatisBitirildi ||
                _satisEkran.SunucuDurum == SunucuDurum.SatisKapatildi)
            {
                pKullaniciDurum = KullaniciDurum.Pasif;
            }
            else
            {
                using (var entity = new DBEntities())
                {
                    var pSatis =
                        entity.SATIS.AsNoTracking()
                              .Include("TEKLIFs")
                              .SingleOrDefault(p => p.AktifMi && p.SatisKey == _satisEkran.AktifSatisKey);
                    if (pSatis != null)
                    {
                        Guid pKullaniciKey = Guid.Parse(PageHelper.KullaniciGetir().ProviderUserKey.ToString());
                        var teklif = pSatis.TEKLIFs.SingleOrDefault(p => p.UserId == pKullaniciKey);
                        if (teklif == null)
                        {
                            pKullaniciDurum = KullaniciDurum.AktifTeklifVerilmedi;
                        }
                        else if (teklif.AktifMi && _satisEkran.TeklifVerenKullanicilar.Count() > 1)
                        {
                            pKullaniciDurum = KullaniciDurum.AktifTeklifVerildiCogul;
                        }
                        else if (teklif.AktifMi && _satisEkran.TeklifVerenKullanicilar.Count() == 1)
                        {
                            pKullaniciDurum = KullaniciDurum.AktifTeklifVerildiTekil;
                        }
                        else
                        {
                            pKullaniciDurum = KullaniciDurum.AktifTeklifGeriCekildi;
                        }
                    }
                }
            }
            return pKullaniciDurum;
        }

        #endregion

        #endregion

        #region broadcast methods

        private void BroadcastSunucuZaman()
        {
            var _sunucuZaman = DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss");
            Clients.All.updateSunucuZaman(_sunucuZaman);
        }

        private void BroadcastSatisEkran()
        {
            Clients.All.updateSatis(_satisEkran);
        }

        private void BroadcastSatisBaslat()
        {
            Clients.All.satisBaslat();
        }

        private void BroadcastSatisBitir()
        {
            Clients.All.satisBitir();
        }

        private void BroadcastSatisKapat()
        {
            Clients.All.satisKapat();
        }

        private void BroadcastKullaniciKontrol(string pConnectionId, KullaniciDurum pKullaniciDurum)
        {
            var _kullaniciDurum = Convert.ToInt32(pKullaniciDurum);
            Clients.Client(pConnectionId).kullaniciKontrol(_kullaniciDurum);
        }

        private void BroadcastKullaniciTeklifVer(string pConnectionId)
        {
            Clients.All.kullaniciTeklifVer();
        }

        private void BroadcastKullaniciTeklifCek(string pConnectionId)
        {
            Clients.All.kullaniciTeklifCek();
        }

        #endregion

    }

}
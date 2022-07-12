using System;
using System.Collections.Generic;
using TicaretBorsasi_Project.Data;
using System.Linq;

namespace TicaretBorsasi_Project.Class.CustomType.SalonSatis
{
    public class SatisEkran
    {
        public SatisEkran()
        {
            SunucuDurum = SunucuDurum.Cevirimdisi;
            AktifSatisKey = -1;                        
            BaslangicFiyat = "0.000";
            SonFiyat = "0.000";
            GenelTeklifOrtalama = "0.000";
            AktifKullanicilar = new List<string>();
            TeklifVerenKullanicilar = new List<string>();
            TekliftenCikanKullanicilar = new List<string>();
            KazananKullanici = "";
            Sayac = 0;
        }

        public int AktifSatisKey { get; set; }
        public SunucuDurum SunucuDurum { get; set; }
        public string BaslangicFiyat { get; set; }
        public string SonFiyat { get; set; }
        public string GenelTeklifOrtalama { get; set; }
        public List<string> AktifKullanicilar { get; set; }
        public List<string> TeklifVerenKullanicilar { get; set; }
        public List<string> TekliftenCikanKullanicilar { get; set; }
        public string KazananKullanici { get; set; }
        public int Sayac { get; set; }

        public static int SayacSuresiGetir()
        {
            using (var entity = new DBEntities())
            {
                var pSALON_SATIS_AYAR = entity.SALON_SATIS_AYAR.SingleOrDefault();
                if (pSALON_SATIS_AYAR != null)
                {
                    return pSALON_SATIS_AYAR.SayacSuresi;
                }
                else
                {
                    throw new ApplicationException("Satis ayarı bulunamadı");
                }
            }
        }
        public static decimal ArtmaMiktariGetir()
        {
            using (var entity = new DBEntities())
            {
                var pSALON_SATIS_AYAR = entity.SALON_SATIS_AYAR.SingleOrDefault();
                if (pSALON_SATIS_AYAR != null)
                {
                    return pSALON_SATIS_AYAR.ArtmaMiktari;
                }
                else
                {
                    throw new ApplicationException("Satis ayarı bulunamadı");
                }
            }
        }
        public static decimal DusmeMiktariGetir()
        {
            using (var entity = new DBEntities())
            {
                var pSALON_SATIS_AYAR = entity.SALON_SATIS_AYAR.SingleOrDefault();
                if (pSALON_SATIS_AYAR != null)
                {
                    return pSALON_SATIS_AYAR.DusmeMiktari;
                }
                else
                {
                    throw new ApplicationException("Satis ayarı bulunamadı");
                }
            }
        }

    }

    public enum SunucuDurum
    {
        Cevirimdisi,
        Cevirimici,
        SatisAktifTeklifVerilmedi,
        SatisAktifTeklifVerildiCogul,
        SatisAktifTeklifVerildiTekil,
        SatisBitirildi,
        SatisKapatildi
    }

    //kazanıldı yeni eklendi,kodda uygun yerlere eklenecek
    public enum KullaniciDurum
    {
        Pasif,
        AktifTeklifVerilmedi,
        AktifTeklifVerildiCogul,
        AktifTeklifVerildiTekil,
        AktifTeklifKazanildi,
        AktifTeklifGeriCekildi,
    }


}
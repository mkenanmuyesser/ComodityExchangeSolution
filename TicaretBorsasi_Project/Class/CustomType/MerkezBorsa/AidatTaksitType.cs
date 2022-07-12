using System;

namespace TicaretBorsasi_Project.Class.CustomType.MerkezBorsa
{
    public class AidatTaksitType
    {
        public int TuccarSicilKey { get; set; }
        public string Donem { get; set; }
        public string DereceAdi { get; set; }
        public decimal AidatTutar { get; set; }
        public decimal OdenenCeza { get; set; }
        public DateTime? OdemeTarihi { get; set; }
        public string Aciklama { get; set; }
    }
}
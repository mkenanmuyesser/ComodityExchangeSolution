using System;

namespace TicaretBorsasi_Project.Class.CustomType.MerkezBorsa
{
    public class AskiType
    {
        public int TuccarAskiKey { get; set; }
        public int? TuccarSicilKey { get; set; }
        public string SicilNo { get; set; }
        public string Unvan { get; set; }
        public DateTime? AskiTarihi { get; set; }
        public string AskiKararNo { get; set; }
        public string AskiAciklama { get; set; }
        public DateTime? BitisTarihi { get; set; }
        public string BitisKararNo { get; set; }
        public string BitisAciklama { get; set; }
    }
}
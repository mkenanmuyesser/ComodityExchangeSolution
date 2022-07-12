using System;

namespace TicaretBorsasi_Project.Class.CustomType.MerkezBorsa
{
    [Serializable]
    public class AidatCezaHesapType
    {
        public Guid Key { get; set; }
        public short AidatYili { get; set; }
        public decimal Taksit1 { get; set; }
        public decimal Taksit2 { get; set; }
        public decimal AidatToplam { get; set; }
        public decimal Ceza { get; set; }
        public decimal AidatCezaToplam { get; set; }
    }
}
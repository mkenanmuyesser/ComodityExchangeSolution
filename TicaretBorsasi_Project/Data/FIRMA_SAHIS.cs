//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace TicaretBorsasi_Project.Data
{
    using System;
    using System.Collections.Generic;
    
    public partial class FIRMA_SAHIS
    {
        public int FirmaSahisKey { get; set; }
        public Nullable<int> TuccarSicilKey { get; set; }
        public string Soyad { get; set; }
        public string Ad { get; set; }
        public string BabaAdi { get; set; }
        public string DogumYeri { get; set; }
        public Nullable<System.DateTime> DogumTarihi { get; set; }
        public string Uyruk { get; set; }
        public Nullable<byte> OgrenimDurumTipKey { get; set; }
        public string Adres { get; set; }
        public string Tel { get; set; }
        public string TcKimlikNo { get; set; }
        public Nullable<System.Guid> KayitKisiKey { get; set; }
        public Nullable<System.DateTime> KayitTarih { get; set; }
        public Nullable<System.Guid> GuncelleKisiKey { get; set; }
        public Nullable<System.DateTime> GuncelleTarih { get; set; }
    
        public virtual TT_OGRENIM_DURUM_TIP TT_OGRENIM_DURUM_TIP { get; set; }
        public virtual TUCCAR_SICIL TUCCAR_SICIL { get; set; }
    }
}

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
    
    public partial class TT_MADDE_KOD1
    {
        public int MaddeKodKey { get; set; }
        public string Kod { get; set; }
        public string Adi { get; set; }
        public Nullable<bool> Stopaj { get; set; }
        public Nullable<bool> MeraFonu { get; set; }
        public Nullable<bool> MaddeKoduFonu { get; set; }
        public Nullable<decimal> Fire { get; set; }
        public Nullable<decimal> BirimKg { get; set; }
        public Nullable<decimal> LabGrubu { get; set; }
        public Nullable<decimal> TmoGrubu { get; set; }
        public Nullable<decimal> StopajYuzdesi { get; set; }
        public string TobbKodu { get; set; }
        public Nullable<System.Guid> KayitKisiKey { get; set; }
        public Nullable<System.DateTime> KayitTarih { get; set; }
        public Nullable<System.Guid> GuncelleKisiKey { get; set; }
        public Nullable<System.DateTime> GuncelleTarih { get; set; }
    }
}
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
    
    public partial class TT_TOBB_KOD
    {
        public int TobbKodKey { get; set; }
        public string Kod { get; set; }
        public string Derece1 { get; set; }
        public string Derece2 { get; set; }
        public string Derece3 { get; set; }
        public string Yemlik { get; set; }
        public string BaremtDisi { get; set; }
        public string YemlikKodu { get; set; }
        public string BaremDisiKodu { get; set; }
        public Nullable<System.Guid> KayitKisiKey { get; set; }
        public Nullable<System.DateTime> KayitTarih { get; set; }
        public Nullable<System.Guid> GuncelleKisiKey { get; set; }
        public Nullable<System.DateTime> GuncelleTarih { get; set; }
    }
}
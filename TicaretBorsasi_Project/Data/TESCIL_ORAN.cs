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
    
    public partial class TESCIL_ORAN
    {
        public int TescilOranKey { get; set; }
        public Nullable<decimal> TescilOrani { get; set; }
        public Nullable<decimal> SimsarOrani { get; set; }
        public Nullable<decimal> Stopaj { get; set; }
        public Nullable<decimal> FonPayi { get; set; }
        public Nullable<decimal> MeraFonu { get; set; }
        public Nullable<decimal> Tavan { get; set; }
        public Nullable<byte> TahsilatTipKey { get; set; }
        public Nullable<int> MuhasebeTipKey { get; set; }
        public Nullable<decimal> Satis { get; set; }
        public Nullable<System.Guid> KayitKisiKey { get; set; }
        public Nullable<System.DateTime> KayitTarih { get; set; }
        public Nullable<System.Guid> GuncelleKisiKey { get; set; }
        public Nullable<System.DateTime> GuncelleTarih { get; set; }
    
        public virtual TT_MUHASEBE_TIP TT_MUHASEBE_TIP { get; set; }
        public virtual TT_TAHSILAT_TIP TT_TAHSILAT_TIP { get; set; }
    }
}
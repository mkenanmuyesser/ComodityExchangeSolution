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
    
    public partial class TUCCAR_KEFALET_TEMINAT
    {
        public int TuccarKefaletTeminatKey { get; set; }
        public int TuccarKey { get; set; }
        public int KefilKey { get; set; }
        public Nullable<System.Guid> KayitKisiKey { get; set; }
        public Nullable<System.DateTime> KayitTarih { get; set; }
        public Nullable<System.Guid> GuncelleKisiKey { get; set; }
        public Nullable<System.DateTime> GuncelleTarih { get; set; }
    
        public virtual TUCCAR_SICIL TUCCAR_SICIL { get; set; }
        public virtual TUCCAR_SICIL TUCCAR_SICIL1 { get; set; }
    }
}

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
    
    public partial class TT_OGRENIM_DURUM_TIP
    {
        public TT_OGRENIM_DURUM_TIP()
        {
            this.FIRMA_SAHIS = new HashSet<FIRMA_SAHIS>();
        }
    
        public byte OgrenimDurumTipKey { get; set; }
        public string OgrenimDurumTipAdi { get; set; }
    
        public virtual ICollection<FIRMA_SAHIS> FIRMA_SAHIS { get; set; }
    }
}
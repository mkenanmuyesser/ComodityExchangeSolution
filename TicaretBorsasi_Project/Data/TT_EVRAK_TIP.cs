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
    
    public partial class TT_EVRAK_TIP
    {
        public TT_EVRAK_TIP()
        {
            this.GELEN_GIDEN_EVRAK = new HashSet<GELEN_GIDEN_EVRAK>();
        }
    
        public byte EvrakTipKey { get; set; }
        public string EvrakTipAdi { get; set; }
    
        public virtual ICollection<GELEN_GIDEN_EVRAK> GELEN_GIDEN_EVRAK { get; set; }
    }
}

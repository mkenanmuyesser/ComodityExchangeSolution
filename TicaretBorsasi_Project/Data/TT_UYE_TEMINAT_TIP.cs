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
    
    public partial class TT_UYE_TEMINAT_TIP
    {
        public TT_UYE_TEMINAT_TIP()
        {
            this.BORSA_BILGI = new HashSet<BORSA_BILGI>();
        }
    
        public byte UyeTeminatTipiKey { get; set; }
        public string UyeTeminatTipAdi { get; set; }
        public Nullable<System.Guid> KayitKisiKey { get; set; }
        public Nullable<System.DateTime> KayitTarih { get; set; }
        public Nullable<System.Guid> GuncelleKisiKey { get; set; }
        public Nullable<System.DateTime> GuncelleTarih { get; set; }
    
        public virtual ICollection<BORSA_BILGI> BORSA_BILGI { get; set; }
    }
}

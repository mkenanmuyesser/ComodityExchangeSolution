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
    
    public partial class TT_MUHASEBE_TIP
    {
        public TT_MUHASEBE_TIP()
        {
            this.FIS_NO = new HashSet<FIS_NO>();
            this.HESAP_PLANI = new HashSet<HESAP_PLANI>();
            this.TESCIL_ORAN = new HashSet<TESCIL_ORAN>();
            this.YEVMIYEs = new HashSet<YEVMIYE>();
        }
    
        public int MuhasebeTipKey { get; set; }
        public string Kod { get; set; }
        public string Adi { get; set; }
        public Nullable<System.Guid> KayitKisiKey { get; set; }
        public Nullable<System.DateTime> KayitTarih { get; set; }
        public Nullable<System.Guid> GuncelleKisiKey { get; set; }
        public Nullable<System.DateTime> GuncelleTarih { get; set; }
    
        public virtual ICollection<FIS_NO> FIS_NO { get; set; }
        public virtual ICollection<HESAP_PLANI> HESAP_PLANI { get; set; }
        public virtual ICollection<TESCIL_ORAN> TESCIL_ORAN { get; set; }
        public virtual ICollection<YEVMIYE> YEVMIYEs { get; set; }
    }
}

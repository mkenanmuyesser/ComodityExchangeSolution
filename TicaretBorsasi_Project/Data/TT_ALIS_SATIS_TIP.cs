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
    
    public partial class TT_ALIS_SATIS_TIP
    {
        public TT_ALIS_SATIS_TIP()
        {
            this.BEYANs = new HashSet<BEYAN>();
            this.TT_SATIS_SEKLI = new HashSet<TT_SATIS_SEKLI>();
            this.TT_SATIS_SEKLI1 = new HashSet<TT_SATIS_SEKLI>();
            this.TT_SATIS_SEKLI2 = new HashSet<TT_SATIS_SEKLI>();
            this.TT_SATIS_SEKLI3 = new HashSet<TT_SATIS_SEKLI>();
            this.TT_SATIS_SEKLI4 = new HashSet<TT_SATIS_SEKLI>();
            this.TT_SATIS_SEKLI5 = new HashSet<TT_SATIS_SEKLI>();
        }
    
        public byte AlisSatisTipKey { get; set; }
        public string Kod { get; set; }
        public string AlisSatisTipAdi { get; set; }
        public Nullable<System.Guid> KayitKisiKey { get; set; }
        public Nullable<System.DateTime> KayitTarih { get; set; }
        public Nullable<System.Guid> GuncelleKisiKey { get; set; }
        public Nullable<System.DateTime> GuncelleTarih { get; set; }
    
        public virtual ICollection<BEYAN> BEYANs { get; set; }
        public virtual ICollection<TT_SATIS_SEKLI> TT_SATIS_SEKLI { get; set; }
        public virtual ICollection<TT_SATIS_SEKLI> TT_SATIS_SEKLI1 { get; set; }
        public virtual ICollection<TT_SATIS_SEKLI> TT_SATIS_SEKLI2 { get; set; }
        public virtual ICollection<TT_SATIS_SEKLI> TT_SATIS_SEKLI3 { get; set; }
        public virtual ICollection<TT_SATIS_SEKLI> TT_SATIS_SEKLI4 { get; set; }
        public virtual ICollection<TT_SATIS_SEKLI> TT_SATIS_SEKLI5 { get; set; }
    }
}

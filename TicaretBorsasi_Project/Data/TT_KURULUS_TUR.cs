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
    
    public partial class TT_KURULUS_TUR
    {
        public TT_KURULUS_TUR()
        {
            this.TUCCAR_SICIL = new HashSet<TUCCAR_SICIL>();
        }
    
        public int KurulusTurKey { get; set; }
        public string Kod { get; set; }
        public string Adi { get; set; }
        public string TobbKodu { get; set; }
        public Nullable<System.Guid> KayitKisiKey { get; set; }
        public Nullable<System.DateTime> KayitTarih { get; set; }
        public Nullable<System.Guid> GuncelleKisiKey { get; set; }
        public Nullable<System.DateTime> GuncelleTarih { get; set; }
    
        public virtual ICollection<TUCCAR_SICIL> TUCCAR_SICIL { get; set; }
    }
}

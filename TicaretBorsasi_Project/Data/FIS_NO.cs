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
    
    public partial class FIS_NO
    {
        public int FisNoKey { get; set; }
        public short Yil { get; set; }
        public int MuhasebeTipKey { get; set; }
        public byte FisTipKey { get; set; }
        public int OcakNo { get; set; }
        public int SubatNo { get; set; }
        public int MartNo { get; set; }
        public int NisanNo { get; set; }
        public int MayisNo { get; set; }
        public int HaziranNo { get; set; }
        public int TemmuzNo { get; set; }
        public int AgustosNo { get; set; }
        public int EylulNo { get; set; }
        public int EkimNo { get; set; }
        public int KasimNo { get; set; }
        public int AralikNo { get; set; }
        public Nullable<System.Guid> KayitKisiKey { get; set; }
        public Nullable<System.DateTime> KayitTarih { get; set; }
        public Nullable<System.Guid> GuncelleKisiKey { get; set; }
        public Nullable<System.DateTime> GuncelleTarih { get; set; }
    
        public virtual TT_FIS_TIP TT_FIS_TIP { get; set; }
        public virtual TT_MUHASEBE_TIP TT_MUHASEBE_TIP { get; set; }
    }
}
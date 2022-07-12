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
    
    public partial class TUCCAR_SICIL
    {
        public TUCCAR_SICIL()
        {
            this.AIDAT_TAKIP = new HashSet<AIDAT_TAKIP>();
            this.BEYANs = new HashSet<BEYAN>();
            this.BEYANs1 = new HashSet<BEYAN>();
            this.DERECE_DEGISIKLIK = new HashSet<DERECE_DEGISIKLIK>();
            this.FIRMA_ADRES = new HashSet<FIRMA_ADRES>();
            this.FIRMA_DIGER_FAALIYET_KOD = new HashSet<FIRMA_DIGER_FAALIYET_KOD>();
            this.FIRMA_FAALIYET = new HashSet<FIRMA_FAALIYET>();
            this.FIRMA_KAYITLI_ODA = new HashSet<FIRMA_KAYITLI_ODA>();
            this.FIRMA_SAHIS = new HashSet<FIRMA_SAHIS>();
            this.FIRMA_TELEFON_FAX = new HashSet<FIRMA_TELEFON_FAX>();
            this.FIRMA_UYARI = new HashSet<FIRMA_UYARI>();
            this.FIRMA_YETKILI = new HashSet<FIRMA_YETKILI>();
            this.FIRMA_YONETIM = new HashSet<FIRMA_YONETIM>();
            this.KAYIT_TAKIP = new HashSet<KAYIT_TAKIP>();
            this.MESLEK_GRUP_DEGISIKLIK = new HashSet<MESLEK_GRUP_DEGISIKLIK>();
            this.SERMAYE_DEGISIKLIK = new HashSet<SERMAYE_DEGISIKLIK>();
            this.TUCCAR_ASKI = new HashSet<TUCCAR_ASKI>();
            this.TUCCAR_DEPO = new HashSet<TUCCAR_DEPO>();
            this.TUCCAR_KEFALET_TEMINAT = new HashSet<TUCCAR_KEFALET_TEMINAT>();
            this.TUCCAR_KEFALET_TEMINAT1 = new HashSet<TUCCAR_KEFALET_TEMINAT>();
            this.TUCCAR_TAHSIL = new HashSet<TUCCAR_TAHSIL>();
            this.UNVAN_DEGISIKLIK = new HashSet<UNVAN_DEGISIKLIK>();
        }
    
        public int TuccarSicilKey { get; set; }
        public string SicilNo { get; set; }
        public string Unvan { get; set; }
        public Nullable<int> MeslekGrupKey { get; set; }
        public Nullable<int> DereceKey { get; set; }
        public Nullable<short> DereceYil { get; set; }
        public string MersisNo { get; set; }
        public bool MerkezSubeMi { get; set; }
        public bool KayitTescilMi { get; set; }
        public string BolgeAdi { get; set; }
        public string IsciSayisi { get; set; }
        public string EpostaAdresi { get; set; }
        public string WebAdresi { get; set; }
        public bool ResenKayitMi { get; set; }
        public string NaceKodu1 { get; set; }
        public string NaceKodu2 { get; set; }
        public Nullable<int> KurulusTurKey { get; set; }
        public Nullable<int> SicilMemurluguKey { get; set; }
        public Nullable<System.DateTime> SicilTarih { get; set; }
        public string SicilKayitNo { get; set; }
        public Nullable<int> IlIlceKey { get; set; }
        public Nullable<System.DateTime> KayitTarihi { get; set; }
        public Nullable<System.DateTime> YKKTarihi { get; set; }
        public string YKKNo { get; set; }
        public Nullable<System.DateTime> TerkinTarihi { get; set; }
        public string TerkinYKKNo { get; set; }
        public Nullable<decimal> Sermaye { get; set; }
        public Nullable<int> VergiDaireKey { get; set; }
        public string VergiNo { get; set; }
        public string TCKimlikNo { get; set; }
        public string VergiNoEski { get; set; }
        public string Aciklama { get; set; }
        public Nullable<System.Guid> KayitKisiKey { get; set; }
        public Nullable<System.DateTime> KayitTarih { get; set; }
        public Nullable<System.Guid> GuncelleKisiKey { get; set; }
        public Nullable<System.DateTime> GuncelleTarih { get; set; }
    
        public virtual ICollection<AIDAT_TAKIP> AIDAT_TAKIP { get; set; }
        public virtual ICollection<BEYAN> BEYANs { get; set; }
        public virtual ICollection<BEYAN> BEYANs1 { get; set; }
        public virtual ICollection<DERECE_DEGISIKLIK> DERECE_DEGISIKLIK { get; set; }
        public virtual ICollection<FIRMA_ADRES> FIRMA_ADRES { get; set; }
        public virtual ICollection<FIRMA_DIGER_FAALIYET_KOD> FIRMA_DIGER_FAALIYET_KOD { get; set; }
        public virtual ICollection<FIRMA_FAALIYET> FIRMA_FAALIYET { get; set; }
        public virtual ICollection<FIRMA_KAYITLI_ODA> FIRMA_KAYITLI_ODA { get; set; }
        public virtual ICollection<FIRMA_SAHIS> FIRMA_SAHIS { get; set; }
        public virtual ICollection<FIRMA_TELEFON_FAX> FIRMA_TELEFON_FAX { get; set; }
        public virtual ICollection<FIRMA_UYARI> FIRMA_UYARI { get; set; }
        public virtual ICollection<FIRMA_YETKILI> FIRMA_YETKILI { get; set; }
        public virtual ICollection<FIRMA_YONETIM> FIRMA_YONETIM { get; set; }
        public virtual ICollection<KAYIT_TAKIP> KAYIT_TAKIP { get; set; }
        public virtual ICollection<MESLEK_GRUP_DEGISIKLIK> MESLEK_GRUP_DEGISIKLIK { get; set; }
        public virtual ICollection<SERMAYE_DEGISIKLIK> SERMAYE_DEGISIKLIK { get; set; }
        public virtual TT_DERECE TT_DERECE { get; set; }
        public virtual TT_IL_ILCE TT_IL_ILCE { get; set; }
        public virtual TT_KURULUS_TUR TT_KURULUS_TUR { get; set; }
        public virtual TT_MESLEK_GRUP TT_MESLEK_GRUP { get; set; }
        public virtual TT_SICIL_MEMURLUGU TT_SICIL_MEMURLUGU { get; set; }
        public virtual TT_VERGI_DAIRE TT_VERGI_DAIRE { get; set; }
        public virtual ICollection<TUCCAR_ASKI> TUCCAR_ASKI { get; set; }
        public virtual ICollection<TUCCAR_DEPO> TUCCAR_DEPO { get; set; }
        public virtual ICollection<TUCCAR_KEFALET_TEMINAT> TUCCAR_KEFALET_TEMINAT { get; set; }
        public virtual ICollection<TUCCAR_KEFALET_TEMINAT> TUCCAR_KEFALET_TEMINAT1 { get; set; }
        public virtual ICollection<TUCCAR_TAHSIL> TUCCAR_TAHSIL { get; set; }
        public virtual ICollection<UNVAN_DEGISIKLIK> UNVAN_DEGISIKLIK { get; set; }
    }
}

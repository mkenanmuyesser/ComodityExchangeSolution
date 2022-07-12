using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TicaretBorsasi_Project.Class.Query
{
    public static class MustahsilTaramaQuery
    {
        public const string MustahsilTaramaListeQuery = @"with Data as
                                                        (
                                                        select 
                                                        B.TuccarSicilKey,
                                                        TS.SicilNo+' - '+TS.Unvan as Unvan,
                                                        B.BeyanTarihi as BeyanTarihi,
                                                        BS.Kod as SubeKodu,
                                                        B.BeyanNo as BeyanNo,
                                                        Max(B.BeyanSatirNo) as SatirNo,
                                                        BT.Aciklama as Tipi,
                                                        TS.Unvan as MustahsilAdi
                                                        from MERKEZ_BORSA.BEYAN as B
                                                        inner join MERKEZ_BORSA.TUCCAR_SICIL as TS
                                                        on B.TuccarSicilKey=TS.TuccarSicilKey
                                                        inner join MERKEZ_BORSA.TT_BORSA_SUBE as BS
                                                        on B.BorsaSubeKey=BS.BorsaSubeKey
                                                        inner join MERKEZ_BORSA.TT_ALIS_SATIS_TIP as AST
                                                        on B.AlisSatisTipKey=AST.AlisSatisTipKey
                                                        inner join MERKEZ_BORSA.TT_BEYAN_TIP as BT
                                                        on B.BeyanTipKey=BT.BeyanTipKey
                                                        where 
                                                        (TS.Unvan like '%'+@Unvan+'%')
                                                        and (@BeyanTip is null or B.BeyanTipKey=@BeyanTip)
                                                        and (B.BeyanTarihi between @BaslangicTarihi and @BitisTarihi)
                                                        and (@BaslangicSubeKodu is null or cast(BS.Kod as int)>=@BaslangicSubeKodu)
                                                        and (@BitisSubeKodu is null or cast(BS.Kod as int)<=@BitisSubeKodu)
                                                        and ((@FaturaNoGirilmisKayit = 0) or (@FaturaNoGirilmisKayit=1 and B.BeyanFaturaNo is not null))
                                                        group by B.TuccarSicilKey,TS.SicilNo+' - '+TS.Unvan,B.BeyanTarihi,BS.Kod,B.BeyanNo,BT.Aciklama,TS.Unvan
                                                        ),
                                                        BeyanNolar as
                                                        (
                                                        select distinct TuccarSicilKey,BeyanNo from MERKEZ_BORSA.BEYAN
                                                        )
                                                        select 
                                                        *,
                                                        Cast(ROW_NUMBER() OVER(Partition By D.TuccarSicilKey Order By D.TuccarSicilKey,D.Unvan,D.SubeKodu,D.BeyanTarihi) as varchar)+ ' / '+
                                                        (
                                                        select cast(COUNT(BSub.BeyanNo) as varchar) from BeyanNolar as BSub
                                                        where BSub.TuccarSicilKey=D.TuccarSicilKey 
                                                        ) as BulunanBeyanSayisi 
                                                        from Data as D
                                                        order by D.TuccarSicilKey,D.Unvan,D.SubeKodu,D.BeyanTarihi";
    }
}
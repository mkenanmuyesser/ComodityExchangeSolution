using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TicaretBorsasi_Project.Class.Query
{
    public static class BeyannameIstihbaratQuery
    {
        public const string BeyannameIstihbaratListeQuery = @"select TS.TuccarSicilKey,TS.Unvan,MK.Kod,SUM(b.BeyanMiktar) as AlisMiktar,SUM(b.BeyanSatisTutari) as AlisTutar,null as SatisMiktar,null as SatisTutar  
                                                            from [MERKEZ_BORSA].[BEYAN] as B  
                                                            left join MERKEZ_BORSA.TUCCAR_SICIL as TS  
                                                            on B.TuccarSicilKey=TS.TuccarSicilKey  
                                                            left join MERKEZ_BORSA.TT_MADDE_KOD as MK  
                                                            on B.MaddeKodKey=MK.MaddeKodKey  
                                                            left join MERKEZ_BORSA.TT_BORSA_SUBE as BS  
                                                            on BS.BorsaSubeKey=B.BorsaSubeKey  
                                                            where AlisSatisTipKey=1  
                                                            and B.BeyanTarihi between @Baslangic and @Bitis  
                                                            and cast(TS.SicilNo as int) between @SicilNoBaslangic and @SicilNoBitis  
                                                            and cast(BS.Kod as int) between @SubeKodBaslangic and @SubeKodBitis  
                                                            and cast(MK.Kod as int) between @MaddeKodBaslangic and @MaddeKodBitis  
                                                            group by TS.TuccarSicilKey,TS.Unvan,MK.Kod  
                                                            union all  
                                                            select TS.TuccarSicilKey,TS.Unvan,MK.Kod,null as AlisMiktar,null as AlisTutar,SUM(b.BeyanMiktar) as SatisMiktar,SUM(b.BeyanSatisTutari) as SatisTutar  
                                                            from [MERKEZ_BORSA].[BEYAN] as B  
                                                            left join MERKEZ_BORSA.TUCCAR_SICIL as TS  
                                                            on B.TuccarSicilKey=TS.TuccarSicilKey  
                                                            left join MERKEZ_BORSA.TT_MADDE_KOD as MK  
                                                            on B.MaddeKodKey=MK.MaddeKodKey  
                                                            left join MERKEZ_BORSA.TT_BORSA_SUBE as BS  
                                                            on BS.BorsaSubeKey=B.BorsaSubeKey  
                                                            where AlisSatisTipKey=2  
                                                            and B.BeyanTarihi between @Baslangic and @Bitis  
                                                            and cast(TS.SicilNo as int) between @SicilNoBaslangic and @SicilNoBitis  
                                                            and cast(BS.Kod as int) between @SubeKodBaslangic and @SubeKodBitis  
                                                            and cast(MK.Kod as int) between @MaddeKodBaslangic and @MaddeKodBitis  
                                                            group by TS.TuccarSicilKey,TS.Unvan,MK.Kod  
                                                            order by TS.Unvan";
    }
}
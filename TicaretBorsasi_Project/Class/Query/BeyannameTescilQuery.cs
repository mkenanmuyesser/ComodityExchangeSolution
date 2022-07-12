using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TicaretBorsasi_Project.Class.Query
{
    public static class BeyannameTescilQuery
    {
        public const string BeyannameTescilListeQuery = @"with Data as(select  
                                                        TS.SicilNo,  
                                                        TS.Unvan,  
                                                        Sum(B.SimsariyeMiktar) as AlBeySimTop,  
                                                        Sum(B.TescilMiktar) as AlBeyTesTop,  
                                                        NULL as StBeyTesTop  
                                                        from [MERKEZ_BORSA].[BEYAN] as B  
                                                        left join [MERKEZ_BORSA].[TUCCAR_SICIL] as TS  
                                                        on B.TuccarSicilKey=TS.TuccarSicilKey  
                                                        where B.AlisSatisTipKey=1  
                                                        and B.BeyanTarihi between @Baslangic and @Bitis  
                                                        group by TS.SicilNo,TS.Unvan  
                                                        union  
                                                        select  
                                                        TS.SicilNo,  
                                                        TS.Unvan,  
                                                        NULL as AlBeySimTop,  
                                                        NULL as AlBeyTesTop,  
                                                        Sum(B.TescilMiktar) as StBeyTesTop  
                                                        from [MERKEZ_BORSA].[BEYAN] as B  
                                                        left join [MERKEZ_BORSA].[TUCCAR_SICIL] as TS  
                                                        on B.TuccarSicilKey=TS.TuccarSicilKey  
                                                        where B.AlisSatisTipKey=2  
                                                        and B.BeyanTarihi between @Baslangic and @Bitis  
                                                        group by TS.SicilNo,TS.Unvan  
                                                        )  
                                                        select  
                                                        SicilNo,  
                                                        Unvan,  
                                                        case AlBeySimTop when 0 then NULL else AlBeySimTop end as AlBeySimTop,  
                                                        case AlBeyTesTop when 0 then NULL else AlBeyTesTop end as AlBeyTesTop ,  
                                                        case StBeyTesTop when 0 then NULL else StBeyTesTop end as StBeyTesTop   
                                                        from Data  
                                                        order by SicilNo ";
    }
}
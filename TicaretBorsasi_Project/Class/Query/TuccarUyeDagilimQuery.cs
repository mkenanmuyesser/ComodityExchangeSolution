using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TicaretBorsasi_Project.Class.Query
{
    public static class TuccarUyeDagilimQuery
    {
        public const string VergiDaireQuery = "with  GercekUyeler as " +
                                                "( " +
                                                "select TSGercek.TuccarSicilKey as GercekSicilKey from MERKEZ_BORSA.TUCCAR_SICIL as TSGercek " +
                                                "left join MERKEZ_BORSA.FIRMA_SAHIS as FS on TSGercek.TuccarSicilKey= FS.TuccarSicilKey " +
                                                "where FS.FirmaSahisKey is not null " +
                                                "and TSGercek.TerkinTarihi is null " +
                                                ") " +
                                                ",TuzelUyeler as " +
                                                "( " +
                                                "select TSTuzel.TuccarSicilKey as TuzelSicilKey from MERKEZ_BORSA.TUCCAR_SICIL as TSTuzel " +
                                                "left join MERKEZ_BORSA.FIRMA_SAHIS as FS on TSTuzel.TuccarSicilKey= FS.TuccarSicilKey " +
                                                "where FS.FirmaSahisKey is  null " +
                                                "and TSTuzel.TerkinTarihi is null " +
                                                ") " +
                                                "select VD.VergiDaireKey as [Key],VD.Kod,VergiDairesiAdi as Ad,COUNT(GU.GercekSicilKey) as GercekUye1,COUNT(TU.TuzelSicilKey) as TuzelUye1, (COUNT(GU.GercekSicilKey)+COUNT(TU.TuzelSicilKey)) as Toplam2 from MERKEZ_BORSA.TUCCAR_SICIL as TS " +
                                                "left join MERKEZ_BORSA.TT_VERGI_DAIRE as VD on TS.VergiDaireKey=VD.VergiDaireKey " +
                                                "left join GercekUyeler as GU on TS.TuccarSicilKey=GU.GercekSicilKey " +
                                                "left join TuzelUyeler as TU on TS.TuccarSicilKey=TU.TuzelSicilKey " +
                                                "group by VD.VergiDaireKey,Kod,VergiDairesiAdi " +
                                                "order by VD.VergiDaireKey";

        public const string KurulusTurQuery = "with TerkinUyeler as " +
                                                "( " +
                                                "select TSTerkin.TuccarSicilKey as TerkinSicilKey from MERKEZ_BORSA.TUCCAR_SICIL as TSTerkin " +
                                                "where  TSTerkin.TerkinTarihi is not null " +
                                                ") " +
                                                ",FaalUyeler as " +
                                                "( " +
                                                "select TSFaal.TuccarSicilKey as FaalSicilKey from MERKEZ_BORSA.TUCCAR_SICIL as TSFaal " +
                                                "where  TSFaal.TerkinTarihi is null " +
                                                ") " +
                                                "select  KT.KurulusTurKey as [Key],KT.Kod,KT.Adi as Ad,count(TU.TerkinSicilKey) as Terkin,count(FU.FaalSicilKey) as Faal,(count(TU.TerkinSicilKey)+count(FU.FaalSicilKey)) as Toplam2  from MERKEZ_BORSA.TUCCAR_SICIL as TS " +
                                                "full join MERKEZ_BORSA.TT_KURULUS_TUR as KT on TS.KurulusTurKey=KT.KurulusTurKey " +
                                                "left join TerkinUyeler as TU on TS.TuccarSicilKey=TU.TerkinSicilKey " +
                                                "left join FaalUyeler as FU on TS.TuccarSicilKey=FU.FaalSicilKey " +
                                                "where KT.Kod<>'000' " +
                                                "group by KT.KurulusTurKey,KT.Kod,KT.Adi ";

        public const string MeslekGrupQuery = "with  GercekUyeler as " +
                                                "( " +
                                                "select TSGercek.TuccarSicilKey as GercekSicilKey from MERKEZ_BORSA.TUCCAR_SICIL as TSGercek " +
                                                "left join MERKEZ_BORSA.FIRMA_SAHIS as FS on TSGercek.TuccarSicilKey= FS.TuccarSicilKey " +
                                                "where FS.FirmaSahisKey is not null " +
                                                "and TSGercek.TerkinTarihi is null " +
                                                ") " +
                                                ",TuzelUyeler as " +
                                                "( " +
                                                "select TSTuzel.TuccarSicilKey as TuzelSicilKey from MERKEZ_BORSA.TUCCAR_SICIL as TSTuzel " +
                                                "left join MERKEZ_BORSA.FIRMA_SAHIS as FS on TSTuzel.TuccarSicilKey= FS.TuccarSicilKey " +
                                                "where FS.FirmaSahisKey is  null " +
                                                "and TSTuzel.TerkinTarihi is null " +
                                                ") " +
                                                "select MG.MeslekGrupKey as [Key],MG.Kod,MG.MeslekAdi as Ad,COUNT(GU.GercekSicilKey) as GercekUye1,COUNT(TU.TuzelSicilKey) as TuzelUye1, (COUNT(GU.GercekSicilKey)+COUNT(TU.TuzelSicilKey)) as Toplam2 from MERKEZ_BORSA.TUCCAR_SICIL as TS " +
                                                "inner join MERKEZ_BORSA.TT_MESLEK_GRUP as MG on TS.MeslekGrupKey=MG.MeslekGrupKey " +
                                                "left join GercekUyeler as GU on TS.TuccarSicilKey=GU.GercekSicilKey " +
                                                "left join TuzelUyeler as TU on TS.TuccarSicilKey=TU.TuzelSicilKey " +
                                                "group by MG.MeslekGrupKey,MG.Kod,MG.MeslekAdi " +
                                                "order by MG.MeslekGrupKey";

        public const string DereceGrupQuery = "with AskiOlanUyeler as " +
                                                "( " +
                                                "select TSAskiOlan.TuccarSicilKey from MERKEZ_BORSA.TUCCAR_SICIL as TSAskiOlan " +
                                                "inner join MERKEZ_BORSA.TUCCAR_ASKI as TA on TSAskiOlan.TuccarSicilKey=TA.TuccarSicilKey " +
                                                "where TSAskiOlan.TerkinTarihi is null " +
                                                "and (TA.TuccarAskiKey is null or (TA.TuccarAskiKey is not null and TA.BitisTarihi is  null)) " +
                                                ") " +
                                                ",AskiOlmayanUyeler as " +
                                                "( " +
                                                "select TSAskiOlmayan.TuccarSicilKey from MERKEZ_BORSA.TUCCAR_SICIL as TSAskiOlmayan " +
                                                "where TSAskiOlmayan.TerkinTarihi is null " +
                                                "except " +
                                                "select * from AskiOlanUyeler " +
                                                ") " +
                                                ",GercekAskiOlanUyeler as " +
                                                "( " +
                                                "select TSGercek.TuccarSicilKey as GercekAskiOlanSicilKey from AskiOlanUyeler as TSGercek " +
                                                "inner join MERKEZ_BORSA.FIRMA_SAHIS as FS on TSGercek.TuccarSicilKey= FS.TuccarSicilKey " +
                                                ") " +
                                                ",TuzelAskiOlanUyeler as " +
                                                "( " +
                                                "select TSTuzel.TuccarSicilKey as TuzelAskiOlanSicilKey from AskiOlanUyeler as TSTuzel " +
                                                "except " +
                                                "select * from GercekAskiOlanUyeler " +
                                                ") " +
                                                ",GercekAskiOlmayanUyeler as " +
                                                "( " +
                                                "select TSGercek.TuccarSicilKey as GercekAskiOlmayanSicilKey from AskiOlmayanUyeler as TSGercek " +
                                                "inner join MERKEZ_BORSA.FIRMA_SAHIS as FS on TSGercek.TuccarSicilKey= FS.TuccarSicilKey " +
                                                ") " +
                                                ",TuzelAskiOlmayanUyeler as " +
                                                "( " +
                                                "select TSTuzel.TuccarSicilKey as TuzelAskiOlmayanSicilKey from AskiOlmayanUyeler as TSTuzel " +
                                                "except " +
                                                "select * from GercekAskiOlmayanUyeler " +
                                                ") " +
                                                "select DR.DereceKey as [Key],DR.Kod as Ad, " +
                                                "COUNT(GAU.GercekAskiOlanSicilKey) as GercekUye1, " +
                                                "COUNT(GAOU.GercekAskiOlmayanSicilKey) as GercekUye2, " +
                                                "COUNT(TAU.TuzelAskiOlanSicilKey) as TuzelUye1, " +
                                                "COUNT(TAOU.TuzelAskiOlmayanSicilKey) as TuzelUye2, " +
                                                "(COUNT(GAU.GercekAskiOlanSicilKey)+COUNT(GAOU.GercekAskiOlmayanSicilKey)) as Toplam1, " +
                                                "(COUNT(TAU.TuzelAskiOlanSicilKey)+COUNT(TAOU.TuzelAskiOlmayanSicilKey)) as Toplam2 " +
                                                "from MERKEZ_BORSA.TUCCAR_SICIL as TS " +
                                                "inner join MERKEZ_BORSA.TT_DERECE as DR on TS.DereceKey=DR.DereceKey " +
                                                "left join GercekAskiOlanUyeler as GAU on TS.TuccarSicilKey=GAU.GercekAskiOlanSicilKey " +
                                                "left join GercekAskiOlmayanUyeler as GAOU on TS.TuccarSicilKey=GAOU.GercekAskiOlmayanSicilKey " +
                                                "left join TuzelAskiOlanUyeler as TAU on TS.TuccarSicilKey=TAU.TuzelAskiOlanSicilKey " +
                                                "left join TuzelAskiOlmayanUyeler as TAOU on TS.TuccarSicilKey=TAOU.TuzelAskiOlmayanSicilKey " +
                                                "group by DR.DereceKey,DR.Kod " +
                                                "order by DR.DereceKey";

        public const string IlIlceGrupQuery = "with  GercekUyeler as " +
                                                "( " +
                                                "select TSGercek.TuccarSicilKey as GercekSicilKey from MERKEZ_BORSA.TUCCAR_SICIL as TSGercek " +
                                                "left join MERKEZ_BORSA.FIRMA_SAHIS as FS on TSGercek.TuccarSicilKey= FS.TuccarSicilKey " +
                                                "where FS.FirmaSahisKey is not null " +
                                                "and TSGercek.TerkinTarihi is null " +
                                                ") " +
                                                ",TuzelUyeler as " +
                                                "( " +
                                                "select TSTuzel.TuccarSicilKey as TuzelSicilKey from MERKEZ_BORSA.TUCCAR_SICIL as TSTuzel " +
                                                "left join MERKEZ_BORSA.FIRMA_SAHIS as FS on TSTuzel.TuccarSicilKey= FS.TuccarSicilKey " +
                                                "where FS.FirmaSahisKey is  null " +
                                                "and TSTuzel.TerkinTarihi is null " +
                                                ") " +
                                                "select II.IlIlceKey as [Key],II.Kod,II.IlIlceAdi as Ad,COUNT(GU.GercekSicilKey) as GercekUye1,COUNT(TU.TuzelSicilKey) as TuzelUye1,(COUNT(GU.GercekSicilKey)+COUNT(TU.TuzelSicilKey)) as Toplam2 from MERKEZ_BORSA.TUCCAR_SICIL as TS " +
                                                "inner join MERKEZ_BORSA.TT_IL_ILCE as II on TS.IlIlceKey=II.IlIlceKey " +
                                                "left join GercekUyeler as GU on TS.TuccarSicilKey=GU.GercekSicilKey " +
                                                "left join TuzelUyeler as TU on TS.TuccarSicilKey=TU.TuzelSicilKey " +
                                                "group by II.IlIlceKey,II.Kod,II.IlIlceAdi " +
                                                "order by II.IlIlceKey";

    }
}
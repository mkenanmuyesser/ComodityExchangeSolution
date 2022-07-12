using System;
using System.Linq;
using TicaretBorsasi_Project.Class.CustomType;
using TicaretBorsasi_Project.Class.CustomType.MerkezBorsa;
using TicaretBorsasi_Project.Data;

namespace TicaretBorsasi_Project.Class.Business
{
    public class AidatBS
    {
        public static AidatCezaHesapType Hesapla(short pAidatYili, decimal pTaksit1, decimal pTaksit2)
        {
            decimal pCezaOranTaksit1 = 0;
            decimal pCezaOranTaksit2 = 0;

            using (var entity = new DBEntities())
            {
                int bulundugumuzyil = DateTime.Now.Year;
                int bulundugumuzay = DateTime.Now.Month;
                bool farkyilvarmi = pAidatYili != bulundugumuzyil;

                for (int i = pAidatYili; i <= bulundugumuzyil; i++)
                {
                    TT_DERECE_CEZA_ORAN _TT_DERECE_CEZA_ORAN =
                        entity.TT_DERECE_CEZA_ORAN.SingleOrDefault(p => p.Yil == i);

                    int taksit1ay = _TT_DERECE_CEZA_ORAN.Taksit1.Value;
                    int taksit2ay = _TT_DERECE_CEZA_ORAN.Taksit2.Value;

                    if (bulundugumuzyil > pAidatYili || bulundugumuzay > taksit1ay)
                    {
                        //ilk taksite kadar olan ceza hesaplanacak 

                        for (int j = 1;
                             (farkyilvarmi
                                  ? (bulundugumuzyil == i ? (j < bulundugumuzay && j <= taksit1ay) : (j <= 12))
                                  : j < taksit1ay);
                             j++)
                        {
                            switch (j)
                            {
                                case 1:
                                    pCezaOranTaksit1 += _TT_DERECE_CEZA_ORAN.Ay1.Value;
                                    break;
                                case 2:
                                    pCezaOranTaksit1 += _TT_DERECE_CEZA_ORAN.Ay2.Value;
                                    break;
                                case 3:
                                    pCezaOranTaksit1 += _TT_DERECE_CEZA_ORAN.Ay3.Value;
                                    break;
                                case 4:
                                    pCezaOranTaksit1 += _TT_DERECE_CEZA_ORAN.Ay4.Value;
                                    break;
                                case 5:
                                    pCezaOranTaksit1 += _TT_DERECE_CEZA_ORAN.Ay5.Value;
                                    break;
                                case 6:
                                    pCezaOranTaksit1 += _TT_DERECE_CEZA_ORAN.Ay6.Value;
                                    break;
                                case 7:
                                    pCezaOranTaksit1 += _TT_DERECE_CEZA_ORAN.Ay7.Value;
                                    break;
                                case 8:
                                    pCezaOranTaksit1 += _TT_DERECE_CEZA_ORAN.Ay8.Value;
                                    break;
                                case 9:
                                    pCezaOranTaksit1 += _TT_DERECE_CEZA_ORAN.Ay9.Value;
                                    break;
                                case 10:
                                    pCezaOranTaksit1 += _TT_DERECE_CEZA_ORAN.Ay10.Value;
                                    break;
                                case 11:
                                    pCezaOranTaksit1 += _TT_DERECE_CEZA_ORAN.Ay11.Value;
                                    break;
                                case 12:
                                    pCezaOranTaksit1 += _TT_DERECE_CEZA_ORAN.Ay12.Value;
                                    break;
                            }
                        }
                    }

                    if (bulundugumuzyil > pAidatYili || bulundugumuzay > taksit2ay)
                    {
                        //ikinci taksite kadar olan detay hesaplanacak

                        for (
                            int j = (farkyilvarmi
                                         ? ((bulundugumuzyil == i || pAidatYili != i) ? 1 : taksit2ay + 1)
                                         : taksit2ay);
                            (farkyilvarmi
                                 ? ((bulundugumuzyil == i) ? (j < bulundugumuzay) : (j <= 12))
                                 : j <= bulundugumuzay);
                            j++)
                        {
                            switch (j)
                            {
                                case 1:
                                    pCezaOranTaksit2 += _TT_DERECE_CEZA_ORAN.Ay1.Value;
                                    break;
                                case 2:
                                    pCezaOranTaksit2 += _TT_DERECE_CEZA_ORAN.Ay2.Value;
                                    break;
                                case 3:
                                    pCezaOranTaksit2 += _TT_DERECE_CEZA_ORAN.Ay3.Value;
                                    break;
                                case 4:
                                    pCezaOranTaksit2 += _TT_DERECE_CEZA_ORAN.Ay4.Value;
                                    break;
                                case 5:
                                    pCezaOranTaksit2 += _TT_DERECE_CEZA_ORAN.Ay5.Value;
                                    break;
                                case 6:
                                    pCezaOranTaksit2 += _TT_DERECE_CEZA_ORAN.Ay6.Value;
                                    break;
                                case 7:
                                    pCezaOranTaksit2 += _TT_DERECE_CEZA_ORAN.Ay7.Value;
                                    break;
                                case 8:
                                    pCezaOranTaksit2 += _TT_DERECE_CEZA_ORAN.Ay8.Value;
                                    break;
                                case 9:
                                    pCezaOranTaksit2 += _TT_DERECE_CEZA_ORAN.Ay9.Value;
                                    break;
                                case 10:
                                    pCezaOranTaksit2 += _TT_DERECE_CEZA_ORAN.Ay10.Value;
                                    break;
                                case 11:
                                    pCezaOranTaksit2 += _TT_DERECE_CEZA_ORAN.Ay11.Value;
                                    break;
                                case 12:
                                    pCezaOranTaksit2 += _TT_DERECE_CEZA_ORAN.Ay12.Value;
                                    break;
                            }
                        }
                    }
                }
            }


            decimal AidatToplam = pTaksit1 + pTaksit2;
            decimal Ceza = (pTaksit1*pCezaOranTaksit1) + (pTaksit2*pCezaOranTaksit2);
            decimal AidatCezaToplam = AidatToplam + Ceza;

            var data = new AidatCezaHesapType
                {
                    Key = Guid.NewGuid(),
                    AidatYili = pAidatYili,
                    Taksit1 = pTaksit1,
                    Taksit2 = pTaksit2,
                    AidatToplam = AidatToplam,
                    Ceza = Ceza,
                    AidatCezaToplam = AidatCezaToplam,
                };


            return data;
        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using TicaretBorsasi_Project.Data;

namespace TicaretBorsasi_Project.Class.Business
{
    public class MuhasebeBS
    {
        public static string MuhasebeHesapNo(string pHesapNo)
        {
            pHesapNo = pHesapNo.Replace("_", "").Replace(" ", "").Trim();
            if (string.IsNullOrEmpty(pHesapNo))
            {
                return "";
            }
            else if (pHesapNo.Length == 3)
            {
                return pHesapNo;
            }
            else if (pHesapNo.Length == 5)
            {
                pHesapNo = pHesapNo.Substring(0, 3) + "_" + pHesapNo.Substring(3, 2);
                return pHesapNo;
            }
            else if (pHesapNo.Length == 10)
            {
                pHesapNo = pHesapNo.Substring(0, 3) + "_" + pHesapNo.Substring(3, 2) + "_" + pHesapNo.Substring(5, 5);
                return pHesapNo;
            }
            else
            {
                return "";
            }
        }

        public static bool MuhasebeHesapNoHatalimi(string pHesapNo)
        {
            pHesapNo = pHesapNo.Replace("_", "").Replace(" ", "").Trim();
            if (string.IsNullOrEmpty(pHesapNo) || !(pHesapNo.Length == 3 || pHesapNo.Length == 5 || pHesapNo.Length == 10))
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        public static string AnaHesapDondur(DBEntities pEntity, int pMuhasebeTip, string pHesapKodu)
        {
            string sonuc = "";
            var hesapplani = pEntity.HESAP_PLANI.SingleOrDefault(p => p.MuhasebeTipKey == pMuhasebeTip && p.HesapKodu == pHesapKodu.Substring(0, 3));
            if (hesapplani != null)
            {
                sonuc = hesapplani.HesapAdi;
            }
            return sonuc;
        }
    }
}
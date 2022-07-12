using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using TicaretBorsasi_Project.Class.Helper;
using TicaretBorsasi_Project.Data;

namespace TicaretBorsasi_Project.Program.MerkezBorsa.BeyannameTescilIslemleri
{
    public partial class BeyannameTescilUcretTavanAsanlar : Page
    {
        #region Properties

        #endregion

        #region Events

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                SetInitials();
            }
            else
            {
                GridViewTescilUcretTavanAsanlar.DataSource = PageHelper.SessionData;
                GridViewTescilUcretTavanAsanlar.DataBind();
            }
        }

        protected void ButtonRapor_Click(object sender, EventArgs e)
        {
            GridViewTescilUcretTavanAsanlar.DataSource = PageHelper.SessionData;
            GridViewTescilUcretTavanAsanlar.DataBind();

            switch (ComboBoxRapor.SelectedIndex)
            {
                case 0:
                    GridViewExporterTescilUcretTavanAsanlar.WriteXlsxToResponse("Tescil Ücret Tavanı Aşanlar");
                    break;
                case 1:
                    GridViewExporterTescilUcretTavanAsanlar.WritePdfToResponse("Tescil Ücret Tavanı Aşanlar");
                    break;
                default:
                    break;
            }
        }

        protected void ButtonAra_Click(object sender, EventArgs e)
        {
            Ara();
        }

        protected void ButtonTemizle_Click(object sender, EventArgs e)
        {
            Response.Redirect(Request.Url.AbsoluteUri);
        }

        #endregion

        #region Methods

        private void SetInitials()
        {
            LabelBaslik.Text = "TESCİL ÜCRET TAVANI AŞANLAR";
            PageHelper.SessionData = null;

            DateEditBaslangic.Date = new DateTime(DateTime.Now.Year, 01, 01);
            DateEditBitis.Date = DateTime.Now;

            using (var entity = new DBEntities())
            {
                List<TT_BEYAN_TIP> listBEYAN_TIP = entity.TT_BEYAN_TIP.AsNoTracking().OrderBy(p => p.BeyanTipKey).ToList();
                listBEYAN_TIP.Insert(0, new TT_BEYAN_TIP { BeyanTipKey = 0, BeyanTipAdi = "TÜMÜ", Aciklama = "TÜMÜ" });
                ComboBoxBeyannameTipi.DataSource = listBEYAN_TIP;
                ComboBoxBeyannameTipi.DataBind();

                ComboBoxBeyannameTipi.SelectedIndex = 0;

                string oran = "0,0000";
                TESCIL_ORAN _TESCIL_ORAN = entity.TESCIL_ORAN.FirstOrDefault();
                if (_TESCIL_ORAN != null)
                {
                    oran = _TESCIL_ORAN.Tavan.ToString();
                }

                LabelUcretTavan.Text = string.Format("Ücret tavan bilgisi : {0}", oran);
            }
        }

        private void Ara()
        {
            using (var entity = new DBEntities())
            {
                int? pBeyannameTip = ComboBoxBeyannameTipi.SelectedIndex == 0 ? null : (int?)Convert.ToInt32(ComboBoxBeyannameTipi.SelectedItem.Value);
                string pSicilNoBaslangic = SpinEditSicilNoBaslangic.Text.Trim();
                string pSicilNoBitis = SpinEditSicilNoBitis.Text.Trim();
                DateTime pBaslangic = DateEditBaslangic.Date;
                DateTime pBitis = DateEditBitis.Date;
                string pSubeKodBaslangic = SpinEditBaslangicSubeKodu.Text.Trim();
                string pSubeKodBitis = SpinEditBitisSubeKodu.Text.Trim();
                bool pFaturaNo = CheckBoxFaturaNo.Checked;

                GridViewTescilUcretTavanAsanlar.DataSource = null;
                var sonuc =
                    entity.BEYANs.Include("TUCCAR_SICIL")
                          .Include("TT_BEYAN_TIP")
                          .Include("TT_BORSA_SUBE")
                          .ToList()
                          .Select(p => new
                              {
                                  p.BeyanKey,
                                  p.TescilMiktar,
                                  p.BeyanTipKey,
                                  SicilNo = p.TUCCAR_SICIL.SicilNo,
                                  Tarih = p.BeyanTarihi,
                                  SubeKodu = p.TT_BORSA_SUBE.Kod,
                                  FaturaNoGirilmis = string.IsNullOrEmpty(p.BeyanFaturaNo) ? false : true,

                                  TescilTarihi = p.BeyanTarihi,
                                  TescilNo = p.BeyanNo.TrimStart('0'),
                                  BeyanTip = p.TT_BEYAN_TIP.BeyanTipAdi,
                                  FaturaNo = p.BeyanFaturaNo,
                                  SatisSayisi = p.BeyanSatirNo.TrimStart('0'),
                                  EmtiaTutari = p.BeyanSatisTutari
                              });

                #region koşullar

                //tescil ücreti limitten büyük olanlar
                decimal oran = 0.0000m;
                TESCIL_ORAN _TESCIL_ORAN = entity.TESCIL_ORAN.FirstOrDefault();
                if (_TESCIL_ORAN != null)
                {
                    oran = _TESCIL_ORAN.Tavan.Value;
                }
                sonuc = sonuc.Where(p => p.TescilMiktar >= oran);

                if (pBeyannameTip != null)
                {
                    sonuc = sonuc.Where(p => p.BeyanTipKey == pBeyannameTip);
                }

                if (!string.IsNullOrEmpty(pSicilNoBaslangic) || !string.IsNullOrEmpty(pSicilNoBitis))
                {
                    if (!string.IsNullOrEmpty(pSicilNoBaslangic) && string.IsNullOrEmpty(pSicilNoBitis))
                    {
                        int baslangic;
                        if (!int.TryParse(pSicilNoBaslangic, out baslangic))
                        {
                            PageHelper.MessageBox(this, "Sicil numara girişi hatalıdır!");
                            return;
                        }

                        for (int i = pSicilNoBaslangic.Length; i < 6; i++)
                        {
                            pSicilNoBaslangic = "0" + pSicilNoBaslangic;
                        }
                        sonuc = sonuc.Where(p => p.SicilNo == pSicilNoBaslangic);
                    }
                    else
                    {
                        int baslangic;
                        int bitis;
                        if (int.TryParse(pSicilNoBaslangic, out baslangic) && int.TryParse(pSicilNoBitis, out bitis))
                        {
                            sonuc =
                                sonuc.Where(
                                    p =>
                                    Convert.ToInt32(p.SicilNo) >= baslangic && Convert.ToInt32(p.SicilNo) <= bitis);
                        }
                        else
                        {
                            PageHelper.MessageBox(this, "Sicil numara girişi hatalıdır!");
                            return;
                        }
                    }
                }

                sonuc = sonuc.Where(p => p.Tarih != null && p.Tarih >= pBaslangic && p.Tarih <= pBitis);

                if (!string.IsNullOrEmpty(pSubeKodBaslangic) || !string.IsNullOrEmpty(pSubeKodBitis))
                {
                    if (!string.IsNullOrEmpty(pSubeKodBaslangic) && string.IsNullOrEmpty(pSubeKodBitis))
                    {
                        int baslangic;
                        if (!int.TryParse(pSubeKodBaslangic, out baslangic))
                        {
                            PageHelper.MessageBox(this, "Şube kodu girişi hatalıdır!");
                            return;
                        }

                        sonuc = sonuc.Where(p => p.SubeKodu == pSubeKodBaslangic);
                    }
                    else
                    {
                        int baslangic;
                        int bitis;
                        if (int.TryParse(pSubeKodBaslangic, out baslangic) && int.TryParse(pSubeKodBitis, out bitis))
                        {
                            sonuc =
                                sonuc.Where(
                                    p =>
                                    Convert.ToInt32(p.SubeKodu) >= baslangic && Convert.ToInt32(p.SubeKodu) <= bitis);
                        }
                        else
                        {
                            PageHelper.MessageBox(this, "Şube kodu girişi hatalıdır!");
                            return;
                        }
                    }
                }

                if (!pFaturaNo)
                {
                    sonuc = sonuc.Where(p => p.FaturaNoGirilmis == false);
                }

                #endregion

                #region sıralama

                sonuc = sonuc.OrderBy(p => Convert.ToInt32(p.TescilNo)).OrderBy(p => p.Tarih).OrderBy(p => p.SubeKodu);

                #endregion

                GridViewTescilUcretTavanAsanlar.DataSource = sonuc;
                PageHelper.SessionData = GridViewTescilUcretTavanAsanlar.DataSource;
                GridViewTescilUcretTavanAsanlar.DataBind();

            }
        }

        #endregion
    }
}
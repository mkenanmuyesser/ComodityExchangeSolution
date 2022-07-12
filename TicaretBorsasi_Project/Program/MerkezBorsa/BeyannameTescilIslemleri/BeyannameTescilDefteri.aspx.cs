using DevExpress.Web.ASPxGridView;
using System;
using System.Linq;
using System.Web.UI;
using TicaretBorsasi_Project.Class.Helper;
using TicaretBorsasi_Project.Data;

namespace TicaretBorsasi_Project.Program.MerkezBorsa.BeyannameTescilIslemleri
{
    public partial class BeyannameTescilDefteri : Page
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
                GridViewTescilDefteri.DataSource = PageHelper.SessionData;
                GridViewTescilDefteri.DataBind();
            }
        }

        protected void ButtonRapor_Click(object sender, EventArgs e)
        {
            GridViewTescilDefteri.DataSource = PageHelper.SessionData;
            GridViewTescilDefteri.DataBind();

            switch (ComboBoxRapor.SelectedIndex)
            {
                case 0:
                    GridViewExporterTescilDefteri.WriteXlsxToResponse("Tescil Defteri");
                    break;
                case 1:
                    GridViewExporterTescilDefteri.WritePdfToResponse("Tescil Defteri");
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
            LabelBaslik.Text = "TESCİL DEFTERİ";
            PageHelper.SessionData = null;

            DateEditBaslangic.Date = new DateTime(DateTime.Now.Year, 01, 01);
            DateEditBitis.Date = DateTime.Now;
        }

        private void Ara()
        {
            using (var entity = new DBEntities())
            {
                DateTime pBaslangic = DateEditBaslangic.Date;
                DateTime pBitis = DateEditBitis.Date;
                string pSubeKodBaslangic = SpinEditBaslangicSubeKodu.Text.Trim();
                string pSubeKodBitis = SpinEditBitisSubeKodu.Text.Trim();

                GridViewTescilDefteri.DataSource = null;
                var sonuc = entity.BEYANs.Include("TUCCAR_SICIL").Include("TT_BORSA_SUBE").Include("TT_MADDE_KOD").Include("TT_BIRIM_TIP").AsNoTracking().ToList().Select(p => new
                    {
                        Key = p.TT_BORSA_SUBE.Kod + "-" + p.BeyanTarihi.Value.Date.ToString("yyyyMMdd") + "-" + p.BeyanNo.ToString(),
                        BeyanKey = p.BeyanKey,
                        TescilNo = p.BeyanNo,
                        Sira = p.BeyanSatirNo,
                        SubeKodu = p.TT_BORSA_SUBE.Kod,
                        Tarih = p.BeyanTarihi,
                        Cinsi = p.TT_MADDE_KOD.Adi,
                        Miktari = p.BeyanMiktar,
                        SicilNo = p.TUCCAR_SICIL.SicilNo,
                        BirimFiyati = p.BirimFiyat,
                        Birim = p.TT_BIRIM_TIP.BirimTipAdi,
                        Tutar = p.BeyanSatisTutari,
                        BorsaUcret = p.TescilMiktar,
                        Sube = p.TT_BORSA_SUBE.BorsaSubeAdi,
                    });

                #region koşullar

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

                #endregion

                sonuc = sonuc.Select(p => new
                {
                    p.Key,
                    p.BeyanKey,
                    p.TescilNo,
                    p.Sira,
                    p.SubeKodu,
                    p.Tarih,
                    p.Cinsi,
                    p.Miktari,
                    p.SicilNo,
                    p.BirimFiyati,
                    p.Birim,
                    p.Tutar,
                    p.BorsaUcret,
                    p.Sube,
                });
                GridViewTescilDefteri.DataSource = sonuc;
                PageHelper.SessionData = GridViewTescilDefteri.DataSource;
                GridViewTescilDefteri.DataBind();

                GridViewTescilDefteri.ExpandAll();
            }
        }

        #endregion
    }
}
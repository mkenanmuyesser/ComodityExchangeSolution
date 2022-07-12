using DevExpress.Web.ASPxEditors;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using TicaretBorsasi_Project.Data;

namespace TicaretBorsasi_Project.Program.MerkezBorsa.MuhasebeIslemleri
{
    public partial class MuhasebeHesapBakiyesi : Page
    {
        #region Properties

        private int HesapPlaniKey
        {
            get
            {
                string key = Request.QueryString["Key"];
                if (Session["HesapPlaniKey"] == null || key != Session["HesapPlaniKey"].ToString())
                {
                    Session["HesapPlaniKey"] = key;
                }

                int keysonuc;
                int.TryParse(key, out keysonuc);
                return keysonuc;
            }
        }

        private int MuhasebeKey
        {
            get
            {
                int sonuc = 0;
                object muhasebekey = Session["MuhasebeKey"];
                if (muhasebekey == null)
                {
                    return 0;
                }
                else
                {
                    int.TryParse(muhasebekey.ToString(), out sonuc);
                }
                return sonuc;
            }
            set { Session["MuhasebeKey"] = value; }
        }

        private int Yil
        {
            get
            {
                int sonuc = 0;
                object yil = Session["Yil"];
                if (yil == null)
                {
                    Session["Yil"] = DateTime.Now.Year;
                    return DateTime.Now.Year;
                }
                else
                {
                    int.TryParse(yil.ToString(), out sonuc);
                }
                return sonuc;
            }
            set { Session["Yil"] = value; }
        }

        private int Sira
        {
            get
            {
                int sonuc = 0;
                object sira = Session["Sira"];
                if (sira == null)
                {
                    Session["Sira"] = 0;
                    return 0;
                }
                else
                {
                    int.TryParse(sira.ToString(), out sonuc);
                }
                return sonuc;
            }
            set { Session["Sira"] = value; }
        }

        #endregion

        #region Events

        protected void Page_Load(object sender, EventArgs e)
        {
            SetInitials();
        }

        protected void ButtonAra_Click(object sender, EventArgs e)
        {
            using (var entity = new DBEntities())
            {
                //string sicilno = TextBoxSicilNo.Text;
                //var _TUCCAR_SICIL = entity.TUCCAR_SICIL.SingleOrDefault(p => p.SicilNo == sicilno);
                //if (_TUCCAR_SICIL == null)
                //{
                //    PageHelper.MessageBox(this, "Tüccar bulunamadı.");
                //}
                //else
                //{
                //    int key = _TUCCAR_SICIL.TuccarSicilKey;
                //    Response.Redirect(string.Format("MuhasebeHesapBakiyesi.aspx?Key={0}", key));
                //}
            }
        }

        protected void ButtonGeriIleri_Click(object sender, EventArgs e)
        {
            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                int pMuhasebeTipKey = Convert.ToInt32(ComboBoxMuhasebeTip.SelectedItem.Value);
                string hesapno = TextBoxHesapNo.Text.Replace("_", "").Replace(" ", "").Trim();
                long hesapkodu;
                long.TryParse(hesapno, out hesapkodu);
                var hesaplistesi = entity.HESAP_PLANI.AsNoTracking().Where(p => p.MuhasebeTipKey == pMuhasebeTipKey).ToList().OrderBy(p => p.HesapKodu);
                HESAP_PLANI _HESAP_PLANI = null;

                string butonadi = ((ASPxButton)sender).ID;
                switch (butonadi)
                {
                    case "ButtonGeri":
                        Sira--;
                        if (Sira < 0)
                        {
                            Sira = 0;
                        }

                        _HESAP_PLANI = hesaplistesi.Skip(Sira).FirstOrDefault();
                        if (_HESAP_PLANI == null)
                        {
                            _HESAP_PLANI = hesaplistesi.First();

                        }
                        break;
                    case "ButtonIleri":
                        Sira++;
                        if (Sira > hesaplistesi.Count())
                        {
                            Sira = hesaplistesi.Count();
                        }
                        _HESAP_PLANI = hesaplistesi.Skip(Sira).FirstOrDefault();
                        if (_HESAP_PLANI == null)
                        {
                            _HESAP_PLANI = hesaplistesi.Last();

                        }
                        break;
                }

                int key = _HESAP_PLANI.HesapPlaniKey;
                Response.Redirect(string.Format("MuhasebeHesapBakiyesi.aspx?Key={0}", key));
            }
        }

        protected void ButtonTemizle_Click(object sender, EventArgs e)
        {
            Response.Redirect("MuhasebeHesapBakiyesi.aspx");
        }

        protected void ComboBoxMuhasebeTip_SelectedIndexChanged(object sender, EventArgs e)
        {
            MuhasebeKey = Convert.ToInt32(ComboBoxMuhasebeTip.SelectedItem.Value);
        }

        protected void ComboBoxYil_SelectedIndexChanged(object sender, EventArgs e)
        {
            Yil = Convert.ToInt32(ComboBoxYil.SelectedItem.Value);
        }

        #endregion

        #region Methods

        private void SetInitials()
        {
            LabelBaslik.Text = "HESAP BAKİYESİ";

            if (!IsPostBack)
            {
                DataLoad();
            }
        }

        private void DataLoad()
        {
            using (var entity = new DBEntities())
            {
                List<TT_MUHASEBE_TIP> listMUHASEBE_TIP = entity.TT_MUHASEBE_TIP.ToList();
                var yillar = new List<int>();
                for (int i = DateTime.Now.Year; i >= 1900; i--)
                {
                    yillar.Add(i);
                }

                ComboBoxMuhasebeTip.DataSource = listMUHASEBE_TIP;
                ComboBoxMuhasebeTip.DataBind();
                if (MuhasebeKey != 0)
                {
                    ComboBoxMuhasebeTip.Items.FindByValue(MuhasebeKey).Selected = true;
                }

                ComboBoxYil.DataSource = yillar;
                ComboBoxYil.DataBind();
                ComboBoxYil.Items.FindByValue(Yil).Selected = true;

                if (HesapPlaniKey != 0)
                {
                    HESAP_PLANI _HESAP_PLANI = entity.HESAP_PLANI.SingleOrDefault(p => p.HesapPlaniKey == HesapPlaniKey);
                    if (_HESAP_PLANI == null)
                    {
                        Response.Redirect("MuhasebeHesapBakiyesi.aspx");
                        return;
                    }

                    decimal borctoplami = BorcToplami(_HESAP_PLANI);
                    decimal alacaktoplami = AlacakToplami(_HESAP_PLANI);

                    TextBoxHesapNo.Text = _HESAP_PLANI.HesapKodu;
                    LabelHesapAdi.Text = _HESAP_PLANI.HesapAdi;
                    LabelBorcToplami.Text = borctoplami.ToString("N");
                    LabelAlacakToplami.Text = alacaktoplami.ToString("N");
                    LabelAlacakBakiye.Text = (borctoplami - alacaktoplami).ToString("N");
                }
            }
        }

        private decimal BorcToplami(HESAP_PLANI pHesapPlani)
        {
            decimal borctoplami = 0;
            borctoplami = pHesapPlani.BorcOcak +
                          pHesapPlani.BorcSubat +
                          pHesapPlani.BorcMart +
                          pHesapPlani.BorcNisan +
                          pHesapPlani.BorcMayis +
                          pHesapPlani.BorcHaziran +
                          pHesapPlani.BorcTemmuz +
                          pHesapPlani.BorcAgustos +
                          pHesapPlani.BorcEylul +
                          pHesapPlani.BorcEkim +
                          pHesapPlani.BorcKasim +
                          pHesapPlani.BorcAralik;
            return borctoplami;
        }

        private decimal AlacakToplami(HESAP_PLANI pHesapPlani)
        {
            decimal alacaktoplami = 0;
            alacaktoplami = pHesapPlani.AlacakOcak +
                            pHesapPlani.AlacakSubat +
                            pHesapPlani.AlacakMart +
                            pHesapPlani.AlacakNisan +
                            pHesapPlani.AlacakMayis +
                            pHesapPlani.AlacakHaziran +
                            pHesapPlani.AlacakTemmuz +
                            pHesapPlani.AlacakAgustos +
                            pHesapPlani.AlacakEylul +
                            pHesapPlani.AlacakEkim +
                            pHesapPlani.AlacakKasim +
                            pHesapPlani.AlacakAralik;
            return alacaktoplami;
        }

        #endregion

    }
}
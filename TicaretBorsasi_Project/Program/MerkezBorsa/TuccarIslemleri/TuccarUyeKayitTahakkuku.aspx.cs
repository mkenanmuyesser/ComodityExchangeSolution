using System;
using System.Linq;
using System.Web.UI;
using DevExpress.Web.ASPxEditors;
using TicaretBorsasi_Project.Class.Helper;
using TicaretBorsasi_Project.Data;

namespace TicaretBorsasi_Project.Program.MerkezBorsa.TuccarIslemleri
{
    public partial class TuccarUyeKayitTahakkuku : Page
    {
        #region Properties

        private int TuccarSicilKey
        {
            get
            {
                string key = Request.QueryString["Key"];
                if (Session["TuccarSicilKey"] == null || key != Session["TuccarSicilKey"].ToString())
                {
                    Session["TuccarSicilKey"] = key;
                }

                int keysonuc;
                int.TryParse(key, out keysonuc);
                return keysonuc;
            }
        }

        #endregion

        #region Events

        protected void Page_Load(object sender, EventArgs e)
        {
            SetInitials();
        }

        protected void ButtonGeriIleri_Click(object sender, EventArgs e)
        {
            using (var entity = new DBEntities())
            {
                int sicilno = Convert.ToInt32(PageHelper.SicilNoTamamlama(TextBoxSicilNo.Text));
                string butonadi = ((ASPxButton) sender).ID;
                IOrderedEnumerable<TUCCAR_SICIL> tuccarlistesi = entity.TUCCAR_SICIL.ToList().OrderBy(p => p.SicilNo);
                TUCCAR_SICIL _TUCCAR_SICIL = null;
                switch (butonadi)
                {
                    case "ButtonGeri":
                        _TUCCAR_SICIL = tuccarlistesi.LastOrDefault(p => Convert.ToInt32(p.SicilNo) < sicilno);
                        if (_TUCCAR_SICIL == null)
                        {
                            _TUCCAR_SICIL = tuccarlistesi.First();
                        }
                        break;
                    case "ButtonIleri":
                        _TUCCAR_SICIL = tuccarlistesi.FirstOrDefault(p => Convert.ToInt32(p.SicilNo) > sicilno);
                        if (_TUCCAR_SICIL == null)
                        {
                            _TUCCAR_SICIL = tuccarlistesi.Last();
                        }
                        break;
                }

                int key = _TUCCAR_SICIL.TuccarSicilKey;
                Response.Redirect(string.Format("TuccarUyeKayitTahakkuku.aspx?Key={0}", key));
            }
        }

        protected void ButtonAra_Click(object sender, EventArgs e)
        {
            using (var entity = new DBEntities())
            {
                string sicilno = PageHelper.SicilNoTamamlama(TextBoxSicilNo.Text);
                TUCCAR_SICIL _TUCCAR_SICIL = entity.TUCCAR_SICIL.SingleOrDefault(p => p.SicilNo == sicilno);
                if (_TUCCAR_SICIL == null)
                {
                    PageHelper.MessageBox(this, "Tüccar bulunamadı.");
                }
                else
                {
                    int key = _TUCCAR_SICIL.TuccarSicilKey;
                    Response.Redirect(string.Format("TuccarUyeKayitTahakkuku.aspx?Key={0}", key));
                }
            }
        }

        #endregion

        #region Methods

        private void SetInitials()
        {
            LabelBaslik.Text = "ÜYE KAYIT TAHAKKUKU";

            if (!IsPostBack)
            {
                DataLoad();
            }
        }


        private void DataLoad()
        {
            DateEditKararTarihi.Text = string.Empty;
            TextBoxKayitUcreti.Text = string.Empty;
            DateEditVadeTarihi.Text = string.Empty;
            LabelDurum.Text = string.Empty;

            if (TuccarSicilKey != 0)
            {
                using (var entity = new DBEntities())
                {
                    entity.Configuration.AutoDetectChangesEnabled = false;

                    TUCCAR_SICIL _TUCCAR_SICIL =
                        entity.TUCCAR_SICIL
                              .Include("FIRMA_SAHIS")
                              .Include("TT_MESLEK_GRUP")
                              .Include("TUCCAR_ASKI")
                              .Include("TT_DERECE")
                              .Include("TT_KURULUS_TUR")
                              .Include("KAYIT_TAKIP")
                              .AsNoTracking()
                              .SingleOrDefault(p => p.TuccarSicilKey == TuccarSicilKey);
                    if (_TUCCAR_SICIL == null)
                    {
                        Response.Redirect("TuccarUyeKayitTahakkuku.aspx");
                        return;
                    }

                    string unvan = _TUCCAR_SICIL.Unvan;

                    TextBoxSicilNo.Text = _TUCCAR_SICIL.SicilNo;
                    TextBoxMeslekGrubu.Text = _TUCCAR_SICIL.TT_MESLEK_GRUP.MeslekAdi;
                    MemoUnvan.Text = unvan;
                    TextBoxDerece.Text = _TUCCAR_SICIL.TT_DERECE.Kod;
                    TextBoxSirketTipi.Text = _TUCCAR_SICIL.TT_KURULUS_TUR == null
                                                 ? ""
                                                 : _TUCCAR_SICIL.TT_KURULUS_TUR.Adi;

                    KAYIT_TAKIP _KAYIT_TAKIP = _TUCCAR_SICIL.KAYIT_TAKIP.SingleOrDefault();
                    if (_KAYIT_TAKIP == null)
                    {
                        LabelDurum.Text = "Bu Üyenin Kayıt Yılı Cari Yıl Değildir.";
                    }
                    else
                    {
                        DateEditKararTarihi.Value = _TUCCAR_SICIL.YKKTarihi;
                        TextBoxKayitUcreti.Text = _KAYIT_TAKIP.AidatMiktar == null
                                                      ? "0"
                                                      : _KAYIT_TAKIP.AidatMiktar.ToString();
                        DateEditVadeTarihi.Value = _KAYIT_TAKIP.VadeTarihi;
                        DateEditOdemeTarihi.Value = _KAYIT_TAKIP.OdemeTarihi;
                        TextBoxCeza.Text = _KAYIT_TAKIP.CezaMiktar == null ? "0" : _KAYIT_TAKIP.CezaMiktar.ToString();
                        LabelDurum.Text = "Bu Tahakkuk Kaydı Girilmiştir.";
                    }
                }
            }
        }

        #endregion
    }
}
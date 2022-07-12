using System;
using System.Linq;
using System.Web.Security;
using System.Web.UI;
using DevExpress.Web.ASPxEditors;
using TicaretBorsasi_Project.Class.Helper;
using TicaretBorsasi_Project.Data;

namespace TicaretBorsasi_Project.Program.MerkezBorsa.TuccarIslemleri
{
    public partial class TuccarKefaletTeminatIslemleri : Page
    {
        #region Properties

        private int TuccarKey
        {
            get
            {
                string key = Request.QueryString["TuccarKey"];
                if (Session["TuccarKey"] == null || key != Session["TuccarKey"].ToString())
                {
                    Session["TuccarKey"] = key;
                }

                int keysonuc;
                int.TryParse(key, out keysonuc);
                return keysonuc;
            }
        }

        private int KefilKey
        {
            get
            {
                string key = Request.QueryString["KefilKey"];
                if (Session["KefilKey"] == null || key != Session["KefilKey"].ToString())
                {
                    Session["KefilKey"] = key;
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
            string butonadi = ((ASPxButton) sender).ID;

            using (var entity = new DBEntities())
            {
                IOrderedEnumerable<TUCCAR_SICIL> tuccarlistesi =
                    entity.TUCCAR_KEFALET_TEMINAT.Include("TUCCAR_SICIL")
                          .ToList()
                          .Select(p => p.TUCCAR_SICIL)
                          .OrderBy(p => p.SicilNo);
                TUCCAR_SICIL _TUCCAR_SICIL = null;

                int sicilno = Convert.ToInt32(TextBoxTuccarSicilNo.Text);

                switch (butonadi)
                {
                    case "ButtonTuccarGeri":
                        _TUCCAR_SICIL = tuccarlistesi.LastOrDefault(p => Convert.ToInt32(p.SicilNo) < sicilno);
                        if (_TUCCAR_SICIL == null)
                        {
                            _TUCCAR_SICIL = tuccarlistesi.First();
                        }
                        break;
                    case "ButtonTuccarIleri":
                        _TUCCAR_SICIL = tuccarlistesi.FirstOrDefault(p => Convert.ToInt32(p.SicilNo) > sicilno);
                        if (_TUCCAR_SICIL == null)
                        {
                            _TUCCAR_SICIL = tuccarlistesi.Last();
                        }
                        break;
                }

                int kefilkey = 0;
                int tuccarkey = _TUCCAR_SICIL.TuccarSicilKey;
                TUCCAR_KEFALET_TEMINAT kefil =
                    entity.TUCCAR_KEFALET_TEMINAT.SingleOrDefault(p => p.TuccarKey == tuccarkey);
                if (kefil != null)
                {
                    kefilkey = kefil.KefilKey;
                }

                Response.Redirect(string.Format("TuccarKefaletTeminatIslemleri.aspx?TuccarKey={0}&KefilKey={1}",
                                                tuccarkey, kefilkey));
            }
        }

        protected void ButtonAra_Click(object sender, EventArgs e)
        {
            string butonadi = ((ASPxButton) sender).ID;

            using (var entity = new DBEntities())
            {
                string tuccarsicilno = TextBoxTuccarSicilNo.Text;
                string kefilsicilno = TextBoxKefilSicilNo.Text;

                int tuccarkey = 0;
                int kefilkey = 0;

                TUCCAR_SICIL _TUCCAR_SICIL = entity.TUCCAR_SICIL.SingleOrDefault(p => p.SicilNo == tuccarsicilno);
                TUCCAR_SICIL _KEFIL_SICIL = entity.TUCCAR_SICIL.SingleOrDefault(p => p.SicilNo == kefilsicilno);

                if (_TUCCAR_SICIL == null)
                {
                    PageHelper.MessageBox(this, "Tüccar bulunamadı.");
                }
                else
                {
                    tuccarkey = _TUCCAR_SICIL.TuccarSicilKey;

                    switch (butonadi)
                    {
                        case "ButtonTuccarAra":
                            TUCCAR_KEFALET_TEMINAT kefil =
                                entity.TUCCAR_KEFALET_TEMINAT.SingleOrDefault(p => p.TuccarKey == tuccarkey);
                            if (kefil != null && kefil.KefilKey != 0)
                            {
                                kefilkey = kefil.KefilKey;
                            }
                            break;
                        case "ButtonKefilAra":
                            kefilkey = _KEFIL_SICIL.TuccarSicilKey;
                            break;
                    }

                    Response.Redirect(string.Format("TuccarKefaletTeminatIslemleri.aspx?TuccarKey={0}&KefilKey={1}",
                                                    tuccarkey, kefilkey));
                }
            }
        }

        protected void ButtonKaydetGuncelle_Click(object sender, EventArgs e)
        {
            using (var entity = new DBEntities())
            {
                #region validation

                string pTuccarSicilNo = TextBoxTuccarSicilNo.Text;
                string pKefilSicilNo = TextBoxKefilSicilNo.Text;

                if ((TuccarKey == 0 && pTuccarSicilNo == "000000") || (KefilKey == 0 && pKefilSicilNo == "000000"))
                {
                    PageHelper.MessageBox(this, "Lütfen sicil no girişi yapınız!");
                    return;
                }
                else if (pTuccarSicilNo == pKefilSicilNo)
                {
                    PageHelper.MessageBox(this, "Aynı tüccarlar kayıt edilemez!");
                    return;
                }

                #endregion

                TUCCAR_KEFALET_TEMINAT _TUCCAR_KEFALET_TEMINAT =
                    entity.TUCCAR_KEFALET_TEMINAT.SingleOrDefault(p => p.TuccarKey == TuccarKey);
                bool ilkkayit = false;
                if (_TUCCAR_KEFALET_TEMINAT == null)
                {
                    ilkkayit = true;
                    _TUCCAR_KEFALET_TEMINAT = new TUCCAR_KEFALET_TEMINAT();
                }

                _TUCCAR_KEFALET_TEMINAT.TuccarKey = TuccarKey;
                _TUCCAR_KEFALET_TEMINAT.KefilKey = KefilKey;

                MembershipUser user = Membership.GetUser(true);
                Guid userkey = user == null ? Guid.Empty : (Guid) user.ProviderUserKey;
                if (ilkkayit)
                {
                    _TUCCAR_KEFALET_TEMINAT.KayitKisiKey = userkey;
                    _TUCCAR_KEFALET_TEMINAT.KayitTarih = DateTime.Now;
                    entity.TUCCAR_KEFALET_TEMINAT.Add(_TUCCAR_KEFALET_TEMINAT);
                }
                else
                {
                    _TUCCAR_KEFALET_TEMINAT.GuncelleKisiKey = userkey;
                    _TUCCAR_KEFALET_TEMINAT.GuncelleTarih = DateTime.Now;
                }

                entity.SaveChanges();

                Response.Redirect(string.Format("TuccarKefaletTeminatIslemleri.aspx?TuccarKey={0}&KefilKey={1}",
                                                TuccarKey, KefilKey));
            }
        }

        protected void ButtonIptal_Click(object sender, EventArgs e)
        {
            Response.Redirect("TuccarKefaletTeminatIslemleri.aspx");
        }

        protected void ButtonTemizle_Click(object sender, EventArgs e)
        {
            Response.Redirect(Request.Url.AbsoluteUri);
        }

        #endregion

        #region Methods

        private void SetInitials()
        {
            LabelBaslik.Text = "TÜCCAR KEFALET VE TEMİNAT İŞLEMLERİ";

            if (TuccarKey == 0)
            {
                ButtonKaydet.Visible = true;
                ButtonTemizle.Visible = true;
                ButtonGuncelle.Visible = false;
                ButtonIptal.Visible = false;
                divIslemler.Style.Value = "margin-left: 40%;";
            }
            else
            {
                ButtonKaydet.Visible = false;
                ButtonTemizle.Visible = false;
                ButtonGuncelle.Visible = true;
                ButtonIptal.Visible = true;
                divIslemler.Style.Value = "margin-left: 35%;";
            }

            if (!IsPostBack)
            {
                DataLoad();
            }
        }

        private void DataLoad()
        {
            if (TuccarKey != 0 || KefilKey != 0)
            {
                using (var entity = new DBEntities())
                {
                    entity.Configuration.AutoDetectChangesEnabled = false;

                    TUCCAR_SICIL _TUCCAR_SICIL = null;

                    if (TuccarKey != 0)
                    {
                        _TUCCAR_SICIL =
                            entity.TUCCAR_SICIL
                            .Include("TUCCAR_ASKI")
                            .AsNoTracking()
                            .SingleOrDefault(p => p.TuccarSicilKey == TuccarKey);
                        TuccarDoldur(_TUCCAR_SICIL);

                        TUCCAR_KEFALET_TEMINAT tuccarkefil =
                            entity.TUCCAR_KEFALET_TEMINAT
                            .AsNoTracking()
                            .SingleOrDefault(p => p.TuccarKey == TuccarKey);
                        if (tuccarkefil != null)
                        {
                            TUCCAR_SICIL kefil =
                                entity.TUCCAR_SICIL
                                .AsNoTracking()
                                .SingleOrDefault(p => p.TuccarSicilKey == tuccarkefil.KefilKey);
                            KefilDoldur(kefil);
                        }
                    }
                    else
                    {
                        TextBoxTuccarSicilNo.Text = string.Empty;
                        MemoTuccarUnvan.Text = string.Empty;
                        LabelTuccarDurum.Text = string.Empty;
                    }

                    if (KefilKey != 0)
                    {
                        _TUCCAR_SICIL =
                            entity.TUCCAR_SICIL
                            .Include("TUCCAR_ASKI")
                            .AsNoTracking()
                            .SingleOrDefault(p => p.TuccarSicilKey == KefilKey);
                        KefilDoldur(_TUCCAR_SICIL);
                    }
                    else
                    {
                        TextBoxKefilSicilNo.Text = string.Empty;
                        MemoKefilUnvan.Text = string.Empty;
                        LabelKefilDurum.Text = string.Empty;
                    }

                    if (_TUCCAR_SICIL == null)
                    {
                        Response.Redirect("TuccarKefaletTeminatIslemleri.aspx");
                        return;
                    }
                }
            }
        }

        private void TuccarDoldur(TUCCAR_SICIL tuccar)
        {
            if (tuccar != null)
            {
                TextBoxTuccarSicilNo.Text = tuccar.SicilNo;
                MemoTuccarUnvan.Text = tuccar.Unvan;
                LabelTuccarDurum.Text =
                    tuccar.TUCCAR_ASKI.Any(p => p.AskiTarihi != null && p.BitisTarihi == null)
                        ? "ASKI"
                        : "FAAL";
            }
        }

        private void KefilDoldur(TUCCAR_SICIL kefil)
        {
            if (kefil != null)
            {
                TextBoxKefilSicilNo.Text = kefil.SicilNo;
                MemoKefilUnvan.Text = kefil.Unvan;
                LabelKefilDurum.Text =
                    kefil.TUCCAR_ASKI.Any(p => p.AskiTarihi != null && p.BitisTarihi == null)
                        ? "ASKI"
                        : "FAAL";
            }
        }

        #endregion
    }
}
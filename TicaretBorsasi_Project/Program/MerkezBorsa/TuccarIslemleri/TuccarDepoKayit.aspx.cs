using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Security;
using System.Web.UI;
using TicaretBorsasi_Project.Class.Helper;
using TicaretBorsasi_Project.Data;

namespace TicaretBorsasi_Project.Program.MerkezBorsa.TuccarIslemleri
{
    public partial class TuccarDepoKayit : Page
    {
        #region Properties

        private int TuccarDepoKey
        {
            get
            {
                string key = Request.QueryString["Key"];
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

        protected void ButtonKaydetGuncelle_Click(object sender, EventArgs e)
        {
            using (var entity = new DBEntities())
            {
                #region validation

                int pMaddeKodu = Convert.ToInt32(ComboBoxMaddeKodu.SelectedItem.Value);
                int pTuccarSicilKey = 0;
                if (TuccarDepoKey == 0)
                {
                    if (ComboBoxSicilNoUnvan.SelectedIndex == -1)
                    {
                        PageHelper.MessageBox(this, "Lütfen tüccar seçimi yapınız!");
                        return;
                    }
                    else
                    {
                        pTuccarSicilKey = Convert.ToInt32(ComboBoxSicilNoUnvan.SelectedItem.Value);
                        if (AyniKayitVarMi(pTuccarSicilKey, pMaddeKodu, entity))
                        {
                            PageHelper.MessageBox(this, "Aynı kayıt bulunmaktadır!");
                            return;
                        }
                    }
                }

                #endregion

                TUCCAR_DEPO _TUCCAR_DEPO;
                if (TuccarDepoKey == 0)
                {
                    _TUCCAR_DEPO = new TUCCAR_DEPO();
                    _TUCCAR_DEPO.TuccarSicilKey = pTuccarSicilKey;
                }
                else
                {
                    _TUCCAR_DEPO = entity.TUCCAR_DEPO.SingleOrDefault(p => p.TuccarDepoKey == TuccarDepoKey);
                    if (_TUCCAR_DEPO == null)
                    {
                        Response.Redirect("TuccarDepoKayit.aspx");
                        return;
                    }
                }

                _TUCCAR_DEPO.MaddeKodKey = pMaddeKodu;
                _TUCCAR_DEPO.Devir1 = Convert.ToDecimal(SpinEditDevir1.Value);
                _TUCCAR_DEPO.Devir2 = Convert.ToDecimal(SpinEditDevir2.Value);
                _TUCCAR_DEPO.Alis1 = Convert.ToDecimal(SpinEditAlis1.Value);
                _TUCCAR_DEPO.Alis2 = Convert.ToDecimal(SpinEditAlis2.Value);
                _TUCCAR_DEPO.Satis1 = Convert.ToDecimal(SpinEditSatis1.Value);
                _TUCCAR_DEPO.Satis2 = Convert.ToDecimal(SpinEditSatis2.Value);
                _TUCCAR_DEPO.DigerBorsaAlis1 = Convert.ToDecimal(SpinEditDigerBorsaAlis1.Value);
                _TUCCAR_DEPO.DigerBorsaAlis2 = Convert.ToDecimal(SpinEditDigerBorsaAlis2.Value);
                _TUCCAR_DEPO.DigerBorsaSatis1 = Convert.ToDecimal(SpinEditDigerBorsaSatis1.Value);
                _TUCCAR_DEPO.DigerBorsaSatis2 = Convert.ToDecimal(SpinEditDigerBorsaSatis2.Value);


                MembershipUser user = Membership.GetUser(true);
                Guid userkey = user == null ? Guid.Empty : (Guid) user.ProviderUserKey;
                if (TuccarDepoKey == 0)
                {
                    _TUCCAR_DEPO.KayitKisiKey = userkey;
                    _TUCCAR_DEPO.KayitTarih = DateTime.Now;
                    entity.TUCCAR_DEPO.Add(_TUCCAR_DEPO);
                }
                else
                {
                    _TUCCAR_DEPO.GuncelleKisiKey = userkey;
                    _TUCCAR_DEPO.GuncelleTarih = DateTime.Now;
                }

                entity.SaveChanges();

                Response.Redirect(string.Format("TuccarDepoKayit.aspx?Key={0}", _TUCCAR_DEPO.TuccarDepoKey));
            }
        }

        protected void ButtonIptal_Click(object sender, EventArgs e)
        {
            Response.Redirect("TuccarDepoKayit.aspx");
        }

        protected void ButtonTemizle_Click(object sender, EventArgs e)
        {
            Response.Redirect(Request.Url.AbsoluteUri);
        }

        #endregion

        #region Methods

        private void SetInitials()
        {
            if (TuccarDepoKey == 0)
            {
                trSicilGrubu1.Visible = true;
                trSicilGrubu2.Visible = false;

                LabelBaslik.Text = "TÜCCAR DEPO KAYDET";

                ButtonKaydet.Visible = true;
                ButtonTemizle.Visible = true;
                ButtonGuncelle.Visible = false;
                ButtonIptal.Visible = false;
            }
            else
            {
                trSicilGrubu1.Visible = false;
                trSicilGrubu2.Visible = true;
                ComboBoxMaddeKodu.Enabled = false;

                LabelBaslik.Text = "TÜCCAR DEPO GÜNCELLE";

                ButtonKaydet.Visible = false;
                ButtonTemizle.Visible = false;
                ButtonGuncelle.Visible = true;
                ButtonIptal.Visible = true;
            }

            if (!IsPostBack)
            {
                DataLoad();
            }
        }

        private void DataLoad()
        {
            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                if (!IsPostBack)
                {
                    List<TT_MADDE_KOD> listMADDE_KOD = entity.TT_MADDE_KOD.AsNoTracking().OrderBy(p => p.Kod).ToList();
                    ComboBoxMaddeKodu.DataSource = listMADDE_KOD;
                    ComboBoxMaddeKodu.DataBind();
                }

                if (TuccarDepoKey == 0)
                {
                    ComboBoxSicilNoUnvan.DataSource = entity.TUCCAR_SICIL.AsNoTracking().OrderBy(p => p.SicilNo).Select(p => new
                        {
                            p.TuccarSicilKey,
                            SicilNoUnvan = (p.SicilNo.Trim() + " - " + p.Unvan)
                        }).ToList();
                    ComboBoxSicilNoUnvan.DataBind();
                }
                else
                {
                    TUCCAR_DEPO _TUCCAR_DEPO =
                        entity.TUCCAR_DEPO.Include("TUCCAR_SICIL").AsNoTracking().Single(p => p.TuccarDepoKey == TuccarDepoKey);

                    LabelSicilNo.Text = _TUCCAR_DEPO.TUCCAR_SICIL.SicilNo;
                    LabelUnvan.Text = _TUCCAR_DEPO.TUCCAR_SICIL.Unvan;

                    ComboBoxMaddeKodu.SelectedItem = ComboBoxMaddeKodu.Items.FindByValue(_TUCCAR_DEPO.MaddeKodKey);
                    SpinEditDevir1.Value = _TUCCAR_DEPO.Devir1;
                    SpinEditDevir2.Value = _TUCCAR_DEPO.Devir2;
                    SpinEditAlis1.Value = _TUCCAR_DEPO.Alis1;
                    SpinEditAlis2.Value = _TUCCAR_DEPO.Alis2;
                    SpinEditSatis1.Value = _TUCCAR_DEPO.Satis1;
                    SpinEditSatis2.Value = _TUCCAR_DEPO.Satis2;
                    SpinEditDigerBorsaAlis1.Value = _TUCCAR_DEPO.DigerBorsaAlis1;
                    SpinEditDigerBorsaAlis2.Value = _TUCCAR_DEPO.DigerBorsaAlis2;
                    SpinEditDigerBorsaSatis1.Value = _TUCCAR_DEPO.DigerBorsaSatis1;
                    SpinEditDigerBorsaSatis2.Value = _TUCCAR_DEPO.DigerBorsaSatis2;
                }
            }
        }

        private bool AyniKayitVarMi(int pTuccarSicilKey, int pMaddeKodu, DBEntities entity)
        {
            int uyeler =
                entity.TUCCAR_DEPO.AsNoTracking().Count(p => p.TuccarSicilKey == pTuccarSicilKey && p.MaddeKodKey == pMaddeKodu);
            if (uyeler > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        #endregion
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Security;
using System.Web.UI;
using TicaretBorsasi_Project.Class.Helper;
using TicaretBorsasi_Project.Data;

namespace TicaretBorsasi_Project.Program.ProgramIslem
{
    public partial class BorsaBilgileri : Page
    {
        #region Properties

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
                byte[] resim = UploadControlResim.UploadedFiles[0].FileBytes;

                #region validation

                if (resim.Length != 0)
                {
                    string uzanti = UploadControlResim.UploadedFiles[0].FileName.Split('.').Last();
                    if (!(uzanti == "jpg" || uzanti == "jpeg" || uzanti == "png" || uzanti == "bmp"))
                    {
                        PageHelper.MessageBox(this, "Hatalı resim format seçimi yaptınız!");
                        return;
                    }
                }

                #endregion

                BORSA_BILGI data = entity.BORSA_BILGI.SingleOrDefault();
                BORSA_BILGI _BORSA_BILGI = data;
                if (_BORSA_BILGI == null)
                {
                    _BORSA_BILGI = new BORSA_BILGI();
                    _BORSA_BILGI.ProgramLogo = resim.Length == 0 ? null : resim;
                }
                else
                {
                    _BORSA_BILGI.ProgramLogo = resim.Length == 0 ? _BORSA_BILGI.ProgramLogo : resim;
                }

                _BORSA_BILGI.ProgramBaslik = TextBoxProgramBaslik.Text;
                _BORSA_BILGI.BorsaAdi = TextBoxBorsaAdi.Text;
                _BORSA_BILGI.TOBBKodu = TextBoxTOBBKodu.Text;
                _BORSA_BILGI.TOBBKurumTipi = Convert.ToByte(TextBoxTOBBKurumTipi.Text);
                _BORSA_BILGI.KurulusTarihi = DateEditKurulusTarihi.Date;
                _BORSA_BILGI.IsyeriSicilNo = TextBoxIsyeriSicilNo.Text;
                _BORSA_BILGI.GenelSekreter = TextBoxGenelSekreter.Text;
                _BORSA_BILGI.YonetimKuruluBaskani = TextBoxYonetimKuruluBaskani.Text;
                _BORSA_BILGI.MeclisBaskani = TextBoxMeclisBaskani.Text;
                _BORSA_BILGI.BorsaAdresi = MemoBorsaAdres.Text;
                _BORSA_BILGI.MuracaatMercii = TextBoxMuracaatMercii.Text;
                _BORSA_BILGI.Telefon1 = TextBoxTelefon1.Text;
                _BORSA_BILGI.Telefon2 = TextBoxTelefon2.Text;
                _BORSA_BILGI.Fax1 = TextBoxFax1.Text;
                _BORSA_BILGI.Fax2 = TextBoxFax2.Text;
                _BORSA_BILGI.Email = TextBoxEmail.Text;
                _BORSA_BILGI.UyeTeminatTipiKey = Convert.ToByte(ComboBoxUyeTeminatTip.SelectedItem.Value);
                _BORSA_BILGI.GecTescil = CheckBoxGecTescil.Checked;
                _BORSA_BILGI.GecTescilBeyan30Gun = CheckBoxGecTescil30GunBeyan.Checked;
                _BORSA_BILGI.TesekkulNo = TextBoxTesekkulNo.Text;
                _BORSA_BILGI.TasTesNo = TextBoxTasTesNo.Text;

                MembershipUser user = Membership.GetUser(true);
                Guid userkey = user == null ? Guid.Empty : (Guid) user.ProviderUserKey;
                if (data == null)
                {
                    _BORSA_BILGI.KayitKisiKey = userkey;
                    _BORSA_BILGI.KayitTarih = DateTime.Now;
                    entity.BORSA_BILGI.Add(_BORSA_BILGI);
                }
                else
                {
                    _BORSA_BILGI.GuncelleKisiKey = userkey;
                    _BORSA_BILGI.GuncelleTarih = DateTime.Now;
                }

                entity.SaveChanges();
            }

            Response.Redirect("BorsaBilgileri.aspx");
        }

        protected void ButtonIptal_Click(object sender, EventArgs e)
        {
            Response.Redirect("BorsaBilgileri.aspx");
        }

        #endregion

        #region Methods

        private void SetInitials()
        {
            LabelBaslik.Text = "BORSA BİLGİLERİ";

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
                    List<TT_UYE_TEMINAT_TIP> listMADDE_KOD = entity.TT_UYE_TEMINAT_TIP.AsNoTracking().ToList();
                    ComboBoxUyeTeminatTip.DataSource = listMADDE_KOD;
                    ComboBoxUyeTeminatTip.DataBind();
                }

                BORSA_BILGI _BORSA_BILGI = entity.BORSA_BILGI.AsNoTracking().SingleOrDefault();

                if (_BORSA_BILGI != null)
                {
                    BinaryImageResim.Value = _BORSA_BILGI.ProgramLogo;
                    TextBoxProgramBaslik.Text = _BORSA_BILGI.ProgramBaslik;
                    TextBoxBorsaAdi.Text = _BORSA_BILGI.BorsaAdi;
                    TextBoxTOBBKodu.Text = _BORSA_BILGI.TOBBKodu;
                    TextBoxTOBBKurumTipi.Text = _BORSA_BILGI.TOBBKurumTipi.ToString();
                    DateEditKurulusTarihi.Date = _BORSA_BILGI.KurulusTarihi;
                    TextBoxIsyeriSicilNo.Text = _BORSA_BILGI.IsyeriSicilNo;
                    TextBoxGenelSekreter.Text = _BORSA_BILGI.GenelSekreter;
                    TextBoxYonetimKuruluBaskani.Text = _BORSA_BILGI.YonetimKuruluBaskani;
                    TextBoxMeclisBaskani.Text = _BORSA_BILGI.MeclisBaskani;
                    MemoBorsaAdres.Text = _BORSA_BILGI.BorsaAdresi;
                    TextBoxMuracaatMercii.Text = _BORSA_BILGI.MuracaatMercii;
                    TextBoxTelefon1.Text = _BORSA_BILGI.Telefon1;
                    TextBoxTelefon2.Text = _BORSA_BILGI.Telefon2;
                    TextBoxFax1.Text = _BORSA_BILGI.Fax1;
                    TextBoxFax2.Text = _BORSA_BILGI.Fax2;
                    TextBoxEmail.Text = _BORSA_BILGI.Email;
                    ComboBoxUyeTeminatTip.Items.FindByValue(Convert.ToInt32(_BORSA_BILGI.UyeTeminatTipiKey))
                                         .Selected = true;
                    CheckBoxGecTescil.Checked = _BORSA_BILGI.GecTescil;
                    CheckBoxGecTescil30GunBeyan.Checked = _BORSA_BILGI.GecTescilBeyan30Gun;
                    TextBoxTesekkulNo.Text = _BORSA_BILGI.TesekkulNo;
                    TextBoxTasTesNo.Text = _BORSA_BILGI.TasTesNo;
                }
            }
        }

        #endregion
    }
}
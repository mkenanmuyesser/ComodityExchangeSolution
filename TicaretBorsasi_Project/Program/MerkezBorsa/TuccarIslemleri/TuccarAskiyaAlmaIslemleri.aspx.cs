using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web.Security;
using System.Web.UI;
using DevExpress.Web.ASPxGridView;
using TicaretBorsasi_Project.Class.CustomType;
using TicaretBorsasi_Project.Class.CustomType.MerkezBorsa;
using TicaretBorsasi_Project.Class.Helper;
using TicaretBorsasi_Project.Data;

namespace TicaretBorsasi_Project.Program.MerkezBorsa.TuccarIslemleri
{
    public partial class TuccarAskiyaAlmaIslemleri : Page
    {
        #region Properties

        public List<int> AskiList
        {
            get
            {
                if (ViewState["AskiList"] == null)
                {
                    ViewState["AskiList"] = new List<int>();
                }

                return (List<int>) ViewState["AskiList"];
            }
        }

        #endregion

        #region Events

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                SetInitials();
            }

            Ara();

            AskiAktifPasif();
        }

        protected void ButtonRapor_Click(object sender, EventArgs e)
        {
            Ara();

            switch (ComboBoxRapor.SelectedIndex)
            {
                case 0:
                    GridViewExporterAskiyaAlinacak.WriteXlsxToResponse("Askıya Alma Bilgileri");
                    break;
                case 1:
                    GridViewExporterAskiyaAlinacak.WritePdfToResponse("Askıya Alma Bilgileri");
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

        protected void ButtonAskiKaydetGuncelle_Click(object sender, EventArgs e)
        {
            using (var entity = new DBEntities())
            {
                #region validation

                switch (RadioButtonListSecim.SelectedItem.Value.ToString())
                {
                    default:
                    case "1":
                        if (string.IsNullOrEmpty(DateEditBitisTarihi.Text) ||
                            string.IsNullOrEmpty(MemoBitisAciklama.Text))
                        {
                            PageHelper.MessageBox(this, "Lütfen tarih ve açıklama alanlarını doldurunuz.");
                            return;
                        }
                        break;
                    case "2":
                        if (string.IsNullOrEmpty(DateEditAskiTarihi.Text) || string.IsNullOrEmpty(MemoAskiAciklama.Text))
                        {
                            PageHelper.MessageBox(this, "Lütfen tarih ve açıklama alanlarını doldurunuz.");
                            return;
                        }
                        break;
                }

                #endregion

                switch (RadioButtonListSecim.SelectedItem.Value.ToString())
                {
                    default:
                    case "1":
                        foreach (int TuccarSicilKey in AskiList)
                        {
                            TUCCAR_ASKI _TUCCAR_ASKI =
                                entity.TUCCAR_ASKI.ToList().Last(p => p.TuccarSicilKey == TuccarSicilKey);
                            _TUCCAR_ASKI.BitisTarihi = (DateTime?) DateEditBitisTarihi.Value;
                            _TUCCAR_ASKI.BitisKararNo = TextBoxBitisKararNo.Text;
                            _TUCCAR_ASKI.BitisAciklama = MemoBitisAciklama.Text;

                            MembershipUser user = Membership.GetUser(true);
                            Guid userkey = user == null ? Guid.Empty : (Guid) user.ProviderUserKey;

                            _TUCCAR_ASKI.GuncelleKisiKey = userkey;
                            _TUCCAR_ASKI.GuncelleTarih = DateTime.Now;
                        }
                        break;
                    case "2":
                        foreach (int TuccarSicilKey in AskiList)
                        {
                            var _TUCCAR_ASKI = new TUCCAR_ASKI();
                            _TUCCAR_ASKI.TuccarSicilKey = TuccarSicilKey;
                            _TUCCAR_ASKI.AskiTarihi = DateEditAskiTarihi.Date;
                            _TUCCAR_ASKI.AskiKararNo = TextBoxAskiKararNo.Text;
                            _TUCCAR_ASKI.AskiAciklama = MemoAskiAciklama.Text;

                            MembershipUser user = Membership.GetUser(true);
                            Guid userkey = user == null ? Guid.Empty : (Guid) user.ProviderUserKey;

                            _TUCCAR_ASKI.KayitKisiKey = userkey;
                            _TUCCAR_ASKI.KayitTarih = DateTime.Now;
                            entity.TUCCAR_ASKI.Add(_TUCCAR_ASKI);
                        }
                        break;
                }

                entity.SaveChanges();

                Response.Redirect("TuccarAskiyaAlmaIslemleri.aspx");
            }
        }

        protected void GridViewAskiyaAlma_RowCommand(object sender, ASPxGridViewRowCommandEventArgs e)
        {
            int key = Convert.ToInt32(e.CommandArgs.CommandArgument);

            if (!AskiList.Contains(key))
            {
                AskiList.Add(key);
            }

            ViewState["AskiList"] = AskiList;
            Ara();
            AskiAktifPasif();
        }

        protected void GridViewAskiyaAlinacak_RowCommand(object sender, ASPxGridViewRowCommandEventArgs e)
        {
            int key = Convert.ToInt32(e.CommandArgs.CommandArgument);

            AskiList.Remove(key);

            ViewState["AskiList"] = AskiList;
            Ara();
            AskiAktifPasif();
        }

        #endregion

        #region Methods

        private void SetInitials()
        {
            LabelBaslik.Text = "ASKIYA ALMA İŞLEMLERİ";
            PageHelper.SessionData = null;
        }

        private void Ara()
        {
            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                string pSicilNo = SpinEditSicilNo.Text.Trim();
                string pUnvan = TextBoxUnvan.Text.Trim().ToLower(CultureInfo.CurrentCulture);

                GridViewAskiyaAlma.DataSource = null;
                var kayitlar = entity.TUCCAR_ASKI
                    .Include("TUCCAR_SICIL")
                    .AsNoTracking()
                    .ToList().Select(p => new
                    {
                        p.TuccarAskiKey,
                        p.TuccarSicilKey,
                        p.TUCCAR_SICIL.SicilNo,
                        p.TUCCAR_SICIL.Unvan,
                        p.AskiTarihi,
                        p.AskiKararNo,
                        p.AskiAciklama,
                        p.BitisTarihi,
                        p.BitisKararNo,
                        p.BitisAciklama
                    });

                var sonuc = kayitlar;

                #region koşullar

                var sonucdizi = new List<AskiType>();
                switch (RadioButtonListSecim.SelectedItem.Value.ToString())
                {
                    default:
                    case "1":
                        sonuc.Where(p => p.BitisTarihi == null).ToList().ForEach(p => sonucdizi.Add(
                            new AskiType
                                {
                                    TuccarAskiKey = p.TuccarAskiKey,
                                    TuccarSicilKey = p.TuccarSicilKey,
                                    SicilNo = p.SicilNo,
                                    Unvan = p.Unvan,
                                    AskiTarihi = p.AskiTarihi,
                                    AskiKararNo = p.AskiKararNo,
                                    AskiAciklama = p.AskiAciklama,
                                    BitisTarihi = p.BitisTarihi,
                                    BitisKararNo = p.BitisKararNo,
                                    BitisAciklama = p.BitisAciklama,
                                }
                                                                                          ));
                        break;
                    case "2":
                        IEnumerable<int?> askidakiler =
                            sonuc.Where(p => p.BitisTarihi == null).Select(p => p.TuccarSicilKey);
                        var askidaolmayanlar =
                            entity.TUCCAR_SICIL.Where(p => !askidakiler.Contains(p.TuccarSicilKey))
                                  .Select(p => new {p.TuccarSicilKey, p.SicilNo, p.Unvan})
                                  .ToList();

                        foreach (var item in askidaolmayanlar)
                        {
                            var aski = new AskiType
                                {
                                    TuccarAskiKey = 0,
                                    TuccarSicilKey = item.TuccarSicilKey,
                                    SicilNo = item.SicilNo,
                                    Unvan = item.Unvan,
                                    AskiTarihi = null,
                                    AskiKararNo = null,
                                    AskiAciklama = null,
                                    BitisTarihi = null,
                                    BitisKararNo = null,
                                    BitisAciklama = null,
                                };

                            var dizi =
                                kayitlar.Where(p => p.TuccarSicilKey == item.TuccarSicilKey)
                                        .OrderByDescending(p => p.TuccarAskiKey);
                            if (dizi.Count() > 0)
                            {
                                var eskiaskıkaydi = dizi.First();
                                aski.AskiTarihi = eskiaskıkaydi.AskiTarihi;
                                aski.AskiKararNo = eskiaskıkaydi.AskiKararNo;
                                aski.AskiAciklama = eskiaskıkaydi.AskiAciklama;
                                aski.BitisTarihi = eskiaskıkaydi.BitisTarihi;
                                aski.BitisKararNo = eskiaskıkaydi.BitisKararNo;
                                aski.BitisAciklama = eskiaskıkaydi.BitisAciklama;
                            }


                            sonucdizi.Add(aski);
                        }
                        break;
                }

                List<AskiType> askitum = sonucdizi;

                if (!string.IsNullOrEmpty(pSicilNo))
                {
                    int sicilno;
                    if (!int.TryParse(pSicilNo, out sicilno))
                    {
                        PageHelper.MessageBox(this, "Sicil numara girişi hatalıdır!");
                        return;
                    }

                    for (int i = pSicilNo.Length; i < 6; i++)
                    {
                        pSicilNo = "0" + pSicilNo;
                    }
                    sonucdizi = sonucdizi.Where(p => p.SicilNo == pSicilNo).ToList();
                }

                if (!string.IsNullOrEmpty(pUnvan))
                {
                    sonucdizi =
                        sonucdizi.Where(p => p.Unvan.ToLower(CultureInfo.CurrentCulture).Contains(pUnvan)).ToList();
                }

                #endregion

                GridViewAskiyaAlma.DataSource = sonucdizi;
                GridViewAskiyaAlma.DataBind();

                AskiListDoldur(askitum);
            }
        }

        private void AskiListDoldur(List<AskiType> askitum)
        {
            using (var entity = new DBEntities())
            {
                var sonuc = askitum.Where(p => AskiList.Contains(p.TuccarSicilKey.Value));
                GridViewAskiyaAlinacak.DataSource = null;
                GridViewAskiyaAlinacak.DataSource = sonuc;
                GridViewAskiyaAlinacak.DataBind();
            }
        }

        private void AskiAktifPasif()
        {
            switch (RadioButtonListSecim.SelectedItem.Value.ToString())
            {
                default:
                case "1":
                    GridViewAskiyaAlma.Columns[2].Visible = true;
                    GridViewAskiyaAlma.Columns[3].Visible = true;
                    GridViewAskiyaAlma.Columns[4].Visible = true;
                    GridViewAskiyaAlinacak.Columns[2].Visible = true;
                    GridViewAskiyaAlinacak.Columns[3].Visible = true;
                    GridViewAskiyaAlinacak.Columns[4].Visible = true;

                    GridViewAskiyaAlma.Columns[5].Visible = false;
                    GridViewAskiyaAlma.Columns[6].Visible = false;
                    GridViewAskiyaAlma.Columns[7].Visible = false;
                    GridViewAskiyaAlinacak.Columns[5].Visible = false;
                    GridViewAskiyaAlinacak.Columns[6].Visible = false;
                    GridViewAskiyaAlinacak.Columns[7].Visible = false;
                    break;
                case "2":
                    GridViewAskiyaAlma.Columns[5].Visible = true;
                    GridViewAskiyaAlma.Columns[6].Visible = true;
                    GridViewAskiyaAlma.Columns[7].Visible = true;
                    GridViewAskiyaAlinacak.Columns[5].Visible = true;
                    GridViewAskiyaAlinacak.Columns[6].Visible = true;
                    GridViewAskiyaAlinacak.Columns[7].Visible = true;

                    GridViewAskiyaAlma.Columns[2].Visible = false;
                    GridViewAskiyaAlma.Columns[3].Visible = false;
                    GridViewAskiyaAlma.Columns[4].Visible = false;
                    GridViewAskiyaAlinacak.Columns[2].Visible = false;
                    GridViewAskiyaAlinacak.Columns[3].Visible = false;
                    GridViewAskiyaAlinacak.Columns[4].Visible = false;
                    break;
            }

            GridViewAskiyaAlma.Columns[8].SetColVisibleIndex(8);
            GridViewAskiyaAlinacak.Columns[8].SetColVisibleIndex(8);

            if (AskiList.Any())
            {
                ButtonAskiKaydet.Enabled = true;

                switch (RadioButtonListSecim.SelectedItem.Value.ToString())
                {
                    default:
                    case "1":
                        DateEditAskiTarihi.Enabled = false;
                        MemoAskiAciklama.Enabled = false;
                        TextBoxAskiKararNo.Enabled = false;
                        DateEditBitisTarihi.Enabled = true;
                        MemoBitisAciklama.Enabled = true;
                        TextBoxBitisKararNo.Enabled = true;
                        break;
                    case "2":
                        DateEditAskiTarihi.Enabled = true;
                        MemoAskiAciklama.Enabled = true;
                        TextBoxAskiKararNo.Enabled = true;
                        DateEditBitisTarihi.Enabled = false;
                        MemoBitisAciklama.Enabled = false;
                        TextBoxBitisKararNo.Enabled = false;
                        break;
                }
            }
            else
            {
                ButtonAskiKaydet.Enabled = false;

                DateEditAskiTarihi.Enabled = false;
                MemoAskiAciklama.Enabled = false;
                TextBoxAskiKararNo.Enabled = false;
                DateEditBitisTarihi.Enabled = false;
                MemoBitisAciklama.Enabled = false;
                TextBoxBitisKararNo.Enabled = false;
            }
        }

        #endregion
    }
}
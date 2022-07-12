using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web.Security;
using System.Web.UI;
using DevExpress.Web.ASPxGridView;
using TicaretBorsasi_Project.Class.Helper;
using TicaretBorsasi_Project.Data;

namespace TicaretBorsasi_Project.Program.MerkezBorsa.TuccarIslemleri
{
    public partial class TuccarAidatDereceDegistirme : Page
    {
        #region Properties

        public List<int> DereceDegisiklikList
        {
            get
            {
                if (ViewState["DereceDegisiklikList"] == null)
                {
                    ViewState["DereceDegisiklikList"] = new List<int>();
                }

                return (List<int>) ViewState["DereceDegisiklikList"];
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
            DereceDegisiklikButtonAktifPasif();
        }

        protected void ButtonRapor_Click(object sender, EventArgs e)
        {
            switch (ComboBoxRapor.SelectedIndex)
            {
                case 0:
                    GridViewExporterDereceDegistirilecek.WriteXlsxToResponse("Aidat Derece Değişiklik Bilgileri");
                    break;
                case 1:
                    GridViewExporterDereceDegistirilecek.WritePdfToResponse("Aidat Derece Değişiklik Bilgileri");
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

        protected void ButtonDereceDegisikligiKaydet_Click(object sender, EventArgs e)
        {
            using (var entity = new DBEntities())
            {
                IQueryable<TUCCAR_SICIL> derecedegisiklikliste =
                    entity.TUCCAR_SICIL.Where(p => DereceDegisiklikList.Contains(p.TuccarSicilKey));

                foreach (TUCCAR_SICIL item in derecedegisiklikliste)
                {
                    var _DERECE_DEGISIKLIK = new DERECE_DEGISIKLIK();

                    _DERECE_DEGISIKLIK.TuccarSicilKey = item.TuccarSicilKey;
                    _DERECE_DEGISIKLIK.DereceKey = Convert.ToInt32(ComboBoxDereceDegisikligiDerece.SelectedItem.Value);
                    _DERECE_DEGISIKLIK.DereceVerilisYil = Convert.ToInt16(SpinEditDereceDegisikligiDereceYil.Value);
                    _DERECE_DEGISIKLIK.YKKTarih = DateEditDereceDegisikligiYKKTarihi.Value == null
                                                      ? null
                                                      : (DateTime?)
                                                        Convert.ToDateTime(DateEditDereceDegisikligiYKKTarihi.Value);
                    _DERECE_DEGISIKLIK.YKKNo = TextBoxDereceDegisikligiYKKNo.Text;

                    MembershipUser user = Membership.GetUser(true);
                    Guid userkey = user == null ? Guid.Empty : (Guid) user.ProviderUserKey;

                    _DERECE_DEGISIKLIK.KayitKisiKey = userkey;
                    _DERECE_DEGISIKLIK.KayitTarih = DateTime.Now;
                    entity.DERECE_DEGISIKLIK.Add(_DERECE_DEGISIKLIK);

                    item.DereceKey = Convert.ToInt32(ComboBoxDereceDegisikligiDerece.SelectedItem.Value);
                    item.DereceYil = Convert.ToInt16(SpinEditDereceDegisikligiDereceYil.Value);
                    item.YKKTarihi = DateEditDereceDegisikligiYKKTarihi.Value == null
                                         ? null
                                         : (DateTime?) Convert.ToDateTime(DateEditDereceDegisikligiYKKTarihi.Value);
                    item.YKKNo = TextBoxDereceDegisikligiYKKNo.Text;
                }

                entity.SaveChanges();
            }

            Response.Redirect("TuccarAidatDereceDegistirme.aspx");
        }

        protected void GridViewTuccarListe_RowCommand(object sender, ASPxGridViewRowCommandEventArgs e)
        {
            int key = Convert.ToInt32(e.CommandArgs.CommandArgument);

            if (!DereceDegisiklikList.Contains(key))
            {
                DereceDegisiklikList.Add(key);
            }

            ViewState["DereceDegisiklikList"] = DereceDegisiklikList;
            DereceDegisiklikListDoldur();
            DereceDegisiklikButtonAktifPasif();
        }

        protected void GridViewDereceDegistirilecek_RowCommand(object sender, ASPxGridViewRowCommandEventArgs e)
        {
            int key = Convert.ToInt32(e.CommandArgs.CommandArgument);

            DereceDegisiklikList.Remove(key);

            ViewState["DereceDegisiklikList"] = DereceDegisiklikList;
            DereceDegisiklikListDoldur();
            DereceDegisiklikButtonAktifPasif();
        }

        #endregion

        #region Methods

        private void SetInitials()
        {
            LabelBaslik.Text = "AİDAT DERECE DEĞİŞİKLİK İŞLEMLERİ";

            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                List<TT_DERECE> listDERECE = entity.TT_DERECE.AsNoTracking().ToList();
                ComboBoxDereceDegisikligiDerece.DataSource = listDERECE;
                ComboBoxDereceDegisikligiDerece.DataBind();
            }
        }

        private void Ara()
        {
            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;
                
                string pSicilNoBaslangic = SpinEditSicilNoBaslangic.Text.Trim();
                string pSicilNoBitis = SpinEditSicilNoBitis.Text.Trim();
                string pUnvan = TextBoxUnvan.Text.Trim().ToLower(CultureInfo.CurrentCulture);

                GridViewTuccarListe.DataSource = null;
                var sonuc = entity.TUCCAR_SICIL.Include("TT_DERECE").AsNoTracking().ToList().Select(p => new
                    {
                        p.TuccarSicilKey,
                        p.SicilNo,
                        p.Unvan,
                        DereceAdi = p.TT_DERECE == null ? null : p.TT_DERECE.Kod,
                    });

                #region koşullar

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
                                    p => Convert.ToInt32(p.SicilNo) >= baslangic && Convert.ToInt32(p.SicilNo) <= bitis);
                        }
                        else
                        {
                            PageHelper.MessageBox(this, "Sicil numara girişi hatalıdır!");
                            return;
                        }
                    }
                }

                if (!string.IsNullOrEmpty(pUnvan))
                {
                    sonuc = sonuc.Where(p => p.Unvan.ToLower(CultureInfo.CurrentCulture).Contains(pUnvan));
                }

                #endregion

                GridViewTuccarListe.DataSource = sonuc;
                GridViewTuccarListe.DataBind();

                DereceDegisiklikListDoldur();
            }
        }

        private void DereceDegisiklikListDoldur()
        {
            using (var entity = new DBEntities())
            {
                entity.Configuration.AutoDetectChangesEnabled = false;

                var sonuc =
                    entity.TUCCAR_SICIL.Include("TT_DERECE")
                          .AsNoTracking()
                          .Where(p => DereceDegisiklikList.Contains(p.TuccarSicilKey))
                          .ToList()
                          .Select(p => new
                              {
                                  p.TuccarSicilKey,
                                  p.SicilNo,
                                  p.Unvan,
                                  DereceAdi = p.TT_DERECE == null ? null : p.TT_DERECE.Kod,
                              });

                GridViewDereceDegistirilecek.DataSource = null;
                GridViewDereceDegistirilecek.DataSource = sonuc;
                GridViewDereceDegistirilecek.DataBind();
            }
        }

        private void DereceDegisiklikButtonAktifPasif()
        {
            if (DereceDegisiklikList.Count() > 0)
            {
                ButtonDereceDegisikligiKaydet.Enabled = true;
            }
            else
            {
                ButtonDereceDegisikligiKaydet.Enabled = false;
            }
        }

        #endregion
    }
}
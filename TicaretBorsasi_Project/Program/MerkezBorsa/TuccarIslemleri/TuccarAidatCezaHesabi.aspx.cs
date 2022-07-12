using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using DevExpress.Web.Data;
using TicaretBorsasi_Project.Class.Business;
using TicaretBorsasi_Project.Class.CustomType;
using TicaretBorsasi_Project.Class.CustomType.MerkezBorsa;
using TicaretBorsasi_Project.Class.Helper;
using TicaretBorsasi_Project.Data;

namespace TicaretBorsasi_Project.Program.MerkezBorsa.TuccarIslemleri
{
    public partial class TuccarAidatCezaHesabi : Page
    {
        #region Properties

        private List<AidatCezaHesapType> AidatCezaList
        {
            get
            {
                if (Session["AidatCezaList"] == null)
                {
                    return new List<AidatCezaHesapType>();
                }
                else
                {
                    return (List<AidatCezaHesapType>) Session["AidatCezaList"];
                }
            }
        }

        #endregion

        #region Events

        protected void Page_Load(object sender, EventArgs e)
        {
            SetInitials();
        }

        protected void ButtonRapor_Click(object sender, EventArgs e)
        {
            GridViewAidatCezaHesabi.DataSource = PageHelper.SessionData;
            GridViewAidatCezaHesabi.DataBind();

            switch (ComboBoxRapor.SelectedIndex)
            {
                case 0:
                    GridViewExporterAidatCezaHesabi.WriteXlsxToResponse("Aidat Ceza Hesabı Bilgileri");
                    break;
                case 1:
                    GridViewExporterAidatCezaHesabi.WritePdfToResponse("Aidat Ceza Hesabı Bilgileri");
                    break;
                default:
                    break;
            }
        }

        protected void ButtonHesapla_Click(object sender, EventArgs e)
        {
            Hesapla();
        }

        protected void ButtonHesaplaEkle_Click(object sender, EventArgs e)
        {
            HesaplaEkle();
            Temizle();
        }

        protected void ButtonTemizle_Click(object sender, EventArgs e)
        {
            Temizle();
        }

        protected void ButtonIptal_Click(object sender, EventArgs e)
        {
            Response.Redirect(Request.Url.AbsoluteUri);
        }

        protected void GridViewAidatCezaHesabi_RowDeleting(object sender, ASPxDataDeletingEventArgs e)
        {
            using (var entity = new DBEntities())
            {
                Guid deletedkey = Guid.Parse(e.Keys[0].ToString());
                AidatCezaHesapType data = AidatCezaList.Single(p => p.Key == deletedkey);
                AidatCezaList.Remove(data);

                Session["AidatCezaList"] = AidatCezaList;
            }

            e.Cancel = true;
            DataLoad();
        }

        #endregion

        #region Methods

        private void SetInitials()
        {
            LabelBaslik.Text = "AİDAT CEZA HESABI";

            if (!IsPostBack)
            {
                PageHelper.SessionData = null;
                Session["AidatCezaList"] = null;
                DataLoad();
            }
        }

        private void DataLoad()
        {
            if (!IsPostBack)
            {
                var yillar = new List<int>();
                for (int i = DateTime.Now.Year; i >= 1900; i--)
                {
                    yillar.Add(i);
                }

                ComboBoxYil.DataSource = yillar;
                ComboBoxYil.DataBind();
                ComboBoxYil.SelectedIndex = 0;
            }

            GridViewAidatCezaHesabi.DataSource = null;
            GridViewAidatCezaHesabi.DataSource = AidatCezaList;
            PageHelper.SessionData = GridViewAidatCezaHesabi.DataSource;
            GridViewAidatCezaHesabi.DataBind();
        }

        private AidatCezaHesapType Hesapla()
        {
            short pAidatYili = Convert.ToInt16(ComboBoxYil.SelectedItem.Text);
            decimal pTaksit1 = string.IsNullOrEmpty(SpinEditTaksit1.Text) ? 0 : Convert.ToDecimal(SpinEditTaksit1.Text);
            decimal pTaksit2 = string.IsNullOrEmpty(SpinEditTaksit2.Text) ? 0 : Convert.ToDecimal(SpinEditTaksit2.Text);

            AidatCezaHesapType hesap = AidatBS.Hesapla(pAidatYili, pTaksit1, pTaksit2);

            SpinEditTaksit1.Text = hesap.Taksit1.ToString();
            SpinEditTaksit2.Text = hesap.Taksit2.ToString();
            SpinEditAidatToplam.Text = hesap.AidatToplam.ToString();
            SpinEditBugunkuCeza.Text = hesap.Ceza.ToString();
            SpinEditAidatCeza.Text = hesap.AidatCezaToplam.ToString();

            return hesap;
        }

        private void HesaplaEkle()
        {
            AidatCezaHesapType hesap = Hesapla();

            List<AidatCezaHesapType> liste = AidatCezaList;
            liste.Add(hesap);
            Session["AidatCezaList"] = liste;

            DataLoad();
        }

        private void Temizle()
        {
            SpinEditTaksit1.Text = string.Empty;
            SpinEditTaksit2.Text = string.Empty;
            SpinEditAidatToplam.Text = string.Empty;
            SpinEditBugunkuCeza.Text = string.Empty;
            SpinEditAidatCeza.Text = string.Empty;
        }

        #endregion
    }
}
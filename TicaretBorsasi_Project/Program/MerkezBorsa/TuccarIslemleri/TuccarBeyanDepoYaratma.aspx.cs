using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using TicaretBorsasi_Project.Data;

namespace TicaretBorsasi_Project.Program.MerkezBorsa.TuccarIslemleri
{
    public partial class TuccarBeyanDepoYaratma : Page
    {
        #region Properties

        #endregion

        #region Events

        protected void Page_Load(object sender, EventArgs e)
        {
            SetInitials();
        }

        protected void ButtonBeyanDepoYarat_Click(object sender, EventArgs e)
        {
            using (var entity = new DBEntities())
            {
                //öncelikle varolan data silinecek

                foreach (TUCCAR_DEPO item in entity.TUCCAR_DEPO)
                {
                    entity.TUCCAR_DEPO.Remove(item);
                }
                entity.SaveChanges();

                //sonrasında her bir beyan datasının toplam verileri için tuccar depo satırı oluşturalım
                //burada özel sql sorgusu da kullanabiliriz
                foreach (var item in entity.BEYANs.GroupBy(p => p.TT_MADDE_KOD))
                {
                    var _TUCCAR_DEPO = new TUCCAR_DEPO
                        {
                        };
                    entity.TUCCAR_DEPO.Add(_TUCCAR_DEPO);
                }

                entity.SaveChanges();
            }
        }

        protected void ButtonIptal_Click(object sender, EventArgs e)
        {
            Response.Redirect(Request.Url.AbsoluteUri);
        }

        #endregion

        #region Methods

        private void SetInitials()
        {
            LabelBaslik.Text = "BEYANLARDAN DEPO YARATMA";

            if (!IsPostBack)
            {
                using (var entity = new DBEntities())
                {
                    var listYil = new List<string>();
                    for (int i = DateTime.Now.Year; i > 1900; i--)
                    {
                        listYil.Add(i.ToString());
                    }

                    ComboBoxAidatYili.DataSource = listYil;
                    ComboBoxAidatYili.DataBind();
                    ComboBoxAidatYili.SelectedIndex = 0;
                }
            }
        }

        private void DataLoad()
        {
        }

        #endregion
    }
}
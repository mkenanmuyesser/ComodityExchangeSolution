<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="TuccarSicilBilgiKayitUserControl.ascx.cs" Inherits="TicaretBorsasi_Project.User_Control.Ortak.TuccarSicilBilgiKayitUserControl" %>


<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxTabControl" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxClasses" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>

<script type="text/javascript">
    document.onkeydown = function (e) {
        switch (e.keyCode) {
            case 37:
                document.getElementById('<%= ButtonGeri.ClientID %>').click();
                break;
            case 38:
                //alert('up');break;
            case 39:
                document.getElementById('<%= ButtonIleri.ClientID %>').click();
                    break;
                case 40:
                    //alert('down');
                    break;
            }
    };
</script>
<div style="margin: 1px; width: 99.9%;">
    <table style="border-color: #999999; width: 99.9%;" border="1">
        <tr>
            <td class="TdOrtala">
                <center>
                        <dx:ASPxLabel ID="LabelBaslik" runat="server" Font-Size="Large" />
                    </center>
            </td>
        </tr>
        <tr>
            <td>
                <center>
                        <dx:ASPxLabel ID="LabelUnvan" runat="server" Font-Size="Medium" />
                    </center>
            </td>
        </tr>
        <tr>
            <td class="TdOrtala">
                <dx:ASPxPageControl ID="PageControlSicilBilgi" runat="server" ActiveTabIndex="0" AutoPostBack="false" EnableCallBacks="true" ShowLoadingPanel="true" Width="99.9%" Font-Size="Small" EnableCallbackAnimation="True" LoadingPanelText="Yükleniyor&hellip;">
                    <TabPages>
                        <dx:TabPage Text="Tüccar Sicil Bilgi">
                            <ContentCollection>
                                <dx:ContentControl ID="ContentControl1" runat="server">
                                    <table style="border-color: #999999; width: 100%;" border="1">
                                        <tr>
                                            <td class="TdSolZorunlu" style="width: 15%;">
                                                <dx:ASPxLabel runat="server" Text="Sicil No : " Font-Size="Small" ForeColor="Red" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <dx:ASPxTextBox ID="TextBoxSicilNo" runat="server" Width="200px" Font-Size="Small" MaxLength="6">
                                                                <MaskSettings Mask="999999" />
                                                                <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                                                                    <RequiredField ErrorText=" " IsRequired="true" />
                                                                </ValidationSettings>
                                                            </dx:ASPxTextBox>
                                                        </td>
                                                        <td>
                                                            <dx:ASPxButton ID="ButtonAra" runat="server" Text="Ara" OnClick="ButtonAra_Click"></dx:ASPxButton>
                                                        </td>
                                                        <td style="width: 9px">&nbsp;&nbsp; 
                                                        </td>
                                                        <td>
                                                            <dx:ASPxButton ID="ButtonGeri" runat="server" Text="<=" Font-Size="X-Small" OnClick="ButtonGeriIleri_Click"></dx:ASPxButton>
                                                        </td>
                                                        <td>
                                                            <dx:ASPxButton ID="ButtonIleri" runat="server" Text="=>" Font-Size="X-Small" OnClick="ButtonGeriIleri_Click"></dx:ASPxButton>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td class="TdSol" style="width: 15%;">
                                                <dx:ASPxLabel runat="server" Text="Tc Kimlik No : " Font-Size="Small" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <dx:ASPxTextBox ID="TextBoxTcKimlikNo" runat="server" Width="200px" Font-Size="Small" MaxLength="11">
                                                                <MaskSettings Mask="<00000000000..99999999999>" />
                                                                <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                                                                    <RequiredField ErrorText=" " IsRequired="true" />
                                                                </ValidationSettings>
                                                            </dx:ASPxTextBox>
                                                        </td>
                                                        <td style="width: 100%">
                                                            <div style="float: right; margin-right: 10px;">
                                                                <dx:ASPxButton ID="ButtonDetayGoster" runat="server" Text="Detay Göster" Width="80" Visible="False" Font-Size="Small" OnClick="ButtonDetayGoster_Click" />
                                                            </div>
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 100%">
                                                            <div style="float: right;">
                                                                <dx:ASPxImage ID="ImageUyari" runat="server" ImageUrl="~/Content/Images/Icons/warning.png" Visible="False"></dx:ASPxImage>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="TdSolZorunlu" style="width: 15%;" rowspan="2">
                                                <dx:ASPxLabel runat="server" Text="Unvanı : " Font-Size="Small" ForeColor="Red" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;" rowspan="2">
                                                <dx:ASPxMemo ID="MemoUnvan" runat="server" Width="300px" Font-Size="Small" MaxLength="2500" Rows="3">
                                                    <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                                                        <RequiredField ErrorText=" " IsRequired="true" />
                                                    </ValidationSettings>
                                                </dx:ASPxMemo>
                                            </td>
                                            <td class="TdSolZorunlu" style="width: 15%;">
                                                <dx:ASPxLabel runat="server" Text="Meslek Grubu : " Font-Size="Small" ForeColor="Red" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <dx:ASPxComboBox ID="ComboBoxMeslekGrubu" runat="server" ValueType="System.String" Width="200px" Font-Size="Small" TextField="MeslekAdi" ValueField="MeslekGrupKey">
                                                    <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                                                        <RequiredField ErrorText=" " IsRequired="true" />
                                                    </ValidationSettings>
                                                </dx:ASPxComboBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="TdSol" style="width: 15%;">
                                                <dx:ASPxLabel runat="server" Text="Mersis No : " Font-Size="Small" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <dx:ASPxTextBox ID="TextBoxMersisNo" runat="server" Width="200px" Font-Size="Small" MaxLength="11">
                                                </dx:ASPxTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="TdSol" style="width: 15%;">
                                                <dx:ASPxLabel runat="server" Text="Nace Kodu : " Font-Size="Small" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <dx:ASPxTextBox ID="TextBoxNaceKodu1" runat="server" Width="50px" Font-Size="Small" MaxLength="20">
                                                                <ValidationSettings ValidationGroup="DigerFaaliyetKodlariKayitGuncelle" Display="Dynamic">
                                                                    <RequiredField ErrorText=" " IsRequired="true" />
                                                                </ValidationSettings>
                                                            </dx:ASPxTextBox>
                                                        </td>
                                                        <td>&nbsp;
                                                        </td>
                                                        <td>
                                                            <dx:ASPxTextBox ID="TextBoxNaceKodu2" runat="server" Width="150px" Font-Size="Small" MaxLength="50">
                                                                <ValidationSettings ValidationGroup="DigerFaaliyetKodlariKayitGuncelle" Display="Dynamic">
                                                                    <RequiredField ErrorText=" " IsRequired="true" />
                                                                </ValidationSettings>
                                                            </dx:ASPxTextBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td class="TdSol" style="width: 15%;">
                                                <dx:ASPxLabel runat="server" Text="Bölge Adı : " Font-Size="Small" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <dx:ASPxTextBox ID="TextBoxBolgeAdi" runat="server" Width="200px" Font-Size="Small" MaxLength="50">
                                                </dx:ASPxTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="TdSolZorunlu" style="width: 15%;">
                                                <dx:ASPxLabel runat="server" Text="İl/İlçe : " Font-Size="Small" ForeColor="Red" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <dx:ASPxComboBox ID="ComboBoxIlIlce" runat="server" ValueType="System.String" Width="200px" Font-Size="Small" TextField="IlIlceAdi" ValueField="IlIlceKey">
                                                    <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                                                        <RequiredField ErrorText=" " IsRequired="true" />
                                                    </ValidationSettings>
                                                </dx:ASPxComboBox>
                                            </td>
                                            <td class="TdSolZorunlu" style="width: 15%;">
                                                <dx:ASPxLabel runat="server" Text="İşletme Türü : " Font-Size="Small" ForeColor="Red" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <dx:ASPxComboBox ID="ComboBoxKurulusTur" runat="server" ValueType="System.String" Width="200px" Font-Size="Small" TextField="Adi" ValueField="KurulusTurKey">
                                                    <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                                                        <RequiredField ErrorText=" " IsRequired="true" />
                                                    </ValidationSettings>
                                                </dx:ASPxComboBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="TdSolZorunlu" style="width: 15%;">
                                                <dx:ASPxLabel runat="server" Text="Merkez/Şube Tipi : " Font-Size="Small" ForeColor="Red" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <dx:ASPxComboBox ID="ComboBoxMerkezSubeMi" runat="server" ValueType="System.String" Width="200px" Font-Size="Small">
                                                    <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                                                        <RequiredField ErrorText=" " IsRequired="true" />
                                                    </ValidationSettings>
                                                </dx:ASPxComboBox>
                                            </td>
                                            <td class="TdSolZorunlu" style="width: 15%;">
                                                <dx:ASPxLabel runat="server" Text="Kayıt/Tescil Tipi : " Font-Size="Small" ForeColor="Red" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <dx:ASPxComboBox ID="ComboBoxKayitTescilMi" runat="server" ValueType="System.String" Width="200px" Font-Size="Small">
                                                    <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                                                        <RequiredField ErrorText=" " IsRequired="true" />
                                                    </ValidationSettings>
                                                </dx:ASPxComboBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="TdSolZorunlu" style="width: 15%;">
                                                <dx:ASPxLabel runat="server" Text="Derecesi : " Font-Size="Small" ForeColor="Red" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <dx:ASPxComboBox ID="ComboBoxDerece" runat="server" ValueType="System.String" Width="200px" Font-Size="Small" TextField="Kod" ValueField="DereceKey">
                                                    <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                                                        <RequiredField ErrorText=" " IsRequired="true" />
                                                    </ValidationSettings>
                                                </dx:ASPxComboBox>
                                            </td>
                                            <td class="TdSol" style="width: 15%;">
                                                <dx:ASPxLabel runat="server" Text="Derece Yıl : " Font-Size="Small" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <dx:ASPxSpinEdit ID="SpinEditDereceYil" runat="server" DecimalPlaces="0" Width="200px" Font-Size="Small" MaxLength="4" NumberType="Integer" AllowNull="true" MinValue="1900" MaxValue="2099" SpinButtons-ShowIncrementButtons="false">
                                                    <SpinButtons ShowIncrementButtons="False"></SpinButtons>
                                                </dx:ASPxSpinEdit>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="TdSol" style="width: 15%;">
                                                <dx:ASPxLabel runat="server" Text="Y.K.K. Tarihi : " Font-Size="Small" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <dx:ASPxDateEdit ID="DateEditYKKTarihi" runat="server" Font-Size="Small" Width="200">
                                                </dx:ASPxDateEdit>
                                            </td>
                                            <td class="TdSol" style="width: 15%;">
                                                <dx:ASPxLabel runat="server" Text="Y.K.K. No : " Font-Size="Small" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <dx:ASPxTextBox ID="TextBoxYKKNo" runat="server" Width="200px" Font-Size="Small" MaxLength="50">
                                                </dx:ASPxTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="TdSolZorunlu" style="width: 15%;">
                                                <dx:ASPxLabel runat="server" Text="Ticaret Sicil Memurluğu : " Font-Size="Small" ForeColor="Red" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <dx:ASPxComboBox ID="ComboBoxSicilMemurlugu" runat="server" ValueType="System.String" Width="200px" Font-Size="Small" TextField="Adi" ValueField="SicilMemurluguKey">
                                                    <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                                                        <RequiredField ErrorText=" " IsRequired="true" />
                                                    </ValidationSettings>
                                                </dx:ASPxComboBox>
                                            </td>
                                            <td class="TdSol" style="width: 15%;">
                                                <dx:ASPxLabel runat="server" Text="Ticaret Sicil No : " Font-Size="Small" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <dx:ASPxTextBox ID="TextBoxTicaretSicilNo" runat="server" Width="200px" Font-Size="Small" MaxLength="50">
                                                </dx:ASPxTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="TdSol" style="width: 15%;">
                                                <dx:ASPxLabel runat="server" Text="Ticaret Sicil Tarih : " Font-Size="Small" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <dx:ASPxDateEdit ID="DateEditSicilTarih" runat="server" Font-Size="Small" Width="200">
                                                </dx:ASPxDateEdit>
                                            </td>
                                            <td class="TdSol" style="width: 15%;">
                                                <dx:ASPxLabel runat="server" Text="Sermayesi : " Font-Size="Small" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <dx:ASPxSpinEdit ID="SpinEditSermaye" runat="server" DecimalPlaces="4" Width="200px" Font-Size="Small" MaxLength="14" NumberType="Float" AllowNull="true" MinValue="0" SpinButtons-ShowIncrementButtons="false">
                                                    <SpinButtons ShowIncrementButtons="False"></SpinButtons>
                                                </dx:ASPxSpinEdit>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="TdSol" style="width: 15%;">
                                                <dx:ASPxLabel runat="server" Text="İşçi Sayısı : " Font-Size="Small" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <dx:ASPxSpinEdit ID="SpinEditIsciSayisi" runat="server" DecimalPlaces="0" Width="200px" Font-Size="Small" MaxLength="10" NumberType="Integer" AllowNull="true" MinValue="0" SpinButtons-ShowIncrementButtons="false">
                                                    <SpinButtons ShowIncrementButtons="False"></SpinButtons>
                                                </dx:ASPxSpinEdit>
                                            </td>
                                            <td class="TdSolZorunlu" style="width: 15%;">
                                                <dx:ASPxLabel runat="server" Text="Re'sen Kayıt : " Font-Size="Small" ForeColor="Red" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <asp:CheckBox ID="CheckBoxResenKayitMi" runat="server" CssClass="mycheckBig" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="TdSol" style="width: 15%;">
                                                <dx:ASPxLabel runat="server" Text="Vergi Dairesi : " Font-Size="Small" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <dx:ASPxComboBox ID="ComboBoxVergiDairesi" runat="server" ValueType="System.String" Width="200px" Font-Size="Small" TextField="VergiDairesiAdi" ValueField="VergiDaireKey" IncrementalFilteringMode="StartsWith">
                                                </dx:ASPxComboBox>
                                            </td>
                                            <td class="TdSol" style="width: 15%;">
                                                <dx:ASPxLabel runat="server" Text="Vergi No : " Font-Size="Small" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <dx:ASPxSpinEdit ID="SpinEditVergiNo" runat="server" DecimalPlaces="0" Width="200px" Font-Size="Small" MaxLength="11" NumberType="Integer" AllowNull="true" MinValue="0" SpinButtons-ShowIncrementButtons="false">
                                                    <SpinButtons ShowIncrementButtons="False"></SpinButtons>
                                                </dx:ASPxSpinEdit>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="TdSol" style="width: 15%;">
                                                <dx:ASPxLabel runat="server" Text="Vergi No(Eski) : " Font-Size="Small" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <dx:ASPxTextBox ID="TextBoxVergiNoEski" runat="server" Width="200px" Font-Size="Small" MaxLength="10">
                                                </dx:ASPxTextBox>
                                            </td>
                                            <td class="TdSol" style="width: 15%;">
                                                <dx:ASPxLabel runat="server" Text="Kayıt Tarihi : " Font-Size="Small" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <dx:ASPxDateEdit ID="DateEditKayitTarihi" runat="server" Font-Size="Small" Width="200">
                                                </dx:ASPxDateEdit>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="TdSol" style="width: 15%;">
                                                <dx:ASPxLabel runat="server" Text="E-posta Adresi : " Font-Size="Small" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <dx:ASPxTextBox ID="TextBoxEpostaAdresi" runat="server" Width="200px" Font-Size="Small" MaxLength="50">
                                                </dx:ASPxTextBox>
                                            </td>
                                            <td class="TdSol" style="width: 15%;">
                                                <dx:ASPxLabel runat="server" Text="Web Adresi : " Font-Size="Small" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <dx:ASPxTextBox ID="TextBoxWebAdresi" runat="server" Width="200px" Font-Size="Small" MaxLength="50">
                                                </dx:ASPxTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="TdSol" style="width: 15%;">
                                                <dx:ASPxLabel runat="server" Text="Terkin Olma Tarihi : " Font-Size="Small" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <dx:ASPxDateEdit ID="DateEditTerkinTarihi" runat="server" Font-Size="Small" Width="200">
                                                </dx:ASPxDateEdit>
                                            </td>
                                            <td rowspan="2" class="TdSol">
                                                <dx:ASPxLabel runat="server" Text="Açıklama : " Font-Size="Small" />
                                            </td>
                                            <td rowspan="2" class="TdSag">
                                                <dx:ASPxMemo ID="MemoAciklama" runat="server" Height="50px" Width="200px" Font-Size="Small" MaxLength="200">
                                                </dx:ASPxMemo>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="TdSol" style="width: 15%;">
                                                <dx:ASPxLabel runat="server" Text="Terkin Y.K.K. No : " Font-Size="Small" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <dx:ASPxTextBox ID="TextBoxTerkinYKKNo" runat="server" Width="200px" Font-Size="Small" MaxLength="10">
                                                </dx:ASPxTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="4" class="TdOrtala">
                                                <div id="divIslemler" runat="server" style="margin-left: 40%;">
                                                    <dx:ASPxButton ID="ButtonKaydet" runat="server" Text="Kaydet" ValidationGroup="KayitGuncelle" Width="120" Font-Size="Small" Visible="false" OnClick="ButtonKaydetGuncelle_Click" />
                                                    <dx:ASPxButton ID="ButtonGuncelle" runat="server" Text="Güncelle" ValidationGroup="KayitGuncelle" Width="120" Font-Size="Small" Visible="false" OnClick="ButtonKaydetGuncelle_Click" />
                                                    <dx:ASPxButton ID="ButtonTemizle" runat="server" Text="Temizle" Width="120" Font-Size="Small" Visible="false" OnClick="ButtonTemizle_Click" />
                                                    <dx:ASPxButton ID="ButtonIptal" runat="server" Text="İptal" Width="120" Font-Size="Small" Visible="false" OnClick="ButtonIptal_Click" />
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </dx:ContentControl>
                            </ContentCollection>
                        </dx:TabPage>
                        <dx:TabPage Text="Şahıs Bilgi" ClientVisible="False" ClientEnabled="True">
                            <ContentCollection>
                                <dx:ContentControl ID="ContentControl2" runat="server">
                                    <table style="border-color: #999999; width: 100%;" border="1">
                                        <tr>
                                            <td class="TdSolZorunlu" style="width: 15%;">
                                                <dx:ASPxLabel runat="server" Text="Ad : " Font-Size="Small" ForeColor="Red" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <dx:ASPxTextBox ID="TextBoxFirmaSahisBilgiAd" runat="server" Width="200px" Font-Size="Small" MaxLength="50">
                                                    <ValidationSettings ValidationGroup="FirmaSahisBilgiKayitGuncelle" Display="Dynamic">
                                                        <RequiredField ErrorText=" " IsRequired="true" />
                                                    </ValidationSettings>
                                                </dx:ASPxTextBox>
                                            </td>
                                            <td class="TdSolZorunlu" style="width: 15%;">
                                                <dx:ASPxLabel runat="server" Text="Soyad : " Font-Size="Small" ForeColor="Red" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <dx:ASPxTextBox ID="TextBoxFirmaSahisBilgiSoyad" runat="server" Width="200px" Font-Size="Small" MaxLength="50">
                                                    <ValidationSettings ValidationGroup="FirmaSahisBilgiKayitGuncelle" Display="Dynamic">
                                                        <RequiredField ErrorText=" " IsRequired="true" />
                                                    </ValidationSettings>
                                                </dx:ASPxTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="TdSolZorunlu" style="width: 15%;">
                                                <dx:ASPxLabel runat="server" Text="Tahsil Durumu : " Font-Size="Small" ForeColor="Red" />

                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <dx:ASPxComboBox ID="ComboBoxFirmaSahisBilgiTahsilDurumu" runat="server" ValueType="System.String" Width="200px" Font-Size="Small" TextField="OgrenimDurumTipAdi" ValueField="OgrenimDurumTipKey">
                                                    <ValidationSettings ValidationGroup="FirmaSahisBilgiKayitGuncelle" Display="Dynamic">
                                                        <RequiredField ErrorText=" " IsRequired="true" />
                                                    </ValidationSettings>
                                                </dx:ASPxComboBox>
                                            </td>
                                            <td class="TdSolZorunlu" style="width: 15%;">
                                                <dx:ASPxLabel runat="server" Text="Uyruk : " Font-Size="Small" ForeColor="Red" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <dx:ASPxTextBox ID="TextBoxFirmaSahisBilgiUyruk" runat="server" Width="200px" Font-Size="Small" MaxLength="50">
                                                    <ValidationSettings ValidationGroup="FirmaSahisBilgiKayitGuncelle" Display="Dynamic">
                                                        <RequiredField ErrorText=" " IsRequired="true" />
                                                    </ValidationSettings>
                                                </dx:ASPxTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="TdSol" style="width: 15%;">
                                                <dx:ASPxLabel runat="server" Text="Doğum Yeri : " Font-Size="Small" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <dx:ASPxTextBox ID="TextBoxFirmaSahisBilgiDogumYeri" runat="server" Width="200px" Font-Size="Small" MaxLength="50">
                                                </dx:ASPxTextBox>
                                            </td>
                                            <td class="TdSol" style="width: 15%;">
                                                <dx:ASPxLabel runat="server" Text="Doğum Tarihi : " Font-Size="Small" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <dx:ASPxDateEdit ID="DateEditFirmaSahisBilgiDogumTarihi" runat="server" Font-Size="Small" Width="200">
                                                </dx:ASPxDateEdit>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="TdSol" style="width: 15%;">
                                                <dx:ASPxLabel runat="server" Text="Baba Adı : " Font-Size="Small" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <dx:ASPxTextBox ID="TextBoxFirmaSahisBilgiBabaAdi" runat="server" Width="200px" Font-Size="Small" MaxLength="50">
                                                </dx:ASPxTextBox>
                                            </td>
                                            <td class="TdSol" style="width: 15%;" rowspan="2">
                                                <dx:ASPxLabel runat="server" Text="Adres : " Font-Size="Small" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;" rowspan="2">
                                                <dx:ASPxMemo ID="MemoFirmaSahisBilgiAdres" runat="server" Height="50px" Width="200px" Font-Size="Small" MaxLength="100">
                                                </dx:ASPxMemo>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="TdSol" style="width: 15%;">
                                                <dx:ASPxLabel runat="server" Text="Tel : " Font-Size="Small" />
                                                </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <dx:ASPxTextBox ID="TextBoxFirmaSahisBilgiTel" runat="server" Width="200px" Font-Size="Small" MaxLength="50">
                                                </dx:ASPxTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="TdSol" style="width: 15%;">
                                                <dx:ASPxLabel runat="server" Text="Tc Kimlik No : " Font-Size="Small" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <dx:ASPxTextBox ID="TextBoxSahisBilgiTcKimlikNo" runat="server" Width="200px" Font-Size="Small" MaxLength="11">
                                                    <MaskSettings Mask="<00000000000..99999999999>" />
                                                </dx:ASPxTextBox>
                                            </td>
                                            <td class="TdSol" style="width: 15%;"></td>
                                            <td class="TdSag" style="width: 35%;"></td>
                                        </tr>
                                        <tr>
                                            <td colspan="4" class="TdOrtala">
                                                <div id="Div1" runat="server" style="margin-left: 36%;">
                                                    <dx:ASPxButton ID="ButtonFirmaSahisBilgiGuncelle" runat="server" Text="Güncelle" ValidationGroup="FirmaSahisBilgiKayitGuncelle" Width="120" Font-Size="Small" OnClick="ButtonFirmaSahisBilgiGuncelle_Click" />
                                                    <dx:ASPxButton ID="ButtonFirmaSahisBilgiIptal" runat="server" Text="İptal" Width="120" Font-Size="Small" OnClick="ButtonFirmaSahisBilgiIptal_Click" />
                                                    <dx:ASPxButton ID="ButtonFirmaSahisBilgiSil" runat="server" Text="Sil" Width="120" Font-Size="Small" OnClick="ButtonFirmaSahisBilgiSil_Click" />
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </dx:ContentControl>
                            </ContentCollection>
                        </dx:TabPage>
                        <dx:TabPage Text="Adres Bilgi" ClientVisible="False" ClientEnabled="True">
                            <ContentCollection>
                                <dx:ContentControl ID="ContentControl3" runat="server">
                                    <table style="border-color: #999999; width: 100%;" border="1">
                                        <tr>
                                            <td class="TdSolZorunlu" style="width: 15%;" rowspan="2">
                                                <dx:ASPxLabel runat="server" Text="Adres : " Font-Size="Small" ForeColor="Red" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;" rowspan="2">
                                                <dx:ASPxMemo ID="MemoFirmaAdres" runat="server" Width="200px" Font-Size="Small" MaxLength="500">
                                                    <ValidationSettings ValidationGroup="FirmaAdresBilgiKayitGuncelle" Display="Dynamic">
                                                        <RequiredField ErrorText=" " IsRequired="true" />
                                                    </ValidationSettings>
                                                </dx:ASPxMemo>
                                            </td>
                                            <td class="TdSol" style="width: 15%;">
                                                <dx:ASPxLabel runat="server" Text="Adres Tipi : " Font-Size="Small" ForeColor="Red" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <dx:ASPxComboBox ID="ComboBoxFirmaAdresTip" runat="server" ValueType="System.String" Width="200px" Font-Size="Small" TextField="FirmaAdresTipAdi" ValueField="FirmaAdresTipKey">
                                                </dx:ASPxComboBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="TdSol" style="width: 15%;">&nbsp;</td>
                                            <td class="TdSag" style="width: 35%;">&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td colspan="4" class="TdOrtala">
                                                <div style="float: left; margin-left: 40%;">
                                                    <dx:ASPxButton ID="ButtonFirmaAdresBilgiKaydet" runat="server" Text="Kaydet" ValidationGroup="FirmaAdresBilgiKayitGuncelle" Width="120" Font-Size="Small" Visible="false" OnClick="ButtonFirmaAdresBilgiKaydetGuncelle_Click" />
                                                    <dx:ASPxButton ID="ButtonFirmaAdresBilgiGuncelle" runat="server" Text="Güncelle" ValidationGroup="FirmaAdresBilgiKayitGuncelle" Width="120" Font-Size="Small" Visible="false" OnClick="ButtonFirmaAdresBilgiKaydetGuncelle_Click" />
                                                    <dx:ASPxButton ID="ButtonFirmaAdresBilgiTemizle" runat="server" Text="Temizle" Width="120" Font-Size="Small" OnClick="ButtonFirmaAdresBilgiIptalTemizle_Click" />
                                                    <dx:ASPxButton ID="ButtonFirmaAdresBilgiIptal" runat="server" Text="İptal" Width="120" Font-Size="Small" OnClick="ButtonFirmaAdresBilgiIptalTemizle_Click" />
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="TdOrtala" colspan="4">
                                                <dx:ASPxGridView ID="GridViewFirmaAdresBilgi" runat="server" KeyFieldName="FirmaAdresKey" AutoGenerateColumns="false" Width="100%" EnableCallBacks="true" Font-Size="Small" OnRowDeleting="GridViewFirmaAdresBilgi_RowDeleting" OnCustomButtonCallback="GridViewFirmaAdresBilgi_CustomButtonCallback">
                                                    <ClientSideEvents EndCallback="function(s, e) {
	                                                                        if (s.cpErrorMessage){
                                                                            delete s.cpErrorMessage;
		                                                                        alert('Silinmek istenen veri diğer kısımlarda kullanılmaktadır!');
                                                                                }
                                                                       }" />
                                                    <Settings ShowGroupPanel="false" />
                                                    <SettingsText ConfirmDelete="Silme işlemini onaylıyor musunuz?" />
                                                    <SettingsBehavior AllowDragDrop="false" AllowFocusedRow="false" ConfirmDelete="true" AllowGroup="false" AllowSort="false" />
                                                    <SettingsPager Visible="true" PageSize="15" AlwaysShowPager="true" Position="Bottom" ShowEmptyDataRows="true" />
                                                    <Paddings Padding="0px" />
                                                    <Border BorderWidth="0px" />
                                                    <BorderBottom BorderWidth="1px" />
                                                    <Columns>
                                                        <dx:GridViewDataColumn FieldName="FirmaAdres" Caption="Adres">
                                                            <CellStyle HorizontalAlign="Center" />
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                        </dx:GridViewDataColumn>
                                                        <dx:GridViewDataColumn FieldName="TT_FIRMA_ADRES_TIP.FirmaAdresTipAdi" Caption="Adres Tip">
                                                            <CellStyle HorizontalAlign="Center" />
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                        </dx:GridViewDataColumn>
                                                        <dx:GridViewCommandColumn Caption="İşlemler" ButtonType="Image">
                                                            <CustomButtons>
                                                                <dx:GridViewCommandColumnCustomButton Visibility="AllDataRows" Image-ToolTip="Düzenle" Image-Url="../../Content/Images/Icons/edit.png" Image-Width="24" Image-Height="24">
                                                                    <Image ToolTip="D&#252;zenle" Height="24px" Width="24px" Url="~/Content/Images/Icons/edit.png"></Image>
                                                                </dx:GridViewCommandColumnCustomButton>
                                                            </CustomButtons>
                                                            <DeleteButton Visible="true" Image-ToolTip="Sil" Image-Url="~/Content/Images/Icons/delete.png" Image-Width="24" Image-Height="24">
                                                                <Image ToolTip="Sil" Height="24px" Width="24px" Url="~/Content/Images/Icons/delete.png"></Image>
                                                            </DeleteButton>
                                                            <CellStyle HorizontalAlign="Center" />
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                        </dx:GridViewCommandColumn>
                                                    </Columns>
                                                </dx:ASPxGridView>
                                            </td>
                                        </tr>
                                    </table>
                                </dx:ContentControl>
                            </ContentCollection>
                        </dx:TabPage>
                        <dx:TabPage Text="Telefon/Fax Bilgi" ClientVisible="False" ClientEnabled="True">
                            <ContentCollection>
                                <dx:ContentControl ID="ContentControl4" runat="server">
                                    <table style="border-color: #999999; width: 100%;" border="1">
                                        <tr>
                                            <td class="TdSolZorunlu" style="width: 15%;">
                                                <dx:ASPxLabel runat="server" Text="Telefon/Fax No : " Font-Size="Small" ForeColor="Red" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <dx:ASPxTextBox ID="TextBoxFirmaTelefonFax" runat="server" Width="200px" Font-Size="Small" MaxLength="20">
                                                    <ValidationSettings ValidationGroup="FirmaTelefonFaxBilgiKayitGuncelle" Display="Dynamic">
                                                        <RequiredField ErrorText=" " IsRequired="true" />
                                                    </ValidationSettings>
                                                </dx:ASPxTextBox>
                                            </td>
                                            <td class="TdSolZorunlu" style="width: 15%;">
                                                <dx:ASPxLabel runat="server" Text="Telefon/Fax Tipi : " Font-Size="Small" ForeColor="Red" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <dx:ASPxComboBox ID="ComboBoxFirmaTelefonFaxTip" runat="server" ValueType="System.String" Width="200px" Font-Size="Small" TextField="FirmaTelefonFaxTipAdi" ValueField="FirmaTelefonFaxTipKey">
                                                    <ValidationSettings ValidationGroup="FirmaTelefonFaxBilgiKayitGuncelle" Display="Dynamic">
                                                        <RequiredField ErrorText=" " IsRequired="true" />
                                                    </ValidationSettings>
                                                </dx:ASPxComboBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="4" class="TdOrtala">
                                                <div style="float: left; margin-left: 40%;">
                                                    <dx:ASPxButton ID="ButtonFirmaTelefonFaxBilgiKaydet" runat="server" Text="Kaydet" ValidationGroup="FirmaTelefonFaxBilgiKayitGuncelle" Width="120" Font-Size="Small" Visible="false" OnClick="ButtonFirmaTelefonFaxBilgiKaydetGuncelle_Click" />
                                                    <dx:ASPxButton ID="ButtonFirmaTelefonFaxBilgiGuncelle" runat="server" Text="Güncelle" ValidationGroup="FirmaTelefonFaxBilgiKayitGuncelle" Width="120" Font-Size="Small" Visible="false" OnClick="ButtonFirmaTelefonFaxBilgiKaydetGuncelle_Click" />
                                                    <dx:ASPxButton ID="ButtonFirmaTelefonFaxBilgiTemizle" runat="server" Text="Temizle" Width="120" Font-Size="Small" OnClick="ButtonFirmaTelefonFaxBilgiIptalTemizle_Click" />
                                                    <dx:ASPxButton ID="ButtonFirmaTelefonFaxBilgiIptal" runat="server" Text="İptal" Width="120" Font-Size="Small" OnClick="ButtonFirmaTelefonFaxBilgiIptalTemizle_Click" />
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="TdOrtala" colspan="4">
                                                <dx:ASPxGridView ID="GridViewFirmaTelefonFaxBilgi" runat="server" KeyFieldName="FirmaTelefonFaxKey" AutoGenerateColumns="false" Width="100%" EnableCallBacks="true" Font-Size="Small" OnRowDeleting="GridViewFirmaTelefonFaxBilgi_RowDeleting" OnCustomButtonCallback="GridViewFirmaTelefonFaxBilgi_CustomButtonCallback">
                                                    <ClientSideEvents EndCallback="function(s, e) {
	                                                                        if (s.cpErrorMessage){
                                                                            delete s.cpErrorMessage;
		                                                                        alert('Silinmek istenen veri diğer kısımlarda kullanılmaktadır!');
                                                                                }
                                                                       }" />
                                                    <Settings ShowGroupPanel="false" />
                                                    <SettingsText ConfirmDelete="Silme işlemini onaylıyor musunuz?" />
                                                    <SettingsBehavior AllowDragDrop="false" AllowFocusedRow="false" ConfirmDelete="true" AllowGroup="false" AllowSort="false" />
                                                    <SettingsPager Visible="true" PageSize="15" AlwaysShowPager="true" Position="Bottom" ShowEmptyDataRows="true" />
                                                    <Paddings Padding="0px" />
                                                    <Border BorderWidth="0px" />
                                                    <BorderBottom BorderWidth="1px" />
                                                    <Columns>
                                                        <dx:GridViewDataColumn FieldName="FirmaTelefonFax" Caption="Telefon/Fax No">
                                                            <CellStyle HorizontalAlign="Center" />
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                        </dx:GridViewDataColumn>
                                                        <dx:GridViewDataColumn FieldName="FirmaTelefonFaxTipAdi" Caption="Telefon/Fax Tip">
                                                            <CellStyle HorizontalAlign="Center" />
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                        </dx:GridViewDataColumn>
                                                        <dx:GridViewCommandColumn Caption="İşlemler" ButtonType="Image">
                                                            <CustomButtons>
                                                                <dx:GridViewCommandColumnCustomButton Visibility="AllDataRows" Image-ToolTip="Düzenle" Image-Url="../../Content/Images/Icons/edit.png" Image-Width="24" Image-Height="24">
                                                                    <Image ToolTip="D&#252;zenle" Height="24px" Width="24px" Url="~/Content/Images/Icons/edit.png"></Image>
                                                                </dx:GridViewCommandColumnCustomButton>
                                                            </CustomButtons>
                                                            <DeleteButton Visible="true" Image-ToolTip="Sil" Image-Url="~/Content/Images/Icons/delete.png" Image-Width="24" Image-Height="24">
                                                                <Image ToolTip="Sil" Height="24px" Width="24px" Url="~/Content/Images/Icons/delete.png"></Image>
                                                            </DeleteButton>
                                                            <CellStyle HorizontalAlign="Center" />
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                        </dx:GridViewCommandColumn>
                                                    </Columns>
                                                </dx:ASPxGridView>
                                            </td>
                                        </tr>
                                    </table>
                                </dx:ContentControl>
                            </ContentCollection>
                        </dx:TabPage>
                        <dx:TabPage Text="Yetkili Bilgi" ClientVisible="False" ClientEnabled="True">
                            <ContentCollection>
                                <dx:ContentControl ID="ContentControl5" runat="server">
                                    <table style="border-color: #999999; width: 100%;" border="1">
                                        <tr>
                                            <td class="TdSolZorunlu" style="width: 15%;">
                                                <dx:ASPxLabel runat="server" Text="Ad Soyad : " Font-Size="Small" ForeColor="Red" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <dx:ASPxTextBox ID="TextBoxFirmaYetkiliBilgiAdSoyad" runat="server" Width="200px" Font-Size="Small" MaxLength="50">
                                                    <ValidationSettings ValidationGroup="FirmaYetkiliBilgiKayitGuncelle" Display="Dynamic">
                                                        <RequiredField ErrorText=" " IsRequired="true" />
                                                    </ValidationSettings>
                                                </dx:ASPxTextBox>
                                            </td>
                                            <td class="TdSolZorunlu" colspan="2"></td>
                                        </tr>
                                        <tr>
                                            <td colspan="4" class="TdOrtala">
                                                <div id="Div2" runat="server" style="float: left; margin-left: 40%;">
                                                    <dx:ASPxButton ID="ButtonFirmaYetkiliBilgiKaydet" runat="server" Text="Kaydet" ValidationGroup="FirmaYetkiliBilgiKayitGuncelle" Width="120" Font-Size="Small" Visible="false" OnClick="ButtonFirmaYetkiliBilgiKaydetGuncelle_Click" />
                                                    <dx:ASPxButton ID="ButtonFirmaYetkiliBilgiGuncelle" runat="server" Text="Güncelle" ValidationGroup="FirmaYetkiliBilgiKayitGuncelle" Width="120" Font-Size="Small" Visible="false" OnClick="ButtonFirmaYetkiliBilgiKaydetGuncelle_Click" />
                                                    <dx:ASPxButton ID="ButtonFirmaYetkiliBilgiTemizle" runat="server" Text="Temizle" Width="120" Font-Size="Small" OnClick="ButtonFirmaYetkiliBilgiIptalTemizle_Click" />
                                                    <dx:ASPxButton ID="ButtonFirmaYetkiliBilgiIptal" runat="server" Text="İptal" Width="120" Font-Size="Small" OnClick="ButtonFirmaYetkiliBilgiIptalTemizle_Click" />
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="TdOrtala" colspan="4">
                                                <dx:ASPxGridView ID="GridViewFirmaYetkiliBilgi" runat="server" KeyFieldName="FirmaYetkiliKey" AutoGenerateColumns="false" Width="100%" EnableCallBacks="true" Font-Size="Small" OnRowDeleting="GridViewFirmaYetkiliBilgi_RowDeleting" OnCustomButtonCallback="GridViewFirmaYetkiliBilgi_CustomButtonCallback">
                                                    <ClientSideEvents EndCallback="function(s, e) {
	                                                                        if (s.cpErrorMessage){
                                                                            delete s.cpErrorMessage;
		                                                                        alert('Silinmek istenen veri diğer kısımlarda kullanılmaktadır!');
                                                                                }
                                                                       }" />
                                                    <Settings ShowGroupPanel="false" />
                                                    <SettingsText ConfirmDelete="Silme işlemini onaylıyor musunuz?" />
                                                    <SettingsBehavior AllowDragDrop="false" AllowFocusedRow="false" ConfirmDelete="true" AllowGroup="false" AllowSort="false" />
                                                    <SettingsPager Visible="true" PageSize="15" AlwaysShowPager="true" Position="Bottom" ShowEmptyDataRows="true" />
                                                    <Paddings Padding="0px" />
                                                    <Border BorderWidth="0px" />
                                                    <BorderBottom BorderWidth="1px" />
                                                    <Columns>
                                                        <dx:GridViewDataColumn FieldName="AdSoyad" Caption="Ad Soyad">
                                                            <CellStyle HorizontalAlign="Center" />
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                        </dx:GridViewDataColumn>
                                                        <dx:GridViewCommandColumn Caption="İşlemler" ButtonType="Image">
                                                            <CustomButtons>
                                                                <dx:GridViewCommandColumnCustomButton Visibility="AllDataRows" Image-ToolTip="Düzenle" Image-Url="../../Content/Images/Icons/edit.png" Image-Width="24" Image-Height="24">
                                                                    <Image ToolTip="D&#252;zenle" Height="24px" Width="24px" Url="~/Content/Images/Icons/edit.png"></Image>
                                                                </dx:GridViewCommandColumnCustomButton>
                                                            </CustomButtons>
                                                            <DeleteButton Visible="true" Image-ToolTip="Sil" Image-Url="~/Content/Images/Icons/delete.png" Image-Width="24" Image-Height="24">
                                                                <Image ToolTip="Sil" Height="24px" Width="24px" Url="~/Content/Images/Icons/delete.png"></Image>
                                                            </DeleteButton>
                                                            <CellStyle HorizontalAlign="Center" />
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                        </dx:GridViewCommandColumn>
                                                    </Columns>
                                                </dx:ASPxGridView>
                                            </td>
                                        </tr>
                                    </table>
                                </dx:ContentControl>
                            </ContentCollection>
                        </dx:TabPage>
                        <dx:TabPage Text="Yönetim Bilgi" ClientVisible="False" ClientEnabled="True">
                            <ContentCollection>
                                <dx:ContentControl ID="ContentControl6" runat="server">
                                    <table style="border-color: #999999; width: 100%;" border="1">
                                        <tr>
                                            <td class="TdSolZorunlu" style="width: 15%;">
                                                <dx:ASPxLabel runat="server" Text="Ad Soyad : " Font-Size="Small" ForeColor="Red" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <dx:ASPxTextBox ID="TextBoxFirmaYonetimBilgiAdSoyad" runat="server" Width="200px" Font-Size="Small" MaxLength="50">
                                                    <ValidationSettings ValidationGroup="FirmaYonetimBilgiKayitGuncelle" Display="Dynamic">
                                                        <RequiredField ErrorText=" " IsRequired="true" />
                                                    </ValidationSettings>
                                                </dx:ASPxTextBox>
                                            </td>
                                            <td class="TdSolZorunlu">
                                                <dx:ASPxLabel runat="server" Text="Unvan : " Font-Size="Small" ForeColor="Red" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <dx:ASPxTextBox ID="TextBoxFirmaYonetimBilgiUnvan" runat="server" Width="200px" Font-Size="Small" MaxLength="50">
                                                    <ValidationSettings ValidationGroup="FirmaYonetimBilgiKayitGuncelle" Display="Dynamic">
                                                        <RequiredField ErrorText=" " IsRequired="true" />
                                                    </ValidationSettings>
                                                </dx:ASPxTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="4" class="TdOrtala">
                                                <div id="Div3" runat="server" style="float: left; margin-left: 40%;">
                                                    <dx:ASPxButton ID="ButtonFirmaYonetimBilgiKaydet" runat="server" Text="Kaydet" ValidationGroup="FirmaYonetimBilgiKayitGuncelle" Width="120" Font-Size="Small" Visible="false" OnClick="ButtonFirmaYonetimBilgiKaydetGuncelle_Click" />
                                                    <dx:ASPxButton ID="ButtonFirmaYonetimBilgiGuncelle" runat="server" Text="Güncelle" ValidationGroup="FirmaYonetimBilgiKayitGuncelle" Width="120" Font-Size="Small" Visible="false" OnClick="ButtonFirmaYonetimBilgiKaydetGuncelle_Click" />
                                                    <dx:ASPxButton ID="ButtonFirmaYonetimBilgiTemizle" runat="server" Text="Temizle" Width="120" Font-Size="Small" OnClick="ButtonFirmaYonetimBilgiIptalTemizle_Click" />
                                                    <dx:ASPxButton ID="ButtonFirmaYonetimBilgiIptal" runat="server" Text="İptal" Width="120" Font-Size="Small" OnClick="ButtonFirmaYonetimBilgiIptalTemizle_Click" />
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="TdOrtala" colspan="4">
                                                <dx:ASPxGridView ID="GridViewFirmaYonetimBilgi" runat="server" KeyFieldName="FirmaYonetimKey" AutoGenerateColumns="false" Width="100%" EnableCallBacks="true" Font-Size="Small" OnRowDeleting="GridViewFirmaYonetimBilgi_RowDeleting" OnCustomButtonCallback="GridViewFirmaYonetimBilgi_CustomButtonCallback">
                                                    <ClientSideEvents EndCallback="function(s, e) {
	                                                                        if (s.cpErrorMessage){
                                                                            delete s.cpErrorMessage;
		                                                                        alert('Silinmek istenen veri diğer kısımlarda kullanılmaktadır!');
                                                                                }
                                                                       }" />
                                                    <Settings ShowGroupPanel="false" />
                                                    <SettingsText ConfirmDelete="Silme işlemini onaylıyor musunuz?" />
                                                    <SettingsBehavior AllowDragDrop="false" AllowFocusedRow="false" ConfirmDelete="true" AllowGroup="false" AllowSort="false" />
                                                    <SettingsPager Visible="true" PageSize="15" AlwaysShowPager="true" Position="Bottom" ShowEmptyDataRows="true" />
                                                    <Paddings Padding="0px" />
                                                    <Border BorderWidth="0px" />
                                                    <BorderBottom BorderWidth="1px" />
                                                    <Columns>
                                                        <dx:GridViewDataColumn FieldName="AdSoyad" Caption="Ad Soyad">
                                                            <CellStyle HorizontalAlign="Center" />
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                        </dx:GridViewDataColumn>
                                                        <dx:GridViewDataColumn FieldName="Unvan" Caption="Unvan">
                                                            <CellStyle HorizontalAlign="Center" />
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                        </dx:GridViewDataColumn>
                                                        <dx:GridViewCommandColumn Caption="İşlemler" ButtonType="Image">
                                                            <CustomButtons>
                                                                <dx:GridViewCommandColumnCustomButton Visibility="AllDataRows" Image-ToolTip="Düzenle" Image-Url="../../Content/Images/Icons/edit.png" Image-Width="24" Image-Height="24">
                                                                    <Image ToolTip="D&#252;zenle" Height="24px" Width="24px" Url="~/Content/Images/Icons/edit.png"></Image>
                                                                </dx:GridViewCommandColumnCustomButton>
                                                            </CustomButtons>
                                                            <DeleteButton Visible="true" Image-ToolTip="Sil" Image-Url="~/Content/Images/Icons/delete.png" Image-Width="24" Image-Height="24">
                                                                <Image ToolTip="Sil" Height="24px" Width="24px" Url="~/Content/Images/Icons/delete.png"></Image>
                                                            </DeleteButton>
                                                            <CellStyle HorizontalAlign="Center" />
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                        </dx:GridViewCommandColumn>
                                                    </Columns>
                                                </dx:ASPxGridView>
                                            </td>
                                        </tr>
                                    </table>
                                </dx:ContentControl>
                            </ContentCollection>
                        </dx:TabPage>
                        <dx:TabPage Text="Faaliyet Bilgi" ClientVisible="False" ClientEnabled="True">
                            <ContentCollection>
                                <dx:ContentControl ID="ContentControl7" runat="server">
                                    <table style="border-color: #999999; width: 100%;" border="1">
                                        <tr>
                                            <td class="TdSolZorunlu" style="width: 15%;">
                                                <dx:ASPxLabel runat="server" Text="Madde Kodu : " Font-Size="Small" ForeColor="Red" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <dx:ASPxComboBox ID="ComboBoxFirmaFaaliyetBilgiMaddeKodu" runat="server" ValueType="System.String" Width="200px" Font-Size="Small" TextField="Adi" ValueField="MaddeKodKey">
                                                    <ValidationSettings ValidationGroup="FirmaFaaliyetBilgiKayitGuncelle" Display="Dynamic">
                                                        <RequiredField ErrorText=" " IsRequired="true" />
                                                    </ValidationSettings>
                                                </dx:ASPxComboBox>
                                            </td>
                                            <td class="TdSolZorunlu" colspan="2"></td>
                                        </tr>
                                        <tr>
                                            <td class="TdSolZorunlu" style="width: 15%;">
                                                <dx:ASPxLabel runat="server" Text="Üretim : " Font-Size="Small" ForeColor="Red" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <asp:CheckBox ID="CheckBoxFirmaFaaliyetBilgiUretim" runat="server" CssClass="mycheckBig" />
                                            </td>
                                            <td class="TdSolZorunlu">
                                                <dx:ASPxLabel runat="server" Text="Bayii : " Font-Size="Small" ForeColor="Red" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <asp:CheckBox ID="CheckBoxFirmaFaaliyetBilgiBayii" runat="server" CssClass="mycheckBig" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="TdSolZorunlu" style="width: 15%;">
                                                <dx:ASPxLabel runat="server" Text="Alım : " Font-Size="Small" ForeColor="Red" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <asp:CheckBox ID="CheckBoxFirmaFaaliyetBilgiAlim" runat="server" CssClass="mycheckBig" />
                                            </td>
                                            <td class="TdSolZorunlu">
                                                <dx:ASPxLabel runat="server" Text="Satım : " Font-Size="Small" ForeColor="Red" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <asp:CheckBox ID="CheckBoxFirmaFaaliyetBilgiSatim" runat="server" CssClass="mycheckBig" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="TdSolZorunlu" style="width: 15%;">
                                                <dx:ASPxLabel runat="server" Text="İthalat : " Font-Size="Small" ForeColor="Red" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <asp:CheckBox ID="CheckBoxFirmaFaaliyetBilgiIthalat" runat="server" CssClass="mycheckBig" />
                                            </td>
                                            <td class="TdSolZorunlu">
                                                <dx:ASPxLabel runat="server" Text="İhracat : " Font-Size="Small" ForeColor="Red" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <asp:CheckBox ID="CheckBoxFirmaFaaliyetBilgiIhracat" runat="server" CssClass="mycheckBig" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="4" class="TdOrtala">
                                                <div id="Div4" runat="server" style="float: left; margin-left: 40%;">
                                                    <dx:ASPxButton ID="ButtonFirmaFaaliyetBilgiKaydet" runat="server" Text="Kaydet" ValidationGroup="FirmaFaaliyetBilgiKayitGuncelle" Width="120" Font-Size="Small" Visible="false" OnClick="ButtonFirmaFaaliyetBilgiKaydetGuncelle_Click" />
                                                    <dx:ASPxButton ID="ButtonFirmaFaaliyetBilgiGuncelle" runat="server" Text="Güncelle" ValidationGroup="FirmaFaaliyetBilgiKayitGuncelle" Width="120" Font-Size="Small" Visible="false" OnClick="ButtonFirmaFaaliyetBilgiKaydetGuncelle_Click" />
                                                    <dx:ASPxButton ID="ButtonFirmaFaaliyetBilgiTemizle" runat="server" Text="Temizle" Width="120" Font-Size="Small" OnClick="ButtonFirmaFaaliyetBilgiIptalTemizle_Click" />
                                                    <dx:ASPxButton ID="ButtonFirmaFaaliyetBilgiIptal" runat="server" Text="İptal" Width="120" Font-Size="Small" OnClick="ButtonFirmaFaaliyetBilgiIptalTemizle_Click" />
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="TdOrtala" colspan="4">
                                                <dx:ASPxGridView ID="GridViewFirmaFaaliyetBilgi" runat="server" KeyFieldName="FirmaFaaliyetKey" AutoGenerateColumns="false" Width="100%" EnableCallBacks="true" Font-Size="Small" OnRowDeleting="GridViewFirmaFaaliyetBilgi_RowDeleting" OnCustomButtonCallback="GridViewFirmaFaaliyetBilgi_CustomButtonCallback">
                                                    <ClientSideEvents EndCallback="function(s, e) {
	                                                                        if (s.cpErrorMessage){
                                                                            delete s.cpErrorMessage;
		                                                                        alert('Silinmek istenen veri diğer kısımlarda kullanılmaktadır!');
                                                                                }
                                                                       }" />
                                                    <Settings ShowGroupPanel="false" />
                                                    <SettingsText ConfirmDelete="Silme işlemini onaylıyor musunuz?" />
                                                    <SettingsBehavior AllowDragDrop="false" AllowFocusedRow="false" ConfirmDelete="true" AllowGroup="false" AllowSort="false" />
                                                    <SettingsPager Visible="true" PageSize="15" AlwaysShowPager="true" Position="Bottom" ShowEmptyDataRows="true" />
                                                    <Paddings Padding="0px" />
                                                    <Border BorderWidth="0px" />
                                                    <BorderBottom BorderWidth="1px" />
                                                    <Columns>
                                                        <dx:GridViewDataColumn FieldName="MaddeKoduAdi" Caption="Madde Kodu">
                                                            <CellStyle HorizontalAlign="Center" />
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                        </dx:GridViewDataColumn>
                                                        <dx:GridViewDataCheckColumn FieldName="Uretim" Caption="Uretim">
                                                            <CellStyle HorizontalAlign="Center" />
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                        </dx:GridViewDataCheckColumn>
                                                        <dx:GridViewDataCheckColumn FieldName="Bayi" Caption="Bayi">
                                                            <CellStyle HorizontalAlign="Center" />
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                        </dx:GridViewDataCheckColumn>
                                                        <dx:GridViewDataCheckColumn FieldName="Alim" Caption="Alim">
                                                            <CellStyle HorizontalAlign="Center" />
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                        </dx:GridViewDataCheckColumn>
                                                        <dx:GridViewDataCheckColumn FieldName="Satim" Caption="Satim">
                                                            <CellStyle HorizontalAlign="Center" />
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                        </dx:GridViewDataCheckColumn>
                                                        <dx:GridViewDataCheckColumn FieldName="Ithalat" Caption="Ithalat">
                                                            <CellStyle HorizontalAlign="Center" />
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                        </dx:GridViewDataCheckColumn>
                                                        <dx:GridViewDataCheckColumn FieldName="Ihracat" Caption="Ihracat">
                                                            <CellStyle HorizontalAlign="Center" />
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                        </dx:GridViewDataCheckColumn>
                                                        <dx:GridViewCommandColumn Caption="İşlemler" ButtonType="Image">
                                                            <CustomButtons>
                                                                <dx:GridViewCommandColumnCustomButton Visibility="AllDataRows" Image-ToolTip="Düzenle" Image-Url="~/Content/Images/Icons/edit.png" Image-Width="24" Image-Height="24">
                                                                    <Image ToolTip="D&#252;zenle" Height="24px" Width="24px" Url="~/Content/Images/Icons/edit.png"></Image>
                                                                </dx:GridViewCommandColumnCustomButton>
                                                            </CustomButtons>
                                                            <DeleteButton Visible="true" Image-ToolTip="Sil" Image-Url="~/Content/Images/Icons/delete.png" Image-Width="24" Image-Height="24">
                                                                <Image ToolTip="Sil" Height="24px" Width="24px" Url="~/Content/Images/Icons/delete.png"></Image>
                                                            </DeleteButton>
                                                            <CellStyle HorizontalAlign="Center" />
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                        </dx:GridViewCommandColumn>
                                                    </Columns>
                                                </dx:ASPxGridView>
                                            </td>
                                        </tr>
                                    </table>
                                </dx:ContentControl>
                            </ContentCollection>
                        </dx:TabPage>
                        <dx:TabPage Text="Uyarılar" ClientVisible="False" ClientEnabled="True">
                            <ContentCollection>
                                <dx:ContentControl ID="ContentControl8" runat="server">
                                    <table style="border-color: #999999; width: 100%;" border="1">
                                        <tr>
                                            <td class="TdSolZorunlu" style="width: 15%;" rowspan="2">
                                                <dx:ASPxLabel runat="server" Text="Uyarı İçeriği : " Font-Size="Small" ForeColor="Red" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;" rowspan="2">
                                                <dx:ASPxMemo ID="MemoFirmaUyari" runat="server" Width="200px" Font-Size="Small" MaxLength="500" Rows="2">
                                                    <ValidationSettings ValidationGroup="FirmaUyariBilgiKayitGuncelle" Display="Dynamic">
                                                        <RequiredField ErrorText=" " IsRequired="true" />
                                                    </ValidationSettings>
                                                </dx:ASPxMemo>
                                            </td>
                                            <td class="TdSol" style="width: 15%;">
                                                <dx:ASPxLabel runat="server" Text="Uyarı Tarihi : " Font-Size="Small" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <dx:ASPxDateEdit ID="DateEditFirmaUyariTarihi" runat="server" Font-Size="Small" Width="200">
                                                </dx:ASPxDateEdit>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="TdSolZorunlu" style="width: 15%;">
                                                <dx:ASPxLabel runat="server" Text="Aktif : " Font-Size="Small" ForeColor="Red" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <asp:CheckBox ID="CheckBoxFirmaUyariAktif" runat="server" CssClass="mycheckBig" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="4" class="TdOrtala">
                                                <div style="float: left; margin-left: 40%;">
                                                    <dx:ASPxButton ID="ButtonFirmaUyariBilgiKaydet" runat="server" Text="Kaydet" ValidationGroup="FirmaUyariBilgiKayitGuncelle" Width="120" Font-Size="Small" Visible="false" OnClick="ButtonFirmaUyariBilgiKaydetGuncelle_Click" />
                                                    <dx:ASPxButton ID="ButtonFirmaUyariBilgiGuncelle" runat="server" Text="Güncelle" ValidationGroup="FirmaUyariBilgiKayitGuncelle" Width="120" Font-Size="Small" Visible="false" OnClick="ButtonFirmaUyariBilgiKaydetGuncelle_Click" />
                                                    <dx:ASPxButton ID="ButtonFirmaUyariBilgiTemizle" runat="server" Text="Temizle" Width="120" Font-Size="Small" OnClick="ButtonFirmaUyariBilgiIptalTemizle_Click" />
                                                    <dx:ASPxButton ID="ButtonFirmaUyariBilgiIptal" runat="server" Text="İptal" Width="120" Font-Size="Small" OnClick="ButtonFirmaUyariBilgiIptalTemizle_Click" />
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="TdOrtala" colspan="4">
                                                <dx:ASPxGridView ID="GridViewFirmaUyariBilgi" runat="server" KeyFieldName="FirmaUyariKey" AutoGenerateColumns="false" Width="100%" EnableCallBacks="true" Font-Size="Small" OnRowDeleting="GridViewFirmaUyariBilgi_RowDeleting" OnCustomButtonCallback="GridViewFirmaUyariBilgi_CustomButtonCallback">
                                                    <ClientSideEvents EndCallback="function(s, e) {
	                                                                        if (s.cpErrorMessage){
                                                                            delete s.cpErrorMessage;
		                                                                        alert('Silinmek istenen veri diğer kısımlarda kullanılmaktadır!');
                                                                                }
                                                                       }" />
                                                    <Settings ShowGroupPanel="false" />
                                                    <SettingsText ConfirmDelete="Silme işlemini onaylıyor musunuz?" />
                                                    <SettingsBehavior AllowDragDrop="false" AllowFocusedRow="false" ConfirmDelete="true" AllowGroup="false" AllowSort="false" />
                                                    <SettingsPager Visible="true" PageSize="15" AlwaysShowPager="true" Position="Bottom" ShowEmptyDataRows="true" />
                                                    <Paddings Padding="0px" />
                                                    <Border BorderWidth="0px" />
                                                    <BorderBottom BorderWidth="1px" />
                                                    <Columns>
                                                        <dx:GridViewDataColumn FieldName="FirmaUyariTarih" Caption="Tarih">
                                                            <CellStyle HorizontalAlign="Center" />
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                        </dx:GridViewDataColumn>
                                                        <dx:GridViewDataColumn FieldName="FirmaUyari" Caption="Madde Kodu">
                                                            <CellStyle HorizontalAlign="Center" />
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                        </dx:GridViewDataColumn>
                                                        <dx:GridViewDataCheckColumn FieldName="Aktif" Caption="Aktif">
                                                            <CellStyle HorizontalAlign="Center" />
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                        </dx:GridViewDataCheckColumn>
                                                        <dx:GridViewCommandColumn Caption="İşlemler" ButtonType="Image">
                                                            <CustomButtons>
                                                                <dx:GridViewCommandColumnCustomButton Visibility="AllDataRows" Image-ToolTip="Düzenle" Image-Url="~/Content/Images/Icons/edit.png" Image-Width="24" Image-Height="24">
                                                                    <Image ToolTip="D&#252;zenle" Height="24px" Width="24px" Url="~/Content/Images/Icons/edit.png"></Image>
                                                                </dx:GridViewCommandColumnCustomButton>
                                                            </CustomButtons>
                                                            <DeleteButton Visible="true" Image-ToolTip="Sil" Image-Url="~/Content/Images/Icons/delete.png" Image-Width="24" Image-Height="24">
                                                                <Image ToolTip="Sil" Height="24px" Width="24px" Url="~/Content/Images/Icons/delete.png"></Image>
                                                            </DeleteButton>
                                                            <CellStyle HorizontalAlign="Center" />
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                        </dx:GridViewCommandColumn>
                                                    </Columns>
                                                </dx:ASPxGridView>
                                            </td>
                                        </tr>
                                    </table>
                                </dx:ContentControl>
                            </ContentCollection>
                        </dx:TabPage>
                        <dx:TabPage Text="Derece Değişikliği" ClientVisible="False" ClientEnabled="True" NewLine="True">
                            <ContentCollection>
                                <dx:ContentControl ID="ContentControl9" runat="server">
                                    <table style="border-color: #999999; width: 100%;" border="1">
                                        <tr>
                                            <td class="TdSolZorunlu" style="width: 15%;">
                                                <dx:ASPxLabel runat="server" Text="Derece : " Font-Size="Small" ForeColor="Red" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <dx:ASPxComboBox ID="ComboBoxDereceDegisikligiDerece" runat="server" ValueType="System.String" Width="200px" Font-Size="Small" TextField="Kod" ValueField="DereceKey">
                                                    <ValidationSettings ValidationGroup="DereceDegisikligiKayitGuncelle" Display="Dynamic">
                                                        <RequiredField ErrorText=" " IsRequired="true" />
                                                    </ValidationSettings>
                                                </dx:ASPxComboBox>
                                            </td>
                                            <td class="TdSolZorunlu" style="width: 15%;">
                                                <dx:ASPxLabel runat="server" Text="Yıl : " Font-Size="Small" ForeColor="Red" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <dx:ASPxComboBox ID="ComboBoxDereceDegisikligiDereceYil" runat="server" ValueType="System.String" Width="200px" Font-Size="Small">
                                                    <ValidationSettings ValidationGroup="DereceDegisikligiKayitGuncelle" Display="Dynamic">
                                                        <RequiredField ErrorText=" " IsRequired="true" />
                                                    </ValidationSettings>
                                                </dx:ASPxComboBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="TdSol" style="width: 15%;">
                                                <dx:ASPxLabel runat="server" Text="Y.K.K. Tarihi : " Font-Size="Small" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <dx:ASPxDateEdit ID="DateEditDereceDegisikligiYKKTarihi" runat="server" Font-Size="Small" Width="200">
                                                </dx:ASPxDateEdit>
                                            </td>
                                            <td class="TdSol" style="width: 15%;">
                                                <dx:ASPxLabel runat="server" Text="Y.K.K. No : " Font-Size="Small" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <dx:ASPxTextBox ID="TextBoxDereceDegisikligiYKKNo" runat="server" Width="200px" Font-Size="Small" MaxLength="50">
                                                </dx:ASPxTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="4" class="TdOrtala">
                                                <div id="Div5" runat="server" style="float: left; margin-left: 40%;">
                                                    <dx:ASPxButton ID="ButtonDereceDegisikligiKaydet" runat="server" Text="Kaydet" ValidationGroup="DereceDegisikligiKayitGuncelle" Width="120" Font-Size="Small" OnClick="ButtonDereceDegisikligiKaydet_Click" />
                                                    <dx:ASPxButton ID="ButtonDereceDegisikligiTemizle" runat="server" Text="Temizle" Width="120" Font-Size="Small" OnClick="ButtonDereceDegisikligiTemizle_Click" />
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="TdOrtala" colspan="4">
                                                <dx:ASPxGridView ID="GridViewDereceDegisikligi" runat="server" KeyFieldName="DereceDegisiklikKey" AutoGenerateColumns="false" Width="100%" EnableCallBacks="true" Font-Size="Small" OnRowDeleting="GridViewDereceDegisikligi_RowDeleting">
                                                    <ClientSideEvents EndCallback="function(s, e) {
	                                                                        if (s.cpErrorMessage){
                                                                            delete s.cpErrorMessage;
		                                                                        alert('Silinmek istenen veri diğer kısımlarda kullanılmaktadır!');
                                                                                }
                                                                       }" />
                                                    <Settings ShowGroupPanel="false" />
                                                    <SettingsText ConfirmDelete="Silme işlemini onaylıyor musunuz?" />
                                                    <SettingsBehavior AllowDragDrop="false" AllowFocusedRow="false" ConfirmDelete="true" AllowGroup="false" AllowSort="false" />
                                                    <SettingsPager Visible="true" PageSize="15" AlwaysShowPager="true" Position="Bottom" ShowEmptyDataRows="true" />
                                                    <Paddings Padding="0px" />
                                                    <Border BorderWidth="0px" />
                                                    <BorderBottom BorderWidth="1px" />
                                                    <Columns>
                                                        <dx:GridViewDataColumn FieldName="DereceAdi" Caption="Derece">
                                                            <CellStyle HorizontalAlign="Center" />
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                        </dx:GridViewDataColumn>
                                                        <dx:GridViewDataColumn FieldName="DereceVerilisYil" Caption="Yıl">
                                                            <CellStyle HorizontalAlign="Center" />
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                        </dx:GridViewDataColumn>
                                                        <dx:GridViewDataColumn FieldName="YKKTarih" Caption="Y.K.K. Tarihi">
                                                            <CellStyle HorizontalAlign="Center" />
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                        </dx:GridViewDataColumn>
                                                        <dx:GridViewDataColumn FieldName="YKKNo" Caption="Y.K.K. No">
                                                            <CellStyle HorizontalAlign="Center" />
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                        </dx:GridViewDataColumn>
                                                        <dx:GridViewCommandColumn Caption="İşlemler" ButtonType="Image">
                                                            <DeleteButton Visible="true" Image-ToolTip="Sil" Image-Url="~/Content/Images/Icons/delete.png" Image-Width="24" Image-Height="24">
                                                                <Image ToolTip="Sil" Height="24px" Width="24px" Url="~/Content/Images/Icons/delete.png"></Image>
                                                            </DeleteButton>
                                                            <CellStyle HorizontalAlign="Center" />
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                        </dx:GridViewCommandColumn>
                                                    </Columns>
                                                </dx:ASPxGridView>
                                            </td>
                                        </tr>
                                    </table>
                                </dx:ContentControl>
                            </ContentCollection>
                        </dx:TabPage>
                        <dx:TabPage Text="Unvan Değişikliği" ClientVisible="False" ClientEnabled="True">
                            <ContentCollection>
                                <dx:ContentControl ID="ContentControl10" runat="server">
                                    <table style="border-color: #999999; width: 100%;" border="1">
                                        <tr>
                                            <td class="TdSolZorunlu" style="width: 15%;" rowspan="3">
                                                <dx:ASPxLabel runat="server" Text="Unvan : " Font-Size="Small" ForeColor="Red" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;" rowspan="3">
                                                <dx:ASPxMemo ID="MemoUnvanDegisikligiUnvan" runat="server" Width="300px" Font-Size="Small" MaxLength="2500" Rows="3">
                                                    <ValidationSettings ValidationGroup="UnvanDegisikligiKayitGuncelle" Display="Dynamic">
                                                        <RequiredField ErrorText=" " IsRequired="true" />
                                                    </ValidationSettings>
                                                </dx:ASPxMemo>
                                            </td>
                                            <td class="TdSolZorunlu" style="width: 15%;">
                                                <dx:ASPxLabel runat="server" Text="Yıl : " Font-Size="Small" ForeColor="Red" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <dx:ASPxComboBox ID="ComboBoxUnvanDegisikligiYil" runat="server" ValueType="System.String" Width="200px" Font-Size="Small">
                                                    <ValidationSettings ValidationGroup="UnvanDegisikligiKayitGuncelle" Display="Dynamic">
                                                        <RequiredField ErrorText=" " IsRequired="true" />
                                                    </ValidationSettings>
                                                </dx:ASPxComboBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="TdSol" style="width: 15%;">
                                                <dx:ASPxLabel runat="server" Text="Y.K.K. Tarihi : " Font-Size="Small" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <dx:ASPxDateEdit ID="DateEditUnvanDegisikligiYKKTarih" runat="server" Font-Size="Small" Width="200">
                                                </dx:ASPxDateEdit>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="TdSol" style="width: 15%;">
                                                <dx:ASPxLabel runat="server" Text="Y.K.K. No : " Font-Size="Small" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <dx:ASPxTextBox ID="TextBoxUnvanDegisikligiYKKNo" runat="server" Width="200px" Font-Size="Small" MaxLength="50">
                                                </dx:ASPxTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="4" class="TdOrtala">
                                                <div style="float: left; margin-left: 40%;">
                                                    <dx:ASPxButton ID="ButtonUnvanDegisikligiKaydet" runat="server" Text="Kaydet" ValidationGroup="UnvanDegisikligiKayitGuncelle" Width="120" Font-Size="Small" OnClick="ButtonUnvanDegisikligiKaydet_Click" />
                                                    <dx:ASPxButton ID="ButtonUnvanDegisikligiTemizle" runat="server" Text="Temizle" Width="120" Font-Size="Small" OnClick="ButtonUnvanDegisikligiTemizle_Click" />
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="TdOrtala" colspan="4">
                                                <dx:ASPxGridView ID="GridViewUnvanDegisikligi" runat="server" KeyFieldName="UnvanDegisiklikKey" AutoGenerateColumns="false" Width="100%" EnableCallBacks="true" Font-Size="Small" OnRowDeleting="GridViewUnvanDegisikligi_RowDeleting">
                                                    <ClientSideEvents EndCallback="function(s, e) {
	                                                                        if (s.cpErrorMessage){
                                                                            delete s.cpErrorMessage;
		                                                                        alert('Silinmek istenen veri diğer kısımlarda kullanılmaktadır!');
                                                                                }
                                                                       }" />
                                                    <Settings ShowGroupPanel="false" />
                                                    <SettingsText ConfirmDelete="Silme işlemini onaylıyor musunuz?" />
                                                    <SettingsBehavior AllowDragDrop="false" AllowFocusedRow="false" ConfirmDelete="true" AllowGroup="false" AllowSort="false" />
                                                    <SettingsPager Visible="true" PageSize="15" AlwaysShowPager="true" Position="Bottom" ShowEmptyDataRows="true" />
                                                    <Paddings Padding="0px" />
                                                    <Border BorderWidth="0px" />
                                                    <BorderBottom BorderWidth="1px" />
                                                    <Columns>
                                                        <dx:GridViewDataColumn FieldName="Unvan" Caption="Unvan">
                                                            <CellStyle HorizontalAlign="Center" />
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                        </dx:GridViewDataColumn>
                                                        <dx:GridViewDataColumn FieldName="Yil" Caption="Yıl">
                                                            <CellStyle HorizontalAlign="Center" />
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                        </dx:GridViewDataColumn>
                                                        <dx:GridViewDataColumn FieldName="UnvanDegisiklikTarih" Caption="Y.K.K. Tarihi">
                                                            <CellStyle HorizontalAlign="Center" />
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                        </dx:GridViewDataColumn>
                                                        <dx:GridViewDataColumn FieldName="YKKNo" Caption="Y.K.K. No">
                                                            <CellStyle HorizontalAlign="Center" />
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                        </dx:GridViewDataColumn>
                                                        <dx:GridViewCommandColumn Caption="İşlemler" ButtonType="Image">
                                                            <DeleteButton Visible="true" Image-ToolTip="Sil" Image-Url="~/Content/Images/Icons/delete.png" Image-Width="24" Image-Height="24">
                                                                <Image ToolTip="Sil" Height="24px" Width="24px" Url="~/Content/Images/Icons/delete.png"></Image>
                                                            </DeleteButton>
                                                            <CellStyle HorizontalAlign="Center" />
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                        </dx:GridViewCommandColumn>
                                                    </Columns>
                                                </dx:ASPxGridView>
                                            </td>
                                        </tr>
                                    </table>
                                </dx:ContentControl>
                            </ContentCollection>
                        </dx:TabPage>
                        <dx:TabPage Text="Sermaye Değişikliği" ClientVisible="False" ClientEnabled="True">
                            <ContentCollection>
                                <dx:ContentControl ID="ContentControl11" runat="server">
                                    <table style="border-color: #999999; width: 100%;" border="1">
                                        <tr>
                                            <td class="TdSolZorunlu" style="width: 15%;">
                                                <dx:ASPxLabel runat="server" Text="Sermaye : " Font-Size="Small" ForeColor="Red" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <dx:ASPxSpinEdit ID="SpinEditSermayeDegisiklikSermaye" runat="server" DecimalPlaces="4" Width="200px" Font-Size="Small" MaxLength="14" NumberType="Float" AllowNull="true" MinValue="0" SpinButtons-ShowIncrementButtons="false">
                                                    <ValidationSettings ValidationGroup="SermayeDegisikligiKayitGuncelle" Display="Dynamic">
                                                        <RequiredField ErrorText=" " IsRequired="true" />
                                                    </ValidationSettings>
                                                    <SpinButtons ShowIncrementButtons="False"></SpinButtons>
                                                </dx:ASPxSpinEdit>
                                            </td>
                                            <td class="TdSolZorunlu" style="width: 15%;">
                                                <dx:ASPxLabel runat="server" Text="Yıl : " Font-Size="Small" ForeColor="Red" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <dx:ASPxComboBox ID="ComboBoxSermayeDegisiklikSermayeYil" runat="server" ValueType="System.String" Width="200px" Font-Size="Small">
                                                    <ValidationSettings ValidationGroup="SermayeDegisikligiKayitGuncelle" Display="Dynamic">
                                                        <RequiredField ErrorText=" " IsRequired="true" />
                                                    </ValidationSettings>
                                                </dx:ASPxComboBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="TdSol" style="width: 15%;">
                                                <dx:ASPxLabel runat="server" Text="Y.K.K. Tarihi : " Font-Size="Small" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <dx:ASPxDateEdit ID="DateEditSermayeDegisiklikYKKTarihi" runat="server" Font-Size="Small" Width="200">
                                                </dx:ASPxDateEdit>
                                            </td>
                                            <td class="TdSol" style="width: 15%;">
                                                <dx:ASPxLabel runat="server" Text="Y.K.K. No : " Font-Size="Small" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <dx:ASPxTextBox ID="TextBoxSermayeDegisiklikYKKNo" runat="server" Width="200px" Font-Size="Small" MaxLength="50">
                                                </dx:ASPxTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="4" class="TdOrtala">
                                                <div style="float: left; margin-left: 40%;">
                                                    <dx:ASPxButton ID="ButtonSermayeDegisikligiKaydet" runat="server" Text="Kaydet" ValidationGroup="SermayeDegisikligiKayitGuncelle" Width="120" Font-Size="Small" OnClick="ButtonSermayeDegisikligiKaydet_Click" />
                                                    <dx:ASPxButton ID="ButtonSermayeDegisikligiTemizle" runat="server" Text="Temizle" Width="120" Font-Size="Small" OnClick="ButtonSermayeDegisikligiTemizle_Click" />
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="TdOrtala" colspan="4">
                                                <dx:ASPxGridView ID="GridViewSermayeDegisikligi" runat="server" KeyFieldName="SermayeDegisiklikKey" AutoGenerateColumns="false" Width="100%" EnableCallBacks="true" Font-Size="Small" OnRowDeleting="GridViewSermayeDegisikligi_RowDeleting">
                                                    <ClientSideEvents EndCallback="function(s, e) {
	                                                                        if (s.cpErrorMessage){
                                                                            delete s.cpErrorMessage;
		                                                                        alert('Silinmek istenen veri diğer kısımlarda kullanılmaktadır!');
                                                                                }
                                                                       }" />
                                                    <Settings ShowGroupPanel="false" />
                                                    <SettingsText ConfirmDelete="Silme işlemini onaylıyor musunuz?" />
                                                    <SettingsBehavior AllowDragDrop="false" AllowFocusedRow="false" ConfirmDelete="true" AllowGroup="false" AllowSort="false" />
                                                    <SettingsPager Visible="true" PageSize="15" AlwaysShowPager="true" Position="Bottom" ShowEmptyDataRows="true" />
                                                    <Paddings Padding="0px" />
                                                    <Border BorderWidth="0px" />
                                                    <BorderBottom BorderWidth="1px" />
                                                    <Columns>
                                                        <dx:GridViewDataColumn FieldName="Sermaye" Caption="Sermaye">
                                                            <CellStyle HorizontalAlign="Center" />
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                        </dx:GridViewDataColumn>
                                                        <dx:GridViewDataColumn FieldName="Yil" Caption="Yıl">
                                                            <CellStyle HorizontalAlign="Center" />
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                        </dx:GridViewDataColumn>
                                                        <dx:GridViewDataColumn FieldName="SermayeDegisiklikTarih" Caption="Y.K.K. Tarihi">
                                                            <CellStyle HorizontalAlign="Center" />
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                        </dx:GridViewDataColumn>
                                                        <dx:GridViewDataColumn FieldName="YKKNo" Caption="Y.K.K. No">
                                                            <CellStyle HorizontalAlign="Center" />
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                        </dx:GridViewDataColumn>
                                                        <dx:GridViewCommandColumn Caption="İşlemler" ButtonType="Image">
                                                            <DeleteButton Visible="true" Image-ToolTip="Sil" Image-Url="~/Content/Images/Icons/delete.png" Image-Width="24" Image-Height="24">
                                                                <Image ToolTip="Sil" Height="24px" Width="24px" Url="~/Content/Images/Icons/delete.png"></Image>
                                                            </DeleteButton>
                                                            <CellStyle HorizontalAlign="Center" />
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                        </dx:GridViewCommandColumn>
                                                    </Columns>
                                                </dx:ASPxGridView>
                                            </td>
                                        </tr>
                                    </table>
                                </dx:ContentControl>
                            </ContentCollection>
                        </dx:TabPage>
                        <dx:TabPage Text="Meslek Grubu Değişikliği" ClientVisible="False" ClientEnabled="True">
                            <ContentCollection>
                                <dx:ContentControl ID="ContentControl12" runat="server">
                                    <table style="border-color: #999999; width: 100%;" border="1">
                                        <tr>
                                            <td class="TdSolZorunlu" style="width: 15%;">
                                                <dx:ASPxLabel runat="server" Text="Meslek Grubu : " Font-Size="Small" ForeColor="Red" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <dx:ASPxComboBox ID="ComboBoxMeslekGrubuDegisiklikMeslekGrubu" runat="server" ValueType="System.String" Width="200px" Font-Size="Small" TextField="MeslekAdi" ValueField="MeslekGrupKey">
                                                    <ValidationSettings ValidationGroup="MeslekGrubuDegisikligiKayitGuncelle" Display="Dynamic">
                                                        <RequiredField ErrorText=" " IsRequired="true" />
                                                    </ValidationSettings>
                                                </dx:ASPxComboBox>
                                            </td>
                                            <td class="TdSolZorunlu" style="width: 15%;">
                                                <dx:ASPxLabel runat="server" Text="Yıl : " Font-Size="Small" ForeColor="Red" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <dx:ASPxComboBox ID="ComboBoxMeslekGrubuDegisiklikMeslekGrubuYil" runat="server" ValueType="System.String" Width="200px" Font-Size="Small">
                                                    <ValidationSettings ValidationGroup="MeslekGrubuDegisikligiKayitGuncelle" Display="Dynamic">
                                                        <RequiredField ErrorText=" " IsRequired="true" />
                                                    </ValidationSettings>
                                                </dx:ASPxComboBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="TdSol" style="width: 15%;">
                                                <dx:ASPxLabel runat="server" Text="Y.K.K. Tarihi : " Font-Size="Small" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <dx:ASPxDateEdit ID="DateEditMeslekGrubuDegisiklikYKKTarihi" runat="server" Font-Size="Small" Width="200">
                                                </dx:ASPxDateEdit>
                                            </td>
                                            <td class="TdSol" style="width: 15%;">
                                                <dx:ASPxLabel runat="server" Text="Y.K.K. No : " Font-Size="Small" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <dx:ASPxTextBox ID="TextBoxMeslekGrubuDegisiklikYKKNo" runat="server" Width="200px" Font-Size="Small" MaxLength="50">
                                                </dx:ASPxTextBox>
                                            </td>
                                            <td class="TdOrtala" colspan="2"></td>
                                        </tr>
                                        <tr>
                                            <td colspan="4" class="TdOrtala">
                                                <div style="float: left; margin-left: 40%;">
                                                    <dx:ASPxButton ID="ButtonMeslekGrubuDegisikligiKaydet" runat="server" Text="Kaydet" ValidationGroup="MeslekGrubuDegisikligiKayitGuncelle" Width="120" Font-Size="Small" OnClick="ButtonMeslekGrubuDegisikligiKaydet_Click" />
                                                    <dx:ASPxButton ID="ButtonMeslekGrubuDegisikligiTemizle" runat="server" Text="Temizle" Width="120" Font-Size="Small" OnClick="ButtonMeslekGrubuDegisikligiTemizle_Click" />
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="TdOrtala" colspan="4">
                                                <dx:ASPxGridView ID="GridViewMeslekGrubuDegisikligi" runat="server" KeyFieldName="MeslekGrupDegisiklikKey" AutoGenerateColumns="false" Width="100%" EnableCallBacks="true" Font-Size="Small" OnRowDeleting="GridViewMeslekGrubuDegisikligi_RowDeleting">
                                                    <ClientSideEvents EndCallback="function(s, e) {
	                                                                        if (s.cpErrorMessage){
                                                                            delete s.cpErrorMessage;
		                                                                        alert('Silinmek istenen veri diğer kısımlarda kullanılmaktadır!');
                                                                                }
                                                                       }" />
                                                    <Settings ShowGroupPanel="false" />
                                                    <SettingsText ConfirmDelete="Silme işlemini onaylıyor musunuz?" />
                                                    <SettingsBehavior AllowDragDrop="false" AllowFocusedRow="false" ConfirmDelete="true" AllowGroup="false" AllowSort="false" />
                                                    <SettingsPager Visible="true" PageSize="15" AlwaysShowPager="true" Position="Bottom" ShowEmptyDataRows="true" />
                                                    <Paddings Padding="0px" />
                                                    <Border BorderWidth="0px" />
                                                    <BorderBottom BorderWidth="1px" />
                                                    <Columns>
                                                        <dx:GridViewDataColumn FieldName="MeslekGrubu" Caption="Meslek Grubu">
                                                            <CellStyle HorizontalAlign="Center" />
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                        </dx:GridViewDataColumn>
                                                        <dx:GridViewDataColumn FieldName="Yil" Caption="Yıl">
                                                            <CellStyle HorizontalAlign="Center" />
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                        </dx:GridViewDataColumn>
                                                        <dx:GridViewDataColumn FieldName="MeslekGrupDegisiklikTarih" Caption="Y.K.K. Tarihi">
                                                            <CellStyle HorizontalAlign="Center" />
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                        </dx:GridViewDataColumn>
                                                        <dx:GridViewDataColumn FieldName="YKKNo" Caption="Y.K.K. No">
                                                            <CellStyle HorizontalAlign="Center" />
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                        </dx:GridViewDataColumn>
                                                        <dx:GridViewCommandColumn Caption="İşlemler" ButtonType="Image">
                                                            <DeleteButton Visible="true" Image-ToolTip="Sil" Image-Url="~/Content/Images/Icons/delete.png" Image-Width="24" Image-Height="24">
                                                                <Image ToolTip="Sil" Height="24px" Width="24px" Url="~/Content/Images/Icons/delete.png"></Image>
                                                            </DeleteButton>
                                                            <CellStyle HorizontalAlign="Center" />
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                        </dx:GridViewCommandColumn>
                                                    </Columns>
                                                </dx:ASPxGridView>
                                            </td>
                                        </tr>
                                    </table>
                                </dx:ContentControl>
                            </ContentCollection>
                        </dx:TabPage>
                        <dx:TabPage Text="Kayıtlı Oda Listesi" ClientVisible="False" ClientEnabled="True">
                            <ContentCollection>
                                <dx:ContentControl ID="ContentControl13" runat="server">
                                    <table style="border-color: #999999; width: 100%;" border="1">
                                        <tr>
                                            <td class="TdSolZorunlu" style="width: 15%;">
                                                <dx:ASPxLabel runat="server" Text="Oda Borsa Adı : " Font-Size="Small" ForeColor="Red" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <dx:ASPxTextBox ID="TextBoxOdaBorsaAdi" runat="server" Width="200px" Font-Size="Small" MaxLength="50">
                                                    <ValidationSettings ValidationGroup="KayitliOdaListesiKayitGuncelle" Display="Dynamic">
                                                        <RequiredField ErrorText=" " IsRequired="true" />
                                                    </ValidationSettings>
                                                </dx:ASPxTextBox>
                                            </td>
                                            <td class="TdSol" style="width: 15%;">
                                                <dx:ASPxLabel runat="server" Text="Kayıt Tarihi : " Font-Size="Small" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <dx:ASPxDateEdit ID="DateEditOdaBorsaKayitTarihi" runat="server" Font-Size="Small" Width="200">
                                                </dx:ASPxDateEdit>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="TdSol" style="width: 15%;" rowspan="2">
                                                <dx:ASPxLabel runat="server" Text="Açıklama : " Font-Size="Small" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;" rowspan="2">
                                                <dx:ASPxMemo ID="MemoOdaBorsaAciklama" runat="server" Width="200px" Font-Size="Small" MaxLength="500" Rows="2">
                                                </dx:ASPxMemo>
                                            </td>
                                            <td class="TdSol" style="width: 15%;">
                                                <dx:ASPxLabel runat="server" Text="Oda Borsa Sicil No : " Font-Size="Small" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <dx:ASPxTextBox ID="TextBoxOdaBorsaSicilNo" runat="server" Width="200px" Font-Size="Small" MaxLength="20">
                                                </dx:ASPxTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">&nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="4" class="TdOrtala">
                                                <div style="float: left; margin-left: 40%;">
                                                    <dx:ASPxButton ID="ButtonKayitliOdaListesiKaydet" runat="server" Text="Kaydet" ValidationGroup="KayitliOdaListesiKayitGuncelle" Width="120" Font-Size="Small" Visible="false" OnClick="ButtonKayitliOdaListesiKaydetGuncelle_Click" />
                                                    <dx:ASPxButton ID="ButtonKayitliOdaListesiGuncelle" runat="server" Text="Güncelle" ValidationGroup="KayitliOdaListesiKayitGuncelle" Width="120" Font-Size="Small" Visible="false" OnClick="ButtonKayitliOdaListesiKaydetGuncelle_Click" />
                                                    <dx:ASPxButton ID="ButtonKayitliOdaListesiTemizle" runat="server" Text="Temizle" Width="120" Font-Size="Small" OnClick="ButtonKayitliOdaListesiIptalTemizle_Click" />
                                                    <dx:ASPxButton ID="ButtonKayitliOdaListesiIptal" runat="server" Text="İptal" Width="120" Font-Size="Small" OnClick="ButtonKayitliOdaListesiIptalTemizle_Click" />
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="TdOrtala" colspan="4">
                                                <dx:ASPxGridView ID="GridViewKayitliOdaListesi" runat="server" KeyFieldName="FirmaKayitliOdaKey" AutoGenerateColumns="false" Width="100%" EnableCallBacks="true" Font-Size="Small" OnRowDeleting="GridViewKayitliOdaListesi_RowDeleting" OnCustomButtonCallback="GridViewKayitliOdaListesi_CustomButtonCallback">
                                                    <ClientSideEvents EndCallback="function(s, e) {
	                                                                        if (s.cpErrorMessage){
                                                                            delete s.cpErrorMessage;
		                                                                        alert('Silinmek istenen veri diğer kısımlarda kullanılmaktadır!');
                                                                                }
                                                                       }" />
                                                    <Settings ShowGroupPanel="false" />
                                                    <SettingsText ConfirmDelete="Silme işlemini onaylıyor musunuz?" />
                                                    <SettingsBehavior AllowDragDrop="false" AllowFocusedRow="false" ConfirmDelete="true" AllowGroup="false" AllowSort="false" />
                                                    <SettingsPager Visible="true" PageSize="15" AlwaysShowPager="true" Position="Bottom" ShowEmptyDataRows="true" />
                                                    <Paddings Padding="0px" />
                                                    <Border BorderWidth="0px" />
                                                    <BorderBottom BorderWidth="1px" />
                                                    <Columns>
                                                        <dx:GridViewDataColumn FieldName="OdaBorsaAdi" Caption="Oda Borsa Adı">
                                                            <CellStyle HorizontalAlign="Center" />
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                        </dx:GridViewDataColumn>
                                                        <dx:GridViewDataColumn FieldName="OdaBorsaKayitTarihi" Caption="Kayıt Tarihi">
                                                            <CellStyle HorizontalAlign="Center" />
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                        </dx:GridViewDataColumn>
                                                        <dx:GridViewDataColumn FieldName="OdaBorsaSicilNo" Caption="Oda Borsa Sicil No">
                                                            <CellStyle HorizontalAlign="Center" />
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                        </dx:GridViewDataColumn>
                                                        <dx:GridViewDataColumn FieldName="Aciklama" Caption="Açıklama">
                                                            <CellStyle HorizontalAlign="Center" />
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                        </dx:GridViewDataColumn>
                                                        <dx:GridViewCommandColumn Caption="İşlemler" ButtonType="Image">
                                                            <CustomButtons>
                                                                <dx:GridViewCommandColumnCustomButton Visibility="AllDataRows" Image-ToolTip="Düzenle" Image-Url="~/Content/Images/Icons/edit.png" Image-Width="24" Image-Height="24">
                                                                    <Image ToolTip="D&#252;zenle" Height="24px" Width="24px" Url="~/Content/Images/Icons/edit.png"></Image>
                                                                </dx:GridViewCommandColumnCustomButton>
                                                            </CustomButtons>
                                                            <DeleteButton Visible="true" Image-ToolTip="Sil" Image-Url="~/Content/Images/Icons/delete.png" Image-Width="24" Image-Height="24">
                                                                <Image ToolTip="Sil" Height="24px" Width="24px" Url="~/Content/Images/Icons/delete.png"></Image>
                                                            </DeleteButton>
                                                            <CellStyle HorizontalAlign="Center" />
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                        </dx:GridViewCommandColumn>
                                                    </Columns>
                                                </dx:ASPxGridView>
                                            </td>
                                        </tr>
                                    </table>
                                </dx:ContentControl>
                            </ContentCollection>
                        </dx:TabPage>
                        <dx:TabPage Text="Diğer Faaliyet Kodları" ClientVisible="False" ClientEnabled="True">
                            <ContentCollection>
                                <dx:ContentControl ID="ContentControl14" runat="server">
                                    <table style="border-color: #999999; width: 100%;" border="1">
                                        <tr>
                                            <td class="TdSolZorunlu" style="width: 15%;">
                                                <dx:ASPxLabel runat="server" Text="Nace Kodu : " Font-Size="Small" ForeColor="Red" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <dx:ASPxTextBox ID="TextBoxDigerFaaliyetKodlariNaceKodu1" runat="server" Width="50px" Font-Size="Small" MaxLength="20">
                                                                <ValidationSettings ValidationGroup="DigerFaaliyetKodlariKayitGuncelle" Display="Dynamic">
                                                                    <RequiredField ErrorText=" " IsRequired="true" />
                                                                </ValidationSettings>
                                                            </dx:ASPxTextBox>
                                                        </td>
                                                        <td>&nbsp;
                                                        </td>
                                                        <td>
                                                            <dx:ASPxTextBox ID="TextBoxDigerFaaliyetKodlariNaceKodu2" runat="server" Width="150px" Font-Size="Small" MaxLength="50">
                                                                <ValidationSettings ValidationGroup="DigerFaaliyetKodlariKayitGuncelle" Display="Dynamic">
                                                                    <RequiredField ErrorText=" " IsRequired="true" />
                                                                </ValidationSettings>
                                                            </dx:ASPxTextBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td class="TdSol" style="width: 15%;">
                                                <dx:ASPxLabel runat="server" Text="Başlangıç Tarihi : " Font-Size="Small" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <dx:ASPxDateEdit ID="DateEditDigerFaaliyetKodlariBaslangicTarihi" runat="server" Font-Size="Small" Width="200">
                                                </dx:ASPxDateEdit>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="TdSol" style="width: 15%;" rowspan="2">
                                                <dx:ASPxLabel runat="server" Text="Açıklama : " Font-Size="Small" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;" rowspan="2">
                                                <dx:ASPxMemo ID="MemoDigerFaaliyetKodlariAciklama" runat="server" Width="200px" Font-Size="Small" MaxLength="500" Rows="2">
                                                </dx:ASPxMemo>
                                            </td>
                                            <td colspan="2">&nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">&nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="4" class="TdOrtala">
                                                <div style="float: left; margin-left: 40%;">
                                                    <dx:ASPxButton ID="ButtonDigerFaaliyetKodlariKaydet" runat="server" Text="Kaydet" ValidationGroup="DigerFaaliyetKodlariKayitGuncelle" Width="120" Font-Size="Small" Visible="false" OnClick="ButtonDigerFaaliyetKodlariKaydetGuncelle_Click" />
                                                    <dx:ASPxButton ID="ButtonDigerFaaliyetKodlariGuncelle" runat="server" Text="Güncelle" ValidationGroup="DigerFaaliyetKodlariKayitGuncelle" Width="120" Font-Size="Small" Visible="false" OnClick="ButtonDigerFaaliyetKodlariKaydetGuncelle_Click" />
                                                    <dx:ASPxButton ID="ButtonDigerFaaliyetKodlariTemizle" runat="server" Text="Temizle" Width="120" Font-Size="Small" OnClick="ButtonDigerFaaliyetKodlariIptalTemizle_Click" />
                                                    <dx:ASPxButton ID="ButtonDigerFaaliyetKodlariIptal" runat="server" Text="İptal" Width="120" Font-Size="Small" OnClick="ButtonDigerFaaliyetKodlariIptalTemizle_Click" />
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="TdOrtala" colspan="4">
                                                <dx:ASPxGridView ID="GridViewDigerFaaliyetKodlari" runat="server" KeyFieldName="FirmaDigerFaaliyetKodKey" AutoGenerateColumns="false" Width="100%" EnableCallBacks="true" Font-Size="Small" OnRowDeleting="GridViewDigerFaaliyetKodlari_RowDeleting" OnCustomButtonCallback="GridViewDigerFaaliyetKodlari_CustomButtonCallback">
                                                    <ClientSideEvents EndCallback="function(s, e) {
	                                                                        if (s.cpErrorMessage){
                                                                            delete s.cpErrorMessage;
		                                                                        alert('Silinmek istenen veri diğer kısımlarda kullanılmaktadır!');
                                                                                }
                                                                       }" />
                                                    <Settings ShowGroupPanel="false" />
                                                    <SettingsText ConfirmDelete="Silme işlemini onaylıyor musunuz?" />
                                                    <SettingsBehavior AllowDragDrop="false" AllowFocusedRow="false" ConfirmDelete="true" AllowGroup="false" AllowSort="false" />
                                                    <SettingsPager Visible="true" PageSize="15" AlwaysShowPager="true" Position="Bottom" ShowEmptyDataRows="true" />
                                                    <Paddings Padding="0px" />
                                                    <Border BorderWidth="0px" />
                                                    <BorderBottom BorderWidth="1px" />
                                                    <Columns>
                                                        <dx:GridViewDataColumn FieldName="NaceKodu" Caption="Nace Kodu">
                                                            <CellStyle HorizontalAlign="Center" />
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                        </dx:GridViewDataColumn>
                                                        <dx:GridViewDataColumn FieldName="BaslangicTarihi" Caption="Başlangıç Tarihi">
                                                            <CellStyle HorizontalAlign="Center" />
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                        </dx:GridViewDataColumn>
                                                        <dx:GridViewDataColumn FieldName="Aciklama" Caption="Açıklama">
                                                            <CellStyle HorizontalAlign="Center" />
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                        </dx:GridViewDataColumn>
                                                        <dx:GridViewCommandColumn Caption="İşlemler" ButtonType="Image">
                                                            <CustomButtons>
                                                                <dx:GridViewCommandColumnCustomButton Visibility="AllDataRows" Image-ToolTip="Düzenle" Image-Url="~/Content/Images/Icons/edit.png" Image-Width="24" Image-Height="24">
                                                                    <Image ToolTip="D&#252;zenle" Height="24px" Width="24px" Url="~/Content/Images/Icons/edit.png"></Image>
                                                                </dx:GridViewCommandColumnCustomButton>
                                                            </CustomButtons>
                                                            <DeleteButton Visible="true" Image-ToolTip="Sil" Image-Url="~/Content/Images/Icons/delete.png" Image-Width="24" Image-Height="24">
                                                                <Image ToolTip="Sil" Height="24px" Width="24px" Url="~/Content/Images/Icons/delete.png"></Image>
                                                            </DeleteButton>
                                                            <CellStyle HorizontalAlign="Center" />
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                        </dx:GridViewCommandColumn>
                                                    </Columns>
                                                </dx:ASPxGridView>
                                            </td>
                                        </tr>
                                    </table>
                                </dx:ContentControl>
                            </ContentCollection>
                        </dx:TabPage>
                    </TabPages>
                </dx:ASPxPageControl>
            </td>
        </tr>
    </table>
</div>

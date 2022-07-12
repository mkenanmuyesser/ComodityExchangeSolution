<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="TuccarSicilBilgiAramaUserControl.ascx.cs" Inherits="TicaretBorsasi_Project.User_Control.Ortak.TuccarSicilBilgiAramaUserControl" %>

<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxTabControl" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxClasses" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridView.Export" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>
<%@ Register TagPrefix="dx" Namespace="DevExpress.Web.ASPxPopupControl" Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>

<script type="text/javascript">
    // <![CDATA[
    function ShowWindow() {
        PopupControlTuccarBilgiDetay.Show();
    }
    // ]]> 
</script>
<div style="margin: 1px; width: 99.9%;">
    <dx:ASPxPopupControl ID="PopupControlTuccarBilgiDetay" runat="server" CloseAction="CloseButton" Modal="True"
        PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ClientInstanceName="PopupControlTuccarBilgiDetay" AllowDragging="False" PopupAnimationType="None" EnableViewState="False">
        <ClientSideEvents PopUp="function(s, e) { }" />
        <ContentCollection>
            <dx:PopupControlContentControl ID="PopupControlContentControl1" runat="server">
                test
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>
    <table style="border-color: #999999; width: 99.9%;" border="1">
        <tr>
            <td class="TdOrtala" colspan="4">
                <div style="margin-left: 40%; padding: 2px;">
                    <dx:ASPxLabel ID="LabelBaslik" runat="server" Font-Size="Large" />
                </div>
            </td>
        </tr>
        <tr>
            <td class="TdOrtala" colspan="4">
                <dx:ASPxPageControl runat="server" ActiveTabIndex="0" AutoPostBack="false" EnableCallBacks="true" ShowLoadingPanel="true" Width="99.9%" Font-Size="Small" EnableCallbackAnimation="True" LoadingPanelText="Yükleniyor&hellip;">
                    <TabPages>
                        <dx:TabPage Text="Arama">
                            <ContentCollection>
                                <dx:ContentControl ID="ContentControl3" runat="server">
                                    <table style="border-color: #999999; width: 99.9%;" border="1">
                                        <tr>
                                            <td class="TdSol" style="width: 15%">
                                                <dx:ASPxLabel runat="server" Text="Sicil No : " Font-Size="Small" />
                                            </td>
                                            <td class="TdSag">
                                                <table style="width: 400px;">
                                                    <tr>
                                                        <td>
                                                            <dx:ASPxSpinEdit ID="SpinEditSicilNoBaslangic" runat="server" DecimalPlaces="2" Width="200px" Font-Size="Small" MaxLength="6" NumberType="Integer" AllowNull="true" MinValue="0" SpinButtons-ShowIncrementButtons="false">
                                                            </dx:ASPxSpinEdit>
                                                        </td>
                                                        <td style="padding-left: 5px;">
                                                            <dx:ASPxSpinEdit ID="SpinEditSicilNoBitis" runat="server" DecimalPlaces="2" Width="200px" Font-Size="Small" MaxLength="6" NumberType="Integer" AllowNull="true" MinValue="0" SpinButtons-ShowIncrementButtons="false">
                                                            </dx:ASPxSpinEdit>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td class="TdSol" style="width: 15%">
                                                <dx:ASPxLabel runat="server" Text="Unvan : " Font-Size="Small" />
                                            </td>
                                            <td class="TdSag">
                                                <dx:ASPxTextBox ID="TextBoxUnvan" runat="server" Width="200px" Font-Size="Small" MaxLength="100">
                                                </dx:ASPxTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="TdSol" style="width: 15%">
                                                <dx:ASPxLabel runat="server" Text="Vergi No : " Font-Size="Small" />
                                            </td>
                                            <td class="TdSag">
                                                <dx:ASPxTextBox ID="TextBoxVergiNo" runat="server" Width="200px" Font-Size="Small" MaxLength="50">
                                                </dx:ASPxTextBox>
                                            </td>
                                            <td class="TdSol" style="width: 15%">
                                                <dx:ASPxLabel runat="server" Text="Vergi Dairesi : " Font-Size="Small" />
                                            </td>
                                            <td class="TdSag">
                                                <dx:ASPxComboBox ID="ComboBoxVergiDairesi" runat="server" ValueType="System.String" Width="200px" Font-Size="Small" TextField="VergiDairesiAdi" ValueField="VergiDaireKey">
                                                </dx:ASPxComboBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="TdSol" style="width: 15%">
                                                <dx:ASPxLabel runat="server" Text="Terkin Durumu : " Font-Size="Small" />
                                            </td>
                                            <td class="TdSag">
                                                <dx:ASPxRadioButtonList ID="RadioButtonListTerkinSecim" runat="server" ValueType="System.String" RepeatDirection="Horizontal" Font-Size="Small" Width="100%" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonListTerkinSecim_SelectedIndexChanged">
                                                    <Items>
                                                        <dx:ListEditItem Selected="true" Text="Tümü" Value="1" />
                                                        <dx:ListEditItem Text="Aktif Üyeler" Value="2" />
                                                        <dx:ListEditItem Text="Kaydı Kapanan Üyeler" Value="3" />
                                                    </Items>
                                                </dx:ASPxRadioButtonList>
                                            </td>
                                            <td class="TdSol" style="width: 15%">
                                                <dx:ASPxLabel runat="server" Text="Terkin Tarihi Başlangıç/Bitiş : " Font-Size="Small" />
                                            </td>
                                            <td class="TdSag">
                                                <table style="width: 400px;">
                                                    <tr>
                                                        <td>
                                                            <dx:ASPxDateEdit ID="DateEditTerkinBaslangic" runat="server" Font-Size="Small" Width="200" Enabled="false">
                                                            </dx:ASPxDateEdit>
                                                        </td>
                                                        <td style="padding-left: 5px;">
                                                            <dx:ASPxDateEdit ID="DateEditTerkinBitis" runat="server" Font-Size="Small" Width="200" Enabled="false">
                                                            </dx:ASPxDateEdit>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </dx:ContentControl>
                            </ContentCollection>
                        </dx:TabPage>
                        <dx:TabPage Text="Detaylı Arama">
                            <ContentCollection>
                                <dx:ContentControl ID="ContentControl1" runat="server">
                                    <table style="border-color: #999999; width: 99.9%;" border="1">
                                        <tr>
                                            <td class="TdSol" style="width: 15%">
                                                <dx:ASPxLabel runat="server" Text="Nace Kodu" Font-Size="Small" />
                                            </td>
                                            <td class="TdSag">
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <dx:ASPxTextBox ID="TextBoxNaceKodu1" runat="server" Width="50px" Font-Size="Small" MaxLength="20">
                                                            </dx:ASPxTextBox>
                                                        </td>
                                                        <td>&nbsp;
                                                        </td>
                                                        <td>
                                                            <dx:ASPxTextBox ID="TextBoxNaceKodu2" runat="server" Width="150px" Font-Size="Small" MaxLength="50">
                                                            </dx:ASPxTextBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td class="TdSol" style="width: 15%">
                                                <dx:ASPxLabel runat="server" Text="Meslek Grubu" Font-Size="Small" />
                                            </td>
                                            <td class="TdSag">
                                                <dx:ASPxComboBox ID="ComboBoxMeslekGrubu" runat="server" ValueType="System.String" Width="200px" Font-Size="Small" TextField="MeslekAdi" ValueField="MeslekGrupKey">
                                                </dx:ASPxComboBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="TdSol" style="width: 15%">
                                                <dx:ASPxLabel runat="server" Text="Adı : " Font-Size="Small" />
                                            </td>
                                            <td class="TdSag">
                                                <dx:ASPxTextBox ID="TextBoxAdi" runat="server" Width="200px" Font-Size="Small" MaxLength="50">
                                                </dx:ASPxTextBox>
                                            </td>
                                            <td class="TdSol" style="width: 15%">
                                                <dx:ASPxLabel runat="server" Text="Soyadı : " Font-Size="Small" />
                                            </td>
                                            <td class="TdSag">
                                                <dx:ASPxTextBox ID="TextBoxSoyadi" runat="server" Width="200px" Font-Size="Small" MaxLength="50">
                                                </dx:ASPxTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="TdSol" style="width: 15%">
                                                <dx:ASPxLabel runat="server" Text="Yetkili : " Font-Size="Small" />
                                            </td>
                                            <td class="TdSag">
                                                <dx:ASPxTextBox ID="TextBoxYetkili" runat="server" Width="200px" Font-Size="Small" MaxLength="100">
                                                </dx:ASPxTextBox>
                                            </td>
                                            <td class="TdSol" style="width: 15%">
                                                <dx:ASPxLabel runat="server" Text="Yönetim Kurulu : " Font-Size="Small" />
                                            </td>
                                            <td class="TdSag">
                                                <dx:ASPxTextBox ID="TextBoxYonetimKurulu" runat="server" Width="200px" Font-Size="Small" MaxLength="100">
                                                </dx:ASPxTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="TdSol" style="width: 15%;">
                                                <dx:ASPxLabel runat="server" Text="Bölge Adı : " Font-Size="Small" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <dx:ASPxTextBox ID="TextBoxBolgeAdi" runat="server" Width="200px" Font-Size="Small" MaxLength="50">
                                                </dx:ASPxTextBox>
                                            </td>

                                            <td class="TdSol" style="width: 15%;">
                                                <dx:ASPxLabel runat="server" Text="İl/İlçe : " Font-Size="Small" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <dx:ASPxComboBox ID="ComboBoxIlIlce" runat="server" ValueType="System.String" Width="200px" Font-Size="Small" TextField="IlIlceAdi" ValueField="IlIlceKey">
                                                </dx:ASPxComboBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="TdSol" style="width: 15%">
                                                <dx:ASPxLabel runat="server" Text="Kayıt Tarihi Başlangıç/Bitiş : " Font-Size="Small" />
                                            </td>
                                            <td class="TdSag">
                                                <table style="width: 400px;">
                                                    <tr>
                                                        <td>
                                                            <dx:ASPxDateEdit ID="DateEditKayitBaslangic" runat="server" Font-Size="Small" Width="200">
                                                            </dx:ASPxDateEdit>
                                                        </td>
                                                        <td style="padding-left: 5px;">
                                                            <dx:ASPxDateEdit ID="DateEditKayitBitis" runat="server" Font-Size="Small" Width="200">
                                                            </dx:ASPxDateEdit>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td class="TdSol" style="width: 15%;">
                                                <dx:ASPxLabel runat="server" Text="Merkez/Şube Tipi : " Font-Size="Small" />
                                            </td>
                                            <td class="TdSag" style="width: 35%;">
                                                <dx:ASPxComboBox ID="ComboBoxMerkezSubeMi" runat="server" ValueType="System.String" Width="200px" Font-Size="Small">
                                                </dx:ASPxComboBox>
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
        <tr>
            <td class="TdOrtala" colspan="4">
                <div style="float: left;">
                    <table>
                        <tr>
                            <td>
                                <dx:ASPxLabel runat="server" Text="Sırala : " Font-Size="Small" />
                            </td>
                            <td>
                                <dx:ASPxComboBox ID="ComboBoxSirala" runat="server" Font-Size="Small" Width="115">
                                    <Items>
                                        <dx:ListEditItem Selected="true" Text="Sicil No" Value="1" />
                                        <dx:ListEditItem Text="Unvan" Value="2" />
                                        <dx:ListEditItem Text="Meslek Grup" Value="3" />
                                        <dx:ListEditItem Text="Kuruluş Tür" Value="4" />
                                        <dx:ListEditItem Text="Vergi Daire" Value="5" />
                                        <dx:ListEditItem Text="Derece" Value="6" />
                                        <dx:ListEditItem Text="İl/İlçe" Value="7" />
                                    </Items>
                                </dx:ASPxComboBox>
                            </td>
                            <td>
                                <dx:ASPxComboBox ID="ComboBoxSiralaArtanAzalan" runat="server" Font-Size="Small" Width="70">
                                    <Items>
                                        <dx:ListEditItem Selected="true" Text="Artan" Value="1" />
                                        <dx:ListEditItem Text="Azalan" Value="2" />
                                    </Items>
                                </dx:ASPxComboBox>
                            </td>
                        </tr>
                    </table>
                </div>
                <div style="float: left; margin-left: 28%;">
                    <dx:ASPxButton ID="ButtonAra" runat="server" Text="Ara" Width="120" Font-Size="Small" OnClick="ButtonAra_Click" />
                    <dx:ASPxButton ID="ButtonTemizle" runat="server" Text="Temizle" Width="120" Font-Size="Small" OnClick="ButtonTemizle_Click" />
                </div>
                <div style="float: right;" id="raporDiv" runat="server">
                    <table>
                        <tr>
                            <td>
                                <dx:ASPxComboBox ID="ComboBoxRapor" runat="server" Font-Size="Small" Width="70">
                                    <Items>
                                        <dx:ListEditItem Selected="true" Text="Excel" Value="Excel" />
                                        <%--<dx:ListEditItem Text="Pdf" Value="Pdf" />--%>
                                    </Items>
                                </dx:ASPxComboBox>
                            </td>
                            <td>
                                <dx:ASPxButton ID="ButtonRapor" runat="server" Text="Rapor" Width="120" Font-Size="Small" OnClick="ButtonRapor_Click" />
                            </td>
                            <td>&nbsp;
                            </td>
                            <td>
                                <dx:ASPxButton ID="ButtonTumDetay" runat="server" Text="Tüm Detay Rapor" Width="120" Font-Size="Small" OnClick="ButtonTumDetay_Click" />
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
        <tr>
            <td class="TdOrtala" colspan="4">
                <dx:ASPxGridViewExporter ExportedRowType="All" GridViewID="GridViewSicilArama" ID="GridViewExporterSicilArama" runat="server">
                </dx:ASPxGridViewExporter>
                <dx:ASPxGridView ID="GridViewSicilArama" ClientInstanceName="GridViewSicilArama" runat="server" KeyFieldName="TuccarSicilKey" AutoGenerateColumns="false" Width="100%" Font-Size="Small" OnRowDeleting="GridViewSicilArama_RowDeleting" OnCustomButtonCallback="GridViewSicilArama_CustomButtonCallback">
                    <ClientSideEvents EndCallback="function(s, e) {
	                                                                        if (s.cpErrorMessage){
                                                                            delete s.cpErrorMessage;
		                                                                        alert('Silinmek istenen veri diğer kısımlarda kullanılmaktadır!');
                                                                                }
                                                                       }" />
                    <Settings ShowGroupPanel="true" />
                    <SettingsText ConfirmDelete="Silme işlemini onaylıyor musunuz?" />
                    <SettingsBehavior AllowDragDrop="true" AllowFocusedRow="false" ConfirmDelete="true" />
                    <SettingsPager Visible="true" PageSize="20" AlwaysShowPager="true" Position="Bottom" ShowEmptyDataRows="true" />
                    <Paddings Padding="0px" />
                    <Border BorderWidth="0px" />
                    <BorderBottom BorderWidth="1px" />
                    <Columns>
                        <dx:GridViewDataColumn FieldName="SicilNo" Caption="Sicil No">
                            <CellStyle HorizontalAlign="Center" />
                            <HeaderStyle HorizontalAlign="Center" />
                        </dx:GridViewDataColumn>
                        <dx:GridViewDataColumn FieldName="Unvan" Caption="Unvan">
                            <HeaderStyle HorizontalAlign="Center" />
                        </dx:GridViewDataColumn>
                        <dx:GridViewDataColumn FieldName="MeslekGrupAdi" Caption="Meslek Grubu">
                            <HeaderStyle HorizontalAlign="Center" />
                        </dx:GridViewDataColumn>
                        <dx:GridViewDataColumn FieldName="KurulusTurAdi" Caption="Kuruluş Türü">
                            <CellStyle HorizontalAlign="Center" />
                            <HeaderStyle HorizontalAlign="Center" />
                        </dx:GridViewDataColumn>
                        <dx:GridViewDataColumn FieldName="VergiDaireAdi" Caption="Vergi Dairesi">
                            <CellStyle HorizontalAlign="Center" />
                            <HeaderStyle HorizontalAlign="Center" />
                        </dx:GridViewDataColumn>
                        <dx:GridViewDataColumn FieldName="DereceAdi" Caption="Derecesi">
                            <CellStyle HorizontalAlign="Center" />
                            <HeaderStyle HorizontalAlign="Center" />
                        </dx:GridViewDataColumn>
                        <dx:GridViewDataColumn FieldName="IlIlceAdi" Caption="İl/İlçe">
                            <CellStyle HorizontalAlign="Center" />
                            <HeaderStyle HorizontalAlign="Center" />
                        </dx:GridViewDataColumn>
                        <dx:GridViewDataColumn FieldName="Tel" Caption="Tel">
                            <CellStyle HorizontalAlign="Center" />
                            <HeaderStyle HorizontalAlign="Center" />
                        </dx:GridViewDataColumn>
                        <dx:GridViewDataColumn FieldName="KayitTarihi" Caption="Kayıt Tarihi">
                            <CellStyle HorizontalAlign="Center" />
                            <HeaderStyle HorizontalAlign="Center" />
                        </dx:GridViewDataColumn>
                        <dx:GridViewDataColumn FieldName="TerkinTarihi" Caption="Terkin Tarihi">
                            <CellStyle HorizontalAlign="Center" />
                            <HeaderStyle HorizontalAlign="Center" />
                        </dx:GridViewDataColumn>
                        <dx:GridViewDataColumn FieldName="TerkinKayitNo" Caption="Terkin Kayıt No" Visible="false">
                            <CellStyle HorizontalAlign="Center" />
                            <HeaderStyle HorizontalAlign="Center" />
                        </dx:GridViewDataColumn>
                        <dx:GridViewDataColumn FieldName="Fax" Caption="Fax" Visible="false">
                            <CellStyle HorizontalAlign="Center" />
                            <HeaderStyle HorizontalAlign="Center" />
                        </dx:GridViewDataColumn>
                        <dx:GridViewDataColumn FieldName="Adres" Caption="Adres" Visible="false">
                            <CellStyle HorizontalAlign="Center" />
                            <HeaderStyle HorizontalAlign="Center" />
                        </dx:GridViewDataColumn>
                        <dx:GridViewDataColumn FieldName="TSTarihi" Caption="T.S. Tarihi" Visible="false">
                            <CellStyle HorizontalAlign="Center" />
                            <HeaderStyle HorizontalAlign="Center" />
                        </dx:GridViewDataColumn>
                        <dx:GridViewDataColumn FieldName="TSKayitNo" Caption="T.S. Kayıt No" Visible="false">
                            <CellStyle HorizontalAlign="Center" />
                            <HeaderStyle HorizontalAlign="Center" />
                        </dx:GridViewDataColumn>
                        <dx:GridViewDataColumn FieldName="YKKTarihi" Caption="Y.K.K. Tarihi" Visible="false">
                            <CellStyle HorizontalAlign="Center" />
                            <HeaderStyle HorizontalAlign="Center" />
                        </dx:GridViewDataColumn>
                        <dx:GridViewDataColumn FieldName="YKKKayitNo" Caption="Y.K.K. Kayıt No" Visible="false">
                            <CellStyle HorizontalAlign="Center" />
                            <HeaderStyle HorizontalAlign="Center" />
                        </dx:GridViewDataColumn>
                        <dx:GridViewDataColumn FieldName="Sermaye" Caption="Sermaye" Visible="false">
                            <CellStyle HorizontalAlign="Center" />
                            <HeaderStyle HorizontalAlign="Center" />
                        </dx:GridViewDataColumn>
                        <dx:GridViewDataColumn FieldName="VergiNo" Caption="Vergi No" Visible="false">
                            <CellStyle HorizontalAlign="Center" />
                            <HeaderStyle HorizontalAlign="Center" />
                        </dx:GridViewDataColumn>
                        <dx:GridViewDataColumn FieldName="AskiDurum" Caption="Askı Durum" Visible="false">
                            <CellStyle HorizontalAlign="Center" />
                            <HeaderStyle HorizontalAlign="Center" />
                        </dx:GridViewDataColumn>
                        <dx:GridViewDataColumn FieldName="SahisAd" Caption="Şahıs Ad" Visible="false">
                            <CellStyle HorizontalAlign="Center" />
                            <HeaderStyle HorizontalAlign="Center" />
                        </dx:GridViewDataColumn>
                        <dx:GridViewDataColumn FieldName="SahisSoyad" Caption="Şahıs Soyad" Visible="false">
                            <CellStyle HorizontalAlign="Center" />
                            <HeaderStyle HorizontalAlign="Center" />
                        </dx:GridViewDataColumn>
                        <dx:GridViewDataColumn FieldName="SahisBabaAdi" Caption="Şahıs Baba Adı" Visible="false">
                            <CellStyle HorizontalAlign="Center" />
                            <HeaderStyle HorizontalAlign="Center" />
                        </dx:GridViewDataColumn>
                        <dx:GridViewDataColumn FieldName="SahisDogumYeri" Caption="Şahıs Doğum Yeri" Visible="false">
                            <CellStyle HorizontalAlign="Center" />
                            <HeaderStyle HorizontalAlign="Center" />
                        </dx:GridViewDataColumn>
                        <dx:GridViewDataColumn FieldName="SahisDogumTarihi" Caption="Şahıs Doğum Tarihi" Visible="false">
                            <CellStyle HorizontalAlign="Center" />
                            <HeaderStyle HorizontalAlign="Center" />
                        </dx:GridViewDataColumn>
                        <dx:GridViewDataColumn FieldName="SahisUyruk" Caption="Şahıs Uyruğu" Visible="false">
                            <CellStyle HorizontalAlign="Center" />
                            <HeaderStyle HorizontalAlign="Center" />
                        </dx:GridViewDataColumn>
                        <dx:GridViewDataColumn FieldName="SahisAdres" Caption="Şahıs Adres" Visible="false">
                            <CellStyle HorizontalAlign="Center" />
                            <HeaderStyle HorizontalAlign="Center" />
                        </dx:GridViewDataColumn>
                        <dx:GridViewDataColumn FieldName="SahisTelefon" Caption="Şahıs Telefon" Visible="false">
                            <CellStyle HorizontalAlign="Center" />
                            <HeaderStyle HorizontalAlign="Center" />
                        </dx:GridViewDataColumn>
                        <%-- <dx:GridViewDataColumn Caption="Detay">
                                <DataItemTemplate>
                                    <dx:ASPxHyperLink ID="ImageUyari" runat="server" AutoPostBack="False" UseSubmitBehavior="false" ImageUrl="../../../Content/Images/Icons/detail.png">
                                        <ClientSideEvents Click="function(s, e) { ShowWindow(); }" />
                                    </dx:ASPxHyperLink>
                                </DataItemTemplate>
                                <CellStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>--%>
                        <dx:GridViewCommandColumn Caption="İşlemler" ButtonType="Image">
                            <CustomButtons>
                                <dx:GridViewCommandColumnCustomButton Visibility="AllDataRows" Image-ToolTip="Düzenle" Image-Url="~/Content/Images/Icons/edit.png" Image-Width="24" Image-Height="24">
                                </dx:GridViewCommandColumnCustomButton>
                            </CustomButtons>
                            <DeleteButton Visible="true" Image-ToolTip="Sil" Image-Url="~/Content/Images/Icons/delete.png" Image-Width="24" Image-Height="24"></DeleteButton>
                            <CellStyle HorizontalAlign="Center" />
                            <HeaderStyle HorizontalAlign="Center" />
                        </dx:GridViewCommandColumn>
                    </Columns>
                </dx:ASPxGridView>
            </td>
        </tr>
    </table>
</div>

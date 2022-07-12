<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MuhtelifBorsaSubeleriUserControl.ascx.cs" Inherits="TicaretBorsasi_Project.User_Control.Ortak.MuhtelifBorsaSubeleriUserControl" %>

<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridView.Export" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>

<div style="margin: 1px; width: 99.9%;">
    <table style="border-color: #999999; width: 99.9%;" border="1">
        <tr>
            <td class="TdOrtala" colspan="4">
                <div style="margin-left: 40%; padding: 2px;">
                    <dx:ASPxLabel ID="LabelBaslik" runat="server" Font-Size="Large" />
                </div>
            </td>
        </tr>
        <tr>
            <td class="TdSolZorunlu" style="width: 15%;">
                <dx:ASPxLabel runat="server" Text="Kod : " Font-Size="Small" ForeColor="Red" />
            </td>
            <td class="TdSag" style="width: 35%;">
                <dx:ASPxTextBox ID="TextBoxKod" runat="server" Width="200px" Font-Size="Small" MaxLength="2">
                    <MaskSettings Mask="<00..99>" />
                    <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                        <RequiredField ErrorText=" " IsRequired="true" />
                    </ValidationSettings>
                </dx:ASPxTextBox>
            </td>
            <td class="TdSolZorunlu" style="width: 15%;">
                <dx:ASPxLabel runat="server" Text="Şube Adı : " Font-Size="Small" ForeColor="Red" />
            </td>
            <td class="TdSag" style="width: 35%;">
                <dx:ASPxTextBox ID="TextBoxSubeAdi" runat="server" Width="200px" Font-Size="Small" MaxLength="50">
                    <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                        <RequiredField ErrorText=" " IsRequired="true" />
                    </ValidationSettings>
                </dx:ASPxTextBox>
            </td>
        </tr>
        <tr>
            <td class="TdSol" style="width: 15%;">
                <dx:ASPxLabel runat="server" Text="Satış Organizasyon H. : " Font-Size="Small" />
            </td>
            <td class="TdSag" style="width: 35%;">
                <dx:ASPxTextBox ID="TextBoxSatisOrganizasyonH" runat="server" Width="200px" Font-Size="Small" MaxLength="6">
                    <MaskSettings Mask="000_00" />
                    <ValidationSettings ValidationGroup=" " Display="Dynamic">
                        <RequiredField ErrorText=" " IsRequired="false" />
                    </ValidationSettings>
                </dx:ASPxTextBox>
            </td>
            <td class="TdSol" style="width: 15%;">
                <dx:ASPxLabel runat="server" Text="Tescil : " Font-Size="Small" />
            </td>
            <td class="TdSag" style="width: 35%;">
                <dx:ASPxTextBox ID="TextBoxTescil" runat="server" Width="200px" Font-Size="Small" MaxLength="6">
                    <MaskSettings Mask="000_00" />
                    <ValidationSettings ValidationGroup=" " Display="Dynamic">
                        <RequiredField ErrorText=" " IsRequired="false" />
                    </ValidationSettings>
                </dx:ASPxTextBox>
            </td>
        </tr>
        <tr>
            <td class="TdSol" style="width: 15%;">
                <dx:ASPxLabel runat="server" Text="Mera Fonu : " Font-Size="Small" />
            </td>
            <td class="TdSag" style="width: 35%;">
                <dx:ASPxTextBox ID="TextBoxMeraFonu" runat="server" Width="200px" Font-Size="Small" MaxLength="6">
                    <MaskSettings Mask="000_00" />
                    <ValidationSettings ValidationGroup=" " Display="Dynamic">
                        <RequiredField ErrorText=" " IsRequired="false" />
                    </ValidationSettings>
                </dx:ASPxTextBox>
            </td>
            <td class="TdOrtala" colspan="2"></td>
        </tr>
        <tr>
            <td colspan="5" class="TdOrtala">
                <div id="divIslemler" runat="server" style="float: left; margin-left: 40%;">
                    <dx:ASPxButton ID="ButtonKaydet" runat="server" Text="Kaydet" ValidationGroup="KayitGuncelle" Width="120" Font-Size="Small" Visible="false" OnClick="ButtonKaydetGuncelle_Click" />
                    <dx:ASPxButton ID="ButtonGuncelle" runat="server" Text="Güncelle" ValidationGroup="KayitGuncelle" Width="120" Font-Size="Small" Visible="false" OnClick="ButtonKaydetGuncelle_Click" />
                    <dx:ASPxButton ID="ButtonTemizle" runat="server" Text="Temizle" Width="120" Font-Size="Small" OnClick="ButtonIptalTemizle_Click" />
                    <dx:ASPxButton ID="ButtonIptal" runat="server" Text="İptal" Width="120" Font-Size="Small" OnClick="ButtonIptalTemizle_Click" />
                </div>
                <div style="float: right;">
                    <dx:ASPxButton ID="ButtonRapor" runat="server" Text="Rapor" Width="120" Font-Size="Small" OnClick="ButtonRapor_Click" />
                </div>
                <div style="float: right;">
                    <dx:ASPxComboBox ID="ComboBoxRapor" runat="server" Font-Size="Small" Width="70">
                        <Items>
                            <dx:ListEditItem Selected="true" Text="Excel" Value="Excel" />
                            <%--<dx:ListEditItem Text="Pdf" Value="Pdf" />--%>
                        </Items>
                    </dx:ASPxComboBox>
                </div>
            </td>
        </tr>
        <tr>
            <td class="TdOrtala" colspan="4">
                <dx:ASPxGridViewExporter ExportedRowType="All" GridViewID="GridViewBorsaSube" ID="GridViewExporterBorsaSube" runat="server">
                </dx:ASPxGridViewExporter>
                <dx:ASPxGridView ID="GridViewBorsaSube" runat="server" KeyFieldName="BorsaSubeKey" AutoGenerateColumns="false" Width="100%" EnableCallBacks="true" Font-Size="Small" OnRowDeleting="GridViewBorsaSube_RowDeleting" OnCustomButtonCallback="GridViewBorsaSube_CustomButtonCallback">
                    <ClientSideEvents EndCallback="function(s, e) {
	                                                                        if (s.cpErrorMessage){
                                                                            delete s.cpErrorMessage;
		                                                                        alert('Silinmek istenen veri diğer kısımlarda kullanılmaktadır!');
                                                                                }
                                                                       }" />
                    <Settings ShowGroupPanel="false" />
                    <SettingsText ConfirmDelete="Silme işlemini onaylıyor musunuz?" />
                    <SettingsBehavior AllowDragDrop="false" AllowFocusedRow="false" ConfirmDelete="true" />
                    <SettingsPager Visible="true" PageSize="15" AlwaysShowPager="true" Position="Bottom" ShowEmptyDataRows="true" />
                    <Paddings Padding="0px" />
                    <Border BorderWidth="0px" />
                    <BorderBottom BorderWidth="1px" />
                    <Columns>
                        <dx:GridViewDataColumn FieldName="Kod" Caption="Kod">
                            <CellStyle HorizontalAlign="Center" />
                            <HeaderStyle HorizontalAlign="Center" />
                        </dx:GridViewDataColumn>
                        <dx:GridViewDataColumn FieldName="BorsaSubeAdi" Caption="Şube Adı">
                            <HeaderStyle HorizontalAlign="Center" />
                        </dx:GridViewDataColumn>
                        <dx:GridViewBandColumn Caption="Tahakkuk İşlemleri Muhasebe Kodu">
                            <Columns>
                                <dx:GridViewDataColumn FieldName="BorsaSubeSimsariyeKodu" Caption="Sat. Org. H.">
                                    <CellStyle HorizontalAlign="Center" />
                                    <HeaderStyle HorizontalAlign="Center" />
                                </dx:GridViewDataColumn>
                                <dx:GridViewDataColumn FieldName="BorsaSubeTesciliyeKodu" Caption="Tescil">
                                    <CellStyle HorizontalAlign="Center" />
                                    <HeaderStyle HorizontalAlign="Center" />
                                </dx:GridViewDataColumn>
                                <dx:GridViewDataColumn FieldName="BorsaSubeMeraFonuKodu" Caption="Mera Fonu">
                                    <CellStyle HorizontalAlign="Center" />
                                    <HeaderStyle HorizontalAlign="Center" />
                                </dx:GridViewDataColumn>
                            </Columns>
                            <HeaderStyle HorizontalAlign="Center" />
                        </dx:GridViewBandColumn>
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

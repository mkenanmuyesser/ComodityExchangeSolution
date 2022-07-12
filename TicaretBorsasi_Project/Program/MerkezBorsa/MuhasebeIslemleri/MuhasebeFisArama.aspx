<%@ Page Title="" Language="C#" MasterPageFile="~/Master_Page/Main.master" AutoEventWireup="true" CodeBehind="MuhasebeFisArama.aspx.cs" Inherits="TicaretBorsasi_Project.Program.MerkezBorsa.MuhasebeIslemleri.MuhasebeFisArama" %>

<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridView.Export" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderMiddleContent" runat="server">
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
                    <dx:ASPxLabel runat="server" Text="Muhasebe Adı : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxComboBox ID="ComboBoxMuhasebeTip" runat="server" ValueType="System.String" Width="200px" Font-Size="Small" TextField="Adi" ValueField="MuhasebeTipKey">
                        <ValidationSettings ValidationGroup="Ara" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxComboBox>
                </td>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Fiş Tipi : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxComboBox ID="ComboBoxFisTip" runat="server" ValueType="System.String" Width="200px" Font-Size="Small" TextField="FisTipAdi" ValueField="FisTipKey">
                        <ValidationSettings ValidationGroup="Ara" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxComboBox>
                </td>
            </tr>
            <tr>
                <td class="TdSol" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="İlgili Kasa Hesabı : " Font-Size="Small" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxTextBox ID="TextBoxIlgiliKasaHesabi" runat="server" Width="200px" Font-Size="Small" MaxLength="12">
                        <MaskSettings Mask="999_99_99999" />
                    </dx:ASPxTextBox>
                </td>
                <td class="TdSol" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Fiş No : " Font-Size="Small" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxTextBox ID="TextBoxFisNo" runat="server" Width="200px" Font-Size="Small" MaxLength="4">
                        <MaskSettings Mask="9999" />
                    </dx:ASPxTextBox>
                </td>
            </tr>
            <tr>
                <td class="TdSol" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Tarihi : " Font-Size="Small" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxDateEdit ID="DateEditTarih" runat="server" Font-Size="Small" Width="200">
                    </dx:ASPxDateEdit>
                </td>
                <td class="TdSol" style="width: 15%;"></td>
                <td class="TdSag" style="width: 35%;"></td>
            </tr>
            <tr>
                <td colspan="4" class="TdOrtala">
                    <div style="float: left; margin-left: 40%;">
                        <dx:ASPxButton ID="ButtonAra" runat="server" Text="Ara" Width="120" Font-Size="Small" ValidationGroup="Ara" OnClick="ButtonAra_Click" />
                        <dx:ASPxButton ID="ButtonTemizle" runat="server" Text="Temizle" Width="120" Font-Size="Small" OnClick="ButtonTemizle_Click" />
                    </div>
                    <div style="float: right;">
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
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="TdOrtala" colspan="4">
                    <dx:ASPxGridViewExporter ExportedRowType="All" GridViewID="GridViewFis" ID="GridViewExporterFis" runat="server">
                    </dx:ASPxGridViewExporter>
                    <dx:ASPxGridView ID="GridViewFis" ClientInstanceName="GridViewFis" runat="server" KeyFieldName="YevmiyeKey" AutoGenerateColumns="false" Width="100%" Font-Size="Small" OnRowDeleting="GridViewFis_RowDeleting" OnCustomButtonCallback="GridViewFis_CustomButtonCallback">
                        <Settings ShowGroupPanel="False" />
                        <SettingsBehavior AllowDragDrop="False" AllowFocusedRow="True" ConfirmDelete="True" />
                        <SettingsPager Visible="true" PageSize="20" AlwaysShowPager="true" Position="Bottom" ShowEmptyDataRows="true" />
                        <Paddings Padding="0px" />
                        <Border BorderWidth="0px" />
                        <BorderBottom BorderWidth="1px" />
                        <SettingsText ConfirmDelete="Silme işlemini onaylıyor musunuz?" />
                        <ClientSideEvents EndCallback="function(s, e) {
	                                                                        if (s.cpErrorMessage){
                                                                            delete s.cpErrorMessage;
		                                                                        alert('Silinmek istenen veri diğer kısımlarda kullanılmaktadır!');
                                                                                }
                                                                       }" />
                        <Columns>
                            <dx:GridViewDataColumn FieldName="HesapNo" Caption="Hesap No">
                                <HeaderStyle HorizontalAlign="Center" />
                                <CellStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="Aciklama" Caption="Aciklama">
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataTextColumn FieldName="Meblag" Caption="Meblağ">
                                <PropertiesTextEdit DisplayFormatString="N" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewCommandColumn Caption="İşlemler" ButtonType="Image">
                                <CustomButtons>
                                    <dx:GridViewCommandColumnCustomButton Visibility="AllDataRows" Image-ToolTip="Düzenle" Image-Url="../../../Content/Images/Icons/edit.png" Image-Width="24" Image-Height="24">
                                    </dx:GridViewCommandColumnCustomButton>
                                </CustomButtons>
                                <DeleteButton Visible="true" Image-ToolTip="Sil" Image-Url="../../../Content/Images/Icons/delete.png" Image-Width="24" Image-Height="24"></DeleteButton>
                                <CellStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewCommandColumn>
                        </Columns>
                    </dx:ASPxGridView>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>

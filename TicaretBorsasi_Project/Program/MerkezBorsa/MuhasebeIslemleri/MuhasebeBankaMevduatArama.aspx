<%@ Page Title="" Language="C#" MasterPageFile="~/Master_Page/Main.master" AutoEventWireup="true" CodeBehind="MuhasebeBankaMevduatArama.aspx.cs" Inherits="TicaretBorsasi_Project.Program.MerkezBorsa.MuhasebeIslemleri.MuhasebeBankaMevduatArama" %>

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
                <td class="TdSol" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Banka Hesap No : " Font-Size="Small" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxTextBox ID="TextBoxBankaHesapNo" runat="server" Width="200px" Font-Size="Small" MaxLength="50">
                    </dx:ASPxTextBox>
                </td>
                <td class="TdSol" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Banka Adı : " Font-Size="Small" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxTextBox ID="TextBoxBankaAdi" runat="server" Width="200px" Font-Size="Small" MaxLength="50">
                    </dx:ASPxTextBox>
                </td>
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
                    <dx:ASPxGridViewExporter ExportedRowType="All" GridViewID="GridViewAra" ID="GridViewExporterAra" runat="server">
                    </dx:ASPxGridViewExporter>
                    <dx:ASPxGridView ID="GridViewAra" ClientInstanceName="GridViewAra" runat="server" KeyFieldName="BankaMevduatKey" AutoGenerateColumns="false" Width="100%" Font-Size="Small" OnRowDeleting="GridViewAra_RowDeleting" OnCustomButtonCallback="GridViewAra_CustomButtonCallback">
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
                            <dx:GridViewDataColumn FieldName="BankaAdi" Caption="Banka Adı">
                                <HeaderStyle HorizontalAlign="Center" />
                                 <CellStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="BankaHesapNo" Caption="Banka Hesap No">
                                <HeaderStyle HorizontalAlign="Center" />
                                <CellStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="VadeBasi" Caption="Vade Başı">
                                <HeaderStyle HorizontalAlign="Center" />
                                 <CellStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="VadeSonu" Caption="Vade Sonu">
                                <HeaderStyle HorizontalAlign="Center" />
                                 <CellStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataTextColumn FieldName="VadeliYatanMeblag" Caption="Vadeli Yatan Meblağ">
                                <PropertiesTextEdit DisplayFormatString="N" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="FaizYuzdesi" Caption="Faiz Yüzdesi">
                                <PropertiesTextEdit DisplayFormatString="N" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="StopajYuzdesi" Caption="Stopaj Yüzdesi">
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

<%@ Page Title="" Language="C#" MasterPageFile="~/Master_Page/Main.master" AutoEventWireup="true" CodeBehind="NumuneArama.aspx.cs" Inherits="TicaretBorsasi_Project.Program.SalonSatis.SatisIslemleri.NumuneArama" %>

<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridView.Export" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderMiddleContent" runat="server">
    <div style="margin: 1px; width: 99.9%;">
        <table style="border-color: #999999; width: 99.9%;" border="1">
            <tr>
                <td class="TdOrtala" colspan="4">
                    <center style="padding: 2px;">
                        <dx:ASPxLabel ID="LabelBaslik" runat="server" Font-Size="Large" />
                    </center>
                </td>
            </tr>
            <tr>
                <td class="TdSol" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="İşlem Tarihi: " Font-Size="Small" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxDateEdit ID="DateEditTarih" runat="server" Width="200px" Font-Size="Small" DisplayFormatString="dd.MM.yyyy HH.mm" AllowNull="False">
                    </dx:ASPxDateEdit>
                </td>
                <td class="TdSol" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Emtia Cinsi : " Font-Size="Small"  />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxComboBox ID="ComboBoxEmtiaCinsi" runat="server" ValueType="System.Int32" Width="200px" Font-Size="Small" TextField="" ValueField="" IncrementalFilteringMode="StartsWith" LoadDropDownOnDemand="true" LoadingPanelText="Yükleniyor&hellip;" EnableCallbackMode="true" CallbackPageSize="10">
                    </dx:ASPxComboBox>
                </td>
            </tr>
            <tr>
                <td class="TdSol" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Satıcı Tc No : " Font-Size="Small" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxTextBox ID="TextBoxSaticiTcKimlikNo" runat="server" Width="200px" Font-Size="Small" MaxLength="11">
                        <MaskSettings Mask="99999999999" />                      
                    </dx:ASPxTextBox>
                </td>
                <td class="TdSolZorunlu" style="width: 15%;"></td>
                <td class="TdSag" style="width: 35%;"></td>
            </tr>
            <tr>
                <td class="TdOrtala" colspan="4">
                    <div style="float: left; margin-left: 40%;">
                        <dx:ASPxButton ID="ButtonAra" runat="server" Text="Ara" Width="120" Font-Size="Small" OnClick="ButtonAra_Click" />
                        <dx:ASPxButton ID="ButtonTemizle" runat="server" Text="Temizle" Width="120" Font-Size="Small" OnClick="ButtonTemizle_Click" />
                    </div>
                    <div style="float: right;" runat="server">
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
                    <dx:ASPxGridViewExporter ExportedRowType="All" GridViewID="GridViewNumune" ID="GridViewExporterNumune" runat="server">
                    </dx:ASPxGridViewExporter>
                    <dx:ASPxGridView ID="GridViewNumune" runat="server" KeyFieldName="TuccarDepoKey" AutoGenerateColumns="false" Width="100%" Font-Size="Small" OnRowDeleting="GridViewNumune_RowDeleting" OnCustomButtonCallback="GridViewNumune_CustomButtonCallback">
                        <ClientSideEvents EndCallback="function(s, e) {
	                                                                        if (s.cpErrorMessage){
                                                                            delete s.cpErrorMessage;
		                                                                        alert('Silinmek istenen veri diğer kısımlarda kullanılmaktadır!');
                                                                                }
                                                                       }" />
                        <Settings ShowGroupPanel="true" />
                        <SettingsText ConfirmDelete="Silme işlemini onaylıyor musunuz?" />
                        <SettingsBehavior AllowDragDrop="true" AllowFocusedRow="false" ConfirmDelete="true" AutoExpandAllGroups="true" />
                        <SettingsPager Visible="true" PageSize="20" AlwaysShowPager="true" Position="Bottom" ShowEmptyDataRows="true" />
                        <Paddings Padding="0px" />
                        <Border BorderWidth="0px" />
                        <BorderBottom BorderWidth="1px" />
                        <Columns>
                            <dx:GridViewDataColumn FieldName="" Caption="İşlem No">
                                <CellStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="" Caption="İşlem Tarihi">
                                <CellStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="" Caption="Emtia Cinsi">
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="" Caption="Tahmini Miktar">
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="" Caption="Satıcı Tc No">
                                <CellStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="" Caption="Satıcı Ad Soyad">
                                <CellStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewBandColumn Caption="Kantar Bilgileri">
                                <Columns>
                                    <dx:GridViewDataColumn FieldName="" Caption="Giriş Saati">
                                        <CellStyle HorizontalAlign="Center" />
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </dx:GridViewDataColumn>
                                    <dx:GridViewDataColumn FieldName="" Caption="Plaka">
                                        <CellStyle HorizontalAlign="Center" />
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </dx:GridViewDataColumn>
                                    <dx:GridViewDataColumn FieldName="" Caption="Araç Türü">
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </dx:GridViewDataColumn>
                                    <dx:GridViewDataColumn FieldName="" Caption="Fire Bilgileri">
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </dx:GridViewDataColumn>
                                    <dx:GridViewDataColumn FieldName="" Caption="Tartım">
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </dx:GridViewDataColumn>
                                </Columns>
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewBandColumn>
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

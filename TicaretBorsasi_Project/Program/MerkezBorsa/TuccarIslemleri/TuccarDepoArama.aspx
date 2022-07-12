<%@ Page Title="" Language="C#" MasterPageFile="~/Master_Page/Main.master" AutoEventWireup="true" CodeBehind="TuccarDepoArama.aspx.cs" Inherits="TicaretBorsasi_Project.Program.MerkezBorsa.TuccarIslemleri.TuccarDepoArama" %>
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
                <td class="TdSol" style="width: 15%">
                    <dx:ASPxLabel runat="server" Text="Sicil No : " Font-Size="Small" />
                </td>
                <td class="TdSag">
                    <dx:ASPxSpinEdit ID="SpinEditSicilNo" runat="server" DecimalPlaces="2" Width="200px" Font-Size="Small" MaxLength="6" NumberType="Integer" AllowNull="true" MinValue="0" SpinButtons-ShowIncrementButtons="false">
                    </dx:ASPxSpinEdit>
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
                    <dx:ASPxLabel runat="server" Text="Madde Kodu : " Font-Size="Small" />
                </td>
                <td class="TdSag" colspan="3">
                    <dx:ASPxComboBox ID="ComboBoxMaddeKodu" runat="server" ValueType="System.String" Width="200px" Font-Size="Small" TextField="Adi" ValueField="MaddeKodKey">
                    </dx:ASPxComboBox>
                </td>
            </tr>
            <tr>
                <td class="TdOrtala" colspan="4">
                    <div style="float: left;">
                        <table>
                            <tr>
                                <td>
                                    <dx:ASPxLabel runat="server" Text="Grupla : " Font-Size="Small" />
                                </td>
                                <td>
                                    <dx:ASPxComboBox ID="ComboBoxGrupla" runat="server" Font-Size="Small" Width="115">
                                        <Items>
                                            <dx:ListEditItem Selected="true" Text="Sicil No" Value="1" />
                                            <dx:ListEditItem Text="Unvan" Value="2" />
                                            <dx:ListEditItem Text="Madde Kodu" Value="3" />
                                        </Items>
                                    </dx:ASPxComboBox>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div style="float: left; margin-left: 30%;">
                        <dx:ASPxButton ID="ButtonAra" runat="server" Text="Ara" Width="120" Font-Size="Small" OnClick="ButtonAra_Click" />
                        <dx:ASPxButton ID="ButtonTemizle" runat="server" Text="Temizle" Width="120" Font-Size="Small" OnClick="ButtonTemizle_Click" />
                    </div>
                    <div style="float: right;" runat="server" >
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
                    <dx:ASPxGridViewExporter ExportedRowType="All" GridViewID="GridViewDepo" ID="GridViewExporterDepo" runat="server">
                    </dx:ASPxGridViewExporter>
                    <dx:ASPxGridView ID="GridViewDepo" ClientInstanceName="GridViewDepo" runat="server" KeyFieldName="TuccarDepoKey" AutoGenerateColumns="false" Width="100%" Font-Size="Small" OnRowDeleting="GridViewDepo_RowDeleting" OnCustomButtonCallback="GridViewDepo_CustomButtonCallback">
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
                            <dx:GridViewDataColumn FieldName="SicilNo" Caption="Sicil No">
                                <CellStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="Unvan" Caption="Unvan">
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="MaddeKoduAdi" Caption="Madde Kodu">
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn Settings-AllowGroup="False" Caption="Bilgiler">
                                <HeaderStyle HorizontalAlign="Center" />
                                <DataItemTemplate>
                                    <table style="border-color: #999999; border-width: 0, 5px; width: 100%;" border="1">
                                        <tr>
                                            <td style="width: 70px;"></td>
                                            <td style="width: 100px;">Devir</td>
                                            <td style="width: 100px;">Alış</td>
                                            <td style="width: 100px;">Satış</td>
                                            <td style="width: 100px;">Diğer Borsa Alış</td>
                                            <td style="width: 100px;">Diğer Borsa Satış</td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <dx:ASPxLabel runat="server" Text="1. Birim : " Font-Size="Small" />
                                            </td>
                                            <td><%# Eval("Devir1") %></td>
                                            <td><%# Eval("Alis1") %></td>
                                            <td><%# Eval("Satis1") %></td>
                                            <td><%# Eval("DigerBorsaAlis1") %></td>
                                            <td><%# Eval("DigerBorsaSatis1") %></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <dx:ASPxLabel runat="server" Text="2. Birim : " Font-Size="Small" />
                                            </td>
                                            <td><%# Eval("Devir2") %></td>
                                            <td><%# Eval("Alis2") %></td>
                                            <td><%# Eval("Satis2") %></td>
                                            <td><%# Eval("DigerBorsaAlis2") %></td>
                                            <td><%# Eval("DigerBorsaSatis2") %></td>
                                        </tr>
                                    </table>

                                </DataItemTemplate>
                            </dx:GridViewDataColumn>
                            <dx:GridViewBandColumn Caption="1.Birim" Name="Birim1Column" Visible="false">
                                <Columns>
                                    <dx:GridViewDataColumn FieldName="Devir1" Caption="Devir">
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </dx:GridViewDataColumn>
                                    <dx:GridViewDataColumn FieldName="Alis1" Caption="Alış">
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </dx:GridViewDataColumn>
                                    <dx:GridViewDataColumn FieldName="Satis1" Caption="Satış">
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </dx:GridViewDataColumn>
                                    <dx:GridViewDataColumn FieldName="DigerBorsaAlis1" Caption="Diğer Borsa Alış">
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </dx:GridViewDataColumn>
                                    <dx:GridViewDataColumn FieldName="DigerBorsaSatis1" Caption="Diğer Borsa Satış">
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </dx:GridViewDataColumn>
                                </Columns>
                            </dx:GridViewBandColumn>
                            <dx:GridViewBandColumn Caption="2.Birim" Name="Birim2Column" Visible="false">
                                <Columns>
                                    <dx:GridViewDataColumn FieldName="Devir2" Caption="Devir">
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </dx:GridViewDataColumn>
                                    <dx:GridViewDataColumn FieldName="Alis2" Caption="Alış">
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </dx:GridViewDataColumn>
                                    <dx:GridViewDataColumn FieldName="Satis2" Caption="Satış">
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </dx:GridViewDataColumn>
                                    <dx:GridViewDataColumn FieldName="DigerBorsaAlis2" Caption="Diğer Borsa Alış">
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </dx:GridViewDataColumn>
                                    <dx:GridViewDataColumn FieldName="DigerBorsaSatis2" Caption="Diğer Borsa Satış">
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </dx:GridViewDataColumn>
                                </Columns>
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
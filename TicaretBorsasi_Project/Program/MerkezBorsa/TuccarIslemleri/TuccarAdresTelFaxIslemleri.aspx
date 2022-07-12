<%@ Page Title="" Language="C#" MasterPageFile="~/Master_Page/Main.master" AutoEventWireup="true" CodeBehind="TuccarAdresTelFaxIslemleri.aspx.cs" Inherits="TicaretBorsasi_Project.Program.MerkezBorsa.TuccarIslemleri.TuccarAdresTelFaxIslemleri" %>
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
                    <dx:ASPxLabel runat="server" Text="Üye Durum : " Font-Size="Small" />
                </td>
                <td class="TdSag">
                    <dx:ASPxRadioButtonList ID="RadioButtonListUyeSecim" runat="server" ValueType="System.String" RepeatDirection="Horizontal" Font-Size="Small" Width="100%" AutoPostBack="false">
                        <Items>
                            <dx:ListEditItem Selected="true" Text="Tümü" Value="1" />
                            <dx:ListEditItem Text="Gerçek" Value="2" />
                            <dx:ListEditItem Text="Tüzel" Value="3" />
                        </Items>
                    </dx:ASPxRadioButtonList>
                </td>
                <td class="TdSol" style="width: 15%"></td>
                <td class="TdSag"></td>
            </tr>
            <tr>
                <td class="TdSol" style="width: 15%">
                    <dx:ASPxLabel runat="server" Text="Terkin Durumu : " Font-Size="Small" />
                </td>
                <td class="TdSag">
                    <dx:ASPxRadioButtonList ID="RadioButtonListTerkinSecim" runat="server" ValueType="System.String" RepeatDirection="Horizontal" Font-Size="Small" Width="100%" AutoPostBack="false">
                        <Items>
                            <dx:ListEditItem Selected="true" Text="Tümü" Value="1" />
                            <dx:ListEditItem Text="Aktif Üyeler" Value="2" />
                            <dx:ListEditItem Text="Kaydı Kapanan Üyeler" Value="3" />
                        </Items>
                    </dx:ASPxRadioButtonList>
                </td>
                <td class="TdSol" style="width: 15%">
                    <dx:ASPxLabel runat="server" Text="Askı Durum : " Font-Size="Small" />
                </td>
                <td class="TdSag">
                    <dx:ASPxRadioButtonList ID="RadioButtonListAskiSecim" runat="server" ValueType="System.String" RepeatDirection="Horizontal" Font-Size="Small" Width="100%" AutoPostBack="false">
                        <Items>
                            <dx:ListEditItem Selected="true" Text="Tümü" Value="1" />
                            <dx:ListEditItem Text="Askıda Olmayanlar" Value="2" />
                            <dx:ListEditItem Text="Askıda Olanlar" Value="3" />
                        </Items>
                    </dx:ASPxRadioButtonList>
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
                    <div style="float: right;" >
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
                    <dx:ASPxGridViewExporter ExportedRowType="All" GridViewID="GridViewAdres" ID="GridViewExporterAdres" runat="server">
                    </dx:ASPxGridViewExporter>
                    <dx:ASPxGridView ID="GridViewAdres" ClientInstanceName="GridViewAdres" runat="server" KeyFieldName="TuccarSicilKey" AutoGenerateColumns="false" Width="100%" Font-Size="Small">
                        <Settings ShowGroupPanel="true" />
                        <SettingsBehavior AllowDragDrop="true" AllowFocusedRow="false" />
                        <SettingsPager Visible="true" PageSize="20" AlwaysShowPager="true" Position="Bottom" ShowEmptyDataRows="true" />
                        <Paddings Padding="0px" />
                        <Border BorderWidth="0px" />
                        <BorderBottom BorderWidth="1px" />
                        <Columns>
                            <dx:GridViewDataColumn FieldName="Sira" Caption="Sıra">
                                <CellStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="SicilNo" Caption="Sicil No">
                                <CellStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="Unvan" Caption="Unvan">
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn Settings-AllowGroup="False" Caption="Telefon/Fax">
                                <HeaderStyle HorizontalAlign="Center" />
                                <DataItemTemplate>
                                    <table style="border-color: #999999; border-width: 0, 5px; width: 100%;" border="1">
                                        <tr>
                                            <td style="padding: 3px; width: 70px;">Tel1</td>
                                            <td style="padding: 3px; width: 100px;"><%# Eval("Tel1") %></td>
                                            <td style="padding: 3px; width: 70px;">Tel3</td>
                                            <td style="padding: 3px; width: 100px;"><%# Eval("Tel3") %></td>
                                        </tr>
                                        <tr>
                                            <td style="padding: 3px; width: 70px;">Tel2</td>
                                            <td style="padding: 3px; width: 100px;"><%# Eval("Tel2") %></td>
                                            <td style="padding: 3px; width: 70px;">Fax</td>
                                            <td style="padding: 3px; width: 100px;"><%# Eval("Fax") %></td>
                                        </tr>
                                    </table>
                                </DataItemTemplate>
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="Tel1" Caption="Tel1" Visible="false">
                                <CellStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="Tel2" Caption="Tel2" Visible="false">
                                <CellStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="Tel3" Caption="Tel3" Visible="false">
                                <CellStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="Fax" Caption="Fax" Visible="false">
                                <CellStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="Adres" Caption="Adres">
                                <CellStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="VergiDaireAdi" Caption="Vergi Dairesi">
                                <CellStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="VergiNo" Caption="Vergi No">
                                <CellStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                        </Columns>
                    </dx:ASPxGridView>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
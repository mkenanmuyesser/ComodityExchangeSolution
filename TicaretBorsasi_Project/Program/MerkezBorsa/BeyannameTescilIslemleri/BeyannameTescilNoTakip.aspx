<%@ Page Title="" Language="C#" MasterPageFile="~/Master_Page/Main.master" AutoEventWireup="true" CodeBehind="BeyannameTescilNoTakip.aspx.cs" Inherits="TicaretBorsasi_Project.Program.MerkezBorsa.BeyannameTescilIslemleri.BeyannameTescilNoTakip" %>

<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridView.Export" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderMiddleContent" runat="server">
    <style type="text/css">
        .columnheader {
            height: 0px;
            padding: 0px;
        }
    </style>
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
                    <dx:ASPxLabel runat="server" Text="Liste Tipi : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxComboBox ID="ComboBoxListeTipi" runat="server" ValueType="System.String" Width="200px" Font-Size="Small">
                        <Items>
                            <dx:ListEditItem Text="Normal" Value="1" Selected="true" />
                            <dx:ListEditItem Text="Detaylı" Value="2" />
                        </Items>
                        <ValidationSettings ValidationGroup="Ara" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxComboBox>
                </td>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Beyanname Tipi : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxComboBox ID="ComboBoxBeyannameTipi" runat="server" ValueType="System.String" Width="200px" Font-Size="Small" TextField="Aciklama" ValueField="BeyanTipKey">
                        <ValidationSettings ValidationGroup="Ara" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxComboBox>
                </td>
            </tr>
            <tr>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Başlangıç Tarihi : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxDateEdit ID="DateEditBaslangic" runat="server" Font-Size="Small" Width="200">
                        <ValidationSettings ValidationGroup="Ara" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxDateEdit>
                </td>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Bitiş Tarihi : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxDateEdit ID="DateEditBitis" runat="server" Font-Size="Small" Width="200">
                        <ValidationSettings ValidationGroup="Ara" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxDateEdit>
                </td>
            </tr>
            <tr>
                <td class="TdSol" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Başlangıç Şube Kodu : " Font-Size="Small" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxSpinEdit ID="SpinEditBaslangicSubeKodu" runat="server" DecimalPlaces="2" Width="200px" Font-Size="Small" MaxLength="2" NumberType="Integer" AllowNull="true" MinValue="0" SpinButtons-ShowIncrementButtons="false">
                    </dx:ASPxSpinEdit>
                </td>
                <td class="TdSol" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Bitiş Şube Kodu : " Font-Size="Small" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxSpinEdit ID="SpinEditBitisSubeKodu" runat="server" DecimalPlaces="2" Width="200px" Font-Size="Small" MaxLength="2" NumberType="Integer" AllowNull="true" MinValue="0" SpinButtons-ShowIncrementButtons="false">
                    </dx:ASPxSpinEdit>
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
                                            <dx:ListEditItem Selected="true" Text="Tarih" Value="1" />
                                            <dx:ListEditItem Text="Tescil No" Value="2" />
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
                    <div style="float: left; margin-left: 26%;">
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
                    <dx:ASPxGridViewExporter ExportedRowType="All" GridViewID="GridViewTescilNoTakip" ID="GridViewExporterTescilNoTakip" runat="server">
                    </dx:ASPxGridViewExporter>
                    <dx:ASPxGridView ID="GridViewTescilNoTakip" ClientInstanceName="GridViewTescilNoTakip" runat="server" KeyFieldName="BeyanKey" AutoGenerateColumns="false" Width="100%" Font-Size="Small">
                        <Settings ShowGroupPanel="true" />
                        <SettingsText ConfirmDelete="Silme işlemini onaylıyor musunuz?" />
                        <SettingsBehavior AllowDragDrop="true" AllowFocusedRow="false" ConfirmDelete="true" />
                        <SettingsPager Visible="true" PageSize="20" AlwaysShowPager="true" Position="Bottom" ShowEmptyDataRows="true" />
                        <Paddings Padding="0px" />
                        <Border BorderWidth="0px" />
                        <BorderBottom BorderWidth="1px" />
                        <Columns>
                            <dx:GridViewDataColumn FieldName="TescilTarihi" Caption="Tescil Tarihi">
                                <DataItemTemplate>
                                    <table style="width: 100%">
                                        <tr style="border-bottom-color: #999999; border-bottom-style: solid; border-bottom-width: thin;">
                                            <td><%# Eval("TescilTarihi") %></td>
                                        </tr>
                                        <tr>
                                            <td><%# Eval("Madde") %></td>
                                        </tr>
                                    </table>
                                </DataItemTemplate>
                                <CellStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="TescilNo" Caption="Tescil No">
                                <DataItemTemplate>
                                    <table style="width: 100%">
                                        <tr style="border-bottom-color: #999999; border-bottom-style: solid; border-bottom-width: thin;">
                                            <td><%# Eval("TescilNo") %></td>
                                        </tr>
                                        <tr>
                                            <td><%# Eval("No") %></td>
                                        </tr>
                                    </table>
                                </DataItemTemplate>
                                <CellStyle HorizontalAlign="Right" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="SubeKoduAdi" Caption="Şube Kodu/Adı">
                                <DataItemTemplate>
                                    <table style="width: 100%">
                                        <tr style="border-bottom-color: #999999; border-bottom-style: solid; border-bottom-width: thin;">
                                            <td><%# Eval("SubeKoduAdi") %></td>
                                        </tr>
                                        <tr>
                                            <td><%# Eval("TeslimTarihi") %></td>
                                        </tr>
                                    </table>
                                </DataItemTemplate>
                                <CellStyle HorizontalAlign="Center" />
                                <CellStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="FirmaNo" Caption="Firma No">
                                <DataItemTemplate>
                                    <table style="width: 100%">
                                        <tr style="border-bottom-color: #999999; border-bottom-style: solid; border-bottom-width: thin;">
                                            <td><%# Eval("FirmaNo") %></td>
                                        </tr>
                                        <tr>
                                            <td><%# Eval("FirmaNo") %></td>
                                        </tr>
                                    </table>
                                </DataItemTemplate>
                                <CellStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="FirmaUnvan" Caption="Unvan">
                                <DataItemTemplate>
                                    <table style="width: 100%">
                                        <tr style="border-bottom-color: #999999; border-bottom-style: solid; border-bottom-width: thin;">
                                            <td><%# Eval("FirmaUnvan") %></td>
                                        </tr>
                                        <tr>
                                            <td><%# Eval("SaticiFirmaUnvan") %></td>
                                        </tr>
                                    </table>
                                </DataItemTemplate>
                                <CellStyle HorizontalAlign="Left" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="BeyanNevi" Caption="Beyan Nevi">
                                <DataItemTemplate>
                                    <table style="width: 100%">
                                        <tr style="border-bottom-color: #999999; border-bottom-style: solid; border-bottom-width: thin;">
                                            <td><%# Eval("BeyanNevi") %></td>
                                        </tr>
                                        <tr>
                                            <td><%# Eval("Miktar") %></td>
                                        </tr>
                                    </table>
                                </DataItemTemplate>
                                <CellStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="Tip" Caption="Tip">
                                <DataItemTemplate>
                                    <table style="width: 100%">
                                        <tr style="border-bottom-color: #999999; border-bottom-style: solid; border-bottom-width: thin;">
                                            <td><%# Eval("Tip") %></td>
                                        </tr>
                                        <tr>
                                            <td><%# Eval("BirimAdi") %></td>
                                        </tr>
                                    </table>
                                </DataItemTemplate>
                                <CellStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="Madde" Caption="Madde Adı" Visible="false">
                                <CellStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="No" Caption="No" Visible="false">
                                <CellStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="TeslimTarihi" Caption="Teslim Tarihi" Visible="false">
                                <CellStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="SaticiFirmaUnvan" Caption="Satıcı Firma Unvan" Visible="false">
                                <CellStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="Miktar" Caption="Miktar" Visible="false">
                                <CellStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="BirimAdi" Caption="Birim" Visible="false">
                                <CellStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                        </Columns>
                        <%--   <Templates>
                            <DataRow>
                                <div style="padding: 5px">
                                    <table style="width: 100%">
                                        <tr>
                                            <td>a</td>
                                            <td>b</td>
                                            <td>c</td>
                                            <td>d</td>
                                            <td>e</td>
                                            <td>f</td>
                                            <td>g</td>
                                            <td>h</td>
                                        </tr>
                                        <tr>
                                            <td>a</td>
                                            <td>b</td>
                                            <td>c</td>
                                            <td>d</td>
                                            <td>e</td>
                                            <td>f</td>
                                            <td>g</td>
                                            <td>h</td>
                                        </tr>
                                    </table>
                                </div>
                            </DataRow>
                        </Templates>--%>
                        <%-- <TotalSummary>
                            <dx:ASPxSummaryItem FieldName="AidatToplam" SummaryType="Sum" />
                            <dx:ASPxSummaryItem FieldName="Ceza" SummaryType="Sum" />
                            <dx:ASPxSummaryItem FieldName="AidatCezaToplam" SummaryType="Sum" />
                        </TotalSummary>--%>
                    </dx:ASPxGridView>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>

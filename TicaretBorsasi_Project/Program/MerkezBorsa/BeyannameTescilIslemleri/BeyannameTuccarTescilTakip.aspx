<%@ Page Title="" Language="C#" MasterPageFile="~/Master_Page/Main.master" AutoEventWireup="true" CodeBehind="BeyannameTuccarTescilTakip.aspx.cs" Inherits="TicaretBorsasi_Project.Program.MerkezBorsa.BeyannameTescilIslemleri.BeyannameTuccarTescilTakip" %>

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
                    <dx:ASPxLabel runat="server" Text="Satış Şekli : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxComboBox ID="ComboBoxSatisSekli" runat="server" ValueType="System.Int32" Width="200px" Font-Size="Small" TextField="SatisSekliAdi" ValueField="SatisSekliKey">
                        <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxComboBox>
                </td>
                <td class="TdOrtala" colspan="2"></td>
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
                    <dx:ASPxLabel runat="server" Text="Başlangıç Madde Kodu : " Font-Size="Small" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxSpinEdit ID="SpinEditBaslangicMaddeKodu" runat="server" DecimalPlaces="2" Width="200px" Font-Size="Small" MaxLength="6" NumberType="Integer" AllowNull="true" MinValue="0" SpinButtons-ShowIncrementButtons="false">
                    </dx:ASPxSpinEdit>
                </td>
                <td class="TdSol" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Bitiş Madde Kodu : " Font-Size="Small" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxSpinEdit ID="SpinEditBitisMaddeKodu" runat="server" DecimalPlaces="2" Width="200px" Font-Size="Small" MaxLength="6" NumberType="Integer" AllowNull="true" MinValue="0" SpinButtons-ShowIncrementButtons="false">
                    </dx:ASPxSpinEdit>
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
                    <dx:ASPxGridViewExporter ExportedRowType="All" GridViewID="GridViewTuccarTescilTakip" ID="GridViewExporterTuccarTescilTakip" runat="server">
                    </dx:ASPxGridViewExporter>
                    <dx:ASPxGridView ID="GridViewTuccarTescilTakip" ClientInstanceName="GridViewTuccarTescilTakip" runat="server" KeyFieldName="BeyanKey" AutoGenerateColumns="false" Width="100%" Font-Size="Small">
                        <Settings ShowGroupPanel="true" />
                        <SettingsText ConfirmDelete="Silme işlemini onaylıyor musunuz?" />
                        <SettingsBehavior AllowDragDrop="true" AllowFocusedRow="false" ConfirmDelete="true" />
                        <SettingsPager Visible="true" PageSize="20" AlwaysShowPager="true" Position="Bottom" ShowEmptyDataRows="true" />
                        <Paddings Padding="0px" />
                        <Border BorderWidth="0px" />
                        <BorderBottom BorderWidth="1px" />
                        <Columns>
                            <dx:GridViewDataColumn FieldName="TuccarBilgi" Caption="">
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="TescilTarihi" Caption="Tescil Tarihi">
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="TescilNo" Caption="Tescil No">
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="FaturaTarihi" Caption="Fatura Tarihi">
                                <CellStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="FaturaNo" Caption="Fatura No">
                                <CellStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="Birim" Caption="Birim">
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="SatOrgHUcret" Caption="Sat. Org. H. Ücret">
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="TescilUcret" Caption="Tescil Ücret">
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewBandColumn Caption="Alış">
                                <Columns>
                                    <dx:GridViewDataColumn FieldName="AlisMiktar" Caption="Miktar">
                                        <CellStyle HorizontalAlign="Center" />
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </dx:GridViewDataColumn>
                                    <dx:GridViewDataColumn FieldName="AlisTutar" Caption="Tutar">
                                        <CellStyle HorizontalAlign="Center" />
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </dx:GridViewDataColumn>
                                    <dx:GridViewDataColumn FieldName="AlisTur" Caption="Tür">
                                        <CellStyle HorizontalAlign="Center" />
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </dx:GridViewDataColumn>
                                </Columns>
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewBandColumn>
                            <dx:GridViewBandColumn Caption="Satış">
                                <Columns>
                                    <dx:GridViewDataColumn FieldName="SatisMiktar" Caption="Miktar">
                                        <CellStyle HorizontalAlign="Center" />
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </dx:GridViewDataColumn>
                                    <dx:GridViewDataColumn FieldName="SatisTutar" Caption="Tutar">
                                        <CellStyle HorizontalAlign="Center" />
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </dx:GridViewDataColumn>
                                    <dx:GridViewDataColumn FieldName="SatisTur" Caption="Tür">
                                        <CellStyle HorizontalAlign="Center" />
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </dx:GridViewDataColumn>
                                </Columns>
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewBandColumn>
                        </Columns>
                        <GroupSummary>
                            <dx:ASPxSummaryItem FieldName="SatOrgHUcret" SummaryType="Sum" />
                            <dx:ASPxSummaryItem FieldName="TescilUcret" SummaryType="Sum" />
                            <dx:ASPxSummaryItem FieldName="AlisMiktar" SummaryType="Sum" />
                            <dx:ASPxSummaryItem FieldName="AlisTutar" SummaryType="Sum" />
                            <dx:ASPxSummaryItem FieldName="SatisMiktar" SummaryType="Sum" />
                            <dx:ASPxSummaryItem FieldName="SatisTutar" SummaryType="Sum" />
                        </GroupSummary>
                    </dx:ASPxGridView>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>

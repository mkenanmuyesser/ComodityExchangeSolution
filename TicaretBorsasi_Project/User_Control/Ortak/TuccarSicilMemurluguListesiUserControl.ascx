<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="TuccarSicilMemurluguListesiUserControl.ascx.cs" Inherits="TicaretBorsasi_Project.User_Control.Ortak.TuccarSicilMemurluguListesiUserControl" %>


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
            <td class="TdSol" style="width: 15%">
                <dx:ASPxLabel runat="server" Text="Terkin Durumu : " Font-Size="Small" />
            </td>
            <td class="TdSag" style="width: 35%">
                <dx:ASPxRadioButtonList ID="RadioButtonListTerkinSecim" runat="server" ValueType="System.String" RepeatDirection="Horizontal" Font-Size="Small" Width="100%">
                    <Items>
                        <dx:ListEditItem Selected="true" Text="Tümü" Value="1" />
                        <dx:ListEditItem Text="Aktif Üyeler" Value="2" />
                        <dx:ListEditItem Text="Kaydı Kapanan Üyeler" Value="3" />
                    </Items>
                </dx:ASPxRadioButtonList>
            </td>
            <td class="TdSol" style="width: 15%">
                <dx:ASPxLabel runat="server" Text="Askı Durumu : " Font-Size="Small" />
            </td>
            <td class="TdSag" style="width: 35%">
                <dx:ASPxRadioButtonList ID="RadioButtonListAskiSecim" runat="server" ValueType="System.String" RepeatDirection="Horizontal" Font-Size="Small" Width="100%">
                    <Items>
                        <dx:ListEditItem Selected="true" Text="Tümü" Value="1" />
                        <dx:ListEditItem Text="Askıya Alınmış Üyeler" Value="2" />
                        <dx:ListEditItem Text="Askıya Alınmamış/Askı Süresi Bitmiş Üyeler" Value="3" />
                    </Items>
                </dx:ASPxRadioButtonList>
            </td>
        </tr>
        <tr>
            <td class="TdSol" style="width: 15%">
                <dx:ASPxLabel runat="server" Text="Ticaret Sicil Memurluğu : " Font-Size="Small" />
            </td>
            <td class="TdSag" style="width: 35%">
                <dx:ASPxComboBox ID="ComboBoxSicilMemurlugu" runat="server" ValueType="System.String" Width="200px" Font-Size="Small" TextField="Adi" ValueField="SicilMemurluguKey">
                </dx:ASPxComboBox>
            </td>
            <td class="TdOrtala" colspan="2"></td>
        </tr>
        <tr>
            <td class="TdOrtala" colspan="4">
                <div style="float: left; margin-left: 40%;">
                    <dx:ASPxButton ID="ButtonAra" runat="server" Text="Ara" Width="120" Font-Size="Small" OnClick="ButtonAra_Click" />
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
                <dx:ASPxGridViewExporter ExportedRowType="All" GridViewID="GridViewTicaretSicilMemurluğuListesi" ID="GridViewExporterTicaretSicilMemurluğuListesi" runat="server">
                </dx:ASPxGridViewExporter>
                <dx:ASPxGridView ID="GridViewTicaretSicilMemurluğuListesi" ClientInstanceName="GridViewTicaretSicilMemurluğuListesi" runat="server" KeyFieldName="TuccarSicilKey" AutoGenerateColumns="false" Width="100%" Font-Size="Small">
                    <Settings ShowGroupPanel="true" />
                    <SettingsText ConfirmDelete="Silme işlemini onaylıyor musunuz?" />
                    <SettingsBehavior AllowDragDrop="true" AllowFocusedRow="false" ConfirmDelete="true" />
                    <SettingsPager Visible="true" PageSize="20" AlwaysShowPager="true" Position="Bottom" ShowEmptyDataRows="true" />
                    <Paddings Padding="0px" />
                    <Border BorderWidth="0px" />
                    <BorderBottom BorderWidth="1px" />
                    <Columns>
                        <dx:GridViewDataColumn FieldName="Sira" Caption="Sıra">
                            <HeaderStyle HorizontalAlign="Center" />
                        </dx:GridViewDataColumn>
                        <dx:GridViewDataColumn FieldName="SicilNo" Caption="Sicil No">
                            <CellStyle HorizontalAlign="Center" />
                            <HeaderStyle HorizontalAlign="Center" />
                        </dx:GridViewDataColumn>
                        <dx:GridViewDataColumn FieldName="Unvan" Caption="Unvan">
                            <HeaderStyle HorizontalAlign="Center" />
                        </dx:GridViewDataColumn>
                        <dx:GridViewDataColumn FieldName="KayitTarihi" Caption="Kayıt Tarihi">
                            <CellStyle HorizontalAlign="Center" />
                            <HeaderStyle HorizontalAlign="Center" />
                        </dx:GridViewDataColumn>
                        <dx:GridViewDataColumn FieldName="KayitNo" Caption="Kayıt No">
                            <CellStyle HorizontalAlign="Center" />
                            <HeaderStyle HorizontalAlign="Center" />
                        </dx:GridViewDataColumn>
                    </Columns>
                </dx:ASPxGridView>
            </td>
        </tr>
    </table>
</div>

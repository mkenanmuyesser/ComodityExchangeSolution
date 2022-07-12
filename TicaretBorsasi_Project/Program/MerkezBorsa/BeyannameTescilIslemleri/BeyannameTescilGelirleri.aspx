<%@ Page Title="" Language="C#" MasterPageFile="~/Master_Page/Main.master" AutoEventWireup="true" CodeBehind="BeyannameTescilGelirleri.aspx.cs" Inherits="TicaretBorsasi_Project.Program.MerkezBorsa.BeyannameTescilIslemleri.BeyannameTescilGelirleri" %>

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
                <td class="TdOrtala" colspan="4">
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
                    <dx:ASPxGridViewExporter ExportedRowType="All" GridViewID="GridViewTescilGelir" ID="GridViewExporterTescilGelir" runat="server">
                    </dx:ASPxGridViewExporter>
                    <dx:ASPxGridView ID="GridViewTescilGelir" ClientInstanceName="GridViewTescilGelir" runat="server" KeyFieldName="BeyanKey" AutoGenerateColumns="false" Width="100%" Font-Size="Small">
                        <Settings ShowGroupPanel="true"  ShowFooter="True"/>
                        <SettingsText ConfirmDelete="Silme işlemini onaylıyor musunuz?" />
                        <SettingsBehavior AllowDragDrop="true" AllowFocusedRow="false" ConfirmDelete="true" />
                        <SettingsPager Visible="true" PageSize="20" AlwaysShowPager="true" Position="Bottom" ShowEmptyDataRows="true" />
                        <Paddings Padding="0px" />
                        <Border BorderWidth="0px" />
                        <BorderBottom BorderWidth="1px" />
                        <Columns>
                            <dx:GridViewDataColumn FieldName="SicilNo" Caption="SicilNo">
                                <CellStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="Unvan" Caption="Unvan">
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="AlBeySimTop" Caption="Al. Bey. Sim. Topl.">
                                <CellStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="AlBeyTesTop" Caption="Al. Bey. Tes. Topl.">
                                <CellStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="StBeyTesTop" Caption="St. Bey. Sim. Topl.">
                                <CellStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                        </Columns>
                        <TotalSummary>
                            <dx:ASPxSummaryItem FieldName="AlBeySimTop" SummaryType="Sum" />
                            <dx:ASPxSummaryItem FieldName="AlBeyTesTop" SummaryType="Sum" />
                            <dx:ASPxSummaryItem FieldName="StBeyTesTop" SummaryType="Sum" />
                        </TotalSummary>
                    </dx:ASPxGridView>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>

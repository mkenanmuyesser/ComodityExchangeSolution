<%@ Page Title="" Language="C#" MasterPageFile="~/Master_Page/Main.master" AutoEventWireup="true" CodeBehind="BeyannameBorsaBeyanGelirleriKontrolu.aspx.cs" Inherits="TicaretBorsasi_Project.Program.MerkezBorsa.BeyannameTescilIslemleri.BeyannameBorsaBeyanGelirleriKontrolu" %>

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
                    <dx:ASPxLabel runat="server" Text="Liste Nevi : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxComboBox ID="ComboBoxListeTipi" runat="server" ValueType="System.String" Width="200px" Font-Size="Small">
                        <Items>
                            <dx:ListEditItem Text="Hepsi" Value="1" Selected="True" />
                            <dx:ListEditItem Text="Hatalılar" Value="2" />
                        </Items>
                        <ValidationSettings ValidationGroup="Ara" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxComboBox>
                </td>
                <td class="TdSol" style="width: 15%;"></td>
                <td class="TdSag" style="width: 35%;"></td>
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
                    <dx:ASPxGridViewExporter ExportedRowType="All" GridViewID="GridViewBeyanGelirKontrol" ID="GridViewExporterBeyanGelirKontrol" runat="server">
                    </dx:ASPxGridViewExporter>
                    <dx:ASPxGridView ID="GridViewBeyanGelirKontrol" ClientInstanceName="GridViewBeyanGelirKontrol" runat="server" KeyFieldName="TuccarSicilKey" AutoGenerateColumns="false" Width="100%" Font-Size="Small">
                        <Settings ShowGroupPanel="true" ShowFooter="true" ShowGroupFooter="VisibleAlways" />
                        <SettingsBehavior AllowDragDrop="true" AllowFocusedRow="false" ConfirmDelete="false" />
                        <SettingsPager Visible="true" PageSize="20" AlwaysShowPager="true" Position="Bottom" ShowEmptyDataRows="true" />
                        <Paddings Padding="0px" />
                        <Border BorderWidth="0px" />
                        <BorderBottom BorderWidth="1px" />
                        <Columns>
                            <dx:GridViewDataColumn FieldName="Sube" Caption="Şube">
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="Sira" Caption="Sıra No">
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="SicilNo" Caption="Sicil No" CellStyle-HorizontalAlign="Right">
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="Unvan" Caption="Unvan">
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="SatOrgHTop" Caption="Sat. Org. H. Topl." CellStyle-HorizontalAlign="Right">
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="TescilTop" Caption="Tescil Topl." CellStyle-HorizontalAlign="Right">
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="TahakkukMuhTop" Caption="Tahakkuk Topl." CellStyle-HorizontalAlign="Right">
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                        </Columns>                       
                        <GroupSummary>
                            <dx:ASPxSummaryItem FieldName="SatOrgHTop" SummaryType="Sum" DisplayFormat="Sat. Org. H. Toplam = {0}"/>
                            <dx:ASPxSummaryItem FieldName="TescilTop" SummaryType="Sum" DisplayFormat="Tescil Toplam = {0}"/>
                            <dx:ASPxSummaryItem FieldName="TahakkukMuhTop" SummaryType="Sum" DisplayFormat="Tahakkuk Toplam = {0}"/>
                        </GroupSummary>
                    </dx:ASPxGridView>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>

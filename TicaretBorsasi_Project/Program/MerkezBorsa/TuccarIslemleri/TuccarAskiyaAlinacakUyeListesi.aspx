<%@ Page Title="" Language="C#" MasterPageFile="~/Master_Page/Main.master" AutoEventWireup="true" CodeBehind="TuccarAskiyaAlinacakUyeListesi.aspx.cs" Inherits="TicaretBorsasi_Project.Program.MerkezBorsa.TuccarIslemleri.TuccarAskiyaAlinacakUyeListesi" %>

<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridView.Export" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>

<asp:Content ContentPlaceHolderID="ContentPlaceHolderMiddleContent" runat="server">
    <script type="text/javascript">
        // <![CDATA[
        function ShowWindow() {
            PopupControlTuccarBilgiDetay.Show();
        }
        // ]]> 
    </script>
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
                    <dx:ASPxLabel runat="server" Text="Beyan Yılı : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxComboBox ID="ComboBoxYil" runat="server" ValueType="System.String" Width="200px" Font-Size="Small">
                        <ValidationSettings ValidationGroup="Ara" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxComboBox>
                </td>
                <td class="TdSolZorunlu" style="width: 15%">
                    <dx:ASPxLabel runat="server" Text="Tarih Aralığı : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag">
                    <table style="width: 400px;">
                        <tr>
                            <td>
                                <dx:ASPxDateEdit ID="DateEditBaslangic" runat="server" Font-Size="Small" Width="200">
                                    <ValidationSettings ValidationGroup="Ara" Display="Dynamic">
                                        <RequiredField ErrorText=" " IsRequired="true" />
                                    </ValidationSettings>
                                </dx:ASPxDateEdit>
                            </td>
                            <td style="padding-left: 5px;">
                                <dx:ASPxDateEdit ID="DateEditBitis" runat="server" Font-Size="Small" Width="200">
                                    <ValidationSettings ValidationGroup="Ara" Display="Dynamic">
                                        <RequiredField ErrorText=" " IsRequired="true" />
                                    </ValidationSettings>
                                </dx:ASPxDateEdit>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Liste Tipi : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxComboBox ID="ComboBoxListeTipi" runat="server" ValueType="System.String" Width="200px" Font-Size="Small">
                        <Items>
                            <dx:ListEditItem Text="Tümü" Value="0" />
                            <dx:ListEditItem Selected="true" Text="Sadece Askıya Alınacaklar" Value="1" />
                            <dx:ListEditItem Text="Sadece Askıda Olanlar" Value="2" />
                            <dx:ListEditItem Text="Sadece Faal Olanlar" Value="3" />
                        </Items>
                        <ValidationSettings ValidationGroup="Ara" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxComboBox>
                </td>
                <td class="TdOrtala" colspan="2"></td>
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
                    <dx:ASPxGridViewExporter ExportedRowType="All" GridViewID="GridViewAskiUyeArama" ID="GridViewExporterAskiUyeArama" runat="server">
                    </dx:ASPxGridViewExporter>
                    <dx:ASPxGridView ID="GridViewAskiUyeArama" ClientInstanceName="GridViewAskiUyeArama" runat="server" KeyFieldName="TuccarSicilKey" AutoGenerateColumns="false" Width="100%" Font-Size="Small">
                        <Settings ShowGroupPanel="true" />
                        <SettingsText ConfirmDelete="Silme işlemini onaylıyor musunuz?" />
                        <SettingsBehavior AllowDragDrop="true" AllowFocusedRow="false" ConfirmDelete="true" />
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
                            <dx:GridViewBandColumn Caption="İşlem">
                                <Columns>
                                    <dx:GridViewDataColumn FieldName="Islem1" Caption="">
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </dx:GridViewDataColumn>
                                    <dx:GridViewDataColumn FieldName="Islem2" Caption="">
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </dx:GridViewDataColumn>
                                </Columns>
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewBandColumn>
                            <dx:GridViewBandColumn Caption="Aidat Ödemesi">
                                <Columns>
                                    <dx:GridViewDataColumn FieldName="Aidat1" Caption="">
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </dx:GridViewDataColumn>
                                    <dx:GridViewDataColumn FieldName="Aidat2" Caption="">
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </dx:GridViewDataColumn>
                                </Columns>
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewBandColumn>
                        </Columns>
                    </dx:ASPxGridView>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>

<%@ Page Title="" Language="C#" MasterPageFile="~/Master_Page/Main.master" AutoEventWireup="true" CodeBehind="TuccarAidatDereceDegistirme.aspx.cs" Inherits="TicaretBorsasi_Project.Program.MerkezBorsa.TuccarIslemleri.TuccarAidatDereceDegistirme" %>

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
                <td class="TdOrtala" colspan="4">
                    <div style="float: left; margin-left: 38%;">
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
                <td class="TdOrtala" colspan="2" style="width: 50%">
                    <dx:ASPxGridView ID="GridViewTuccarListe" ClientInstanceName="GridViewTuccarListe" runat="server" KeyFieldName="TuccarSicilKey" AutoGenerateColumns="false" Width="100%" Font-Size="Small" OnRowCommand="GridViewTuccarListe_RowCommand">
                        <Settings ShowGroupPanel="false" />
                        <SettingsText ConfirmDelete="Silme işlemini onaylıyor musunuz?" />
                        <SettingsBehavior AllowDragDrop="False" AllowFocusedRow="False" ConfirmDelete="false" />
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
                            <dx:GridViewDataColumn FieldName="DereceAdi" Caption="Derecesi">
                                <CellStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn Caption="İşlemler">
                                <DataItemTemplate>
                                    <dx:ASPxButton ID="ButtonDereceListeEkle" runat="server" Image-Url="../../../Content/Images/Icons/send.png" Image-Height="24" Image-Width="24" RenderMode="Link" CommandArgument='<%# Eval("TuccarSicilKey") %>'></dx:ASPxButton>
                                </DataItemTemplate>
                                <CellStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                        </Columns>
                    </dx:ASPxGridView>
                </td>
                <td class="TdOrtala" colspan="2" style="vertical-align: top;">
                    <dx:ASPxGridViewExporter ExportedRowType="All" GridViewID="GridViewDereceDegistirilecek" ID="GridViewExporterDereceDegistirilecek" runat="server">
                    </dx:ASPxGridViewExporter>
                    <dx:ASPxGridView ID="GridViewDereceDegistirilecek" ClientInstanceName="GridViewDereceDegistirilecek" runat="server" KeyFieldName="TuccarSicilKey" AutoGenerateColumns="false" Width="100%" Font-Size="Small" OnRowCommand="GridViewDereceDegistirilecek_RowCommand">
                        <Settings ShowGroupPanel="false" />
                        <SettingsText ConfirmDelete="Silme işlemini onaylıyor musunuz?" />
                        <SettingsBehavior AllowDragDrop="False" AllowFocusedRow="False" ConfirmDelete="true" />
                        <SettingsPager Visible="true" PageSize="10" AlwaysShowPager="true" Position="Bottom" ShowEmptyDataRows="true" />
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
                            <dx:GridViewDataColumn FieldName="DereceAdi" Caption="Derecesi">
                                <CellStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn Caption="İşlemler">
                                <DataItemTemplate>
                                    <dx:ASPxButton ID="ButtonDereceListeKaldir" runat="server" Image-Url="../../../Content/Images/Icons/back.png" Image-Height="24" Image-Width="24" RenderMode="Link" CommandArgument='<%# Eval("TuccarSicilKey") %>'></dx:ASPxButton>
                                </DataItemTemplate>
                                <CellStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                        </Columns>
                    </dx:ASPxGridView>
                    <table style="border-color: #999999; width: 100%;" border="1">
                        <tr>
                            <td class="TdSolZorunlu" style="width: 15%;">
                                <dx:ASPxLabel runat="server" Text="Derece : " Font-Size="Small" ForeColor="Red" />
                            </td>
                            <td class="TdSag" style="width: 35%;">
                                <dx:ASPxComboBox ID="ComboBoxDereceDegisikligiDerece" runat="server" ValueType="System.String" Width="200px" Font-Size="Small" TextField="Kod" ValueField="DereceKey">
                                    <ValidationSettings ValidationGroup="DereceDegisikligiKayitGuncelle" Display="Dynamic">
                                        <RequiredField ErrorText=" " IsRequired="true" />
                                    </ValidationSettings>
                                </dx:ASPxComboBox>
                            </td>
                            <td class="TdSolZorunlu" style="width: 15%;">
                                <dx:ASPxLabel runat="server" Text="Derece Yıl : " Font-Size="Small" ForeColor="Red" />
                            </td>
                            <td class="TdSag" style="width: 35%;">
                                <dx:ASPxSpinEdit ID="SpinEditDereceDegisikligiDereceYil" runat="server" DecimalPlaces="0" Width="200px" Font-Size="Small" MaxLength="4" NumberType="Integer" AllowNull="false" MinValue="1900" MaxValue="2099" SpinButtons-ShowIncrementButtons="false">
                                    <SpinButtons ShowIncrementButtons="False"></SpinButtons>

                                    <ValidationSettings ValidationGroup="DereceDegisikligiKayitGuncelle" Display="Dynamic">
                                        <RequiredField ErrorText=" " IsRequired="true" />
                                    </ValidationSettings>
                                </dx:ASPxSpinEdit>
                            </td>
                        </tr>
                        <tr>
                            <td class="TdSol" style="width: 15%;">
                                <dx:ASPxLabel runat="server" Text="Y.K.K. Tarihi : " Font-Size="Small" />
                            </td>
                            <td class="TdSag" style="width: 35%;">
                                <dx:ASPxDateEdit ID="DateEditDereceDegisikligiYKKTarihi" runat="server" Font-Size="Small" Width="200">
                                </dx:ASPxDateEdit>
                            </td>
                            <td class="TdSol" style="width: 15%;">
                                <dx:ASPxLabel runat="server" Text="Y.K.K. No : " Font-Size="Small" />
                            </td>
                            <td class="TdSag" style="width: 35%;">
                                <dx:ASPxTextBox ID="TextBoxDereceDegisikligiYKKNo" runat="server" Width="200px" Font-Size="Small" MaxLength="50">
                                </dx:ASPxTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4" class="TdOrtala">
                                <div style="float: left; margin-left: 40%;">
                                    <dx:ASPxButton ID="ButtonDereceDegisikligiKaydet" runat="server" Text="Listedeki Dereceleri Değiştir" ValidationGroup="DereceDegisikligiKayitGuncelle" Width="120" Font-Size="Small" OnClick="ButtonDereceDegisikligiKaydet_Click" Enabled="false" />
                                </div>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
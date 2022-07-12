<%@ Page Title="" Language="C#" MasterPageFile="~/Master_Page/Main.master" AutoEventWireup="true" CodeBehind="TuccarCariIslemleri.aspx.cs" Inherits="TicaretBorsasi_Project.Program.MerkezBorsa.TuccarIslemleri.TuccarCariIslemleri" %>

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
                    <dx:ASPxLabel runat="server" Text="Liste Nevi : " Font-Size="Small" />
                </td>
                <td class="TdSag">
                    <dx:ASPxComboBox ID="ComboBoxListeNevi" runat="server" ValueType="System.String" Width="200px" Font-Size="Small" TextField="Aciklama" ValueField="BeyanTipKey">
                    </dx:ASPxComboBox>
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
                    <dx:ASPxLabel runat="server" Text="Diğer Borsa Alış Satış : " Font-Size="Small" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <asp:CheckBox ID="CheckBoxDigerBorsaAlisSatis" runat="server" CssClass="mycheckBig" />
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
                    <dx:ASPxGridViewExporter ExportedRowType="All" GridViewID="GridViewTuccarCariDefteri" ID="GridViewExporterTuccarCariDefteri" runat="server">
                    </dx:ASPxGridViewExporter>
                    <dx:ASPxGridView ID="GridViewTuccarCariDefteri" ClientInstanceName="GridViewTuccarCariDefteri" runat="server" KeyFieldName="BeyanKey" AutoGenerateColumns="false" Width="100%" Font-Size="Small">
                        <Settings ShowGroupPanel="true" />
                        <SettingsText ConfirmDelete="Silme işlemini onaylıyor musunuz?" />
                        <SettingsBehavior AllowDragDrop="true" AllowFocusedRow="false" ConfirmDelete="true" />
                        <SettingsPager Visible="true" PageSize="20" AlwaysShowPager="true" Position="Bottom" ShowEmptyDataRows="true" />
                        <Paddings Padding="0px" />
                        <Border BorderWidth="0px" />
                        <BorderBottom BorderWidth="1px" />
                        <Columns>
                            <dx:GridViewDataColumn FieldName="MaddeKodu" Caption="Madde Kodu">
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="Tarih" Caption="Tarih">
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="BeyanNo" Caption="Beyan No">
                                <CellStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="MaddeAdi" Caption="Madde">
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="MiktarAlis" Caption="Miktar">
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="BirimAdi" Caption="Birim">
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>                         
                            <dx:GridViewDataColumn FieldName="TutarAlis" Caption="Tutar">
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="" Caption="Tip">
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                        </Columns>
                    </dx:ASPxGridView>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
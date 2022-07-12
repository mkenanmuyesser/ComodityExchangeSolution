<%@ Page Title="" Language="C#" MasterPageFile="~/Master_Page/Main.master" AutoEventWireup="true" CodeBehind="TuccarAidatGenelDurum.aspx.cs" Inherits="TicaretBorsasi_Project.Program.MerkezBorsa.TuccarIslemleri.TuccarAidatGenelDurum" %>
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
                    <dx:ASPxLabel runat="server" Text="Sicil No : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <table>
                        <tr>
                            <td>
                                <dx:ASPxTextBox ID="TextBoxSicilNo" runat="server" Width="200px" Font-Size="Small" MaxLength="6">
                                    <MaskSettings Mask="999999" />
                                    <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                                        <RequiredField ErrorText=" " IsRequired="true" />
                                    </ValidationSettings>
                                </dx:ASPxTextBox>
                            </td>
                            <td>
                                <dx:ASPxButton ID="ButtonAra" runat="server" Text="Ara" OnClick="ButtonAra_Click"></dx:ASPxButton>
                            </td>
                            <td style="width: 9px">&nbsp;&nbsp; 
                            </td>
                            <td>
                                <dx:ASPxButton ID="ButtonGeri" runat="server" Text="<=" Font-Size="X-Small" OnClick="ButtonGeriIleri_Click"></dx:ASPxButton>
                            </td>
                            <td>
                                <dx:ASPxButton ID="ButtonIleri" runat="server" Text="=>" Font-Size="X-Small" OnClick="ButtonGeriIleri_Click"></dx:ASPxButton>
                            </td>
                        </tr>
                    </table>
                </td>
                <td class="TdSol" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Meslek Grubu : " Font-Size="Small" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxTextBox ID="TextBoxMeslekGrubu" runat="server" Width="200px" Font-Size="Small" Enabled="false">
                    </dx:ASPxTextBox>
                </td>
            </tr>
            <tr>
                <td class="TdSol" style="width: 15%;" rowspan="2">
                    <dx:ASPxLabel runat="server" Text="Unvan/Adı Soyadı : " Font-Size="Small" />
                </td>
                <td class="TdSag" style="width: 35%;" rowspan="2">
                    <dx:ASPxMemo ID="MemoUnvan" runat="server" Width="200px" Font-Size="Small" Rows="3" Enabled="false">
                    </dx:ASPxMemo>
                </td>
                <td class="TdSol" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Durumu : " Font-Size="Small" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxLabel ID="LabelDurum" runat="server" Text="" Font-Size="Small" ForeColor="Red" />
                </td>
            </tr>
            <tr>
                <td class="TdOrtala" colspan="4">
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
                    <dx:ASPxGridViewExporter ExportedRowType="All" GridViewID="GridViewAidatGenelDurum" ID="GridViewExporterAidatGenelDurum" runat="server">
                    </dx:ASPxGridViewExporter>
                    <dx:ASPxGridView ID="GridViewAidatGenelDurum" ClientInstanceName="GridViewAidatGenelDurum" runat="server" KeyFieldName="TuccarSicilKey" AutoGenerateColumns="false" Width="100%" Font-Size="Small" >
                        <Settings ShowGroupPanel="false" />
                        <SettingsText ConfirmDelete="Aidat iptal işlemini onaylıyor musunuz?" />
                        <SettingsBehavior AllowDragDrop="true" AllowFocusedRow="false" ConfirmDelete="true" />
                        <SettingsPager Visible="true" PageSize="20" AlwaysShowPager="true" Position="Bottom" ShowEmptyDataRows="true" />
                        <Paddings Padding="0px" />
                        <Border BorderWidth="0px" />
                        <BorderBottom BorderWidth="1px" />
                        <Columns>
                            <dx:GridViewDataColumn FieldName="Donem" Caption="Dönem">
                                <CellStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="DereceAdi" Caption="Derece">
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="AidatTutar" Caption="Aidat Tutarı">
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="OdenenCeza" Caption="Ödenen Ceza">
                                <CellStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="OdemeTarihi" Caption="Ödeme Tarihi">
                                <CellStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="Aciklama" Caption="Açıklama">
                                <CellStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <%--   <dx:GridViewCommandColumn Caption="İşlemler" ButtonType="Image">                               
                                <DeleteButton Visible="true" Image-ToolTip="İptal" Image-Url="../../../Content/Images/Icons/cancel.png" Image-Width="24" Image-Height="24"></DeleteButton>
                                <CellStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewCommandColumn>--%>
                        </Columns>
                    </dx:ASPxGridView>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
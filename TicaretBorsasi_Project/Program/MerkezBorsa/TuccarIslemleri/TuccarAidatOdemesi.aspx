<%@ Page Title="" Language="C#" MasterPageFile="~/Master_Page/Main.master" AutoEventWireup="true" CodeBehind="TuccarAidatOdemesi.aspx.cs" Inherits="TicaretBorsasi_Project.Program.MerkezBorsa.TuccarIslemleri.TuccarAidatOdemesi" %>

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
                                <dx:ASPxTextBox ID="TextBoxTuccarSicilNo" runat="server" Width="200px" Font-Size="Small" MaxLength="6">
                                    <MaskSettings Mask="<000000..999999>" />
                                    <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                                        <RequiredField ErrorText=" " IsRequired="true" />
                                    </ValidationSettings>
                                </dx:ASPxTextBox>
                            </td>
                            <td>
                                <dx:ASPxButton ID="ButtonTuccarAra" runat="server" Text="Ara" OnClick="ButtonAra_Click"></dx:ASPxButton>
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
                <td class="TdSol" style="width: 15%;" rowspan="2">
                    <dx:ASPxLabel runat="server" Text="Unvanı : " Font-Size="Small" />
                </td>
                <td class="TdSag" style="width: 35%;" rowspan="2">
                    <dx:ASPxMemo ID="MemoUnvan" runat="server" Width="200px" Font-Size="Small" Rows="3" Enabled="false">
                    </dx:ASPxMemo>
                </td>
            </tr>
            <tr>
                <td class="TdSol" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Meslek Grubu : " Font-Size="Small" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxTextBox ID="TextBoxMeslekGrubu" runat="server" Width="200px" Font-Size="Small" Enabled="false">
                    </dx:ASPxTextBox>
                </td>
            </tr>
            <tr>
                <td class="TdSol" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Durumu : " Font-Size="Small" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxLabel ID="LabelTuccarDurum" runat="server" Text="" Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSol" colspan="2"></td>
            </tr>
            <tr>
                <td colspan="4" class="TdOrtala">
                    <asp:Panel ID="PanelOdeme" runat="server" Visible="false">
                        <table style="border-color: #999999; width: 99.9%;" border="1">
                            <tr>
                                <td class="TdSol" style="width: 15%;">
                                    <dx:ASPxLabel runat="server" Text="Yıl : " Font-Size="Small" />
                                </td>
                                <td class="TdSag" style="width: 35%;">
                                    <dx:ASPxComboBox ID="ComboBoxYil" runat="server" ValueType="System.String" Width="200px" Font-Size="Small">
                                        <ValidationSettings ValidationGroup="Hesapla" Display="Dynamic">
                                            <RequiredField ErrorText=" " IsRequired="true" />
                                        </ValidationSettings>
                                    </dx:ASPxComboBox>
                                </td>
                                <td class="TdOrtala" colspan="2"></td>
                            </tr>
                            <tr>
                                <td class="TdSolZorunlu" style="width: 15%;">
                                    <dx:ASPxLabel runat="server" Text="1. Taksit : " Font-Size="Small" ForeColor="Red" />
                                </td>
                                <td class="TdSag" style="width: 35%;">
                                    <dx:ASPxSpinEdit ID="SpinEditTaksit1" runat="server" DecimalPlaces="2" Width="200px" Font-Size="Small" MaxLength="14" NumberType="Float" AllowNull="true" MinValue="0" SpinButtons-ShowIncrementButtons="false">
                                        <SpinButtons ShowIncrementButtons="False"></SpinButtons>
                                    </dx:ASPxSpinEdit>
                                </td>
                                <td class="TdSolZorunlu" style="width: 15%;">
                                    <dx:ASPxLabel runat="server" Text="2.Taksit : " Font-Size="Small" ForeColor="Red" />
                                </td>
                                <td class="TdSag" style="width: 35%;">
                                    <dx:ASPxSpinEdit ID="SpinEditTaksit2" runat="server" DecimalPlaces="2" Width="200px" Font-Size="Small" MaxLength="14" NumberType="Float" AllowNull="true" MinValue="0" SpinButtons-ShowIncrementButtons="false">
                                        <SpinButtons ShowIncrementButtons="False"></SpinButtons>
                                    </dx:ASPxSpinEdit>
                                </td>
                            </tr>
                            <tr>
                                <td class="TdSol" style="width: 15%;">
                                    <dx:ASPxLabel runat="server" Text="Aidat Toplamı : " Font-Size="Small" />
                                </td>
                                <td class="TdSag" style="width: 35%;">
                                    <dx:ASPxSpinEdit ID="SpinEditAidatToplam" runat="server" DecimalPlaces="2" Width="200px" Font-Size="Small" MaxLength="14" NumberType="Float" AllowNull="true" MinValue="0" SpinButtons-ShowIncrementButtons="false" Enabled="false">
                                        <SpinButtons ShowIncrementButtons="False"></SpinButtons>
                                    </dx:ASPxSpinEdit>
                                </td>
                                <td class="TdSol" style="width: 15%;">
                                    <dx:ASPxLabel runat="server" Text="Bugünkü Cezası : " Font-Size="Small" />
                                </td>
                                <td class="TdSag" style="width: 35%;">
                                    <dx:ASPxSpinEdit ID="SpinEditBugunkuCeza" runat="server" DecimalPlaces="2" Width="200px" Font-Size="Small" MaxLength="14" NumberType="Float" AllowNull="true" MinValue="0" SpinButtons-ShowIncrementButtons="false" Enabled="false">
                                        <SpinButtons ShowIncrementButtons="False"></SpinButtons>
                                    </dx:ASPxSpinEdit>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </td>
            </tr>
            <tr>
                <td colspan="4" class="TdOrtala">
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
                    <dx:ASPxGridViewExporter ExportedRowType="All" GridViewID="GridViewAidatOdeme" ID="GridViewExporterAidatOdeme" runat="server">
                    </dx:ASPxGridViewExporter>
                    <dx:ASPxGridView ID="GridViewAidatOdeme" ClientInstanceName="GridViewAidatOdeme" runat="server" KeyFieldName="AidatYili" AutoGenerateColumns="false" Width="100%" Font-Size="Small" OnCustomButtonCallback="GridViewAidatOdeme_CustomButtonCallback">
                        <%--OnRowDeleting="GridViewAidatOdeme_RowDeleting"--%>
                        <Settings ShowGroupPanel="true" ShowFooter="true" ShowGroupFooter="VisibleAlways" />
                        <SettingsBehavior AllowDragDrop="true" AllowFocusedRow="false" ConfirmDelete="false" />
                        <SettingsPager Visible="true" PageSize="20" AlwaysShowPager="true" Position="Bottom" ShowEmptyDataRows="true" />
                        <Paddings Padding="0px" />
                        <Border BorderWidth="0px" />
                        <BorderBottom BorderWidth="1px" />
                        <Columns>
                            <dx:GridViewDataColumn FieldName="AidatYili" Caption="Aidat Yılı">
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="Taksit1" Caption="1. Taksit (Ödenecek)">
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="Taksit2" Caption="2. Taksit (Ödenecek)">
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="AidatToplam" Caption="Aidat Toplamı">
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="Ceza" Caption="Bugünkü Ceza">
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="AidatCezaToplam" Caption="Aidat ve Ceza Toplam">
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewCommandColumn Caption="İşlemler" ButtonType="Image">
                                <CustomButtons>
                                    <dx:GridViewCommandColumnCustomButton Visibility="AllDataRows" Image-ToolTip="Öde" Image-Url="../../../Content/Images/Icons/send.png" Image-Width="24" Image-Height="24">
                                    </dx:GridViewCommandColumnCustomButton>
                                </CustomButtons>
                                <%-- <DeleteButton Visible="true" Image-ToolTip="Sil" Image-Url="../../../Content/Images/Icons/delete.png" Image-Width="24" Image-Height="24"></DeleteButton>--%>
                                <CellStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewCommandColumn>
                        </Columns>
                        <TotalSummary>
                            <dx:ASPxSummaryItem FieldName="AidatToplam" SummaryType="Sum" />
                            <dx:ASPxSummaryItem FieldName="Ceza" SummaryType="Sum" />
                            <dx:ASPxSummaryItem FieldName="AidatCezaToplam" SummaryType="Sum" />
                        </TotalSummary>
                    </dx:ASPxGridView>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
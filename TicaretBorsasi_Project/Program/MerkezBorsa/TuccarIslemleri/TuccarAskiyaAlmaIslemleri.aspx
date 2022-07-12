<%@ Page Title="" Language="C#" MasterPageFile="~/Master_Page/Main.master" AutoEventWireup="true" CodeBehind="TuccarAskiyaAlmaIslemleri.aspx.cs" Inherits="TicaretBorsasi_Project.Program.MerkezBorsa.TuccarIslemleri.TuccarAskiyaAlmaIslemleri" %>
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
                    <dx:ASPxLabel runat="server" Text="Üye Askı Durumu : " Font-Size="Small" />
                </td>
                <td class="TdSag" style="width: 35%">
                    <dx:ASPxRadioButtonList ID="RadioButtonListSecim" runat="server" ValueType="System.String" RepeatDirection="Horizontal" Font-Size="Small" Width="100%">
                        <Items>
                            <dx:ListEditItem Selected="true" Text="Askıya Alınmış Üyeler" Value="1" />
                            <dx:ListEditItem Text="Askıya Alınmamış/Askı Süresi Bitmiş Üyeler" Value="2" />
                        </Items>
                    </dx:ASPxRadioButtonList>
                </td>
                <td colspan="2"></td>
            </tr>
            <tr>
                <td class="TdSol" style="width: 15%">
                    <dx:ASPxLabel runat="server" Text="Sicil No : " Font-Size="Small" />
                </td>
                <td class="TdSag">
                    <dx:ASPxSpinEdit ID="SpinEditSicilNo" runat="server" DecimalPlaces="2" Width="200px" Font-Size="Small" MaxLength="6" NumberType="Integer" AllowNull="true" MinValue="0" SpinButtons-ShowIncrementButtons="false">
                    </dx:ASPxSpinEdit>
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
                    <div style="float: left; margin-left: 40%;">
                        <dx:ASPxButton ID="ButtonAra" runat="server" Text="Ara" Width="120" Font-Size="Small" OnClick="ButtonAra_Click" />
                        <dx:ASPxButton ID="ButtonTemizle" runat="server" Text="Temizle" Width="120" Font-Size="Small" OnClick="ButtonTemizle_Click" />
                    </div>
                    <div style="float: right;" >
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
                    <dx:ASPxGridViewExporter ExportedRowType="All" GridViewID="GridViewAskiyaAlma" ID="GridViewExporterAskiyaAlma" runat="server">
                    </dx:ASPxGridViewExporter>
                    <dx:ASPxGridView ID="GridViewAskiyaAlma" ClientInstanceName="GridViewAskiyaAlma" runat="server" KeyFieldName="TuccarAskiKey" Width="100%" AutoGenerateColumns="false" Font-Size="Small" OnRowCommand="GridViewAskiyaAlma_RowCommand">
                        <ClientSideEvents EndCallback="function(s, e) {
	                                                                        if (s.cpErrorMessage){
                                                                            delete s.cpErrorMessage;
		                                                                        alert('Silinmek istenen veri diğer kısımlarda kullanılmaktadır!');
                                                                                }
                                                                       }" />
                        <Settings ShowGroupPanel="false" />
                        <SettingsText ConfirmDelete="Silme işlemini onaylıyor musunuz?" />
                        <SettingsBehavior AllowDragDrop="False" AllowFocusedRow="False" ConfirmDelete="true" />
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
                                <CellStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="AskiTarihi" Caption="Askıya Alma Tarihi">
                                <CellStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="AskiKararNo" Caption="Askıya Alma Karar No">
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="AskiAciklama" Caption="Askı Alma Açıklaması">
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="BitisTarihi" Caption="Askı Bitiş Tarihi">
                                <CellStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="BitisKararNo" Caption="Askı Bitiş Karar No">
                                <CellStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="BitisAciklama" Caption="Askı Bitiş Açıklaması">
                                <CellStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn Caption="İşlemler" >
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
                    <dx:ASPxGridViewExporter ExportedRowType="All" GridViewID="GridViewAskiyaAlinacak" ID="GridViewExporterAskiyaAlinacak" runat="server">
                    </dx:ASPxGridViewExporter>
                    <dx:ASPxGridView ID="GridViewAskiyaAlinacak" ClientInstanceName="GridViewAskiyaAlinacak" runat="server" KeyFieldName="TuccarAskiKey" AutoGenerateColumns="false" Width="100%" Font-Size="Small" OnRowCommand="GridViewAskiyaAlinacak_RowCommand">
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
                                <CellStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="AskiTarihi" Caption="Askıya Alma Tarihi">
                                <CellStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="AskiKararNo" Caption="Askıya Alma Karar No">
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="AskiAciklama" Caption="Askı Alma Açıklaması">
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="BitisTarihi" Caption="Askı Bitiş Tarihi">
                                <CellStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="BitisKararNo" Caption="Askı Bitiş Karar No">
                                <CellStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="BitisAciklama" Caption="Askı Bitiş Açıklaması">
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
                            <td class="TdSol" style="width: 15%;">
                                <dx:ASPxLabel runat="server" Text="Askıya Alma Tarihi : " Font-Size="Small" />
                            </td>
                            <td class="TdSag" style="width: 35%;">
                                <dx:ASPxDateEdit ID="DateEditAskiTarihi" runat="server" Font-Size="Small" Width="200">
                                    <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                                        <RequiredField ErrorText=" " IsRequired="true" />
                                    </ValidationSettings>
                                </dx:ASPxDateEdit>

                            </td>
                            <td class="TdSol" style="width: 15%;" rowspan="2">
                                <dx:ASPxLabel runat="server" Text="Askı Alma Açıklaması : " Font-Size="Small" />
                            </td>
                            <td class="TdSag" style="width: 35%;" rowspan="2">
                                <dx:ASPxMemo ID="MemoAskiAciklama" runat="server" Height="50px" Width="200px" Font-Size="Small" MaxLength="200">
                                    <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                                        <RequiredField ErrorText=" " IsRequired="true" />
                                    </ValidationSettings>
                                </dx:ASPxMemo>
                            </td>
                        </tr>
                        <tr>
                            <td class="TdSol" style="width: 15%;">
                                <dx:ASPxLabel runat="server" Text="Askıya Alma Karar No : " Font-Size="Small" />
                            </td>
                            <td class="TdSag" style="width: 35%;">
                                <dx:ASPxTextBox ID="TextBoxAskiKararNo" runat="server" Width="200px" Font-Size="Small" MaxLength="50">
                                    <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                                        <RequiredField ErrorText=" " IsRequired="true" />
                                    </ValidationSettings>
                                </dx:ASPxTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="TdSol" style="width: 15%;">
                                <dx:ASPxLabel runat="server" Text="Askı Bitiş Tarihi : " Font-Size="Small" />
                            </td>
                            <td class="TdSag" style="width: 35%;">
                                <dx:ASPxDateEdit ID="DateEditBitisTarihi" runat="server" Font-Size="Small" Width="200">
                                    <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                                        <RequiredField ErrorText=" " IsRequired="false" />
                                    </ValidationSettings>
                                </dx:ASPxDateEdit>
                            </td>
                            <td class="TdSol" style="width: 15%;" rowspan="2">
                                <dx:ASPxLabel runat="server" Text="Askı Bitiş Açıklaması : " Font-Size="Small" />
                            </td>
                            <td class="TdSag" style="width: 35%;" rowspan="2">
                                <dx:ASPxMemo ID="MemoBitisAciklama" runat="server" Height="50px" Width="200px" Font-Size="Small" MaxLength="200">
                                    <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                                        <RequiredField ErrorText=" " IsRequired="false" />
                                    </ValidationSettings>
                                </dx:ASPxMemo>
                            </td>
                        </tr>
                        <tr>
                            <td class="TdSol" style="width: 15%;">
                                <dx:ASPxLabel runat="server" Text="Askı Bitiş Karar No : " Font-Size="Small" />
                            </td>
                            <td class="TdSag" style="width: 35%;">
                                <dx:ASPxTextBox ID="TextBoxBitisKararNo" runat="server" Width="200px" Font-Size="Small" MaxLength="50">
                                    <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                                        <RequiredField ErrorText=" " IsRequired="false" />
                                    </ValidationSettings>
                                </dx:ASPxTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4" class="TdOrtala">
                                <div id="divIslemler" runat="server" style="margin-left: 40%;">
                                    <dx:ASPxButton ID="ButtonAskiKaydet" runat="server" Text="Kaydet" ValidationGroup="KayitGuncelle" Width="120" Font-Size="Small" OnClick="ButtonAskiKaydetGuncelle_Click" />
                                </div>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
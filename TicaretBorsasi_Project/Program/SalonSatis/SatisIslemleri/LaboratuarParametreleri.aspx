<%@ Page Title="" Language="C#" MasterPageFile="~/Master_Page/Main.master" AutoEventWireup="true" CodeBehind="LaboratuarParametreleri.aspx.cs" Inherits="TicaretBorsasi_Project.Program.SalonSatis.SatisIslemleri.LaboratuarParametreleri" %>

<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridView.Export" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderMiddleContent" runat="server">
    <div style="margin: 1px; width: 99.9%;">
        <table style="border-color: #999999; width: 99.9%;" border="1">
            <tr>
                <td class="TdOrtala" colspan="4">
                    <center style="padding: 2px;">
                        <dx:ASPxLabel ID="LabelBaslik" runat="server" Font-Size="Large" />
                    </center>
                </td>
            </tr>
            <tr>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Kodu : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxTextBox ID="TextBoxKod" runat="server" Width="200px" Font-Size="Small" MaxLength="4">
                         <MaskSettings Mask="0000" />
                        <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="True" />
                        </ValidationSettings>
                    </dx:ASPxTextBox>
                </td>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Parametre Adı : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxTextBox ID="TextBoxParametreAdi" runat="server" Width="200px" Font-Size="Small" MaxLength="100">
                        <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="True" />
                        </ValidationSettings>
                    </dx:ASPxTextBox>
                </td>
            </tr>
            <tr>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="GRP : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">???
                </td>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Parametre Kısa Adı : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxTextBox ID="TextBoxParametreKisaAdi" runat="server" Width="200px" Font-Size="Small" MaxLength="50">
                        <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="True" />
                        </ValidationSettings>
                    </dx:ASPxTextBox>
                </td>
            </tr>
            <tr>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Grup No : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxTextBox ID="TextBoxGrupNo" runat="server" Width="200px" Font-Size="Small" MaxLength="2">
                         <MaskSettings Mask="00" />
                        <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="True" />
                        </ValidationSettings>
                    </dx:ASPxTextBox>
                </td>
                <td class="TdSol" style="width: 15%;"></td>
                <td class="TdSag" style="width: 35%;"></td>
            </tr>
            <tr>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Derece : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <asp:CheckBox ID="CheckBoxDerece" runat="server" CssClass="mycheckBig" />
                </td>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Ekran : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <asp:CheckBox ID="CheckBoxEkran" runat="server" CssClass="mycheckBig" />
                </td>
            </tr>
            <tr>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Fiyat : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <asp:CheckBox ID="CheckBoxFiyat" runat="server" CssClass="mycheckBig" />
                </td>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Alıma : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <asp:CheckBox ID="CheckBoxAlima" runat="server" CssClass="mycheckBig" />
                </td>
            </tr>
            <tr>
                <td colspan="5" class="TdOrtala">
                    <div style="float: left; margin-left: 40%;">
                        <dx:ASPxButton ID="ButtonKaydet" runat="server" Text="Kaydet" ValidationGroup="KayitGuncelle" Width="120" Font-Size="Small" Visible="false" OnClick="ButtonKaydetGuncelle_Click" />
                        <dx:ASPxButton ID="ButtonGuncelle" runat="server" Text="Güncelle" ValidationGroup="KayitGuncelle" Width="120" Font-Size="Small" Visible="false" OnClick="ButtonKaydetGuncelle_Click" />
                        <dx:ASPxButton ID="ButtonTemizle" runat="server" Text="Temizle" Width="120" Font-Size="Small" OnClick="ButtonIptalTemizle_Click" />
                        <dx:ASPxButton ID="ButtonIptal" runat="server" Text="İptal" Width="120" Font-Size="Small" OnClick="ButtonIptalTemizle_Click" />
                    </div>
                    <div style="float: right;">
                        <dx:ASPxButton ID="ButtonRapor" runat="server" Text="Rapor" Width="120" Font-Size="Small" OnClick="ButtonRapor_Click" />
                    </div>
                    <div style="float: right;">
                        <dx:ASPxComboBox ID="ComboBoxRapor" runat="server" Font-Size="Small" Width="70">
                            <Items>
                                <dx:ListEditItem Selected="true" Text="Excel" Value="Excel" />
                                <%--<dx:ListEditItem Text="Pdf" Value="Pdf" />--%>
                            </Items>
                        </dx:ASPxComboBox>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="TdOrtala" colspan="4">
                    <dx:ASPxGridViewExporter ExportedRowType="All" GridViewID="GridViewLaboratuarParametreleri" ID="GridViewExporterLaboratuarParametreleri" runat="server">
                    </dx:ASPxGridViewExporter>
                    <dx:ASPxGridView ID="GridViewLaboratuarParametreleri" runat="server" KeyFieldName="BorsaSubeKey" AutoGenerateColumns="false" Width="100%" EnableCallBacks="true" Font-Size="Small" OnRowDeleting="GridViewLaboratuarParametreleri_RowDeleting" OnCustomButtonCallback="GridViewLaboratuarParametreleri_CustomButtonCallback">
                        <ClientSideEvents EndCallback="function(s, e) {
	                                                                        if (s.cpErrorMessage){
                                                                            delete s.cpErrorMessage;
		                                                                        alert('Silinmek istenen veri diğer kısımlarda kullanılmaktadır!');
                                                                                }
                                                                       }" />
                        <Settings ShowGroupPanel="false" />
                        <SettingsText ConfirmDelete="Silme işlemini onaylıyor musunuz?" />
                        <SettingsBehavior AllowDragDrop="false" AllowFocusedRow="false" ConfirmDelete="true" />
                        <SettingsPager Visible="true" PageSize="15" AlwaysShowPager="true" Position="Bottom" ShowEmptyDataRows="true" />
                        <Paddings Padding="0px" />
                        <Border BorderWidth="0px" />
                        <BorderBottom BorderWidth="1px" />
                        <Columns>
                            <dx:GridViewBandColumn Caption="Laboratuar Parametreleri">
                                <Columns>
                                    <dx:GridViewDataColumn FieldName="" Caption="Kodu">
                                        <CellStyle HorizontalAlign="Center" />
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </dx:GridViewDataColumn>
                                    <dx:GridViewDataColumn FieldName="" Caption="Laboratuar Parametre Adı">
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </dx:GridViewDataColumn>
                                </Columns>
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewBandColumn>
                            <dx:GridViewDataColumn FieldName="" Caption="GRP">
                                <CellStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="" Caption="Parametre Kısa Adı">
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewBandColumn Caption="Analiz">
                                <Columns>
                                    <dx:GridViewDataColumn FieldName="" Caption="Grup No">
                                        <CellStyle HorizontalAlign="Center" />
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </dx:GridViewDataColumn>
                                </Columns>
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewBandColumn>
                            <dx:GridViewBandColumn Caption="TSE (?)">
                                <Columns>
                                    <dx:GridViewDataCheckColumn FieldName="" Caption="Derece">
                                        <CellStyle HorizontalAlign="Center" />
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </dx:GridViewDataCheckColumn>
                                    <dx:GridViewDataCheckColumn FieldName="" Caption="Ekran">
                                        <CellStyle HorizontalAlign="Center" />
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </dx:GridViewDataCheckColumn>
                                </Columns>
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewBandColumn>
                            <dx:GridViewBandColumn Caption="TMO (?)">
                                <Columns>
                                    <dx:GridViewDataCheckColumn FieldName="" Caption="Fiyat">
                                        <CellStyle HorizontalAlign="Center" />
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </dx:GridViewDataCheckColumn>
                                    <dx:GridViewDataCheckColumn FieldName="" Caption="Alıma">
                                        <CellStyle HorizontalAlign="Center" />
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </dx:GridViewDataCheckColumn>
                                </Columns>
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewBandColumn>
                            <dx:GridViewCommandColumn Caption="İşlemler" ButtonType="Image">
                                <CustomButtons>
                                    <dx:GridViewCommandColumnCustomButton Visibility="AllDataRows" Image-ToolTip="Düzenle" Image-Url="~/Content/Images/Icons/edit.png" Image-Width="24" Image-Height="24">
                                    </dx:GridViewCommandColumnCustomButton>
                                </CustomButtons>
                                <DeleteButton Visible="true" Image-ToolTip="Sil" Image-Url="~/Content/Images/Icons/delete.png" Image-Width="24" Image-Height="24"></DeleteButton>
                                <CellStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewCommandColumn>
                        </Columns>
                    </dx:ASPxGridView>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>

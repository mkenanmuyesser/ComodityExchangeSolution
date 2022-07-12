<%@ Page Title="" Language="C#" MasterPageFile="~/Master_Page/Main.master" AutoEventWireup="true" CodeBehind="RolIslemleri.aspx.cs" Inherits="TicaretBorsasi_Project.Program.ProgramIslem.RolIslemleri" %>

<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxTreeView" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxTabControl" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxClasses" TagPrefix="dx" %>
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
                    <dx:ASPxLabel runat="server" Text="Rol Adı : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxTextBox ID="TextBoxRolAdi" runat="server" Width="200px" Font-Size="Small" MaxLength="50">
                        <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxTextBox>
                </td>
                <td class="TdOrtala" colspan="2">&nbsp;
                </td>
            </tr>
            <tr>
                <td colspan="4" class="TdOrtala">
                    <div id="divIslemler" runat="server" style="float: left; margin-left: 40%;">
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
                    <dx:ASPxGridViewExporter ExportedRowType="All" GridViewID="GridViewRolIslem" ID="GridViewExporterRolIslem" runat="server">
                    </dx:ASPxGridViewExporter>
                    <dx:ASPxGridView ID="GridViewRolIslem" runat="server" KeyFieldName="RoleId" DataMember="RoleId" AutoGenerateColumns="false" Width="100%" EnableCallBacks="true" Font-Size="Small" OnRowDeleting="GridViewRolIslem_RowDeleting" OnCustomButtonCallback="GridViewRolIslem_CustomButtonCallback">
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
                            <dx:GridViewDataColumn FieldName="RoleName" Caption="Rolü">
                                <CellStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewCommandColumn Caption="İşlemler" ButtonType="Image">
                                <CustomButtons>
                                    <dx:GridViewCommandColumnCustomButton Visibility="AllDataRows" Image-ToolTip="Düzenle" Image-Url="../../../Content/Images/Icons/edit.png" Image-Width="24" Image-Height="24">
                                    </dx:GridViewCommandColumnCustomButton>
                                </CustomButtons>
                                <DeleteButton Visible="true" Image-ToolTip="Sil" Image-Url="../../../Content/Images/Icons/delete.png" Image-Width="24" Image-Height="24"></DeleteButton>
                                <CellStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewCommandColumn>
                        </Columns>
                    </dx:ASPxGridView>
                </td>
            </tr>
            <tr>
                <td class="TdOrtala" colspan="4">
                    <dx:ASPxPageControl runat="server" ActiveTabIndex="0" AutoPostBack="false" EnableCallBacks="true" ShowLoadingPanel="true" Width="99.9%" Font-Size="Small" EnableCallbackAnimation="True" LoadingPanelText="Yükleniyor&hellip;">
                        <TabPages>
                            <dx:TabPage Text="Merkez Borsa">
                                <ContentCollection>
                                    <dx:ContentControl ID="ContentControl3" runat="server">
                                        <dx:ASPxTreeView ID="TreeviewMerkezBorsa" runat="server">
                                            <Nodes>
                                                <dx:TreeViewNode Text="Merkez Borsa İşlemleri">
                                                    <Nodes>
                                                        <dx:TreeViewNode Text="Beyanname Tescil İşlemleri"></dx:TreeViewNode>
                                                        <dx:TreeViewNode Text="Muhasebe Bordro İşlemleri"></dx:TreeViewNode>
                                                        <dx:TreeViewNode Text="Muhtelif İşlemler"></dx:TreeViewNode>
                                                        <dx:TreeViewNode Text="Parametre Kodlu Bilgi İşlemleri">
                                                            <Nodes>
                                                                <dx:TreeViewNode Text="Derece Tablosu" />
                                                                <dx:TreeViewNode Text="İl ve İlçe Adları" />
                                                                <dx:TreeViewNode Text="Vergi Daireleri" />
                                                                <dx:TreeViewNode Text="Kuruluş Türleri" />
                                                                <dx:TreeViewNode Text="Ticaret Sicil Memurluğu" />
                                                                <dx:TreeViewNode Text="Meslek Grupları" />
                                                                <dx:TreeViewNode Text="Madde Kodları" />
                                                            </Nodes>
                                                        </dx:TreeViewNode>
                                                        <dx:TreeViewNode Text="Tüccar İşlemleri">
                                                            <Nodes>

                                                                <dx:TreeViewNode Text="Tüccar Sicil İşlemleri">
                                                                    <Nodes>
                                                                        <dx:TreeViewNode Text="Tüccar Sicil Kayıt İşlemleri" NavigateUrl="../Program/MerkezBorsa/TuccarIslemleri/TuccarSicilBilgiKayit.aspx" />
                                                                        <dx:TreeViewNode Text="Tüccar Sicil Arama İşlemleri" />
                                                                    </Nodes>
                                                                </dx:TreeViewNode>
                                                                <dx:TreeViewNode Text="*Tüccar Cari İşlemleri" />
                                                                <dx:TreeViewNode Text="Tüccar Depo İşlemleri">
                                                                    <Nodes>
                                                                        <dx:TreeViewNode Text="Tüccar Depo Kayıt İşlemleri" NavigateUrl="../Program/MerkezBorsa/TuccarIslemleri/TuccarDepoKayit.aspx" />
                                                                        <dx:TreeViewNode Text="Tüccar Depo Arama İşlemleri" />
                                                                        <dx:TreeViewNode Text="*Beyanlardan Tüccar Depo Yaratma" />
                                                                    </Nodes>
                                                                </dx:TreeViewNode>
                                                                <dx:TreeViewNode Text="*Tüccar Adres Etiketi İşlemleri" />
                                                                <dx:TreeViewNode Text="*Tüccar Seçimli Adres Etiketi İşlemleri" />
                                                                <dx:TreeViewNode Text="*Tüccar Kefalet veya Teminat İşlemleri" />
                                                                <dx:TreeViewNode Text="*Tüccar Aidat İşlemleri" />
                                                                <dx:TreeViewNode Text="*Tüccar Faaliyet Belgesi İşlemleri" />
                                                                <dx:TreeViewNode Text="Tüccar Liste İşlemleri">
                                                                    <Nodes>
                                                                        <dx:TreeViewNode Text="*Seçim Listeleri" />
                                                                        <dx:TreeViewNode Text="*Ticaret Sicil Memurluğu Listesi" />
                                                                        <dx:TreeViewNode Text="Tüccar Adresleri/Tel/Fax İşlemleri" />
                                                                        <dx:TreeViewNode Text="Üye Dağılımları" />
                                                                        <dx:TreeViewNode Text="*İlçe Seçim Listesi" />
                                                                        <dx:TreeViewNode Text="*Düz Tüccar Bilgileri" />
                                                                    </Nodes>
                                                                </dx:TreeViewNode>
                                                                <dx:TreeViewNode Text="Tüccar Askıya Alma İşlemleri">
                                                                    <Nodes>
                                                                        <dx:TreeViewNode Text="*Askıya Alınacak Üyeleri Bul" />
                                                                        <dx:TreeViewNode Text="Askıya Alma İşlemleri" />
                                                                    </Nodes>
                                                                </dx:TreeViewNode>
                                                                <dx:TreeViewNode Text="*Tüccar Stopaj Vergisi İşlemleri" />
                                                            </Nodes>
                                                        </dx:TreeViewNode>
                                                    </Nodes>
                                                </dx:TreeViewNode>
                                            </Nodes>
                                            <NodeTemplate>
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <%# Eval("Text") %>
                                                        </td>
                                                        <td>
                                                            <asp:CheckBox ID="CheckBoxOku" runat="server" CssClass="mycheckBig" Checked="true" Text="Oku" />
                                                        </td>
                                                        <td>
                                                            <asp:CheckBox ID="CheckBoxYaz" runat="server" CssClass="mycheckBig" Checked="true" Text="Sil" />
                                                        </td>
                                                        <td>
                                                            <asp:CheckBox ID="CheckBoxDuzenle" runat="server" CssClass="mycheckBig" Checked="true" Text="Kaydet/Düzenle" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </NodeTemplate>
                                        </dx:ASPxTreeView>
                                    </dx:ContentControl>
                                </ContentCollection>
                            </dx:TabPage>
                            <dx:TabPage Text="Canlı Hayvan Borsa">
                                <ContentCollection>
                                    <dx:ContentControl ID="ContentControl4" runat="server">
                                    </dx:ContentControl>
                                </ContentCollection>
                            </dx:TabPage>
                            <dx:TabPage Text="Süpürge Borsa">
                                <ContentCollection>
                                    <dx:ContentControl ID="ContentControl5" runat="server">
                                    </dx:ContentControl>
                                </ContentCollection>
                            </dx:TabPage>
                            <dx:TabPage Text="Toprak Tahlil Laboratuvar">
                                <ContentCollection>
                                    <dx:ContentControl ID="ContentControl6" runat="server">
                                    </dx:ContentControl>
                                </ContentCollection>
                            </dx:TabPage>
                            <dx:TabPage Text="Salon Satış">
                                <ContentCollection>
                                    <dx:ContentControl ID="ContentControl7" runat="server">
                                    </dx:ContentControl>
                                </ContentCollection>
                            </dx:TabPage>
                            <dx:TabPage Text="Program İşlem">
                                <ContentCollection>
                                    <dx:ContentControl ID="ContentControl8" runat="server">
                                        <dx:ASPxTreeView ID="TreeviewProgramIslem" runat="server">
                                            <Nodes>
                                                <dx:TreeViewNode Text="Program İşlemleri">
                                                    <Nodes>
                                                        <dx:TreeViewNode Text="*Program Ayarları" />
                                                        <dx:TreeViewNode Text="Kullanıcı ve Yetki İşlemleri" />
                                                        <dx:TreeViewNode Text="*Programlar" />
                                                        <dx:TreeViewNode Text="*Datalar" />
                                                    </Nodes>
                                                </dx:TreeViewNode>
                                            </Nodes>
                                            <NodeTemplate>
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <%# Eval("Text") %>
                                                        </td>
                                                        <td>
                                                            <asp:CheckBox ID="CheckBoxOku" runat="server" CssClass="mycheckBig" Checked="true" Text="Oku" />
                                                        </td>
                                                        <td>
                                                            <asp:CheckBox ID="CheckBoxYaz" runat="server" CssClass="mycheckBig" Checked="true" Text="Sil" />
                                                        </td>
                                                        <td>
                                                            <asp:CheckBox ID="CheckBoxDuzenle" runat="server" CssClass="mycheckBig" Checked="true" Text="Kaydet/Düzenle" /></td>
                                                    </tr>
                                                </table>
                                            </NodeTemplate>
                                        </dx:ASPxTreeView>
                                    </dx:ContentControl>
                                </ContentCollection>
                            </dx:TabPage>
                        </TabPages>
                    </dx:ASPxPageControl>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>

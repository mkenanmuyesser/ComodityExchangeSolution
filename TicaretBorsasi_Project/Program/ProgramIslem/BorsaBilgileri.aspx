<%@ Page Title="" Language="C#" MasterPageFile="~/Master_Page/Main.master" AutoEventWireup="true" CodeBehind="BorsaBilgileri.aspx.cs" Inherits="TicaretBorsasi_Project.Program.ProgramIslem.BorsaBilgileri" %>
<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxUploadControl" TagPrefix="dx" %>
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
                <td class="TdSol" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Resim : " Font-Size="Medium" />
                </td>
                <td>
                    <table>
                        <tr>
                            <td>
                                <dx:ASPxUploadControl ID="UploadControlResim" runat="server" UploadMode="Standard" Width="290" ShowProgressPanel="true" Font-Size="Medium" ValidateRequestMode="Enabled">
                                    <ValidationSettings AllowedFileExtensions="Resim Dosyaları|*.jpg;*.jpeg;*.png;*.bmp;" NotAllowedFileExtensionErrorText=" " MaxFileSize="2097152"></ValidationSettings>
                                    <AdvancedModeSettings EnableMultiSelect="false" PacketSize="2097152" />
                                </dx:ASPxUploadControl>
                            </td>
                            <td>
                                <span style="color: red">&nbsp;&nbsp;(max 2mb)</span>
                            </td>
                        </tr>
                    </table>
                </td>
                <td colspan="2" style="text-align: right;">
                    <dx:ASPxBinaryImage ID="BinaryImageResim" runat="server" Width="64" Height="64" EmptyImage-Url="../../Content/Images/Icons/empty.png" BackgroundImage-Repeat="NoRepeat" ImageAlign="Middle" Border-BorderWidth="1">
                    </dx:ASPxBinaryImage>
                </td>
            </tr>
            <tr>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Program Başlık : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxTextBox ID="TextBoxProgramBaslik" runat="server" Width="200px" Font-Size="Small" MaxLength="50">
                        <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxTextBox>
                </td>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Borsa Adı : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxTextBox ID="TextBoxBorsaAdi" runat="server" Width="200px" Font-Size="Small" MaxLength="50">
                        <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxTextBox>
                </td>
            </tr>
            <tr>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="TOBB Kodu : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxTextBox ID="TextBoxTOBBKodu" runat="server" Width="200px" Font-Size="Small" MaxLength="50">
                        <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxTextBox>
                </td>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="TOBB Kurum Tipi : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxTextBox ID="TextBoxTOBBKurumTipi" runat="server" Width="200px" Font-Size="Small" MaxLength="1">
                        <MaskSettings Mask="<0..9>" />
                        <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxTextBox>
                </td>
            </tr>
            <tr>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Kuruluş Tarihi : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxDateEdit ID="DateEditKurulusTarihi" runat="server" Font-Size="Small" Width="200">
                        <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxDateEdit>
                </td>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Işyeri Sicil No : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxTextBox ID="TextBoxIsyeriSicilNo" runat="server" Width="200px" Font-Size="Small" MaxLength="50">
                        <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxTextBox>
                </td>
            </tr>
            <tr>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Genel Sekreter : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxTextBox ID="TextBoxGenelSekreter" runat="server" Width="200px" Font-Size="Small" MaxLength="50">
                        <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxTextBox>
                </td>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Yonetim Kurulu Başkanı : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxTextBox ID="TextBoxYonetimKuruluBaskani" runat="server" Width="200px" Font-Size="Small" MaxLength="50">
                        <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxTextBox>
                </td>
            </tr>
            <tr>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Meclis Başkanı : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxTextBox ID="TextBoxMeclisBaskani" runat="server" Width="200px" Font-Size="Small" MaxLength="50">
                        <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxTextBox>
                </td>
                <td class="TdSolZorunlu" style="width: 15%;" rowspan="2">
                    <dx:ASPxLabel runat="server" Text="Borsa Adresi : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;" rowspan="2">
                    <dx:ASPxMemo ID="MemoBorsaAdres" runat="server" Height="50px" Width="200px" Font-Size="Small" MaxLength="100">
                        <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxMemo>
                </td>
            </tr>
            <tr>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Muracaat Mercii : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxTextBox ID="TextBoxMuracaatMercii" runat="server" Width="200px" Font-Size="Small" MaxLength="50">
                        <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxTextBox>
                </td>
            </tr>
            <tr>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Telefon 1 : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxTextBox ID="TextBoxTelefon1" runat="server" Width="200px" Font-Size="Small" MaxLength="20">
                        <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxTextBox>
                </td>
                <td class="TdSol" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Telefon 2 : " Font-Size="Small" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxTextBox ID="TextBoxTelefon2" runat="server" Width="200px" Font-Size="Small" MaxLength="20">
                    </dx:ASPxTextBox>
                </td>
            </tr>
            <tr>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Fax 1 : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxTextBox ID="TextBoxFax1" runat="server" Width="200px" Font-Size="Small" MaxLength="20">
                        <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxTextBox>
                </td>
                <td class="TdSol" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Fax 2 : " Font-Size="Small" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxTextBox ID="TextBoxFax2" runat="server" Width="200px" Font-Size="Small" MaxLength="20">
                    </dx:ASPxTextBox>
                </td>
            </tr>
            <tr>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="E-mail : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxTextBox ID="TextBoxEmail" runat="server" Width="200px" Font-Size="Small" MaxLength="20">
                        <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxTextBox>
                </td>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Üye Teminat Tipi : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxComboBox ID="ComboBoxUyeTeminatTip" runat="server" ValueType="System.Int32" Width="200px" Font-Size="Small" TextField="UyeTeminatTipAdi" ValueField="UyeTeminatTipiKey">
                        <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxComboBox>
                </td>
            </tr>
            <tr>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Geç Tescil : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <asp:CheckBox ID="CheckBoxGecTescil" runat="server" CssClass="mycheckBig" />
                </td>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Geç Tescil 30 Gün Beyan : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <asp:CheckBox ID="CheckBoxGecTescil30GunBeyan" runat="server" CssClass="mycheckBig" />
                </td>
            </tr>
            <tr>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Teşekkül No : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxTextBox ID="TextBoxTesekkulNo" runat="server" Width="200px" Font-Size="Small" MaxLength="10">
                        <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxTextBox>
                </td>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Tas. Tes. No : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxTextBox ID="TextBoxTasTesNo" runat="server" Width="200px" Font-Size="Small" MaxLength="10">
                        <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxTextBox>
                </td>
            </tr>
            <tr>
                <td colspan="4" class="TdOrtala">
                    <div id="divIslemler" runat="server" style="margin-left: 40%;">
                        <dx:ASPxButton ID="ButtonGuncelle" runat="server" Text="Güncelle" ValidationGroup="KayitGuncelle" Width="120" Font-Size="Small" OnClick="ButtonKaydetGuncelle_Click" />
                        <dx:ASPxButton ID="ButtonIptal" runat="server" Text="İptal" Width="120" Font-Size="Small" OnClick="ButtonIptal_Click" />
                    </div>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
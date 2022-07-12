<%@ Page Title="" Language="C#" MasterPageFile="~/Master_Page/Main.master" AutoEventWireup="true" CodeBehind="BeyannameTescilIslemleri.aspx.cs" Inherits="TicaretBorsasi_Project.Program.MerkezBorsa.BeyannameTescilIslemleri.BeyannameTescilIslemleri" %>

<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderMiddleContent" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div style="margin: 1px; width: 99.9%;">
                <table style="border-color: #999999; width: 99.9%;" border="1">
                    <tr>
                        <td class="TdOrtala" colspan="4">
                            <center>
                        <dx:ASPxLabel ID="LabelBaslik" runat="server" Font-Size="Large" />
                    </center>
                        </td>
                    </tr>
                    <tr>
                        <td class="TdSolZorunlu" style="width: 15%;">
                            <dx:ASPxLabel runat="server" Text="Beyanname Tipi : " Font-Size="Small" ForeColor="Red" />
                        </td>
                        <td class="TdSag" style="width: 35%;">
                            <dx:ASPxComboBox ID="ComboBoxBeyannameTipi" runat="server" ValueType="System.Byte" Width="200px" Font-Size="Small" TextField="BeyanTipAdi" ValueField="BeyanTipKey" AutoPostBack="true" OnSelectedIndexChanged="ComboBoxBeyannameTipi_SelectedIndexChanged" IncrementalFilteringMode="StartsWith" TabIndex="1">
                                <ValidationSettings ValidationGroup="Ara" Display="Dynamic">
                                    <RequiredField ErrorText=" " IsRequired="true" />
                                </ValidationSettings>
                            </dx:ASPxComboBox>
                        </td>
                        <td class="TdSolZorunlu" style="width: 15%;">
                            <dx:ASPxLabel runat="server" Text="Şube : " Font-Size="Small" ForeColor="Red" />
                        </td>
                        <td class="TdSag" style="width: 35%;">
                            <dx:ASPxComboBox ID="ComboBoxSube" runat="server" ValueType="System.Int32" Width="200px" Font-Size="Small" TextField="BorsaSubeAdi" ValueField="BorsaSubeKey" IncrementalFilteringMode="StartsWith" TabIndex="1">
                                <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                                    <RequiredField ErrorText=" " IsRequired="true" />
                                </ValidationSettings>
                            </dx:ASPxComboBox>
                        </td>

                    </tr>
                    <asp:Panel runat="server" ID="PanelTescil" Enabled="false">
                        <tr>
                            <td class="TdSolZorunlu" style="width: 15%;">
                                <dx:ASPxLabel runat="server" Text="Yılı : " Font-Size="Small" ForeColor="Red" />
                            </td>
                            <td class="TdSag" style="width: 35%;">
                                <dx:ASPxComboBox ID="ComboBoxYili" runat="server" ValueType="System.String" Width="200px" Font-Size="Small" IncrementalFilteringMode="StartsWith" TabIndex="2">
                                </dx:ASPxComboBox>
                            </td>
                            <td class="TdSolZorunlu" style="width: 15%;">
                                <dx:ASPxLabel runat="server" Text="Tescil No : " Font-Size="Small" ForeColor="Red" />
                            </td>
                            <td class="TdSag" style="width: 35%;">
                                <table>
                                    <tr>
                                        <td>
                                            <dx:ASPxTextBox ID="TextBoxTescilKodu" runat="server" Width="200px" Font-Size="Small" MaxLength="6" TabIndex="2" OnTextChanged="TextBoxTescilKodu_TextChanged" AutoPostBack="True">
                                                <MaskSettings Mask="999999" />
                                                <ValidationSettings ValidationGroup="Ara" Display="Dynamic">
                                                    <RequiredField ErrorText=" " IsRequired="true" />
                                                </ValidationSettings>
                                            </dx:ASPxTextBox>
                                        </td>
                                        <td>
                                            <dx:ASPxButton ID="ButtonTescilAra" runat="server" Text="Ara" OnClick="ButtonTescilAra_Click" UseSubmitBehavior="False"></dx:ASPxButton>
                                        </td>
                                        <td style="width: 9px">&nbsp;&nbsp; 
                                        </td>
                                        <td>
                                            <dx:ASPxButton ID="ButtonTescilGeri" runat="server" Text="<=" Font-Size="X-Small" OnClick="ButtonGeriIleri_Click" UseSubmitBehavior="False"></dx:ASPxButton>
                                        </td>
                                        <td>
                                            <dx:ASPxButton ID="ButtonTescilIleri" runat="server" Text="=>" Font-Size="X-Small" OnClick="ButtonGeriIleri_Click" UseSubmitBehavior="False"></dx:ASPxButton>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td class="TdSolZorunlu" style="width: 15%;">
                                <dx:ASPxLabel runat="server" Text="Tarih : " Font-Size="Small" ForeColor="Red" />
                            </td>
                            <td class="TdSag" style="width: 35%;">
                                <dx:ASPxDateEdit ID="DateEditBeyanTarihi" runat="server" Font-Size="Small" Width="200" TabIndex="3">
                                    <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                                        <RequiredField ErrorText=" " IsRequired="true" />
                                    </ValidationSettings>
                                </dx:ASPxDateEdit>
                            </td>
                            <td class="TdSolZorunlu" style="width: 15%;" rowspan="2">
                                <dx:ASPxLabel runat="server" Text="Unvan : " Font-Size="Small" ForeColor="Red" />
                            </td>
                            <td class="TdSag" style="width: 35%;" rowspan="2">
                                <dx:ASPxMemo ID="MemoUnvan" runat="server" Width="300px" Font-Size="Small" MaxLength="2500" Rows="3" Enabled="false">
                                    <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                                        <RequiredField ErrorText=" " IsRequired="true" />
                                    </ValidationSettings>
                                </dx:ASPxMemo>
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
                                            <dx:ASPxTextBox ID="TextBoxSicilNo" runat="server" Width="200px" Font-Size="Small" MaxLength="6" TabIndex="4" OnTextChanged="TextBoxSicilNo_TextChanged" AutoPostBack="True">
                                                <MaskSettings Mask="999999" />
                                                <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                                                    <RequiredField ErrorText=" " IsRequired="true" />
                                                </ValidationSettings>
                                            </dx:ASPxTextBox>
                                        </td>
                                        <td>
                                            <dx:ASPxButton ID="ButtonSicilAra" runat="server" Text="Ara" OnClick="ButtonAra_Click" UseSubmitBehavior="False"></dx:ASPxButton>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td class="TdSolZorunlu" style="width: 15%;">
                                <dx:ASPxLabel runat="server" Text="Beyan Satır No : " Font-Size="Small" ForeColor="Red" />
                            </td>
                            <td class="TdSag" style="width: 35%;">
                                <dx:ASPxSpinEdit ID="SpinEditBeyanSatirNo" runat="server" DecimalPlaces="0" Width="200px" Font-Size="Small" MaxLength="2" NumberType="Integer" AllowNull="true" MinValue="1" MaxValue="99" SpinButtons-ShowIncrementButtons="false" TabIndex="5">
                                    <SpinButtons ShowIncrementButtons="False"></SpinButtons>
                                </dx:ASPxSpinEdit>
                            </td>
                            <td class="TdSolZorunlu" style="width: 15%;">
                                <dx:ASPxLabel runat="server" Text="Toplam Satır : " Font-Size="Small" ForeColor="Red" />
                            </td>
                            <td class="TdSag" style="width: 35%;">
                                <dx:ASPxSpinEdit ID="SpinEditToplamSatir" runat="server" DecimalPlaces="0" Width="200px" Font-Size="Small" MaxLength="2" NumberType="Integer" AllowNull="true" MinValue="1" MaxValue="99" SpinButtons-ShowIncrementButtons="false" TabIndex="6">
                                    <SpinButtons ShowIncrementButtons="False"></SpinButtons>
                                </dx:ASPxSpinEdit>
                            </td>
                        </tr>
                        <tr>
                            <td class="TdSolZorunlu" style="width: 15%;">
                                <dx:ASPxLabel runat="server" Text="Satış Şekli : " Font-Size="Small" ForeColor="Red" />
                            </td>
                            <td class="TdSag" style="width: 35%;">
                                <dx:ASPxComboBox ID="ComboBoxSatisSekli" runat="server" ValueType="System.Int32" Width="200px" Font-Size="Small" TextField="SatisSekliAdi" ValueField="SatisSekliKey" IncrementalFilteringMode="StartsWith" TabIndex="7">
                                    <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                                        <RequiredField ErrorText=" " IsRequired="true" />
                                    </ValidationSettings>
                                </dx:ASPxComboBox>
                            </td>
                            <td class="TdSolZorunlu" style="width: 15%;">
                                <dx:ASPxLabel runat="server" Text="Sayısı: " Font-Size="Small" ForeColor="Red" />
                            </td>
                            <td class="TdSag" style="width: 35%;">
                                <dx:ASPxSpinEdit ID="SpinEditSayisi" runat="server" DecimalPlaces="0" Width="200px" Font-Size="Small" MaxLength="2" NumberType="Integer" AllowNull="true" MinValue="1" MaxValue="99" SpinButtons-ShowIncrementButtons="false" TabIndex="8">
                                    <SpinButtons ShowIncrementButtons="False"></SpinButtons>
                                </dx:ASPxSpinEdit>
                            </td>
                        </tr>
                        <tr>
                            <td class="TdSolZorunlu" style="width: 15%;">
                                <dx:ASPxLabel runat="server" Text="Alıcı Firma No : " Font-Size="Small" ForeColor="Red" />
                            </td>
                            <td class="TdSag" style="width: 35%;">
                                <table>
                                    <tr>
                                        <td>
                                            <dx:ASPxTextBox ID="TextBoxAliciSicilNo" runat="server" Width="200px" Font-Size="Small" MaxLength="6" OnTextChanged="TextBoxSicilNo_TextChanged" TabIndex="9" AutoPostBack="True">
                                                <MaskSettings Mask="999999" />
                                                <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                                                    <RequiredField ErrorText=" " IsRequired="true" />
                                                </ValidationSettings>
                                            </dx:ASPxTextBox>
                                        </td>
                                        <td>
                                            <dx:ASPxButton ID="ButtonAliciSicilAra" runat="server" Text="Ara" OnClick="ButtonAra_Click" UseSubmitBehavior="False"></dx:ASPxButton>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td class="TdSolZorunlu" style="width: 15%;" rowspan="2">
                                <dx:ASPxLabel runat="server" Text="Unvan : " Font-Size="Small" ForeColor="Red" />
                            </td>
                            <td class="TdSag" style="width: 35%;" rowspan="2">
                                <dx:ASPxMemo ID="MemoAliciUnvan" runat="server" Width="300px" Font-Size="Small" MaxLength="2500" Rows="3" Enabled="false">
                                    <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                                        <RequiredField ErrorText=" " IsRequired="true" />
                                    </ValidationSettings>
                                </dx:ASPxMemo>
                            </td>
                        </tr>
                        <tr>
                            <td class="TdSolZorunlu" style="width: 15%;">
                                <dx:ASPxLabel runat="server" Text="Vergi No : " Font-Size="Small" ForeColor="Red" />
                            </td>
                            <td class="TdSag" style="width: 35%;">
                                <dx:ASPxSpinEdit ID="SpinEditVergiNo" runat="server" DecimalPlaces="0" Width="200px" Font-Size="Small" MaxLength="11" NumberType="Integer" AllowNull="true" MinValue="0" SpinButtons-ShowIncrementButtons="false" TabIndex="10">
                                    <SpinButtons ShowIncrementButtons="False"></SpinButtons>
                                </dx:ASPxSpinEdit>
                            </td>
                        </tr>
                        <tr>
                            <td class="TdSolZorunlu" style="width: 15%;">
                                <dx:ASPxLabel runat="server" Text="Vergi Dairesi : " Font-Size="Small" ForeColor="Red" />
                            </td>
                            <td class="TdSag" style="width: 35%;">
                                <dx:ASPxComboBox ID="ComboBoxVergiDairesi" runat="server" ValueType="System.Int32" Width="200px" Font-Size="Small" TextField="VergiDairesiAdi" ValueField="VergiDaireKey" IncrementalFilteringMode="StartsWith" TabIndex="11">
                                </dx:ASPxComboBox>
                            </td>
                            <td class="TdSolZorunlu" colspan="2"></td>
                        </tr>
                        <tr>
                            <td class="TdSolZorunlu" style="width: 15%;">
                                <dx:ASPxLabel runat="server" Text="Emtia Adı : " Font-Size="Small" ForeColor="Red" />
                            </td>
                            <td class="TdSag" style="width: 35%;">
                                <dx:ASPxTextBox ID="TextBoxEmtiaAdi" runat="server" Width="200px" Font-Size="Small" MaxLength="50" TabIndex="12">
                                </dx:ASPxTextBox>
                            </td>
                            <td class="TdSolZorunlu" style="width: 15%;">
                                <dx:ASPxLabel runat="server" Text="Miktarı : " Font-Size="Small" ForeColor="Red" />
                            </td>
                            <td class="TdSag" style="width: 35%;">
                                <dx:ASPxSpinEdit ID="SpinEditMiktar" runat="server" DecimalPlaces="0" Width="200px" Font-Size="Small" MaxLength="10" NumberType="Integer" AllowNull="true" MinValue="0" SpinButtons-ShowIncrementButtons="false" TabIndex="14">
                                    <SpinButtons ShowIncrementButtons="False"></SpinButtons>
                                </dx:ASPxSpinEdit>
                            </td>
                        </tr>
                        <tr>
                            <td class="TdSolZorunlu" style="width: 15%;">
                                <dx:ASPxLabel runat="server" Text="Birimi : " Font-Size="Small" ForeColor="Red" />
                            </td>
                            <td class="TdSag" style="width: 35%;">
                                <dx:ASPxComboBox ID="ComboBoxBirim" runat="server" ValueType="System.Byte" Width="200px" Font-Size="Small" TextField="Kod" ValueField="BirimTipKey" IncrementalFilteringMode="StartsWith" TabIndex="13">
                                    <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                                        <RequiredField ErrorText=" " IsRequired="true" />
                                    </ValidationSettings>
                                </dx:ASPxComboBox>
                            </td>
                            <td class="TdSolZorunlu" style="width: 15%;">
                                <dx:ASPxLabel runat="server" Text="Fiyatı : " Font-Size="Small" ForeColor="Red" />
                            </td>
                            <td class="TdSag" style="width: 35%;">
                                <dx:ASPxSpinEdit ID="SpinEditFiyat" runat="server" DecimalPlaces="4" Width="200px" Font-Size="Small" MaxLength="14" NumberType="Float" AllowNull="true" MinValue="0" SpinButtons-ShowIncrementButtons="false" TabIndex="15">
                                    <SpinButtons ShowIncrementButtons="False"></SpinButtons>
                                </dx:ASPxSpinEdit>
                            </td>
                        </tr>
                        <tr>
                            <td class="TdOrtala" colspan="2"></td>
                            <td class="TdSolZorunlu" style="width: 15%;">
                                <dx:ASPxLabel runat="server" Text="Tutarı : " Font-Size="Small" ForeColor="Red" />
                            </td>
                            <td class="TdSag" style="width: 35%;">
                                <dx:ASPxSpinEdit ID="SpinEditTutar" runat="server" DecimalPlaces="4" Width="200px" Font-Size="Small" MaxLength="14" NumberType="Float" AllowNull="true" MinValue="0" SpinButtons-ShowIncrementButtons="false" TabIndex="16">
                                    <SpinButtons ShowIncrementButtons="False"></SpinButtons>
                                </dx:ASPxSpinEdit>
                            </td>
                        </tr>
                        <tr>
                            <td class="TdSolZorunlu" style="width: 15%;">
                                <dx:ASPxLabel runat="server" Text="Fatura No : " Font-Size="Small" ForeColor="Red" />
                            </td>
                            <td class="TdSag" style="width: 35%;">
                                <dx:ASPxSpinEdit ID="SpinEditFaturaNo" runat="server" DecimalPlaces="0" Width="200px" Font-Size="Small" MaxLength="10" NumberType="Integer" AllowNull="true" MinValue="0" SpinButtons-ShowIncrementButtons="false" TabIndex="17">
                                    <SpinButtons ShowIncrementButtons="False"></SpinButtons>
                                </dx:ASPxSpinEdit>
                            </td>
                            <td style="width: 15%;">
                                <dx:ASPxLabel runat="server" Text="Fatura Tarihi : " Font-Size="Small" />
                            </td>
                            <td class="TdSag" style="width: 35%;">
                                <dx:ASPxDateEdit ID="DateEditFaturaTarihi" runat="server" Font-Size="Small" Width="200" AllowNull="true" TabIndex="18">
                                </dx:ASPxDateEdit>
                            </td>
                        </tr>
                        <tr>
                            <td class="TdSolZorunlu" style="width: 15%;">
                                <dx:ASPxLabel runat="server" Text="Menşei : " Font-Size="Small" ForeColor="Red" />
                            </td>
                            <td class="TdSag" style="width: 35%;">
                                <dx:ASPxTextBox ID="TextBoxMensei" runat="server" Width="200px" Font-Size="Small" MaxLength="50" TabIndex="19">
                                </dx:ASPxTextBox>
                            </td>
                            <td class="TdSolZorunlu" style="width: 15%;">
                                <dx:ASPxLabel runat="server" Text="Teslim Tarihi : " Font-Size="Small" ForeColor="Red" />
                            </td>
                            <td class="TdSag" style="width: 35%;">
                                <dx:ASPxDateEdit ID="DateEditTeslimTarihi" runat="server" Font-Size="Small" Width="200" TabIndex="22">
                                </dx:ASPxDateEdit>
                            </td>
                        </tr>
                        <tr>
                            <td class="TdSolZorunlu" style="width: 15%;">
                                <dx:ASPxLabel runat="server" Text="Tescil Ücreti : " Font-Size="Small" ForeColor="Red" />
                            </td>
                            <td class="TdSag" style="width: 35%;">
                                <dx:ASPxSpinEdit ID="SpinEditTescilUcreti" runat="server" DecimalPlaces="4" Width="200px" Font-Size="Small" MaxLength="14" NumberType="Float" AllowNull="true" MinValue="0" SpinButtons-ShowIncrementButtons="false" TabIndex="21">
                                    <SpinButtons ShowIncrementButtons="False"></SpinButtons>
                                </dx:ASPxSpinEdit>
                            </td>
                            <td rowspan="2" class="TdSol">
                                <dx:ASPxLabel runat="server" Text="Özel Şartlar : " Font-Size="Small" />

                            </td>
                            <td rowspan="2" class="TdSag">
                                <dx:ASPxMemo ID="MemoOzelSartlar" runat="server" Height="50px" Width="200px" Font-Size="Small" MaxLength="200" TabIndex="24">
                                </dx:ASPxMemo>
                            </td>
                        </tr>
                        <tr>
                            <td class="TdSolZorunlu" style="width: 15%;">
                                <dx:ASPxLabel runat="server" Text="Emtia No : " Font-Size="Small" ForeColor="Red" />
                            </td>
                            <td class="TdSag" style="width: 35%;">
                                <dx:ASPxComboBox ID="ComboBoxEmtia" runat="server" ValueType="System.Int32" Width="200px" Font-Size="Small" TextField="Adi" ValueField="MaddeKodKey" IncrementalFilteringMode="StartsWith" TabIndex="23">
                                    <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                                        <RequiredField ErrorText=" " IsRequired="true" />
                                    </ValidationSettings>
                                </dx:ASPxComboBox>
                            </td>

                        </tr>
                        <tr>
                            <td class="TdSolZorunlu" style="width: 15%;">
                                <dx:ASPxLabel runat="server" Text="Adet : " Font-Size="Small" ForeColor="Red" />
                            </td>
                            <td class="TdSag" style="width: 35%;">
                                <dx:ASPxSpinEdit ID="SpinEditAdet" runat="server" DecimalPlaces="0" Width="200px" Font-Size="Small" MaxLength="11" NumberType="Integer" AllowNull="true" MinValue="0" SpinButtons-ShowIncrementButtons="false" TabIndex="25">
                                    <SpinButtons ShowIncrementButtons="False"></SpinButtons>
                                </dx:ASPxSpinEdit>
                            </td>
                            <td class="TdSolZorunlu" style="width: 15%;">
                                <dx:ASPxLabel runat="server" Text="Teslim Mahalli : " Font-Size="Small" ForeColor="Red" />
                            </td>
                            <td class="TdSag" style="width: 35%;">
                                <dx:ASPxTextBox ID="TextBoxTeslimMahalli" runat="server" Width="200px" Font-Size="Small" MaxLength="50" TabIndex="26">
                                </dx:ASPxTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="TdOrtala" colspan="4">
                                <dx:ASPxLabel runat="server" Text="Beyanname Toplamları" Font-Size="Medium" />
                            </td>
                        </tr>
                        <tr>
                            <td class="TdSolZorunlu" style="width: 15%;">
                                <dx:ASPxLabel runat="server" Text="Tescil Toplamı : " Font-Size="Small" ForeColor="Red" />
                            </td>
                            <td class="TdSag" style="width: 35%;">
                                <dx:ASPxSpinEdit ID="SpinEditTescilToplam" runat="server" DecimalPlaces="0" Width="200px" Font-Size="Small" MaxLength="10" NumberType="Integer" AllowNull="true" MinValue="0" SpinButtons-ShowIncrementButtons="false" TabIndex="27">
                                    <SpinButtons ShowIncrementButtons="False"></SpinButtons>
                                </dx:ASPxSpinEdit>
                            </td>
                            <td class="TdSolZorunlu" style="width: 15%;">
                                <dx:ASPxLabel runat="server" Text="Beyanname Toplamı : " Font-Size="Small" ForeColor="Red" />
                            </td>
                            <td class="TdSag" style="width: 35%;">
                                <dx:ASPxSpinEdit ID="SpinEditBeyannameToplam" runat="server" DecimalPlaces="0" Width="200px" Font-Size="Small" MaxLength="10" NumberType="Integer" AllowNull="true" MinValue="0" SpinButtons-ShowIncrementButtons="false" TabIndex="28">
                                    <SpinButtons ShowIncrementButtons="False"></SpinButtons>
                                </dx:ASPxSpinEdit>
                            </td>
                        </tr>
                        <tr>
                            <td class="TdOrtala" colspan="2"></td>
                            <td class="TdSolZorunlu" style="width: 15%;">
                                <dx:ASPxLabel runat="server" Text="Kalan : " Font-Size="Small" ForeColor="Red" />
                            </td>
                            <td class="TdSag" style="width: 35%;">
                                <dx:ASPxSpinEdit ID="SpinEditKalan" runat="server" DecimalPlaces="0" Width="200px" Font-Size="Small" MaxLength="10" NumberType="Integer" AllowNull="true" MinValue="0" SpinButtons-ShowIncrementButtons="false" TabIndex="29">
                                    <SpinButtons ShowIncrementButtons="False"></SpinButtons>
                                </dx:ASPxSpinEdit>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4" class="TdOrtala">
                                <div id="divIslemler" runat="server" style="margin-left: 40%;">
                                    <asp:Panel ID="PanelKaydet" runat="server" Visible="false" DefaultButton="ButtonKaydet">
                                        <dx:ASPxButton ID="ButtonKaydet" runat="server" Text="Kaydet" ValidationGroup="KayitGuncelle" Width="120" Font-Size="Small" OnClick="ButtonKaydetGuncelle_Click" TabIndex="30" UseSubmitBehavior="True" />
                                        <dx:ASPxButton ID="ButtonTemizle" runat="server" Text="Temizle" Width="120" Font-Size="Small" OnClick="ButtonTemizle_Click" TabIndex="32" UseSubmitBehavior="False" />
                                    </asp:Panel>
                                    <asp:Panel ID="PanelGuncelle" runat="server" Visible="false" DefaultButton="ButtonGuncelle">
                                        <dx:ASPxButton ID="ButtonGuncelle" runat="server" Text="Güncelle" ValidationGroup="KayitGuncelle" Width="120" Font-Size="Small" OnClick="ButtonKaydetGuncelle_Click" TabIndex="31" UseSubmitBehavior="True" />
                                        <dx:ASPxButton ID="ButtonIptal" runat="server" Text="İptal" Width="120" Font-Size="Small" OnClick="ButtonIptal_Click" TabIndex="33" UseSubmitBehavior="False" />
                                    </asp:Panel>
                                </div>
                            </td>
                        </tr>
                    </asp:Panel>
                </table>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

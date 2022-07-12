<%@ Page Title="" Language="C#" MasterPageFile="~/Master_Page/Main.master" AutoEventWireup="true" CodeBehind="TuccarUyeAidatCezaOranlari.aspx.cs" Inherits="TicaretBorsasi_Project.Program.MerkezBorsa.TuccarIslemleri.TuccarUyeAidatCezaOranlari" %>
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
                    <dx:ASPxLabel runat="server" Text="Yıl : " Font-Size="Small" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxComboBox ID="ComboBoxYil" runat="server" ValueType="System.String" Width="200px" Font-Size="Small" AutoPostBack="true" OnSelectedIndexChanged="ComboBoxYil_SelectedIndexChanged">
                        <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxComboBox>
                </td>
                <td class="TdOrtala" colspan="2"></td>
            </tr>
            <tr>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Ocak : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxSpinEdit ID="SpinEditOcak" runat="server" DecimalPlaces="4" Width="200px" Font-Size="Small" MaxLength="5" NumberType="Float" AllowNull="true" MinValue="0" MaxValue="9" SpinButtons-ShowIncrementButtons="false">
                        <SpinButtons ShowIncrementButtons="False"></SpinButtons>
                        <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxSpinEdit>
                </td>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Temmuz : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxSpinEdit ID="SpinEditTemmuz" runat="server" DecimalPlaces="4" Width="200px" Font-Size="Small" MaxLength="5" NumberType="Float" AllowNull="true" MinValue="0" MaxValue="9" SpinButtons-ShowIncrementButtons="false">
                        <SpinButtons ShowIncrementButtons="False"></SpinButtons>
                        <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxSpinEdit>
                </td>
            </tr>
            <tr>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Şubat : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxSpinEdit ID="SpinEditSubat" runat="server" DecimalPlaces="4" Width="200px" Font-Size="Small" MaxLength="5" NumberType="Float" AllowNull="true" MinValue="0" MaxValue="9" SpinButtons-ShowIncrementButtons="false">
                        <SpinButtons ShowIncrementButtons="False"></SpinButtons>
                        <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxSpinEdit>
                </td>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Ağustos : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxSpinEdit ID="SpinEditAgustos" runat="server" DecimalPlaces="4" Width="200px" Font-Size="Small" MaxLength="5" NumberType="Float" AllowNull="true" MinValue="0" MaxValue="9" SpinButtons-ShowIncrementButtons="false">
                        <SpinButtons ShowIncrementButtons="False"></SpinButtons>
                        <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxSpinEdit>
                </td>
            </tr>
            <tr>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Mart : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxSpinEdit ID="SpinEditMart" runat="server" DecimalPlaces="4" Width="200px" Font-Size="Small" MaxLength="5" NumberType="Float" AllowNull="true" MinValue="0" MaxValue="9" SpinButtons-ShowIncrementButtons="false">
                        <SpinButtons ShowIncrementButtons="False"></SpinButtons>
                        <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxSpinEdit>
                </td>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Eylül : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxSpinEdit ID="SpinEditEylul" runat="server" DecimalPlaces="4" Width="200px" Font-Size="Small" MaxLength="5" NumberType="Float" AllowNull="true" MinValue="0" MaxValue="9" SpinButtons-ShowIncrementButtons="false">
                        <SpinButtons ShowIncrementButtons="False"></SpinButtons>
                        <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxSpinEdit>
                </td>
            </tr>
            <tr>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Nisan : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxSpinEdit ID="SpinEditNisan" runat="server" DecimalPlaces="4" Width="200px" Font-Size="Small" MaxLength="5" NumberType="Float" AllowNull="true" MinValue="0" MaxValue="9" SpinButtons-ShowIncrementButtons="false">
                        <SpinButtons ShowIncrementButtons="False"></SpinButtons>
                        <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxSpinEdit>
                </td>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Ekim : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxSpinEdit ID="SpinEditEkim" runat="server" DecimalPlaces="4" Width="200px" Font-Size="Small" MaxLength="5" NumberType="Float" AllowNull="true" MinValue="0" MaxValue="9" SpinButtons-ShowIncrementButtons="false">
                        <SpinButtons ShowIncrementButtons="False"></SpinButtons>
                        <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxSpinEdit>
                </td>
            </tr>
            <tr>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Mayıs : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxSpinEdit ID="SpinEditMayis" runat="server" DecimalPlaces="4" Width="200px" Font-Size="Small" MaxLength="5" NumberType="Float" AllowNull="true" MinValue="0" MaxValue="9" SpinButtons-ShowIncrementButtons="false">
                        <SpinButtons ShowIncrementButtons="False"></SpinButtons>
                        <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxSpinEdit>
                </td>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Kasım : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxSpinEdit ID="SpinEditKasim" runat="server" DecimalPlaces="4" Width="200px" Font-Size="Small" MaxLength="5" NumberType="Float" AllowNull="true" MinValue="0" MaxValue="9" SpinButtons-ShowIncrementButtons="false">
                        <SpinButtons ShowIncrementButtons="False"></SpinButtons>
                        <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxSpinEdit>
                </td>
            </tr>
            <tr>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Haziran : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxSpinEdit ID="SpinEditHaziran" runat="server" DecimalPlaces="4" Width="200px" Font-Size="Small" MaxLength="5" NumberType="Float" AllowNull="true" MinValue="0" MaxValue="9" SpinButtons-ShowIncrementButtons="false">
                        <SpinButtons ShowIncrementButtons="False"></SpinButtons>
                        <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxSpinEdit>
                </td>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Aralık : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxSpinEdit ID="SpinEditAralik" runat="server" DecimalPlaces="4" Width="200px" Font-Size="Small" MaxLength="5" NumberType="Float" AllowNull="true" MinValue="0" MaxValue="9" SpinButtons-ShowIncrementButtons="false">
                        <SpinButtons ShowIncrementButtons="False"></SpinButtons>
                        <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxSpinEdit>
                </td>
            </tr>
            <tr>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="1.Taksit Ödemesi : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <table>
                        <tr>
                            <td>
                                <dx:ASPxComboBox ID="ComboBoxTaksit1Ay" runat="server" ValueType="System.String" Width="200px" Font-Size="Small" >
                                    <Items>
                                        <dx:ListEditItem Text="Ocak" Value="1" />
                                        <dx:ListEditItem Text="Şubat" Value="2" />
                                        <dx:ListEditItem Text="Mart" Value="3" />
                                        <dx:ListEditItem Text="Nisan" Value="4" />
                                        <dx:ListEditItem Text="Mayıs" Value="5" />
                                        <dx:ListEditItem Text="Haziran" Value="6" />
                                        <dx:ListEditItem Text="Temmuz" Value="7" />
                                        <dx:ListEditItem Text="Ağustos" Value="8" />
                                        <dx:ListEditItem Text="Eylül" Value="9" />
                                        <dx:ListEditItem Text="Ekim" Value="10" />
                                        <dx:ListEditItem Text="Kasım" Value="11" />
                                        <dx:ListEditItem Text="aralık" Value="12" />
                                    </Items>
                                    <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                                        <RequiredField ErrorText=" " IsRequired="true" />
                                    </ValidationSettings>
                                </dx:ASPxComboBox>
                            </td>
                            <td>&nbsp;Sonu
                            </td>
                        </tr>
                    </table>
                </td>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="2.Taksit Ödemesi : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <table>
                        <tr>
                            <td>
                                <dx:ASPxComboBox ID="ComboBoxTaksit2Ay" runat="server" ValueType="System.String" Width="200px" Font-Size="Small">
                                    <Items>
                                        <dx:ListEditItem Text="Ocak" Value="1" />
                                        <dx:ListEditItem Text="Şubat" Value="2" />
                                        <dx:ListEditItem Text="Mart" Value="3" />
                                        <dx:ListEditItem Text="Nisan" Value="4" />
                                        <dx:ListEditItem Text="Mayıs" Value="5" />
                                        <dx:ListEditItem Text="Haziran" Value="6" />
                                        <dx:ListEditItem Text="Temmuz" Value="7" />
                                        <dx:ListEditItem Text="Ağustos" Value="8" />
                                        <dx:ListEditItem Text="Eylül" Value="9" />
                                        <dx:ListEditItem Text="Ekim" Value="10" />
                                        <dx:ListEditItem Text="Kasım" Value="11" />
                                        <dx:ListEditItem Text="aralık" Value="12" />
                                    </Items>
                                    <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                                        <RequiredField ErrorText=" " IsRequired="true" />
                                    </ValidationSettings>
                                </dx:ASPxComboBox>
                            </td>
                            <td>&nbsp;Sonu
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td colspan="4">&nbsp;</td>
            </tr>
            <tr>
                <td colspan="4" class="TdOrtala">
                    <div id="divIslemler" runat="server" style="margin-left: 40%;">
                        <dx:ASPxButton ID="ButtonKaydet" runat="server" Text="Kaydet" ValidationGroup="KayitGuncelle" Width="120" Font-Size="Small" Visible="false" OnClick="ButtonKaydetGuncelle_Click" />
                        <dx:ASPxButton ID="ButtonGuncelle" runat="server" Text="Güncelle" ValidationGroup="KayitGuncelle" Width="120" Font-Size="Small" Visible="false" OnClick="ButtonKaydetGuncelle_Click" />
                        <dx:ASPxButton ID="ButtonTemizle" runat="server" Text="Temizle" Width="120" Font-Size="Small" Visible="false" OnClick="ButtonTemizle_Click" />
                        <dx:ASPxButton ID="ButtonIptal" runat="server" Text="İptal" Width="120" Font-Size="Small" Visible="false" OnClick="ButtonIptal_Click" />
                    </div>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
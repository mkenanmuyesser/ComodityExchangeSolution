<%@ Page Title="" Language="C#" MasterPageFile="~/Master_Page/Main.master" AutoEventWireup="true" CodeBehind="BeyannameTescilOran.aspx.cs" Inherits="TicaretBorsasi_Project.Program.MerkezBorsa.BeyannameTescilIslemleri.BeyannameTescilOran" %>
<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderMiddleContent" runat="server">
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
                    <dx:ASPxLabel runat="server" Text="Tahsilat Tipi : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxComboBox ID="ComboBoxTahsilatTipi" runat="server" ValueType="System.String" Width="200px" Font-Size="Small" TextField="TahsilatTipAdi" ValueField="TahsilatTipKey">
                        <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxComboBox>
                </td>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Muhasebe Adı : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxComboBox ID="ComboBoxMuhasebeTipi" runat="server" ValueType="System.String" Width="200px" Font-Size="Small" TextField="Adi" ValueField="MuhasebeTipKey">
                        <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxComboBox>
                </td>
            </tr>
            <tr>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Tescil Oranı : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxSpinEdit ID="SpinEditTescilOran" runat="server" DecimalPlaces="4" Width="200px" Font-Size="Small" MaxLength="14" NumberType="Float" AllowNull="true" MinValue="0" SpinButtons-ShowIncrementButtons="false">
                        <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                        <SpinButtons ShowIncrementButtons="False"></SpinButtons>
                    </dx:ASPxSpinEdit>
                </td>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Simsar Oranı : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxSpinEdit ID="SpinEditSimsarOran" runat="server" DecimalPlaces="4" Width="200px" Font-Size="Small" MaxLength="14" NumberType="Float" AllowNull="true" MinValue="0" SpinButtons-ShowIncrementButtons="false">
                        <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                        <SpinButtons ShowIncrementButtons="False"></SpinButtons>
                    </dx:ASPxSpinEdit>
                </td>
            </tr>
            <tr>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Stopaj : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxSpinEdit ID="SpinEditStopaj" runat="server" DecimalPlaces="4" Width="200px" Font-Size="Small" MaxLength="14" NumberType="Float" AllowNull="true" MinValue="0" SpinButtons-ShowIncrementButtons="false">
                        <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                        <SpinButtons ShowIncrementButtons="False"></SpinButtons>
                    </dx:ASPxSpinEdit>
                </td>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Fon Payı : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxSpinEdit ID="SpinEditFonPayi" runat="server" DecimalPlaces="4" Width="200px" Font-Size="Small" MaxLength="14" NumberType="Float" AllowNull="true" MinValue="0" SpinButtons-ShowIncrementButtons="false">
                        <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                        <SpinButtons ShowIncrementButtons="False"></SpinButtons>
                    </dx:ASPxSpinEdit>
                </td>
            </tr>
            <tr>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Mera Fonu : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxSpinEdit ID="SpinEditMeraFonu" runat="server" DecimalPlaces="4" Width="200px" Font-Size="Small" MaxLength="14" NumberType="Float" AllowNull="true" MinValue="0" SpinButtons-ShowIncrementButtons="false">
                        <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                        <SpinButtons ShowIncrementButtons="False"></SpinButtons>
                    </dx:ASPxSpinEdit>
                </td>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Tavan : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxSpinEdit ID="SpinEditTavan" runat="server" DecimalPlaces="4" Width="200px" Font-Size="Small" MaxLength="14" NumberType="Float" AllowNull="true" MinValue="0" SpinButtons-ShowIncrementButtons="false">
                        <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                        <SpinButtons ShowIncrementButtons="False"></SpinButtons>
                    </dx:ASPxSpinEdit>
                </td>
            </tr>
            <tr>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel  runat="server" Text="Satış : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxSpinEdit ID="SpinEditSatis" runat="server" DecimalPlaces="4" Width="200px" Font-Size="Small" MaxLength="14" NumberType="Float" AllowNull="true" MinValue="0" SpinButtons-ShowIncrementButtons="false">
                        <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                        <SpinButtons ShowIncrementButtons="False"></SpinButtons>
                    </dx:ASPxSpinEdit>
                </td>
                <td class="TdOrtala" colspan="2"></td>
            </tr>
            <tr>
                <td colspan="4" class="TdOrtala">
                    <div style="margin-left: 40%;">
                        <dx:ASPxButton ID="ButtonGuncelle" runat="server" Text="Güncelle" ValidationGroup="KayitGuncelle" Width="120" Font-Size="Small" OnClick="ButtonGuncelle_Click" />
                        <dx:ASPxButton ID="ButtonIptal" runat="server" Text="İptal" Width="120" Font-Size="Small" OnClick="ButtonIptal_Click" />
                    </div>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
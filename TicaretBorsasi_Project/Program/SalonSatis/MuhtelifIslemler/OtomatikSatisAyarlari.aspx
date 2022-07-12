<%@ Page Title="" Language="C#" MasterPageFile="~/Master_Page/Main.master" AutoEventWireup="true" CodeBehind="OtomatikSatisAyarlari.aspx.cs" Inherits="TicaretBorsasi_Project.Program.SalonSatis.MuhtelifIslemler.OtomatikSatisAyarlari" %>

<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridView.Export" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>

<%@ Register Src="../../../User_Control/Ortak/MuhtelifBorsaSubeleriUserControl.ascx" TagName="MuhtelifBorsaSubeleriUserControl" TagPrefix="uc1" %>

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
                    <dx:ASPxLabel runat="server" Text="Artış miktarı : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                     <dx:ASPxSpinEdit ID="SpinEditArtisMiktari" runat="server" DecimalPlaces="4" Width="200px" Font-Size="Small" MaxLength="6" NumberType="Integer" AllowNull="False" MinValue="0" SpinButtons-ShowIncrementButtons="false">
                        <SpinButtons ShowIncrementButtons="False"></SpinButtons>
                        <ValidationSettings ValidationGroup="KaydetGuncelle" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxSpinEdit>
                </td>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Düşüş miktarı : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxSpinEdit ID="SpinEditDususMiktari" runat="server" DecimalPlaces="4" Width="200px" Font-Size="Small" MaxLength="6" NumberType="Integer" AllowNull="False" MinValue="0" SpinButtons-ShowIncrementButtons="false">
                        <SpinButtons ShowIncrementButtons="False"></SpinButtons>
                        <ValidationSettings ValidationGroup="KaydetGuncelle" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxSpinEdit>
                </td>
            </tr>
            <tr>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel  runat="server" Text="Artış/Düşüş süre : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxSpinEdit ID="SpinEditArtisDususSure" runat="server" DecimalPlaces="0" Width="200px" Font-Size="Small" MaxLength="2" NumberType="Integer" AllowNull="False" MinValue="0" SpinButtons-ShowIncrementButtons="false">
                        <SpinButtons ShowIncrementButtons="False"></SpinButtons>
                        <ValidationSettings ValidationGroup="KaydetGuncelle" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxSpinEdit>
                </td>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel  runat="server" Text="Geri sayım süre : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxSpinEdit ID="SpinEditGeriSayimSure" runat="server" DecimalPlaces="0" Width="200px" Font-Size="Small" MaxLength="2" NumberType="Integer" AllowNull="False" MinValue="0" SpinButtons-ShowIncrementButtons="false">
                        <SpinButtons ShowIncrementButtons="False"></SpinButtons>
                        <ValidationSettings ValidationGroup="KaydetGuncelle" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxSpinEdit>
                </td>
            </tr>
            <tr>
                <td colspan="4">
                    <center>
                        <dx:ASPxButton ID="ButtonGuncelle" runat="server" Text="Güncelle" ValidationGroup="KaydetGuncelle" Width="120" Font-Size="Small" OnClick="ButtonKaydetGuncelle_Click" />
                        <dx:ASPxButton ID="ButtonIptal" runat="server" Text="İptal" Width="120" Font-Size="Small" OnClick="ButtonIptalTemizle_Click" />
                     </center>
                </td>
            </tr>            
        </table>
    </div>
</asp:Content>

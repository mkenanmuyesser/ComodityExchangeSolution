<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Master_Page/Root.master" CodeBehind="Default.aspx.cs" Inherits="TicaretBorsasi_Project.Default" %>

<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">
    <style type="text/css">
        .HeaderStyle {
            font-size: 16px;
            margin-left: 20px;
        }

        .ButtonStyle { margin: 20px 0px 0px 50px; }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <div style="margin: 10% 0px 0px 40%;">
        <table>
            <tr>
                <td colspan="2">
                    <div class="HeaderStyle">
                        <p>
                            <dx:ASPxLabel ID="LabelGiris" runat="server" Text="" Font-Size="XX-Large" />
                        </p>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="TdSolZorunlu" style="border: none;">
                    <dx:ASPxLabel ID="LabelKullaniciAdi" runat="server" AssociatedControlID="TextBoxKullaniciAdi" Text="Kullanýcý Adý : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag">
                    <dx:ASPxTextBox ID="TextBoxKullaniciAdi" runat="server" Width="200px" Font-Size="Small">
                        <ValidationSettings ValidationGroup="GirisDogrulama" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxTextBox>
                </td>
            </tr>
            <tr>
                <td class="TdSolZorunlu" style="border: none;">
                    <dx:ASPxLabel ID="LabelSifre" runat="server" AssociatedControlID="TextBoxSifre" Text="Þifre : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag">
                    <dx:ASPxTextBox ID="TextBoxSifre" runat="server" Password="true" Width="200px" Font-Size="Small">
                        <ValidationSettings ValidationGroup="GirisDogrulama" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxTextBox>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <div class="ButtonStyle">
                        <dx:ASPxButton ID="ButtonGiris" runat="server" Text="Giriþ" ValidationGroup="GirisDogrulama" Width="250" Font-Size="Small"
                                       OnClick="ButtonGiris_Click">
                        </dx:ASPxButton>
                    </div>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
<%@ Page Title="" Language="C#" MasterPageFile="~/Master_Page/Main.master" AutoEventWireup="true" CodeBehind="TuccarBeyanDepoYaratma.aspx.cs" Inherits="TicaretBorsasi_Project.Program.MerkezBorsa.TuccarIslemleri.TuccarBeyanDepoYaratma" %>
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
                    <dx:ASPxLabel runat="server" Text="Beyan Yılı : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxComboBox ID="ComboBoxAidatYili" runat="server" ValueType="System.String" Width="200px" Font-Size="Small" Enabled="false">
                        <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxComboBox>
                </td>
                <td class="TdOrtala" colspan="2"></td>
            </tr>
            <tr>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Beyan Yaratma İşlemi Yapılsın mı? : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxComboBox ID="ComboBoxIslemDogrulama" runat="server" ValueType="System.String" Width="200px" Font-Size="Small">
                        <Items>
                            <dx:ListEditItem Text="Hayır" Value="H" />
                            <dx:ListEditItem Text="Evet" Value="E" />
                        </Items>
                        <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxComboBox>
                </td>
                <td class="TdOrtala" colspan="2"></td>
            </tr>
            <tr>
                <td colspan="4">
                    <center>
                        <dx:ASPxLabel runat="server" Text="Tüccar depoları yeniden yaratılacaktır !" Font-Size="Medium" ForeColor="Red" />
                    </center>
                </td>
            </tr>
            <tr>
                <td colspan="4" class="TdOrtala">
                    <div id="divIslemler" runat="server" style="float: left; margin-left: 40%;">
                        <dx:ASPxButton ID="ButtonBeyanDepoYarat" runat="server" Text="Beyanlardan Depo Yarat" ValidationGroup="KayitGuncelle" Width="120" Font-Size="Small" OnClick="ButtonBeyanDepoYarat_Click" />
                        <dx:ASPxButton ID="ButtonIptal" runat="server" Text="İptal" Width="120" Font-Size="Small" OnClick="ButtonIptal_Click" />
                    </div>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
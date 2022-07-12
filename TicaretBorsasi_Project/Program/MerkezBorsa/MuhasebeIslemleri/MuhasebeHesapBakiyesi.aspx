<%@ Page Title="" Language="C#" MasterPageFile="~/Master_Page/Main.master" AutoEventWireup="true" CodeBehind="MuhasebeHesapBakiyesi.aspx.cs" Inherits="TicaretBorsasi_Project.Program.MerkezBorsa.MuhasebeIslemleri.MuhasebeHesapBakiyesi" %>

<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderMiddleContent" runat="server">
    <script type="text/javascript">
        document.onkeydown = function (e) {
            switch (e.keyCode) {
                case 37:
                    document.getElementById('<%= ButtonGeri.ClientID %>').click();
                    break;
                case 38:
                    //alert('up');break;
                case 39:
                    document.getElementById('<%= ButtonIleri.ClientID %>').click();
                    break;
                case 40:
                    //alert('down');
                    break;
            }
        };
    </script>
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
                    <dx:ASPxLabel runat="server" Text="Muhasebe Adı : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxComboBox ID="ComboBoxMuhasebeTip" runat="server" ValueType="System.Int32" Width="200px" Font-Size="Small" TextField="Adi" ValueField="MuhasebeTipKey" OnSelectedIndexChanged="ComboBoxMuhasebeTip_SelectedIndexChanged">
                        <ValidationSettings ValidationGroup="Ara" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxComboBox>
                </td>
                <td class="TdSolZorunlu" style="width: 15%;">Yıl</td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxComboBox ID="ComboBoxYil" runat="server" ValueType="System.Int32" Width="200px" Font-Size="Small" AutoPostBack="true" OnSelectedIndexChanged="ComboBoxYil_SelectedIndexChanged">
                        <ValidationSettings ValidationGroup="Ara" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxComboBox>
                </td>
            </tr>
            <tr>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Hesap No : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <table>
                        <tr>
                            <td>
                                <dx:ASPxTextBox ID="TextBoxHesapNo" runat="server" Width="200px" Font-Size="Small" MaxLength="12">
                                    <MaskSettings Mask="999_99_99999" />
                                    <ValidationSettings ValidationGroup="Ara" Display="Dynamic">
                                        <RequiredField ErrorText=" " IsRequired="true" />
                                    </ValidationSettings>
                                </dx:ASPxTextBox>
                            </td>
                            <td style="width: 9px">&nbsp;&nbsp; 
                            </td>
                            <td>
                                <dx:ASPxButton ID="ButtonGeri" runat="server" Text="<=" Font-Size="X-Small" OnClick="ButtonGeriIleri_Click" ValidationGroup="Ara"></dx:ASPxButton>
                            </td>
                            <td>
                                <dx:ASPxButton ID="ButtonIleri" runat="server" Text="=>" Font-Size="X-Small" OnClick="ButtonGeriIleri_Click" ValidationGroup="Ara"></dx:ASPxButton>
                            </td>
                        </tr>
                    </table>
                </td>
                <td class="TdOrtala" colspan="2"></td>
            </tr>
            <tr>
                <td class="TdOrtala" colspan="4">
                    <div style="float: left; margin-left: 40%;">
                        <dx:ASPxButton ID="ButtonAra" runat="server" Text="Ara" Width="120" Font-Size="Small" ValidationGroup="Ara" OnClick="ButtonAra_Click" />
                        <dx:ASPxButton ID="ButtonTemizle" runat="server" Text="Temizle" Width="120" Font-Size="Small" OnClick="ButtonTemizle_Click" />
                    </div>
                </td>
            </tr>
            <tr>
                <td class="TdOrtala" colspan="4"></td>
            </tr>
            <tr>
                <td class="TdSol" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Hesap Adı : " Font-Size="Small" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxLabel ID="LabelHesapAdi" runat="server" Text="" Font-Size="Small" />
                </td>
                <td class="TdOrtala" colspan="2"></td>
            </tr>
            <tr>
                <td class="TdSol" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Borç Toplamı : " Font-Size="Small" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxLabel ID="LabelBorcToplami" runat="server" Text="" Font-Size="Small" />
                </td>
                <td class="TdSol" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Alacak Toplamı : " Font-Size="Small" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxLabel ID="LabelAlacakToplami" runat="server" Text="" Font-Size="Small" />
                </td>
            </tr>
            <tr>
                <td class="TdSol" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Alacak Bakiye : " Font-Size="Small" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxLabel ID="LabelAlacakBakiye" runat="server" Text="" Font-Size="Small" />
                </td>
                <td class="TdOrtala" colspan="2"></td>
            </tr>
        </table>
    </div>
</asp:Content>

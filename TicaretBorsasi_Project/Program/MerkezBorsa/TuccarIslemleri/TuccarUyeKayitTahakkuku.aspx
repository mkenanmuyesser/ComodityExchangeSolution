<%@ Page Title="" Language="C#" MasterPageFile="~/Master_Page/Main.master" AutoEventWireup="true" CodeBehind="TuccarUyeKayitTahakkuku.aspx.cs" Inherits="TicaretBorsasi_Project.Program.MerkezBorsa.TuccarIslemleri.TuccarUyeKayitTahakkuku" %>

<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderMiddleContent" runat="server">
    <script type="text/javascript">
        document.onkeydown = function(e) {
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
                    <dx:ASPxLabel runat="server" Text="Sicil No : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <table>
                        <tr>
                            <td>
                                <dx:ASPxTextBox ID="TextBoxSicilNo" runat="server" Width="200px" Font-Size="Small" MaxLength="6">
                                    <MaskSettings Mask="999999" />
                                    <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                                        <RequiredField ErrorText=" " IsRequired="true" />
                                    </ValidationSettings>
                                </dx:ASPxTextBox>
                            </td>
                            <td>
                                <dx:ASPxButton ID="ButtonAra" runat="server" Text="Ara" OnClick="ButtonAra_Click"></dx:ASPxButton>
                            </td>
                            <td style="width: 9px">&nbsp;&nbsp; 
                            </td>
                            <td>
                                <dx:ASPxButton ID="ButtonGeri" runat="server" Text="<=" Font-Size="X-Small" OnClick="ButtonGeriIleri_Click"></dx:ASPxButton>
                            </td>
                            <td>
                                <dx:ASPxButton ID="ButtonIleri" runat="server" Text="=>" Font-Size="X-Small" OnClick="ButtonGeriIleri_Click"></dx:ASPxButton>
                            </td>
                        </tr>
                    </table>
                </td>
                <td class="TdSol" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Meslek Grubu : " Font-Size="Small" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxTextBox ID="TextBoxMeslekGrubu" runat="server" Width="200px" Font-Size="Small" Enabled="false">
                    </dx:ASPxTextBox>
                </td>
            </tr>
            <tr>
                <td class="TdSol" style="width: 15%;" rowspan="2">
                    <dx:ASPxLabel runat="server" Text="Unvanı : " Font-Size="Small" />
                </td>
                <td class="TdSag" style="width: 35%;" rowspan="2">
                    <dx:ASPxMemo ID="MemoUnvan" runat="server" Width="200px" Font-Size="Small" Rows="2" Enabled="false">
                    </dx:ASPxMemo>
                </td>
                <td class="TdSol" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Derece : " Font-Size="Small" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxTextBox ID="TextBoxDerece" runat="server" Width="200px" Font-Size="Small" Enabled="false">
                    </dx:ASPxTextBox>
                </td>
            </tr>
            <tr>
                <td class="TdSol" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Şirket Tipi : " Font-Size="Small" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxTextBox ID="TextBoxSirketTipi" runat="server" Width="200px" Font-Size="Small" Enabled="false">
                    </dx:ASPxTextBox>
                </td>
            </tr>
            <tr>
                <td class="TdSol" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Karar Tarihi : " Font-Size="Small" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxDateEdit ID="DateEditKararTarihi" runat="server" Font-Size="Small" Width="200" Enabled="false">
                    </dx:ASPxDateEdit>
                </td>
                <td class="TdSol" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Vade Tarihi : " Font-Size="Small" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxDateEdit ID="DateEditVadeTarihi" runat="server" Font-Size="Small" Width="200" Enabled="false">
                    </dx:ASPxDateEdit>
                </td>
            </tr>
            <tr>
                <td class="TdSol" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Kayıt Ücreti : " Font-Size="Small" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxTextBox ID="TextBoxKayitUcreti" runat="server" Width="200px" Font-Size="Small" Enabled="false">
                    </dx:ASPxTextBox>
                </td>
                <td class="TdSol" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Ödeme Tarihi : " Font-Size="Small" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxDateEdit ID="DateEditOdemeTarihi" runat="server" Font-Size="Small" Width="200" Enabled="false">
                    </dx:ASPxDateEdit>
                </td>
            </tr>
            <tr>
                <td class="TdSol" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Ceza : " Font-Size="Small" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxTextBox ID="TextBoxCeza" runat="server" Width="200px" Font-Size="Small" Enabled="false">
                    </dx:ASPxTextBox>
                </td>
                <td class="TdSol" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Durum : " Font-Size="Small" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxLabel ID="LabelDurum" runat="server" Text="" Font-Size="Small" />
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
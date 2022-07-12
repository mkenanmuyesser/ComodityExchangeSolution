<%@ Page Title="" Language="C#" MasterPageFile="~/Master_Page/Main.master" AutoEventWireup="true" CodeBehind="TuccarKefaletTeminatIslemleri.aspx.cs" Inherits="TicaretBorsasi_Project.Program.MerkezBorsa.TuccarIslemleri.TuccarKefaletTeminatIslemleri" %>

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
                <td colspan="4">
                    <dx:ASPxLabel runat="server" Font-Size="Large" Text="TÜCCAR" />
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
                                <dx:ASPxTextBox ID="TextBoxTuccarSicilNo" runat="server" Width="200px" Font-Size="Small" MaxLength="6">
                                    <MaskSettings Mask="<000000..999999>" />
                                    <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                                        <RequiredField ErrorText=" " IsRequired="true" />
                                    </ValidationSettings>
                                </dx:ASPxTextBox>
                            </td>
                            <td>
                                <dx:ASPxButton ID="ButtonTuccarAra" runat="server" Text="Ara" OnClick="ButtonAra_Click"></dx:ASPxButton>
                            </td>
                            <td style="width: 9px">&nbsp;&nbsp; 
                            </td>
                            <td>
                                <dx:ASPxButton ID="ButtonTuccarGeri" runat="server" Text="<=" Font-Size="X-Small" OnClick="ButtonGeriIleri_Click"></dx:ASPxButton>
                            </td>
                            <td>
                                <dx:ASPxButton ID="ButtonTuccarIleri" runat="server" Text="=>" Font-Size="X-Small" OnClick="ButtonGeriIleri_Click"></dx:ASPxButton>
                            </td>
                        </tr>
                    </table>
                </td>
                <td class="TdSol" style="width: 15%;" rowspan="2">
                    <dx:ASPxLabel runat="server" Text="Unvanı : " Font-Size="Small" />
                </td>
                <td class="TdSag" style="width: 35%;" rowspan="2">
                    <dx:ASPxMemo ID="MemoTuccarUnvan" runat="server" Width="200px" Font-Size="Small" MaxLength="2500" Rows="3" Enabled="false">
                    </dx:ASPxMemo>
                </td>
            </tr>
            <tr>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Durumu : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxLabel ID="LabelTuccarDurum" runat="server" Text="" Font-Size="Small" ForeColor="Red" />
                </td>
            </tr>
            <tr>
                <td colspan="4">&nbsp;</td>
            </tr>
            <tr>
                <td colspan="4">
                    <dx:ASPxLabel runat="server" Font-Size="Large" Text="KEFİL" />
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
                                <dx:ASPxTextBox ID="TextBoxKefilSicilNo" runat="server" Width="200px" Font-Size="Small" MaxLength="6">
                                    <MaskSettings Mask="<000000..999999>" />
                                    <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                                        <RequiredField ErrorText=" " IsRequired="true" />
                                    </ValidationSettings>
                                </dx:ASPxTextBox>
                            </td>
                            <td>
                                <dx:ASPxButton ID="ButtonKefilAra" runat="server" Text="Ara" OnClick="ButtonAra_Click"></dx:ASPxButton>
                            </td>
                            <td style="width: 9px">&nbsp;&nbsp; 
                            </td>
                            <td></td>
                            <td></td>
                        </tr>
                    </table>
                </td>
                <td class="TdSol" style="width: 15%;" rowspan="2">
                    <dx:ASPxLabel runat="server" Text="Unvanı : " Font-Size="Small" />
                </td>
                <td class="TdSag" style="width: 35%;" rowspan="2">
                    <dx:ASPxMemo ID="MemoKefilUnvan" runat="server" Width="200px" Font-Size="Small" MaxLength="2500" Rows="3" Enabled="false">
                    </dx:ASPxMemo>
                </td>
            </tr>
            <tr>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Durumu : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxLabel ID="LabelKefilDurum" runat="server" Text="" Font-Size="Small" ForeColor="Red" />
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
<%@ Page Title="" Language="C#" MasterPageFile="~/Master_Page/Main.master" AutoEventWireup="true" CodeBehind="TuccarStopajTahsilatKontrolu.aspx.cs" Inherits="TicaretBorsasi_Project.Program.MerkezBorsa.TuccarIslemleri.TuccarStopajTahsilatKontrolu" %>

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
                <td class="TdSol" style="width: 15%;" rowspan="2">
                    <dx:ASPxLabel runat="server" Text="Unvanı : " Font-Size="Small" />
                </td>
                <td class="TdSag" style="width: 35%;" rowspan="2">
                    <dx:ASPxMemo ID="MemoUnvan" runat="server" Width="200px" Font-Size="Small" Rows="3" Enabled="false">
                    </dx:ASPxMemo>
                </td>
            </tr>
            <tr>
                <td class="TdSol" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Vergi Dairesi : " Font-Size="Small" />

                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxTextBox ID="TextBoxVergiDairesi" runat="server" Width="200px" Font-Size="Small" Enabled="false">
                    </dx:ASPxTextBox>
                </td>
            </tr>
            <tr>
                <td class="TdSol" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Durumu : " Font-Size="Small" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxLabel ID="LabelDurum" runat="server" Text="" Font-Size="Small" />
                </td>
                <td class="TdOrtala" colspan="2"></td>
            </tr>
            <tr>
                <td colspan="4">
                    <table style="border-color: #999999; width: 99.9%;" border="2">
                        <tr>
                            <td class="TdSol" style="font-size: large; text-align: center; width: 15%;">DÖNEM</td>
                            <td class="TdSag" style="font-size: large; text-align: center; width: 25%;">TAHAKKUK</td>
                            <td class="TdSag" style="font-size: large; text-align: center; width: 25%;">TAHSİLAT</td>
                            <td class="TdSag" style="font-size: large; text-align: center; width: 25%;">BAKİYE</td>
                        </tr>
                        <tr>
                            <td class="TdSol" style="font-size: medium; width: 25%;">
                                <dx:ASPxLabel runat="server" ID="LabelEskiYil" ForeColor="#3399ff" Text="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ARALIK"></dx:ASPxLabel>
                            </td>
                            <td class="TdSag" style="width: 25%;">
                                <dx:ASPxLabel ID="LabelEskiYilAralikTahakkuk" runat="server" Text="" Font-Size="Small" />
                            </td>
                            <td class="TdSag" style="width: 25%;">
                                <dx:ASPxLabel ID="LabelEskiYilAralikTahsilat" runat="server" Text="" Font-Size="Small" />
                            </td>
                            <td class="TdSag" style="width: 25%;">
                                <dx:ASPxLabel ID="LabelEskiYilAralikBakiye" runat="server" Text="" Font-Size="Small" />
                            </td>
                        </tr>
                        <tr>
                            <td class="TdSol" style="font-size: medium; width: 25%;">
                                <dx:ASPxLabel runat="server" ID="LabelYil" ForeColor="#669900" Text="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;OCAK"></dx:ASPxLabel>
                            </td>
                            <td class="TdSag" style="width: 25%;">
                                <dx:ASPxLabel ID="LabelOcakTahakkuk" runat="server" Text="" Font-Size="Small" />
                            </td>
                            <td class="TdSag" style="width: 25%;">
                                <dx:ASPxLabel ID="LabelOcakTahsilat" runat="server" Text="" Font-Size="Small" />
                            </td>
                            <td class="TdSag" style="width: 25%;">
                                <dx:ASPxLabel ID="LabelOcakBakiye" runat="server" Text="" Font-Size="Small" />
                            </td>
                        </tr>
                        <tr>
                            <td class="TdSol" style="font-size: medium; width: 25%;">
                                <dx:ASPxLabel runat="server" ForeColor="#669900" Text="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ŞUBAT"></dx:ASPxLabel>
                            </td>
                            <td class="TdSag" style="width: 25%;">
                                <dx:ASPxLabel ID="LabelSubatTahakkuk" runat="server" Text="" Font-Size="Small" />
                            </td>
                            <td class="TdSag" style="width: 25%;">
                                <dx:ASPxLabel ID="LabelSubatTahsilat" runat="server" Text="" Font-Size="Small" />
                            </td>
                            <td class="TdSag" style="width: 25%;">
                                <dx:ASPxLabel ID="LabelSubatBakiye" runat="server" Text="" Font-Size="Small" />
                            </td>
                        </tr>
                        <tr>
                            <td class="TdSol" style="font-size: medium; width: 25%;">
                                <dx:ASPxLabel runat="server" ForeColor="#669900" Text="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;MART"></dx:ASPxLabel>
                            </td>
                            <td class="TdSag" style="width: 25%;">
                                <dx:ASPxLabel ID="LabelMartTahakkuk" runat="server" Text="" Font-Size="Small" />
                            </td>
                            <td class="TdSag" style="width: 25%;">
                                <dx:ASPxLabel ID="LabelMartTahsilat" runat="server" Text="" Font-Size="Small" />
                            </td>
                            <td class="TdSag" style="width: 25%;">
                                <dx:ASPxLabel ID="LabelMartBakiye" runat="server" Text="" Font-Size="Small" />
                            </td>
                        </tr>
                        <tr>
                            <td class="TdSol" style="font-size: medium; width: 25%;">
                                <dx:ASPxLabel runat="server" ForeColor="#669900" Text="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;NİSAN"></dx:ASPxLabel>
                            </td>
                            <td class="TdSag" style="width: 25%;">
                                <dx:ASPxLabel ID="LabelNisanTahakkuk" runat="server" Text="" Font-Size="Small" />
                            </td>
                            <td class="TdSag" style="width: 25%;">
                                <dx:ASPxLabel ID="LabelNisanTahsilat" runat="server" Text="" Font-Size="Small" />
                            </td>
                            <td class="TdSag" style="width: 25%;">
                                <dx:ASPxLabel ID="LabelNisanBakiye" runat="server" Text="" Font-Size="Small" />
                            </td>
                        </tr>
                        <tr>
                            <td class="TdSol" style="font-size: medium; width: 25%;">
                                <dx:ASPxLabel runat="server" ForeColor="#669900" Text="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;MAYIS"></dx:ASPxLabel>
                            </td>
                            <td class="TdSag" style="width: 25%;">
                                <dx:ASPxLabel ID="LabelMayisTahakkuk" runat="server" Text="" Font-Size="Small" />
                            </td>
                            <td class="TdSag" style="width: 25%;">
                                <dx:ASPxLabel ID="LabelMayisTahsilat" runat="server" Text="" Font-Size="Small" />
                            </td>
                            <td class="TdSag" style="width: 25%;">
                                <dx:ASPxLabel ID="LabelMayisBakiye" runat="server" Text="" Font-Size="Small" />
                            </td>
                        </tr>
                        <tr>
                            <td class="TdSol" style="font-size: medium; width: 25%;">
                                <dx:ASPxLabel runat="server" ForeColor="#669900" Text="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;HAZİRAN"></dx:ASPxLabel>
                            </td>
                            <td class="TdSag" style="width: 25%;">
                                <dx:ASPxLabel ID="LabelHaziranTahakkuk" runat="server" Text="" Font-Size="Small" />
                            </td>
                            <td class="TdSag" style="width: 25%;">
                                <dx:ASPxLabel ID="LabelHaziranTahsilat" runat="server" Text="" Font-Size="Small" />
                            </td>
                            <td class="TdSag" style="width: 25%;">
                                <dx:ASPxLabel ID="LabelHaziranBakiye" runat="server" Text="" Font-Size="Small" />
                            </td>
                        </tr>
                        <tr>
                            <td class="TdSol" style="font-size: medium; width: 25%;">
                                <dx:ASPxLabel runat="server" ForeColor="#669900" Text="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;TEMMUZ"></dx:ASPxLabel>
                            </td>
                            <td class="TdSag" style="width: 25%;">
                                <dx:ASPxLabel ID="LabelTemmuzTahakkuk" runat="server" Text="" Font-Size="Small" />
                            </td>
                            <td class="TdSag" style="width: 25%;">
                                <dx:ASPxLabel ID="LabelTemmuzTahsilat" runat="server" Text="" Font-Size="Small" />
                            </td>
                            <td class="TdSag" style="width: 25%;">
                                <dx:ASPxLabel ID="LabelTemmuzBakiye" runat="server" Text="" Font-Size="Small" />
                            </td>
                        </tr>
                        <tr>
                            <td class="TdSol" style="font-size: medium; width: 25%;">
                                <dx:ASPxLabel runat="server" ForeColor="#669900" Text="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;AĞUSTOS"></dx:ASPxLabel>
                            </td>
                            <td class="TdSag" style="width: 25%;">
                                <dx:ASPxLabel ID="LabelAgustosTahakkuk" runat="server" Text="" Font-Size="Small" />
                            </td>
                            <td class="TdSag" style="width: 25%;">
                                <dx:ASPxLabel ID="LabelAgustosTahsilat" runat="server" Text="" Font-Size="Small" />
                            </td>
                            <td class="TdSag" style="width: 25%;">
                                <dx:ASPxLabel ID="LabelAgustosBakiye" runat="server" Text="" Font-Size="Small" />
                            </td>
                        </tr>
                        <tr>
                            <td class="TdSol" style="font-size: medium; width: 25%;">
                                <dx:ASPxLabel runat="server" ForeColor="#669900" Text="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;EYLÜL"></dx:ASPxLabel>
                            </td>
                            <td class="TdSag" style="width: 25%;">
                                <dx:ASPxLabel ID="LabelEylulTahakkuk" runat="server" Text="" Font-Size="Small" />
                            </td>
                            <td class="TdSag" style="width: 25%;">
                                <dx:ASPxLabel ID="LabelEylulTahsilat" runat="server" Text="" Font-Size="Small" />
                            </td>
                            <td class="TdSag" style="width: 25%;">
                                <dx:ASPxLabel ID="LabelEylulBakiye" runat="server" Text="" Font-Size="Small" />
                            </td>
                        </tr>
                        <tr>
                            <td class="TdSol" style="font-size: medium; width: 25%;">
                                <dx:ASPxLabel runat="server" ForeColor="#669900" Text="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;EKİM"></dx:ASPxLabel>
                            </td>
                            <td class="TdSag" style="width: 25%;">
                                <dx:ASPxLabel ID="LabelEkimTahakkuk" runat="server" Text="" Font-Size="Small" />
                            </td>
                            <td class="TdSag" style="width: 25%;">
                                <dx:ASPxLabel ID="LabelEkimTahsilat" runat="server" Text="" Font-Size="Small" />
                            </td>
                            <td class="TdSag" style="width: 25%;">
                                <dx:ASPxLabel ID="LabelEkimBakiye" runat="server" Text="" Font-Size="Small" />
                            </td>
                        </tr>
                        <tr>
                            <td class="TdSol" style="font-size: medium; width: 25%;">
                                <dx:ASPxLabel runat="server" ForeColor="#669900" Text="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;KASIM"></dx:ASPxLabel>
                            </td>
                            <td class="TdSag" style="width: 25%;">
                                <dx:ASPxLabel ID="LabelKasimTahakkuk" runat="server" Text="" Font-Size="Small" />
                            </td>
                            <td class="TdSag" style="width: 25%;">
                                <dx:ASPxLabel ID="LabelKasimTahsilat" runat="server" Text="" Font-Size="Small" />
                            </td>
                            <td class="TdSag" style="width: 25%;">
                                <dx:ASPxLabel ID="LabelKasimBakiye" runat="server" Text="" Font-Size="Small" />
                            </td>
                        </tr>
                        <tr>
                            <td class="TdSol" style="font-size: medium; width: 25%;">
                                <dx:ASPxLabel runat="server" ForeColor="#669900" Text="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ARALIK"></dx:ASPxLabel>
                            </td>
                            <td class="TdSag" style="width: 25%;">
                                <dx:ASPxLabel ID="LabelAralikTahakkuk" runat="server" Text="" Font-Size="Small" />
                            </td>
                            <td class="TdSag" style="width: 25%;">
                                <dx:ASPxLabel ID="LabelAralikTahsilat" runat="server" Text="" Font-Size="Small" />
                            </td>
                            <td class="TdSag" style="width: 25%;">
                                <dx:ASPxLabel ID="LabelAralikBakiye" runat="server" Text="" Font-Size="Small" />
                            </td>
                        </tr>
                        <tr>
                            <td class="TdSol" style="font-size: large; width: 25%;">
                                <dx:ASPxLabel runat="server" ForeColor="Red" Text="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;TOPLAM : "></dx:ASPxLabel>
                            </td>
                            <td class="TdSag" style="width: 25%;">
                                <dx:ASPxLabel ID="LabelToplamTahakkuk" runat="server" Text="" Font-Size="Small" />
                            </td>
                            <td class="TdSag" style="width: 25%;">
                                <dx:ASPxLabel ID="LabelToplamTahsilat" runat="server" Text="" Font-Size="Small" />
                            </td>
                            <td class="TdSag" style="width: 25%;">
                                <dx:ASPxLabel ID="LabelToplamBakiye" runat="server" Text="" Font-Size="Small" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
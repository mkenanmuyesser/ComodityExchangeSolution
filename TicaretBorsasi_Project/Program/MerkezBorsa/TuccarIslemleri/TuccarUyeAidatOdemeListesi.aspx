<%@ Page Title="" Language="C#" MasterPageFile="~/Master_Page/Main.master" AutoEventWireup="true" CodeBehind="TuccarUyeAidatOdemeListesi.aspx.cs" Inherits="TicaretBorsasi_Project.Program.MerkezBorsa.TuccarIslemleri.TuccarUyeAidatOdemeListesi" %>
<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridView.Export" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>
<%@ Register TagPrefix="dx" Namespace="DevExpress.Web.ASPxPopupControl" Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>

<asp:Content ContentPlaceHolderID="ContentPlaceHolderMiddleContent" runat="server">
    <script type="text/javascript">
        // <![CDATA[
        function ShowWindow() {
            PopupControlTuccarBilgiDetay.Show();
        }
    // ]]> 
    </script>
    <div style="margin: 1px; width: 99.9%;">
        <dx:ASPxPopupControl ID="PopupControlTuccarBilgiDetay" runat="server" CloseAction="CloseButton" Modal="True"
                             PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ClientInstanceName="PopupControlTuccarBilgiDetay" AllowDragging="False" PopupAnimationType="None" EnableViewState="False">
            <ClientSideEvents PopUp="function(s, e) { }" />
            <ContentCollection>
                <dx:PopupControlContentControl runat="server">
                    test
                </dx:PopupControlContentControl>
            </ContentCollection>
        </dx:ASPxPopupControl>
        <table style="border-color: #999999; width: 99.9%;" border="1">
            <tr>
                <td class="TdOrtala" colspan="4">
                    <div style="margin-left: 40%; padding: 2px;">
                        <dx:ASPxLabel ID="LabelBaslik" runat="server" Font-Size="Large" />
                    </div>
                </td>
            </tr>
            <tr>
                <td class="TdSol" style="width: 15%">
                    <dx:ASPxLabel runat="server" Text="Sicil No : " Font-Size="Small" />
                </td>
                <td class="TdSag">
                    <table style="width: 400px;">
                        <tr>
                            <td>
                                <dx:ASPxSpinEdit ID="SpinEditSicilNoBaslangic" runat="server" DecimalPlaces="2" Width="200px" Font-Size="Small" MaxLength="6" NumberType="Integer" AllowNull="true" MinValue="0" SpinButtons-ShowIncrementButtons="false">
                                </dx:ASPxSpinEdit>
                            </td>
                            <td style="padding-left: 5px;">
                                <dx:ASPxSpinEdit ID="SpinEditSicilNoBitis" runat="server" DecimalPlaces="2" Width="200px" Font-Size="Small" MaxLength="6" NumberType="Integer" AllowNull="true" MinValue="0" SpinButtons-ShowIncrementButtons="false">
                                </dx:ASPxSpinEdit>
                            </td>
                        </tr>
                    </table>
                </td>
                <td class="TdOrtala" colspan="2"></td>
            </tr>
            <tr>
                <td class="TdSol" style="width: 15%">
                    <dx:ASPxLabel runat="server" Text="Başlangıç Meslek Grubu : " Font-Size="Small" />
                </td>
                <td class="TdSag">
                    <dx:ASPxSpinEdit ID="SpinEditBaslangicMeslekGrubu" runat="server" DecimalPlaces="2" Width="200px" Font-Size="Small" MaxLength="4" NumberType="Integer" AllowNull="true" MinValue="0" SpinButtons-ShowIncrementButtons="false">
                    </dx:ASPxSpinEdit>
                </td>
                <td class="TdSol" style="width: 15%">
                    <dx:ASPxLabel runat="server" Text="Bitiş Meslek Grubu : " Font-Size="Small" />
                </td>
                <td class="TdSag">
                    <dx:ASPxSpinEdit ID="SpinEditBitisMeslekGrubu" runat="server" DecimalPlaces="2" Width="200px" Font-Size="Small" MaxLength="4" NumberType="Integer" AllowNull="true" MinValue="0" SpinButtons-ShowIncrementButtons="false">
                    </dx:ASPxSpinEdit>
                </td>
            </tr>
            <tr>
                <td class="TdSol" style="width: 15%">
                    <dx:ASPxLabel runat="server" Text="Başlangıç Aidat Yılı : " Font-Size="Small" />
                </td>
                <td class="TdSag">
                    <dx:ASPxComboBox ID="ComboBoxBaslangicAidatYil" runat="server" ValueType="System.String" Width="200px" Font-Size="Small">
                    </dx:ASPxComboBox>
                </td>
                <td class="TdSol" style="width: 15%">
                    <dx:ASPxLabel runat="server" Text="Bitiş Aidat Yılı : " Font-Size="Small" />
                </td>
                <td class="TdSag">
                    <dx:ASPxComboBox ID="ComboBoxBitisAidatYil" runat="server" ValueType="System.String" Width="200px" Font-Size="Small">
                    </dx:ASPxComboBox>
                </td>
            </tr>
            <tr>
                <td class="TdSol" style="width: 15%">
                    <dx:ASPxLabel runat="server" Text="Terkin Durumu : " Font-Size="Small" />
                </td>
                <td class="TdSag">
                    <dx:ASPxRadioButtonList ID="RadioButtonListTerkinSecim" runat="server" ValueType="System.String" RepeatDirection="Horizontal" Font-Size="Small" Width="100%">
                        <Items>
                            <dx:ListEditItem Selected="true" Text="Tümü" Value="0" />
                            <dx:ListEditItem Text="Aktif Üyeler" Value="1" />
                            <dx:ListEditItem Text="Kaydı Kapanan Üyeler" Value="2" />
                        </Items>
                    </dx:ASPxRadioButtonList>
                </td>
                <td class="TdSol" style="width: 15%">
                    <dx:ASPxLabel runat="server" Text="Liste Tipi : " Font-Size="Small" />
                </td>
                <td class="TdSag">
                    <dx:ASPxComboBox ID="ComboBoxListeTipi" runat="server" ValueType="System.String" Width="200px" Font-Size="Small" AutoPostBack="true" OnSelectedIndexChanged="ComboBoxListeTipi_SelectedIndexChanged">
                        <Items>
                            <dx:ListEditItem Selected="true" Text="Üye Aidat Listesi" Value="1" />
                            <dx:ListEditItem Text="Aidat Borcu Olan Üyeler Listesi" Value="2" />
                            <dx:ListEditItem Text="Aidat Borcu Olmayan Üyeler Listesi" Value="3" />
                            <dx:ListEditItem Text="Aidat Ödeme Listesi" Value="4" />
                        </Items>
                    </dx:ASPxComboBox>
                </td>
            </tr>
            <tr>
                <td class="TdOrtala" colspan="4">
                    <div style="float: left; margin-left: 40%;">
                        <dx:ASPxButton ID="ButtonAra" runat="server" Text="Ara" Width="120" Font-Size="Small" OnClick="ButtonAra_Click" />
                        <dx:ASPxButton ID="ButtonTemizle" runat="server" Text="Temizle" Width="120" Font-Size="Small" OnClick="ButtonTemizle_Click" />
                    </div>
                    <div style="float: right;" id="raporDiv" runat="server" >
                        <table>
                            <tr>
                                <td>
                                    <dx:ASPxComboBox ID="ComboBoxRapor" runat="server" Font-Size="Small" Width="70">
                                        <Items>
                                            <dx:ListEditItem Selected="true" Text="Excel" Value="Excel" />
                                            <%--<dx:ListEditItem Text="Pdf" Value="Pdf" />--%>
                                        </Items>
                                    </dx:ASPxComboBox>
                                </td>
                                <td>
                                    <dx:ASPxButton ID="ButtonRapor" runat="server" Text="Rapor" Width="120" Font-Size="Small" OnClick="ButtonRapor_Click" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="TdOrtala" colspan="4">
                    <dx:ASPxGridViewExporter ExportedRowType="All" GridViewID="GridViewUyeAidatOdemeListesi" ID="GridViewExporterUyeAidatOdemeListesi" runat="server">
                    </dx:ASPxGridViewExporter>
                    <dx:ASPxGridView ID="GridViewUyeAidatOdemeListesi" ClientInstanceName="GridViewUyeAidatOdemeListesi" runat="server" KeyFieldName="AidatTakipKey" AutoGenerateColumns="false" Width="100%" Font-Size="Small">
                        <Settings ShowGroupPanel="true" />
                        <SettingsPager Visible="true" PageSize="20" AlwaysShowPager="true" Position="Bottom" ShowEmptyDataRows="true" />
                        <Paddings Padding="0px" />
                        <Border BorderWidth="0px" />
                        <BorderBottom BorderWidth="1px" />
                        <Columns>
                            <dx:GridViewDataColumn FieldName="Sira" Caption="Sıra No">
                                <CellStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="SicilNo" Caption="Sicil No">
                                <CellStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="Unvan" Caption="Unvan">
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="MeslekGrupAdi" Caption="Meslek Grubu">
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="Yil" Caption="Yılı">
                                <CellStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="DereceAdi" Caption="Derecesi">
                                <CellStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="ToplamAidat" Caption="Toplam Aidatı">
                                <CellStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="Kalan" Caption="Kalan">
                                <CellStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="Durum" Caption="Durum" Visible="false">
                                <CellStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewBandColumn Caption="Taksit 1" Visible="false">
                                <Columns>
                                    <dx:GridViewDataColumn FieldName="OdemeTarihi1" Caption="Ödeme Tarihi">
                                        <CellStyle HorizontalAlign="Center" />
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </dx:GridViewDataColumn>
                                    <dx:GridViewDataColumn FieldName="OdemeYilAy1" Caption="Yili">
                                        <CellStyle HorizontalAlign="Center" />
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </dx:GridViewDataColumn>
                                    <dx:GridViewDataColumn FieldName="OdenenAidat1" Caption="Ödenen Aidat">
                                        <CellStyle HorizontalAlign="Center" />
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </dx:GridViewDataColumn>
                                    <dx:GridViewDataColumn FieldName="OdenenCeza1" Caption="Ödenen Ceza">
                                        <CellStyle HorizontalAlign="Center" />
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </dx:GridViewDataColumn>
                                </Columns>
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewBandColumn>
                            <dx:GridViewBandColumn Caption="Taksit 2" Visible="false">
                                <Columns>
                                    <dx:GridViewDataColumn FieldName="OdemeTarihi2" Caption="Ödeme Tarihi">
                                        <CellStyle HorizontalAlign="Center" />
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </dx:GridViewDataColumn>
                                    <dx:GridViewDataColumn FieldName="OdemeYilAy2" Caption="Yili">
                                        <CellStyle HorizontalAlign="Center" />
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </dx:GridViewDataColumn>
                                    <dx:GridViewDataColumn FieldName="OdenenAidat2" Caption="Ödenen Aidat">
                                        <CellStyle HorizontalAlign="Center" />
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </dx:GridViewDataColumn>
                                    <dx:GridViewDataColumn FieldName="OdenenCeza2" Caption="Ödenen Ceza">
                                        <CellStyle HorizontalAlign="Center" />
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </dx:GridViewDataColumn>
                                </Columns>
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewBandColumn>
                        </Columns>
                    </dx:ASPxGridView>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
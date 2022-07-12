<%@ Page Title="" Language="C#" MasterPageFile="~/Master_Page/Main.master" AutoEventWireup="true" CodeBehind="VerilenVerilmeyenMallar.aspx.cs" Inherits="TicaretBorsasi_Project.Program.SalonSatis.SatisIslemleri.VerilenVerilmeyenMallar" %>

<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridView.Export" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>

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
                <td class="TdSolZorunlu" style="width: 15%">
                    <dx:ASPxLabel runat="server" Text="Tarih : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag">
                      <dx:ASPxDateEdit ID="DateEditTarih" runat="server" Font-Size="Small" Width="200">
                            <ValidationSettings ValidationGroup="Ara" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                      </dx:ASPxDateEdit>
                </td>
                <td class="TdSol" style="width: 15%">
                    <dx:ASPxLabel runat="server" Text="Durum : " Font-Size="Small"  />
                </td>
                <td class="TdSag">
                    <dx:ASPxRadioButtonList ID="RadioButtonListDurum" runat="server" ValueType="System.String" RepeatDirection="Horizontal" Font-Size="Small" Width="100%" >
                        <Items>
                            <dx:ListEditItem Selected="true" Text="Tümü" Value="1" />
                            <dx:ListEditItem Text="Verilen Mallar" Value="2" />
                            <dx:ListEditItem Text="Verilmeyen Mallar" Value="3" />
                        </Items>
                    </dx:ASPxRadioButtonList>
                </td>
            </tr>
            <tr>
                <td class="TdOrtala" colspan="4">
                    <div style="float: left; margin-left: 40%;">
                        <dx:ASPxButton ID="ButtonAra" runat="server" Text="Ara" Width="120" Font-Size="Small" ValidationGroup="Ara" OnClick="ButtonAra_Click" />
                        <dx:ASPxButton ID="ButtonTemizle" runat="server" Text="Temizle" Width="120" Font-Size="Small" OnClick="ButtonTemizle_Click" />
                    </div>
                    <div style="float: right;" runat="server">
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
                    <dx:ASPxGridViewExporter ExportedRowType="All" GridViewID="GridViewVerilenVerilmeyenMallar" ID="GridViewExporterVerilenVerilmeyenMallar" runat="server">
                    </dx:ASPxGridViewExporter>
                    <dx:ASPxGridView ID="GridViewVerilenVerilmeyenMallar" ClientInstanceName="GridViewVerilenVerilmeyenMallar" runat="server" KeyFieldName="TuccarDepoKey" AutoGenerateColumns="false" Width="100%" Font-Size="Small" OnCustomButtonCallback="GridViewVerilenVerilmeyenMallar_CustomButtonCallback" OnDataBinding="GridViewVerilenVerilmeyenMallar_DataBinding">
                        <Settings ShowGroupPanel="true" />
                        <SettingsBehavior AllowDragDrop="true" AllowFocusedRow="false" />
                        <SettingsPager Visible="true" PageSize="20" AlwaysShowPager="true" Position="Bottom" ShowEmptyDataRows="true" />
                        <Paddings Padding="0px" />
                        <Border BorderWidth="0px" />
                        <BorderBottom BorderWidth="1px" />
                        <Columns>
                            <dx:GridViewDataColumn FieldName="" Caption="K. No">
                                <CellStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="" Caption="Madde Adi">
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="" Caption="Tahmini Miktar">
                                <CellStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="" Caption="Üretici Adi">
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="" Caption="Tüccar Adi">
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="" Caption="Satış Fiyatı">
                                <CellStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewCommandColumn Caption="İşlemler" ButtonType="Image">
                                <CustomButtons>
                                    <dx:GridViewCommandColumnCustomButton ID="ImageButtonKabul" Visibility="AllDataRows" Image-ToolTip="Kabul" Image-Url="../../../Content/Images/Icons/edit.png" Image-Width="24" Image-Height="24">
                                    </dx:GridViewCommandColumnCustomButton>
                                    <dx:GridViewCommandColumnCustomButton ID="ImageButtonRed" Visibility="AllDataRows" Image-ToolTip="Red" Image-Url="../../../Content/Images/Icons/cancel.png" Image-Width="24" Image-Height="24">
                                    </dx:GridViewCommandColumnCustomButton>
                                </CustomButtons>                               
                                <CellStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </dx:GridViewCommandColumn>
                        </Columns>
                    </dx:ASPxGridView>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>

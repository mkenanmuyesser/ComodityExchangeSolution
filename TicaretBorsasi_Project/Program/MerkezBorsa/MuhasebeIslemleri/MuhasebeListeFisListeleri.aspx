<%@ Page Title="" Language="C#" MasterPageFile="~/Master_Page/Main.master" AutoEventWireup="true" CodeBehind="MuhasebeListeFisListeleri.aspx.cs" Inherits="TicaretBorsasi_Project.Program.MerkezBorsa.MuhasebeIslemleri.MuhasebeListeFisListeleri" %>

<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridView.Export" TagPrefix="dx" %>
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
                    <dx:ASPxLabel runat="server" Text="Muhasebe Adı : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxComboBox ID="ComboBoxMuhasebeTip" runat="server" ValueType="System.String" Width="200px" Font-Size="Small" TextField="Adi" ValueField="MuhasebeTipKey">
                        <ValidationSettings ValidationGroup="Ara" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxComboBox>
                </td>
                <td class="TdSolZorunlu" style="width: 15%;">Yıl</td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxComboBox ID="ComboBoxYil" runat="server" ValueType="System.String" Width="200px" Font-Size="Small">
                        <ValidationSettings ValidationGroup="Ara" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxComboBox>
                </td>
            </tr>
            <tr>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Başlangıç Tarihi : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxDateEdit ID="DateEditBaslangic" runat="server" Font-Size="Small" Width="200">
                        <ValidationSettings ValidationGroup="Ara" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxDateEdit>
                </td>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Bitiş Tarihi : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxDateEdit ID="DateEditBitis" runat="server" Font-Size="Small" Width="200">
                        <ValidationSettings ValidationGroup="Ara" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxDateEdit>
                </td>
            </tr>
            <tr>
                <td colspan="4" class="TdOrtala">
                    <div style="float: left;">
                        <dx:ASPxButton ID="ButtonFisBas" runat="server" Text="Fiş Bas" Width="120" Font-Size="Small" OnClick="ButtonFisBas_Click" />
                    </div>
                    <div style="float: left; margin-left: 30%;">
                        <dx:ASPxButton ID="ButtonAra" runat="server" Text="Ara" Width="120" Font-Size="Small" ValidationGroup="Ara" OnClick="ButtonAra_Click" />
                        <dx:ASPxButton ID="ButtonTemizle" runat="server" Text="Temizle" Width="120" Font-Size="Small" OnClick="ButtonTemizle_Click" />
                    </div>
                    <div style="float: right;">
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
                    <dx:ASPxGridViewExporter ExportedRowType="All" GridViewID="GridViewFis" ID="GridViewExporterFis" runat="server">
                    </dx:ASPxGridViewExporter>
                    <dx:ASPxGridView ID="GridViewFis" ClientInstanceName="GridViewFis" runat="server" KeyFieldName="YevmiyeKey" AutoGenerateColumns="false" Width="100%" Font-Size="Small">
                        <Settings ShowGroupPanel="False" />
                        <SettingsBehavior AllowDragDrop="False" AllowFocusedRow="True" ConfirmDelete="false" />
                        <SettingsPager Visible="true" PageSize="20" AlwaysShowPager="true" Position="Bottom" ShowEmptyDataRows="true" />
                        <Paddings Padding="0px" />
                        <Border BorderWidth="0px" />
                        <BorderBottom BorderWidth="1px" />
                        <Columns>
                            <dx:GridViewCommandColumn ShowSelectCheckbox="True" VisibleIndex="0" Caption="Bas" Width="5%">
                                <HeaderStyle HorizontalAlign="Center" />
                                <CellStyle HorizontalAlign="Center" />
                            </dx:GridViewCommandColumn>
                            <dx:GridViewDataColumn FieldName="FisTarih" Caption="Fiş Tarihi">
                                <HeaderStyle HorizontalAlign="Center" />
                                <CellStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="FisTip" Caption="Tip">
                                <HeaderStyle HorizontalAlign="Center" />
                                <CellStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn FieldName="FisNo" Caption="Fiş No">
                                <HeaderStyle HorizontalAlign="Center" />
                                <CellStyle HorizontalAlign="Center" />
                            </dx:GridViewDataColumn>
                        </Columns>
                    </dx:ASPxGridView>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>

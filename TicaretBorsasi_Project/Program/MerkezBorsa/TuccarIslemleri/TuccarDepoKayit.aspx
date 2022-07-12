<%@ Page Title="" Language="C#" MasterPageFile="~/Master_Page/Main.master" AutoEventWireup="true" CodeBehind="TuccarDepoKayit.aspx.cs" Inherits="TicaretBorsasi_Project.Program.MerkezBorsa.TuccarIslemleri.TuccarDepoKayit" %>
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
            <tr runat="server" id="trSicilGrubu1">
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Sicil No / Unvan : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxComboBox ID="ComboBoxSicilNoUnvan" runat="server" ValueType="System.Int32" Width="400px" Font-Size="Small" TextField="SicilNoUnvan" ValueField="TuccarSicilKey" IncrementalFilteringMode="Contains" LoadDropDownOnDemand="True" LoadingPanelText="Yükleniyor&hellip;">
                        <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxComboBox>
                </td>
                <td class="TdSolZorunlu" style="width: 15%;"></td>
                <td class="TdSag" style="width: 35%;"></td>
            </tr>
            <tr runat="server" id="trSicilGrubu2">
                <td class="TdSol" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Sicil No : " Font-Size="Small" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxLabel ID="LabelSicilNo" runat="server" Font-Size="Small" />
                </td>
                <td class="TdSol" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Unvan : " Font-Size="Small" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxLabel ID="LabelUnvan" runat="server" Font-Size="Small" />
                </td>
            </tr>
            <tr>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Madde Kodu : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxComboBox ID="ComboBoxMaddeKodu" runat="server" ValueType="System.Int32" Width="200px" Font-Size="Small" TextField="Adi" ValueField="MaddeKodKey">
                        <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxComboBox>
                </td>
                <td class="TdSolZorunlu" style="width: 15%;"></td>
                <td class="TdSag" style="width: 35%;"></td>
            </tr>
            <tr>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Devir : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxSpinEdit ID="SpinEditDevir1" runat="server" Number="0.0" DecimalPlaces="3" Width="200px" Font-Size="Small" MaxLength="9" NumberType="Float" AllowNull="false" SpinButtons-ShowIncrementButtons="false">
                        <SpinButtons ShowIncrementButtons="False"></SpinButtons>
                        <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxSpinEdit>
                </td>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Devir : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxSpinEdit ID="SpinEditDevir2" runat="server" Number="0.0" DecimalPlaces="3" Width="200px" Font-Size="Small" MaxLength="9" NumberType="Float" AllowNull="false" SpinButtons-ShowIncrementButtons="false">
                        <SpinButtons ShowIncrementButtons="False"></SpinButtons>
                        <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxSpinEdit>
                </td>
            </tr>
            <tr>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Alış : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxSpinEdit ID="SpinEditAlis1" runat="server" Number="0.0" DecimalPlaces="3" Width="200px" Font-Size="Small" MaxLength="9" NumberType="Float" AllowNull="false" SpinButtons-ShowIncrementButtons="false">
                        <SpinButtons ShowIncrementButtons="False"></SpinButtons>
                        <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxSpinEdit>
                </td>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Alış : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxSpinEdit ID="SpinEditAlis2" runat="server" Number="0.0" DecimalPlaces="3" Width="200px" Font-Size="Small" MaxLength="9" NumberType="Float" AllowNull="false" SpinButtons-ShowIncrementButtons="false">
                        <SpinButtons ShowIncrementButtons="False"></SpinButtons>
                        <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxSpinEdit>
                </td>
            </tr>
            <tr>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Satış : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxSpinEdit ID="SpinEditSatis1" runat="server" Number="0.0" DecimalPlaces="3" Width="200px" Font-Size="Small" MaxLength="9" NumberType="Float" AllowNull="false" SpinButtons-ShowIncrementButtons="false">
                        <SpinButtons ShowIncrementButtons="False"></SpinButtons>
                        <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxSpinEdit>
                </td>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Satış : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxSpinEdit ID="SpinEditSatis2" runat="server" Number="0.0" DecimalPlaces="3" Width="200px" Font-Size="Small" MaxLength="9" NumberType="Float" AllowNull="false" SpinButtons-ShowIncrementButtons="false">
                        <SpinButtons ShowIncrementButtons="False"></SpinButtons>
                        <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxSpinEdit>
                </td>
            </tr>
            <tr>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Diğer Borsa Alış : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxSpinEdit ID="SpinEditDigerBorsaAlis1" runat="server" Number="0.0" DecimalPlaces="3" Width="200px" Font-Size="Small" MaxLength="9" NumberType="Float" AllowNull="false" SpinButtons-ShowIncrementButtons="false">
                        <SpinButtons ShowIncrementButtons="False"></SpinButtons>
                        <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxSpinEdit>
                </td>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Diğer Borsa Alış : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxSpinEdit ID="SpinEditDigerBorsaAlis2" runat="server" Number="0.0" DecimalPlaces="3" Width="200px" Font-Size="Small" MaxLength="9" NumberType="Float" AllowNull="false" SpinButtons-ShowIncrementButtons="false">
                        <SpinButtons ShowIncrementButtons="False"></SpinButtons>
                        <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxSpinEdit>
                </td>
            </tr>
            <tr>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Diğer Borsa Satış : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxSpinEdit ID="SpinEditDigerBorsaSatis1" runat="server" Number="0.0" DecimalPlaces="3" Width="200px" Font-Size="Small" MaxLength="9" NumberType="Float" AllowNull="false" SpinButtons-ShowIncrementButtons="false">
                        <SpinButtons ShowIncrementButtons="False"></SpinButtons>
                        <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxSpinEdit>
                </td>
                <td class="TdSolZorunlu" style="width: 15%;">
                    <dx:ASPxLabel runat="server" Text="Diğer Borsa Satış : " Font-Size="Small" ForeColor="Red" />
                </td>
                <td class="TdSag" style="width: 35%;">
                    <dx:ASPxSpinEdit ID="SpinEditDigerBorsaSatis2" runat="server" Number="0.0" DecimalPlaces="3" Width="200px" Font-Size="Small" MaxLength="9" NumberType="Float" AllowNull="false" SpinButtons-ShowIncrementButtons="false">
                        <SpinButtons ShowIncrementButtons="False"></SpinButtons>
                        <ValidationSettings ValidationGroup="KayitGuncelle" Display="Dynamic">
                            <RequiredField ErrorText=" " IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxSpinEdit>
                </td>
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
<%@ Page Title="" Language="C#" MasterPageFile="~/Master_Page/Main.master" AutoEventWireup="true" CodeBehind="AnaMenu.aspx.cs" Inherits="TicaretBorsasi_Project.Program.AnaMenu" %>
<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>

<asp:Content ID="Content" ContentPlaceHolderID="ContentPlaceHolderMiddleContent" runat="server">
    <div style="margin-left: 35%; margin-top: 50px;">
        <table>
            <tr>
                <td>
                    <dx:ASPxBinaryImage ID="BinaryImageResim" runat="server" Width="400" Height="400"  BackgroundImage-Repeat="NoRepeat" ImageAlign="Middle" Border-BorderWidth="1">
                    </dx:ASPxBinaryImage>
                </td>
                <td>
                    <marquee direction="up" style="font-family: 'Segoe UI'; font-size: large; margin-left: 50px;" scrollamount="2">                
                        <asp:Repeater ID="RepeaterDuyurular" runat="server">
                            <ItemTemplate>
                                <table>
                                    <tr>
                                        <td>Tarih : <%# String.Format("{0:dd.MM.yyyy}", Eval("ProgramDuyuruTarih")) %> </td>
                                    </tr>
                                    <tr>
                                        <td><%# Eval("ProgramDuyuru") %></td>
                                    </tr>
                                    <tr>
                                        <br />
                                    </tr>
                                </table>
                            </ItemTemplate>
                        </asp:Repeater>
                    </marquee>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
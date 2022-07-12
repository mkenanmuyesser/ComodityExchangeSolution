<%@ Page Title="" Language="C#" MasterPageFile="~/Master_Page/Main.master" AutoEventWireup="true" CodeBehind="RaporMuhasebeIslemleri.aspx.cs" Inherits="TicaretBorsasi_Project.Program.MerkezBorsa.MuhasebeIslemleri.RaporMuhasebeIslemleri" %>
<%@ Register Assembly="DevExpress.XtraReports.v14.1.Web, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraReports.Web" TagPrefix="dx" %>

<asp:Content ID="Content" ContentPlaceHolderID="ContentPlaceHolderMiddleContent" runat="server">
    <dx:ASPxDocumentViewer ID="DocumentViewerRapor" runat="server" Width="100%" ></dx:ASPxDocumentViewer>
</asp:Content>
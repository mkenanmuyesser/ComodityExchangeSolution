<%@ Page Title="" Language="C#" MasterPageFile="~/Master_Page/Main.master" AutoEventWireup="true" CodeBehind="IlIlceIslemleri.aspx.cs" Inherits="TicaretBorsasi_Project.Program.MerkezBorsa.ParametreKodluBilgiIslemleri.IlIlceIslemleri" %>

<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridView.Export" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>

<%@ Register src="../../../User_Control/Ortak/ParametreKodluIlIlceIslemleriUserControl.ascx" tagname="ParametreKodluIlIlceIslemleriUserControl" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderMiddleContent" runat="server">
    <uc1:ParametreKodluIlIlceIslemleriUserControl ID="ParametreKodluIlIlceIslemleriUserControl1" runat="server" />   
</asp:Content>
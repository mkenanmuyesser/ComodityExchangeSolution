﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Master_Page/Main.master" AutoEventWireup="true" CodeBehind="TicaretSicilMemurluguIslemleri.aspx.cs" Inherits="TicaretBorsasi_Project.Program.MerkezBorsa.ParametreKodluBilgiIslemleri.TicaretSicilMemurluguIslemleri" %>

<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridView.Export" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>

<%@ Register src="../../../User_Control/Ortak/ParametreKodluTicaretSicilMemurluguIslemleriUserControl.ascx" tagname="ParametreKodluTicaretSicilMemurluguIslemleriUserControl" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderMiddleContent" runat="server">    
    <uc1:ParametreKodluTicaretSicilMemurluguIslemleriUserControl ID="ParametreKodluTicaretSicilMemurluguIslemleriUserControl1" runat="server" />    
</asp:Content>
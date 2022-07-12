<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RaporPopUp.aspx.cs" Inherits="TicaretBorsasi_Project.Program.MerkezBorsa.TuccarIslemleri.PopUp.RaporPopUp" %>

<%@ Register Assembly="DevExpress.XtraReports.v14.1.Web, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraReports.Web" TagPrefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
        <title></title>
    </head>
    <body>
        <form id="form1" runat="server">
            <div>
                <dx:ASPxDocumentViewer ID="DocumentViewerRapor" runat="server" Width="100%"  >
                    <SettingsReportViewer PrintUsingAdobePlugIn="false"/>            
                </dx:ASPxDocumentViewer>
            </div>
        </form>
    </body>
</html>
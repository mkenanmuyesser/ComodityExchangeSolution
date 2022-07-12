<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SalonSatisKullanici.aspx.cs" Inherits="TicaretBorsasi_Project.Genel.SalonSatisKullanici" %>

<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Tüccar Teklif Modülü</title>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link href="../Content/Css/font-awesome.css" rel="stylesheet" />
    <link href="../Content/Css/bootstrap.min.css" rel="stylesheet" />
    <link href="../Content/Css/toastr.min.css" rel="stylesheet" />
    <link href="../Content/Css/animate.css" rel="stylesheet" />
    <link href="../Content/Css/style.css" rel="stylesheet" />
    <link href="../Content/Css/custom.css" rel="stylesheet" />
    <link href="../Content/Css/jquery.gritter.css" rel="stylesheet" />

    <script src="../Content/Scripts/jquery-2.1.1.js"></script>
    <script src="../Content/Scripts/bootstrap.min.js"></script>
    <script src="../Content/Scripts/jquery.metisMenu.js"></script>
    <script src="../Content/Scripts/jquery.slimscroll.min.js"></script>
    <script src="../Content/Scripts/inspinia.js"></script>
    <script src="../Content/Scripts/pace.min.js"></script>
    <script src="../Content/Scripts/jquery.signalR-2.2.0.js"></script>
    <script src="../signalr/hubs"></script>
    <script src="../Content/Scripts/SignalR.Kullanici.js"></script>
</head>
<body class="top-navigation">
    <form id="form1" runat="server">
        <div id="wrapper">

            <div id="page-wrapper" class="gray-bg">

                <div class="row border-bottom white-bg">
                    <nav class="navbar navbar-static-top" role="navigation">
                        <div class="navbar-header">
                            <button aria-controls="navbar" aria-expanded="false" data-target="#navbar" data-toggle="collapse" class="navbar-toggle collapsed" type="button">
                                <i class="fa fa-reorder"></i>
                            </button>
                            <a href="#" class="navbar-brand">TTM</a>
                        </div>
                        <div class="navbar-collapse collapse" id="navbar">
                            <ul class="nav navbar-top-links navbar-right">
                                <li>
                                    <span id="spanTarihSaat">99.99.9999 99:99:99</span> |
                                </li>
                                <li>
                                    <asp:LoginView ID="LoginView1" runat="server" EnableViewState="false">
                                        <LoggedInTemplate>
                                            <asp:LoginName ID="HeadLoginName" runat="server" />
                                        </LoggedInTemplate>
                                    </asp:LoginView>
                                    |
                                </li>
                                <li>
                                    <span class="m-r-sm text-muted welcome-message">Ticaret Borsası Project <strong>v 1.1</strong></span> |
                                </li>
                                <li>
                                    <a href="../Default.aspx">
                                        <i class="fa fa-sign-out"></i>Çıkış
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </nav>
                </div>

                <div class="wrapper wrapper-content animated fadeInRight">
                    <div class="row wrapper border-bottom white-bg page-heading">
                        <div class="col-lg-9">
                            <h2>Tüccar Teklif Modülü</h2>
                        </div>
                    </div>

                    <div class="wrapper wrapper-content ">
                        <div class="row">
                            <div class="col-lg-4">
                                <div id="divAnlikFiyat" class="widget-head-color-box yellow-bg p-lg text-center">
                                    <div class="m-b-md">
                                        <h2 class="font-bold no-margins">Anlık Fiyat</h2>
                                    </div>
                                    <center>
                                        <div class="m-b-md" style="background-image: url(../Content/Images/backgrounds/daire_gri_orta.png);background-repeat: no-repeat;background-position: center;width: 128px;height: 128px;" >
                                           <h1><span id="spanAnlikFiyat" style="position: relative;top: 45px;left: 0px;color: royalblue;font-weight: bold;">-</span></h1>
                                        </div>
                                    </center>
                                </div>
                                <div class="widget-text-box">
                                    <div class="text-right">
                                        <button id="buttonTeklifVer" class="btn btn-primary " type="button" disabled="True"><i class="fa fa-check"></i>&nbsp;Teklif Ver</button>
                                        <button id="buttonTeklifCek" class="btn btn-danger " type="button" disabled="True"><i class="fa fa-times"></i>&nbsp;Teklif Çek</button>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-2">
                                <div class="widget red-bg p-lg text-center">
                                    <div class="m-b-md">
                                        <h2 class="font-bold no-margins">Süre</h2>
                                    </div>
                                    <div>
                                        <i class="fa fa-bell fa-4x"></i>
                                        <h1 class="m-xs"><span id="spanSayac">-</span></h1>
                                        <h3 class="font-bold no-margins"></h3>
                                        <small></small>
                                    </div>
                                </div>
                                <div class="widget navy-bg">
                                    <div class="row">
                                        <div class="col-xs-8 text-left">
                                            <h4 class="font-bold no-margins">Başlangıç Fiyatı</h4>
                                            <br/>
                                            <h4 class="font-bold">-</h4>
                                        </div>
                                        <div class="col-xs-4 text-center">
                                            <i class="fa fa-try fa-5x"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="ibox float-e-margins">
                                    <div class="ibox-title">
                                        <h5>Ürün Bilgileri</h5>
                                    </div>
                                    <div class="ibox-content no-padding">
                                        <table class="table table-hover no-margins">
                                            <tbody>
                                                <tr>
                                                    <td>
                                                        <button type="button" class="btn btn-danger m-r-sm">12</button>
                                                        test data
                                                    </td>
                                                    <td>
                                                        <button type="button" class="btn btn-primary m-r-sm">28</button>
                                                        test data
                                                    </td>
                                                    <td>
                                                        <button type="button" class="btn btn-info m-r-sm">15</button>
                                                        test data
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <button type="button" class="btn btn-danger m-r-sm">12</button>
                                                        test data
                                                    </td>
                                                    <td>
                                                        <button type="button" class="btn btn-primary m-r-sm">28</button>
                                                        test data
                                                    </td>
                                                    <td>
                                                        <button type="button" class="btn btn-info m-r-sm">15</button>
                                                        test data
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <button type="button" class="btn btn-danger m-r-sm">12</button>
                                                        test data
                                                    </td>
                                                    <td>
                                                        <button type="button" class="btn btn-primary m-r-sm">28</button>
                                                        test data
                                                    </td>
                                                    <td>
                                                        <button type="button" class="btn btn-info m-r-sm">15</button>
                                                        test data
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <button type="button" class="btn btn-danger m-r-sm">12</button>
                                                        test data
                                                    </td>
                                                    <td>
                                                        <button type="button" class="btn btn-primary m-r-sm">28</button>
                                                        test data
                                                    </td>
                                                    <td>
                                                        <button type="button" class="btn btn-info m-r-sm">15</button>
                                                        test data
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <button type="button" class="btn btn-danger m-r-sm">12</button>
                                                        test data
                                                    </td>
                                                    <td>
                                                        <button type="button" class="btn btn-primary m-r-sm">28</button>
                                                        test data
                                                    </td>
                                                    <td>
                                                        <button type="button" class="btn btn-info m-r-sm">15</button>
                                                        test data
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <br />
                        <div class="row">
                            <div class="col-lg-6">
                                <div class="ibox float-e-margins">
                                    <div class="ibox-title">
                                        <h5>Durum Raporları</h5>
                                    </div>
                                    <div class="ibox-content no-padding">
                                        <table class="table table-hover no-margins">
                                            <tbody>
                                                <tr>
                                                    <td><small>Sunucu Durum : </small></td>
                                                    <td class="text-info"><span id="spanCevirimDurum">Çevirimdışı</span>
                                                        <img id="imgCevirimDurum" src="../Content/Images/Icons/warning.png" width="16" height="16" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td><small>Satış Durum : </small></td>
                                                    <td class="text-danger"><span id="spanSatisDurum">Pasif</span></td>
                                                </tr>
                                                <tr>
                                                    <td><small>Satış No : </small></td>
                                                    <td class="text-navy"><span id="spanSatisNo">0</span></td>
                                                </tr>
                                                <tr>
                                                    <td><small>Ortalama : </small></td>
                                                    <td class="text-capitalize"><span id="spanOrtalamaFiyat">0</span></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-2">
                                <div class="ibox float-e-margins">
                                    <div class="ibox-title">
                                        <span class="label label-success pull-right">&nbsp;&nbsp;</span>
                                        <h5>Aktif Kullanıcılar</h5>
                                    </div>
                                    <div class="ibox-content">
                                        <small><span id="spanAktifKullanicilar"></span></small>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-2">
                                <div class="ibox float-e-margins">
                                    <div class="ibox-title">
                                        <span class="label label-info pull-right">&nbsp;&nbsp;</span>
                                        <h5>Teklif Verenler</h5>
                                    </div>
                                    <div class="ibox-content">
                                        <small><span id="spanTeklifVerenKullanicilar"></span></small>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-2">
                                <div class="ibox float-e-margins">
                                    <div class="ibox-title">
                                        <span class="label label-default pull-right">&nbsp;&nbsp;</span>
                                        <h5>Tekliften Çekilenler</h5>
                                    </div>
                                    <div class="ibox-content">
                                        <small><span id="spanTekliftenCekilenKullanicilar"></span></small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="footer">
                    <div class="pull-left">
                        <strong>Gayret Bilgisayar</strong> &copy; 2015           
                    </div>
                </div>

            </div>

        </div>
    </form>
</body>
</html>

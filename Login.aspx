﻿<%@ Page Language="VB" AutoEventWireup="false" EnableEventValidation="false" CodeFile="Login.aspx.vb" Inherits="Login" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

    <title>Deloitte 360</title>
    <link href="Images/favicon.ico" rel="shortcut icon" type="image/x-icon" />
    <!-- CSS Files -->
    <%--<link href="Content/font-awesome.css" rel="stylesheet" type="text/css" />--%>
    <link href="Content/Site.css" rel="stylesheet" type="text/css" />
    <link href="Content/bootstrap.min.css" rel="stylesheet" type="text/css" />


    <!-- jQuery -->
    <script src="Scripts/jqueryJS.js"></script>
    <script src="Scripts/loginJS2.js"></script>
    <style>
        html,body {
            overflow:hidden !important;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="full-background">
            <img src="Images/login-bg.jpg" class="bg-img" />
        </div>
        <div class="wrapper">
            <div class="main-header">
                <div class="container">
                    <!-- Logo -->
                    <a href="####" class="logo">
                        <!-- logo for regular state and mobile devices -->
                        <span class="logo-lg">
                            <asp:Image ID="imgTopLeftLogo" runat="server" ImageUrl="~/Images/deloitte.svg" />
                        </span></a>
                </div>
            </div>
            <div class="container-fluid">
                <div class="loginfrm cls-4">
                    <div class="login-box">
                        <!-- Login Title -->
                        <div class="login-box-msg">
                            <h3 class="title">Login</h3>
                        </div>

                        <!-- Login Form -->
                        <div class="login-box-body clearfix">
                            <div class="frm-group">
                                <label for="txtLoginID">Email</label>
                                <div class="input-group">
                                    <input type="text" id="txtLoginID" class="form-control" placeholder="Enter your Email" autocomplete="off" />
                                </div>
                            </div>
                            <input type="button" id="btnLogin" value="Next" class="btns btn-submit w-100" />
                            <a href="Data/frmUndertakingPage.aspx" style="font-size: 11px; font-style: italic">Privacy Statement</a>
                            <div class="text-center">
                                <div id="dvMessage" runat="server" class="text-danger font-weight-bold"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Footer Links -->
        <div class="footer">
            <p class="footer-text">
                Deloitte refers to one or more of Deloitte Touche Tohmatsu Limited, a UK private company limited by guarantee ("DTTL"), its network of member firms, and their related entities. DTTL and each of its member firms are legally separate and independent entities. DTTL (also referred to as "Deloitte Global") does not provide services to user. Please see www.deloitte.com/about for a more detailed description of DTTL and its member firms. This tool is a proprietary application-based tool developed and exclusively owned by Deloitte Touche Tohmatsu India LLP (DTTILLP). The tool enables collecting, compiling or obtaining information. User shall not copy, reproduce, modify, distribute, disseminate the tool, nor will the user reverse engineer, decompile, dismantle or obtain access to the underlying formulae of the tool. Unless specifically agreed with the Client, DTTILLP HAS NO OBLIGATION TO PROVIDE SUPPORT, UPDATES, UPGRADES, OR MODIFICATIONS TO THE TOOL. Copyright ©2024 Deloitte Touche Tohmatsu India LLP. Member of Deloitte Touche Tohmatsu Limited.
            </p>
        </div>

        <div class="loader_bg" style="display: none" id="dvFadeForProcessing">
            <div class="loader"></div>
        </div>
        <asp:HiddenField runat="server" ID="hiddenCSRFToken" />
        <asp:HiddenField ID="hdnEmailId" runat="server" />
    </form>
</body>
</html>

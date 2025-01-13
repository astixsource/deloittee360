﻿<%@ Page Language="VB" AutoEventWireup="false"  CodeFile="Login.aspx.vb" Inherits="Login" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

    <title>HCAS 360</title>
    <%--<link href="Images/favicon.ico" rel="shortcut icon" type="image/x-icon" />--%>
    <!-- CSS Files -->
    <%--<link href="Content/font-awesome.css" rel="stylesheet" type="text/css" />--%>
    <link href="Content/Site.css" rel="stylesheet" type="text/css" />
    <link href="Content/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <%--<link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">--%>
  

    <!-- jQuery -->
    <script src="Scripts/jqueryJS.js"></script>
    <script src="Scripts/loginJS.js"></script>
    
</head>
<body>
    <form id="form1" runat="server">
        <div class="full-background">
            <img src="Images/login-bg.jpg" class="bg-img" />
        </div>

        <div class="loginfrm cls-4">
            <div class="login-box">
                <!-- Logo -->
                <div class="login-logo">
                    <asp:Image ID="imgLogo1" runat="server" ImageUrl="~/Images/Deloitte-logo_Black.png" CssClass="ey-logo" />
                </div>

                <!-- Login Title -->
                <div class="login-box-msg">
                    <h3 class="title">Login</h3>
                </div>

                <!-- Login Form -->
                <div class="login-box-body clearfix">
                    <div class="form-group">
                        <label for="txtLoginID">User Nameee</label>
                        <div class="input-group">
                            <input type="text" id="txtLoginID" class="form-control" placeholder="Enter your User Name" autocomplete="off" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="txtPassword">Password</label>
                        <div class="input-group">
                            <input type="password" id="txtPassword" class="form-control" placeholder="Enter your Password" autocomplete="off" />
                        </div>
                    </div>
                     <input type="button" id="btnLogin" value="Login" class="btns btn-submit w-100" />
                    <%--<asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btns btn-submit w-100" />--%>
                     <div class="text-center">
            <div id="dvMessage" runat="server" class="text-danger font-weight-bold"></div>
        </div>
                </div>

                <!-- Footer Links -->


            </div>
        </div>
       
       <%-- <div id="divAntiforgery" runat="server" style="display:none"></div>--%>
          <div id="dvFadeForProcessing" style="display: none" align="center" class="clsloader">
            <img src="Images/loading.gif" style="margin-top: 300px;" />
        </div>
         <div class="footer">
            <p class="footer-text">
              Deloitte refers to one or more of Deloitte Touche Tohmatsu Limited, a UK private company limited by guarantee ("DTTL"), its network of member firms, and their related entities. DTTL and each of its member firms are legally separate and independent entities. DTTL (also referred to as "Deloitte Global") does not provide services to user. Please see www.deloitte.com/about for a more detailed description of DTTL and its member firms.
This tool is a proprietary application-based tool developed and exclusively owned by Deloitte Touche Tohmatsu India LLP (DTTILLP). The tool enables collecting, compiling or obtaining information. User shall not copy, reproduce, modify, distribute, disseminate the tool, nor will the user reverse engineer, decompile, dismantle or obtain access to the underlying formulae of the tool.
Unless specifically agreed with the Client, DTTILLP HAS NO OBLIGATION TO PROVIDE SUPPORT, UPDATES, UPGRADES, OR MODIFICATIONS TO THE TOOL.
Copyright ©2024 Deloitte Touche Tohmatsu India LLP. Member of Deloitte Touche Tohmatsu Limited  
            </p>
             
        </div>
    </form>
    <%--<div class="col-md-4">
    <%--<div class="login-img">
        <img src="Images/Checkbox1.png" class="w-100" />
    </div>--%>
    <%--</div>--%>
   

</body>
</html>

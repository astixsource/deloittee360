<%@ Page Language="VB" AutoEventWireup="false" CodeFile="LoginPageSSO.aspx.vb" Inherits="LoginPageSSO" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <!-- viewport meta to Content-Type -->
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

    <!-- viewport meta to reset iPhone inital scale -->
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=0" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0," />

    <title>Deloitte 360</title>
    <link href="Content/Site.css" rel="stylesheet" type="text/css" />
 <link href="Content/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <!-- jQuery -->
<script src="Scripts/jqueryJS.js"></script>
<script src="Scripts/loginpageJS_v2.js"></script>
   
</head>
<body onload="fnSetFocus();">
    <form id="form1" runat="server">
         <div class="full-background">
     <img src="Images/login-bg.jpg" class="bg-img" />
 </div>

        <div class="wrapper">
    <div class="main-header">
        <div class="container">
            <!-- Logo -->
            <a href="#" class="logo">
                <!-- logo for regular state and mobile devices -->
                <span class="logo-lg">
                    <asp:Image ID="imgTopLeftLogo" runat="server" ImageUrl="~/Images/Deloitte-logo_White.png" />
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
                     <div id="dvMessage" align="center" runat="server" style="color: #FF0000; display: inline-block;"></div>
                    <div class="text-center">
                         <asp:Button ID="btnSubmit" Text="Click To Re-Login" CssClass="btns btn-submit" OnClick="btnSubmit_Click" runat="server" />
                        
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
       
       
        <div id="dvFadeForProcessing" style="position: fixed; z-index: 9999999999999; display: none; top: 0; bottom: 0; left: 0; right: 0; opacity: .80; -moz-opacity: 0.8; filter: alpha(opacity=80); background-color: #ccc;">
            <div id="Div2" runat="server" align="center" style="position: absolute; width: 150px; top: 35%; left: 45%;">
                <img alt="" title="Loading..." src="Images/blue-loading.gif" />
            </div>
        </div>
        <input type="hidden" id="hdnRes" runat="server" name="hdnRes" />
    </form>
</body>
</html>

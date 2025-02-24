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
    <%--<link href="CSS/theme.css" rel="stylesheet" type="text/css" />--%>
    <link href="styles/Multiselect/jquery-ui.css" rel="stylesheet" type="text/css" />
    <script src="scripts/MultiSelect/jquery.js" type="text/javascript"></script>
    <script src="scripts/MultiSelect/jquery-ui.min.js" type="text/javascript"></script>
    <link href="CSS/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <%--<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js" type="text/javascript"></script>--%>
    <style type="text/css">
        * {
            -webkit-box-sizing: border-box;
            -moz-box-sizing: border-box;
            box-sizing: border-box;
        }

        :after,
        :before {
            -webkit-box-sizing: border-box;
            -moz-box-sizing: border-box;
            box-sizing: border-box;
        }

        .full-background img,
        img.full-background {
            z-index: -4;
            height: 100%;
            width: 100%;
            position: fixed;
            left: 0;
            display: block;
            opacity: 0.7;
        }

        .full-background:after {
            background: #000;
            position: absolute;
            content: "";
            z-index: -2;
            top: 0px;
            bottom: 0px;
            left: 0px;
            right: 0px;
            opacity: 0.6;
            filter: alpha(opacity=60);
        }

        .login-box-left {
            height: 400px;
            display: table-cell;
            vertical-align: middle;
            text-align: center;
        }

            .login-box-left img {
                height: 200px;
                box-shadow: 2px 2px 10px 2px #4d4d4d;
            }

        input {
            outline: none;
            border: none;
        }

            input[type="number"] {
                -moz-appearance: textfield;
                -webkit-appearance: none;
            }

                input[type="number"]::-webkit-outer-spin-button,
                input[type="number"]::-webkit-inner-spin-button {
                    -webkit-appearance: none;
                }

            input:focus::-webkit-input-placeholder {
                color: transparent;
            }

            input:focus:-moz-placeholder {
                color: transparent;
            }

            input:focus::-moz-placeholder {
                color: transparent;
            }

            input:focus:-ms-input-placeholder {
                color: transparent;
            }

            input::-webkit-input-placeholder {
                color: #868686;
            }

            input:-moz-placeholder {
                color: #868686;
            }

            input::-moz-placeholder {
                color: #868686;
            }

            input:-ms-input-placeholder {
                color: #868686;
            }

        .login-box h4.h4 {
            color: #4d4d4d;
            text-transform: uppercase;
        }

        .login-box {
            background: #fff;
            border: 8px solid rgba(0, 0, 0, .3);
            border-radius: 12px;
            -moz-border-radius: 12px;
            -webkit-border-radius: 12px;
            -webkit-background-clip: padding-box;
            background-clip: padding-box;
            padding: 0 !important;
        }

        .login-box,
        .register-box {
            display: table;
            position: relative;
        }

        .login-box-body,
        .register-box-body {
            padding: 15px 0 0;
            color: #666;
        }

        /*---------------------------------------------------
[ Input ]*/

        .custom-form-group {
            width: 100%;
            position: relative;
            border-bottom: 2px solid rgba(0,0,0,0.24);
            margin-bottom: 30px;
        }

        .custom-form-control {
            font-size: 14px;
            color: #808080;
            line-height: 1.2;
            display: block;
            width: 100%;
            height: 45px;
            background: transparent;
            padding: 0 5px 0 40px;
        }

        /*---------------------------------------------*/
        .custom-focus-input {
            position: absolute;
            display: block;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            pointer-events: none;
        }

            .custom-focus-input::before {
                content: "";
                display: block;
                position: absolute;
                bottom: -2px;
                left: 0;
                width: 0;
                height: 2px;
                -webkit-transition: all 0.4s;
                -o-transition: all 0.4s;
                -moz-transition: all 0.4s;
                transition: all 0.4s;
                background: #2488C4;
            }

            .custom-focus-input::after {
                font-family: 'Glyphicons Halflings';
                font-size: 18px;
                color: #808080;
                content: attr(data-placeholder);
                display: block;
                width: 100%;
                position: absolute;
                top: 10px;
                left: 0px;
                padding-left: 5px;
                -webkit-transition: all 0.4s;
                -o-transition: all 0.4s;
                -moz-transition: all 0.4s;
                transition: all 0.4s;
            }

        .custom-form-control:focus {
            padding-left: 5px;
        }

            .custom-form-control:focus + .custom-focus-input::after {
                top: -22px;
                font-size: 18px;
            }

            .custom-form-control:focus + .custom-focus-input::before {
                width: 100%;
            }

        .has-val.custom-form-control + .custom-focus-input::after {
            top: -22px;
            font-size: 18px;
        }

        .has-val.custom-form-control + .custom-focus-input::before {
            width: 100%;
        }

        .has-val.custom-form-control {
            padding-left: 5px;
        }

        /*---------------------------------------------*/

        .frm-group-btn {
            display: inline-flex;
            position: relative;
            z-index: 1;
            border-radius: 5px;
            text-align: right;
            margin-bottom: 6px;
            float: right;
        }

        a.btns,
        .btns {
            background: transparent;
            color: transparent;
            border: none;
            display: inline-block;
            padding: 10px 10px;
            margin-right: 5px;
            border-radius: 3px;
            letter-spacing: 0.06em;
            text-transform: uppercase;
            text-decoration: none;
            outline: none;
            -webkit-box-shadow: 0 1px 3px rgba(0, 0, 0, 0.12), 0 1px 2px rgba(0, 0, 0, 0.24);
            -moz-box-shadow: 0 1px 3px rgba(0, 0, 0, 0.12), 0 1px 2px rgba(0, 0, 0, 0.24);
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.12), 0 1px 2px rgba(0, 0, 0, 0.24);
            -webkit-transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
            transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
        }

            a.btns:hover,
            .btns:hover {
                color: transparent;
                -webkit-box-shadow: 0 7px 14px rgba(0, 0, 0, 0.18), 0 5px 5px rgba(0, 0, 0, 0.12);
                -moz-box-shadow: 0 7px 14px rgba(0, 0, 0, 0.18), 0 5px 5px rgba(0, 0, 0, 0.12);
                box-shadow: 0 7px 14px rgba(0, 0, 0, 0.18), 0 5px 5px rgba(0, 0, 0, 0.12);
            }

            .btns.btn-submit {
                background: #6cb832;
                color: #ffffff;
            }

                .btns.btn-submit:hover {
                    background: #397908;
                    color: #ffffff;
                }

            .btns.btn-cancel {
                background: #2488C4;
                color: #ffffff;
            }

                .btns.btn-cancel:hover {
                    background: #1b6998;
                    color: #ffffff;
                }
    </style>
    <script language="javascript">
        $(document).ready(function () {
            $(".login-box").css({ "margin-top": $(window).height() - ($(this).outerHeight() + 400) / 2 + 'px' });
            $(window).resize(function () {
                if (window.innerWidth <= 768) {
                    $(".login-box").css({ "margin-top": "85px" });
                }
            });

            /*[ Focus input ]*/
            $('.custom-form-control').each(function () {
                $(this).on('blur', function () {
                    if ($(this).val().trim() != "") {
                        $(this).addClass('has-val');
                    }
                    else {
                        $(this).removeClass('has-val');
                    }
                });
            });
            $('input,textarea').focus(function () {
                $(this).data('placeholder', $(this).attr('placeholder'))
                    .attr('placeholder', '');
            }).blur(function () {
                $(this).attr('placeholder', $(this).data('placeholder'));
            });
        });

        function fnReset() {
            document.getElementById("txtUserName").value = "";
            document.getElementById("txtPassword").value = "";
            document.getElementById("txtUserName").focus();
            return false;
        }
        function fnValidate() {
            if (document.getElementById("txtUserName").value == "") {
                alert("User name can't be left blank");
                document.getElementById("txtUserName").focus();
                return false;
            }
            else if (document.getElementById("txtPassword").value == "") {
                alert("Password can't be left blank");
                document.getElementById("txtPassword").focus();
                return false;
            }
            else
                return true;
        }
        function fnSetFocus() {
            document.getElementById("hdnRes").value = screen.availWidth + "*" + screen.availHeight;
        }

        function fnOpenForgotPasswordDialog() {
            $("#dvForgotPassword").dialog({
                modal: true,
                title: "Forgot Password",
                width: '450',
                height: 'auto',
                //buttons: {
                //    Close: function () {
                //        $(this).dialog('close');
                //    }
                //},
                open: function () {
                    //Do nothing
                }
            });
        }

        function fnSendResetLink() {
            $("#dvFadeForProcessing").css("display", "block");
            var userName = $("#txtUsernameForForgotPassword").val().trim();

            if (userName == "") {
                $("#dvFadeForProcessing").css("display", "none");
                $("#txtUsernameForForgotPassword").val("");
                $("#txtUsernameForForgotPassword").focus();
                alert("Please enter username first!");
                return false;
            }

            $.ajax({
                url: "dmswebservice.asmx/fnGetUserdetailForResetLink",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: '{UserName:' + JSON.stringify(userName) + '}',
                success: function (response) {
                    $("#dvFadeForProcessing").css("display", "none");
                    var strRep = response.d;

                    if (strRep.split("^")[0] == "1") {
                        alert(strRep.split("^")[1]);
                        //window.location.href = 'frmLogin.aspx';
                                  $("#dvForgotPassword").dialog("close");
                    }
                    else {
                        alert(strRep.split("^")[1]);
                    }
                },
                error: function (msg) {
                    $("#dvFadeForProcessing").css("display", "none");
                    alert(msg.responseText);
                }
            });
        }
    </script>
</head>
<body onload="fnSetFocus();">
    <form id="form1" runat="server">
        <div class="full-background">
            <img src="NewImages/login-bg.jpg" alt="background">
        </div>
        <div class="login-box col-md-6 col-sm-6 col-lg-offset-3 col-md-offset-3 col-sm-offset-3">
            <div class="col-md-6 col-sm-6 text-center">
               
            </div>
            <div class="col-md-6 col-sm-6" style="background-color: #eee;">
                <div class="col-md-10 col-md-offset-1">
                    <div class="text-center" style="padding-top: 30px;">
                    </div>
                    <h4 class="h4">Sign In</h4>
                    <div class="login-box-body">
                        <div id="dvMessage" align="center" runat="server" style="color: #FF0000; display: inline-block;"></div>
                    </div>
                    <div class="frm-group-btn" style="margin-top: 60px" >
                            <asp:Button ID="btnSubmit" Text="Click To Re-Login" CssClass="btns btn-submit" OnClick="btnSubmit_Click" runat="server" />
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

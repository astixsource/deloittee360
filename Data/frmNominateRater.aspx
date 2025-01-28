<%@ Page Title="" Language="C#" MasterPageFile="~/Data/Site.master" AutoEventWireup="true" CodeFile="frmNominateRater.aspx.cs" Inherits="Data_frmNominateRater" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <style>

     .button-group {
            display: flex;
            justify-content: space-evenly;
            align-items: center;
            gap: 15px;
            margin-left: 15px;
        }

         .btn {
            padding: 12px 30px; /* Adjust padding for consistent size */
            font-size: 16px;
            border: none;
           /* border-radius: 5px;*/
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s ease;
            text-align: center;
        }

            .btn:hover {
                transform: translateY(-2px);
            }

            .btn:active {
                transform: translateY(0);
            }

        .btn-previous {
            background-color: #6c757d;
            color: white;
        }

            .btn-previous:hover {
                background-color: #5a6268;
            }

            .btn-previous:active {
                background-color: #495057;
            }

        .btn-next {
            background-color: #88bd26 !important;
            color: white;
        }

            .btn-next:hover {
                background-color: #5e6271 !important;
                color: white;
            }

            .btn-next:active {
                background-color: #1e7e34;
            }

        .btn-submit  {
            background-color:#88bd26 !important;
            color: white;
        }

            .btn-submit:hover {
               background-color: #5e6271 !important;
               color: white;
            }

            .btn-submit:active {
               background-color: #1e7e34;
            }

        .btn-danger {
            background-color: black !important;
            color: white;
            /*padding: 12px 25px;*/ /* Match size with other buttons */
        }

            .btn-danger:hover {
                background-color: black !important;
            }

            .btn-danger:active {
                background-color: #bd2130;
            }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="row no-gutters">
        <div class="col-md-12">

            <div class="section-title">
                <h3 class="text-center">Nominate your Raters</h3>
                <div class="title-line-center"></div>
            </div>
            <h3 class="text-center">Nominate individuals for the rater groups listed below, ensuring a minimum of 3 nominations per category</h3>
            <table>
                <tr>
                    <td style="font-size: 22px">Select Category:</td>
                    <td style="padding: 10px">
                        <asp:DropDownList ID="ddlRelatioShip" CssClass="form-control" Style="width: 195px" runat="server">
                        </asp:DropDownList></td>
                </tr>
            </table>

            <table>
                <p>
                    Enter details of
                    <label id="lblSelectedCategory"><strong>Review Partner</strong></label>
                    Nominee 1*
                </p>
                <tr>
                    <td style="font-size: 22px">Name*:</td>
                    <td style="padding: 10px">
                        <asp:TextBox ID="txtName" CssClass="form-control" Style="width: 195px" runat="server">
                        </asp:TextBox></td>
                </tr>

                <tr>
                    <td style="font-size: 22px">EmailID*:</td>
                    <td style="padding: 10px">
                        <asp:TextBox ID="txtEmailid" CssClass="form-control" Style="width: 195px" runat="server">
                        </asp:TextBox></td>
                </tr>
                <tr>
                    <td style="font-size: 22px">Function*:</td>
                    <td style="padding: 10px">
                        <asp:TextBox ID="txtfunction" CssClass="form-control" Style="width: 195px" runat="server">
                        </asp:TextBox></td>
                </tr>
                <tr>
                    <td style="font-size: 22px">Department*:</td>
                    <td style="padding: 10px">
                        <asp:TextBox ID="txtDepartment" CssClass="form-control" Style="width: 195px" runat="server">
                        </asp:TextBox></td>
                </tr>
                <tr>
                    <td style="font-size: 22px">Designation*:</td>
                    <td style="padding: 10px">
                        <asp:TextBox ID="txtDesignation" CssClass="form-control" Style="width: 195px" runat="server">
                        </asp:TextBox></td>
                </tr>
            </table>

            <div class="button-group">
                    <input type="button" class="btn btn-submit" id="btnSubmit"  value="Save" style="display: inline-block;">
                <input type="button" class="btn btn-next" id="btnNext"value="Next" style="display: inline-block;">
             
                </div>
        </div>
    </div>
</asp:Content>


<%@ Page Title="" Language="C#" MasterPageFile="~/Data/SiteNominate.master" AutoEventWireup="true" CodeFile="frmNominateRaterApprove.aspx.cs" Inherits="frmNominateRaterApprove" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <link href="../Content/jquery-ui.css" rel="stylesheet" />
    <link href="../JDatatable/dataTables.dataTables.css" rel="stylesheet" />
    <link href="../JDatatable/fixedHeader.dataTables.css" rel="stylesheet" />
    <script src="../Scripts/jquery-ui.js"></script>
    <script src="../JDatatable/dataTables.js"></script>
    <script src="../JDatatable/dataTables.fixedHeader.js"></script>
    <script src="../JDatatable/fixedHeader.dataTables.js"></script>
    <style>
        .main-content {
            max-width: 97.5%;
            width: 97.5%;
        }

        body {
            overflow-y: scroll;
        }

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

        .btn-submit {
            background-color: #88bd26 !important;
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

        .clsNomineebodycontainer {
            padding: 10px;
        }

            .clsNomineebodycontainer > table > tr > td {
                font-size: 13pt;
                font-weight: bold;
            }

        .ui-menu .ui-menu-item {
            line-height: 18px !important;
        }

        td.clscellbgcolor {
            background-color: #86bc25;
            color: #ffffff;
            font-weight: bold;
            padding: 0px 0px 0px 5px;
        }

        .clsbodytable > tr > td {
            border: 1px solid #c0c0c0 !important;
        }

        .clsinput {
            border-radius: 0px !important;
        }



        table.dataTable > tbody > tr > th, table.dataTable > tbody > tr > td {
            padding: 2px 2px;
            border: 1px solid #e3efcc;
            font-size: 9pt;
        }

        table.dataTable > tfoot > tr > th {
            padding: 2px 2px;
            border: 1px solid #e3efcc;
            border-top: 2px solid #a6a6a6;
            font-size: 10pt;
        }

        table.dataTable > thead > tr > th, table.dataTable > thead > tr > td {
            padding: 2px 2px;
            border: 1px solid #e3efcc;
            background-color: #86bc25;
            color: #ffffff;
            font-size: 10.5pt;
        }
        div.clscoacheelist{
            border: 1px solid #354e09;
            background-color: #86bc25;
            color: #ffffff;
            padding:3px 2px 3px 4px;
            margin-block:2px;
            cursor:pointer;
        }
        div.clscoacheelist:hover{
            border: 1px solid #354e09;
            background-color: #000000;
            color: #ffffff;
        }

        div.clsactive{
            border: 1px solid #354e09;
            background-color: #000000;
            color: #ffffff;
        }

    </style>
    <script>
        $.widget('custom.mcautocomplete', $.ui.autocomplete, {
            _create: function () {
                this._super();
                this.widget().menu("option", "items", "> :not(.ui-widget-header)");
            },
            _renderMenu: function (ul, items) {
                var self = this,
                    thead;
                if (this.options.showHeader) {
                    table = $('<div class="ui-widget-header" style="width:auto;position:fixed;margin-top:-2px"></div>');
                    $.each(this.options.columns, function (index, item) {
                        table.append('<span style="padding:0 4px;float:left;width:' + item.width + ';">' + item.name + '</span>');
                    });
                    table.append('<div style="clear: both;"></div>');
                    ul.append(table);
                }
                var cnt = 0;
                $.each(items, function (index, item) {
                    self._renderItem(ul, item, cnt);
                    cnt++;
                });
            },
            _renderItem: function (ul, item, cnt) {
                var stylee = "";
                if (cnt == 0) {
                    stylee = "style='margin-top:25px'";
                }
                var t = '',
                    result = '';
                if (item.label != "No Record Found,Please enter correct text for search!" && item.label != "Session Expired,Kindly login again!") {
                    $.each(this.options.columns, function (index, column) {
                        t += '<span style="padding:0 4px;float:left;width:' + column.width + ';">' + item[column.valueField ? column.valueField : index] + '</span>'
                    });
                    result = $('<li ' + stylee + '></li>')
                        .data('ui-autocomplete-item', item)
                        .append('<a class="mcacAnchor">' + t + '<div style="clear: both;"></div></a>')
                        .appendTo(ul);
                } else {
                    result = $('<li style="margin-top:25px"></li>')
                        .data('ui-autocomplete-item', item)
                        .append('<a class="mcacAnchor">' + item.label + '<div style="clear: both;"></div></a>')
                        .appendTo(ul);
                }

                return result;
            }
        });
        var dTable = null;
        $(document).ready(function () {
            $("#dvFadeForProcessing").hide();
            if ($("#MainContent_dvcoacheelist div").length > 0) {
                $("#MainContent_dvcoacheelist div").eq(0).click();
            }
            dTable = new DataTable('#tblMainNominee', {
                paging: false,
                scrollCollapse: true,
                scrollY: '220px',
                info: false,
                ordering: false,
                searching: false
            });
            fnBindAutocomplete();
            fnHideremoveicon();
        })

        function fnGetNomineeDetails(sender, nodeid) {
            $("#MainContent_dvcoacheelist div.clsactive").removeClass("clsactive");
            $(sender).addClass("clsactive");
            $("#dvFadeForProcessing").show();
            var LoginId = $("#MainContent_hdnLoginId").val();
            PageMethods.fnGetNomineeDetails(LoginId, nodeid, function (result) {
                $("#dvFadeForProcessing").hide();
                if (result.split("|")[0] == 2) {
                    fnShowmsg("Error:" + result.split("|")[1]);
                } else {
                    $("#tblMainNominee tbody").html(result.split("|")[1]);
                    //fnDisableCategory();
                }

            }, function (result) {
                $("#dvFadeForProcessing").hide();
                fnShowmsg("Error:" + result._message);
            });
        }

        function fnBindAutocomplete() {
            $(".clsSearchUser").mcautocomplete({
                open: function () {
                    var wd = $(".ui-autocomplete:visible").find("div.ui-widget-header").width();
                    wd = parseInt(wd) + parseInt(30)
                    $(".ui-autocomplete:visible").css({
                        "width": wd + "px",
                        "max-height": "200px",
                        "overflow-y": "auto",
                        "overflow-y": "auto",
                        "left": "250px",
                    });
                },
                position: ({
                    my: "left top",
                    at: "left bottom",
                    collision: 'flipfit',
                    within: window
                }),
                delay: 100,
                showHeader: true,
                columns: [{
                    name: 'Emp Code',
                    width: '100px',
                    valueField: 'EmpCode'
                },
                {
                    name: 'Name',
                    width: '230px',
                    valueField: 'FullName'
                },
                {
                    name: 'EmailId',
                    width: '260px',
                    valueField: 'EMailID'
                },
                {
                    name: 'Function',
                    width: '150px',
                    valueField: 'Function'
                }
                    ,
                {
                    name: 'Department',
                    width: '150px',
                    valueField: 'Department'
                },
                {
                    name: 'Designation',
                    width: '150px',
                    valueField: 'Designation'
                }
                ],
                minLength: 1,
                source: function (request, response) {
                    var SearchText = request.term;
                    if ($("#MainContent_ddlRelatioShip option:selected").val() == "0") {
                        alert("Please select category first!");
                        $("#MainContent_ddlRelatioShip").focus();
                        $("#txtsearch").val("");
                        return false;
                    }
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "frmNominateRater.aspx/fnGetUserListForNomination",
                        data: "{'searchText':'" + SearchText + "',LoginID:" + $("#MainContent_hdnLoginId").val() + "}",
                        dataType: "json",
                        success: function (data) {
                            var resulttt = "";
                            if (data.d != "") {
                                if (data.d.split("^")[0] == "3") {
                                    var lbl = [{
                                        label: data.d.split("^")[1]
                                    }]
                                    response(lbl);
                                } else {
                                    //debugger;
                                    var storedata = $.parseJSON('[' + data.d.split("^")[1] + ']');
                                    response(storedata[0])
                                }
                            } else {

                                var lbl = [{
                                    label: "No Record Found!!"
                                }]
                                response(lbl);
                            }
                        },
                        error: function (result) {
                            alert("Error-" + result.responseJSON.Message);
                            return false;
                        }
                    });

                },
                focus: function (event, ui) {
                    return false;
                },
                change: function (event, ui) {
                    if (ui.item) {
                        return;
                    }

                    // Remove invalid value
                    var value = this.value;
                    this.value = "";
                    $("#hdnInvId").val("0");
                },
                select: function (event, ui) {
                    $("#txtsearch").val("");
                    if (ui.item.label != "No Record Found,Please enter correct text for search!" && ui.item.label != "Session Expired,Kindly login again!") {
                        //  $(this).val((ui.item ? ui.item.InvCode : ''));
                        //alert(ui.item.FullName)
                        //tblMainNominee
                        var str = "<tr empid='" + ui.item.NodeID + "' rip='" + $("#MainContent_ddlRelatioShip option:selected").val() + "'>";
                        str += "<td>" + $("#MainContent_ddlRelatioShip option:selected").text() + "</td>";
                        str += "<td>" + ui.item.FullName + "</td>";
                        str += "<td>" + ui.item.EMailID + "</td>";
                        str += "<td>" + ui.item.Function + "</td>";
                        str += "<td>" + ui.item.Department + "</td>";
                        str += "<td>" + ui.item.Designation + "</td>";
                        str += "<td class='text-center'><i class='fa fa-remove' onclick='fnRemoverow(this)'></i></td>";
                        str += "</tr>";
                        $("#tblMainNominee tbody").find("td.dt-empty").closest("tr").remove();
                        $("#tblMainNominee tbody").append(str);
                        // dTable.DataTable().columns.adjust().draw();
                        //$(this).closest("div").prev().find("span.clsnomiTitle").html(" Edit");
                        //$(this).closest("table").next().find("input").attr("sid", ui.item.NodeID);
                        //$(this).closest("table").next().find("input#txtName").val(ui.item.FullName);
                        //$(this).closest("table").next().find("input#txtEmailid").val(ui.item.EMailID);
                        //$(this).closest("table").next().find("input#txtfunction").val(ui.item.Function);
                        //$(this).closest("table").next().find("input#txtDepartment").val(ui.item.Department);
                        //$(this).closest("table").next().find("input#txtDesignation").val(ui.item.Designation);
                    }
                    return false;
                }
            })

        }
        function fnShowHideDiv(sender) {
            if ($(sender).find("i.fa").hasClass("fa-arrow-circle-o-down")) {
                $("div.clsNomineebodycontainer").hide();
                $("#btnMainbodyContainer").find("i.clsarrow").removeClass("fa-arrow-circle-o-up").addClass("fa-arrow-circle-o-down");
                $(sender).closest("div").next().show();
                $(sender).find("i.fa").removeClass("fa-arrow-circle-o-down").addClass("fa-arrow-circle-o-up")
            }
            else {
                $(sender).find("i.fa").removeClass("fa-arrow-circle-o-up").addClass("fa-arrow-circle-o-down");
                $(sender).closest("div").next().hide();
            }
        }
        function fnAddNewNominee(sender) {
            if (!IsValidateInput($("#btnMainbodyContainer").find("input.clsinput"))) {
                alert("Please enter nominee details first before adding new one");
                //$(sender).closest(".clsNomineebtncontainer").next().show();
                //$(sender).closest(".clsNomineebtncontainer").find("i.clsarrow").removeClass("fa-arrow-circle-o-down").addClass("fa-arrow-circle-o-up");
                //$(sender).closest(".clsNomineebtncontainer").next().find("input.clsSearchUser").focus();
                return false;
            }
            $("#btnMainbodyContainer").append("<div style='margin: 5px 0px 10px 0px;' class='clsmainbody'>" + $("div.clsmainbody").eq(0).html() + "</div>");
            $("div.clsNomineebodycontainer").hide();
            $("#btnMainbodyContainer").find("i.clsarrow").removeClass("fa-arrow-circle-o-up").addClass("fa-arrow-circle-o-down");
            $("div.clsNomineebodycontainer").eq($("div.clsNomineebodycontainer").length - 1).show();
            $("div.clsNomineebtncontainer").eq($("div.clsNomineebodycontainer").length - 1).find("span.clsnomiTitle").html(" Enter");
            $("div.clsNomineebodycontainer").eq($("div.clsNomineebodycontainer").length - 1).prev().find("i.clsarrow").removeClass("fa-arrow-circle-o-down").addClass("fa-arrow-circle-o-up");
            fnHideremoveicon();
            fnBindAutocomplete();
        }
        function IsValidateInput(inputs) {
            for (var i = 0; i < inputs.length; i++) {
                if (inputs.eq(i).val().trim() == "") {
                    inputs.eq(i).closest("clsNomineebodycontainer").show();
                    return false;
                }
            }
            return true;
        }
        function fnRemoveNewNominee(sender) {
            $(sender).closest(".clsmainbody").remove();
            $("div.clsNomineebodycontainer").hide();
            $("#btnMainbodyContainer").find("i.clsarrow").removeClass("fa-arrow-circle-o-up").addClass("fa-arrow-circle-o-down");
            $("div.clsNomineebodycontainer").eq($("div.clsNomineebodycontainer").length - 1).show();
            $("div.clsNomineebodycontainer").eq($("div.clsNomineebodycontainer").length - 1).prev().find("i.clsarrow").removeClass("fa-arrow-circle-o-down").addClass("fa-arrow-circle-o-up")
            fnHideremoveicon();
        }
        function fnHideremoveicon() {
            if ($("i.fa-minus-circle").length > 1) {
                $("i.fa-minus-circle").show();
            }
            else {
                $("i.fa-minus-circle").eq(0).hide();
            }
            var ctrl = $("span.clsnomcount");
            for (var i = 0; i < ctrl.length; i++) {
                $(ctrl).eq(i).html((i + 1) + (i < 3 ? "<span style='color:red'>*</span>" : ""));
            }
        }
        function fnRemoverow(sender) {
            $(sender).closest("tr").remove();
        }

        function fnShowmsg(msg) {
            $("#dvAlert").html(msg);
            $("#dvAlert").dialog({
                title: "Alert!",
                modal: true,
                width: "auto",
                height: "auto",
                dialogClass: "alertcss",
                close: function () {
                    $(this).dialog('destroy');
                    $("#dvAlert").html("");
                },
                buttons: [
                    {
                        text: "OK",
                        "class": "btns btn-submit",
                        click: function () {
                            $("#dvAlert").dialog('close');
                        }
                    }
                ]
            })
        }


       
        function fnSaveAndSubmit(flg) {
            var $trs = $("#tblMainNominee tr[flgvalid='1']");
            if ($trs.length == 0 && flg == 0) {
                fnShowmsg("No data found for this action!");
                return false;
            }
            var $checked = $("#tblMainNominee input:checked");
            if ($checked.length == 0) {
                fnShowmsg("Please select record first for this action!");
                return false;
            }
           
            var LoginId = $("#MainContent_hdnLoginId").val();
            var str = "<div>Are you sure to approve the selected ones?</div>";
            if (flg == 2) {
                var str = "<div><b>Reason for rejection:</b></div><div><textarea value='' rows='3' style='width:100%' id='txtReason' place='type here'></textarea></div>";
            }
           
            $("#dvDialog").html(str);
            $("#dvDialog").dialog({
                title: "Confirmation :",
                modal: true,
                width: (flg==1? "350":"500"),
                height: "auto",
                close: function () {
                    $(this).dialog('destroy');
                    $("#dvDialog").html("");
                },
                buttons: {
                    "Yes": function () {
                        var RejectionComment = "";
                        if (flg == 2) {
                            RejectionComment = $("#txtReason").val().trim();
                            if (RejectionComment == "") {
                                fnShowmsg("Please give the reason for rejection first!");
                                $("#txtReason").focus();
                                return false;
                            }
                        }
                        var arr = [];
                        for (var i = 0; i < $checked.length; i++) {
                            arr.push({
                                CycleApseApsrMapID: $checked.eq(i).closest("tr").attr("CycleApseApsrMapID"), flgApproved: flg
                            });
                        }
                        $("#dvFadeForProcessing").show();
                        $(this).dialog('close');
                        PageMethods.fnSaveandDeleteNomineeData(LoginId, arr, RejectionComment, function (result) {
                            $("#dvFadeForProcessing").hide();
                            if (result.split("|")[0] == 2) {
                                fnShowmsg("Error:" + result.split("|")[1]);
                                return false;
                            }
                            $("#MainContent_dvcoacheelist div.clsactive").click();

                        }, function (result) {
                            $("#dvFadeForProcessing").hide();
                            fnShowmsg("Error:" + result._message);
                        });
                    },
                    "No": function () {

                        $(this).dialog('close');
                    }
                }
            })
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="row no-gutters">
        <div class="col-md-12">

            <div class="section-title">
                <h3 class="text-center">Coachee Nomination List</h3>
                <div class="title-line-center"></div>
            </div>
            <h6 class="text-center" style="font-size: 11.5pt">Please review the list of nominated raters submitted by your coachee and provide your approval or suggest changes as needed to ensure balanced and meaningful feedback.</h6>

            <div class="row">
                <div class="col-md-3" style="width:18%;border-right:1px solid #b0b0b0;min-height:430px;max-height:430px">
                    <div class="text-center">
                       <b> Your Coachees </b>
                    </div>
                    <div runat="server" id="dvcoacheelist" style="overflow:auto;max-height:380px">
                    </div>
                </div>
                <div class="col-md-9" style="width:82%">
                    <div id="btnMainbodyContainer">
                        <table id="tblMainNominee" style="width: 100%">
                            <thead>
                                <tr>
                                    <th style="width: 3%"></th>
                                    <th style="width: 11%">Category*</th>
                                    <th>Name*</th>
                                    <th style="width: 22%">Email ID*
                                    </th>
                                    <th style="width: 11%">Function*
                                    </th>
                                    <th style="width: 11%">Department*
                                    </th>
                                    <th style="width: 11%">Designation*
                                    </th>
                                    <th style="width: 14%">Status
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>

                        </table>
                    </div>
                    <div class="button-group mb-4">
                        <input type="button" class="btn btn-submit" id="btnSave" value="Approve" onclick="fnSaveAndSubmit(1)"  style="display: inline-block;">
                        <input type="button" class="btn btn-submit" id="btnSubmit" value="Reject" onclick="fnSaveAndSubmit(2)" style="display: inline-block;">
                        <%--<input type="button" class="btn btn-next" id="btnNext" value="Next" style="display: inline-block;">--%>
                    </div>
                </div>
            </div>

        </div>
    </div>
    <asp:HiddenField ID="hdnNodeId" runat="server" Value="0" />
    <asp:HiddenField ID="hdnLoginId" runat="server" Value="0" />
     <div id="dvDialog" style="display: none"></div>
    <div id="dvAlert" style="display: none"></div>
    <div id="dvFadeForProcessing" style="display: block; position: fixed; text-align: center; z-index: 999999; top: 0; bottom: 0; left: 0; right: 0; opacity: .80; -moz-opacity: 0.8; filter: alpha(opacity=80); background-color: #ccc;">
        <img src="../Images/loading.gif" style="width: 90px; height: 70px; position: relative; top: 50%; margin-top: -35px;" />
    </div>
</asp:Content>


<%@ Page Title="" Language="C#" MasterPageFile="~/Data/SiteNominate.master" AutoEventWireup="true" CodeFile="frmNominateRaterApprove.aspx.cs" Inherits="frmNominateRaterApprove" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <link href="../Content/jquery-ui.css" rel="stylesheet" />
    <link href="../JDatatable/dataTables.dataTables.css" rel="stylesheet" />
    <link href="../JDatatable/fixedHeader.dataTables.css" rel="stylesheet" />
    <script src="../Scripts/jquery-ui.js"></script>
    <script src="../JDatatable/dataTables.js"></script>
    <script src="../JDatatable/dataTables.fixedHeader.js"></script>
    <script src="../JDatatable/fixedHeader.dataTables.js"></script>
    <script src="../Scripts/progressbarJS.js"></script>
    <style>
        /*.main-content {
            max-width: 97.5%;
            width: 97.5%;
        }*/
         table.table > tbody > tr:nth-child(even) {
    background-color: transparent !important;
}
          table.table > thead > tr:last-child {
    border-bottom: 2px solid #b0b0b0 !important;
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
            padding: 12px 30px;
            font-size: 16px;
            border: none;
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

        div.clscoacheelist {
            border: 1px solid #354e09;
            background-color: #86bc25;
            color: #ffffff;
            padding: 3px 2px 3px 4px;
            margin-block: 2px;
            cursor: pointer;
        }

            div.clscoacheelist:hover {
                border: 1px solid #354e09;
                background-color: #000000;
                color: #ffffff;
            }

        div.clsactive {
            border: 1px solid #354e09;
            background-color: #000000;
            color: #ffffff;
        }

        .ui-autocomplete {
            max-height: 200px;
            overflow-y: auto;
            overflow-x: hidden;
            border: 1px solid #ccc;
            background: white;
            font-size: 9.5pt;
        }

        .autocomplete-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 9.5pt;
        }

            .autocomplete-table th, .autocomplete-table td {
                padding: 5px;
                border: 1px solid #ddd;
            }

            .autocomplete-table th {
                background-color: #f4f4f4;
                text-align: left;
            }

        .autocomplete-table-row {
            width: 100%;
        }

        .ui-menu-item {
            list-style: none;
            padding: 5px;
            cursor: pointer;
        }

        /* Highlight selected row */
        .ui-menu-item-wrapper {
            display: block;
            padding: 5px;
        }

        .ui-state-active {
            background: #007bff;
            color: white;
        }

        .clsheaderitem th {
            background-color: #f4f4f4 !important;
            text-align: left;
            color: #000000 !important;
        }
    </style>
    <script>
        $.widget('custom.mcautocomplete', $.ui.autocomplete, {
            _create: function () {
                this._super();
                this.widget().menu("option", "items", "> :not(.ui-widget-header)");
            },
            _renderMenu: function (ul, items) {
                // $(ul).addClass("autocomplete-menu"); // Add class to style
                if (this.options.showHeader) {
                    var table = '<table id="tblPrdContainer" class="autocomplete-table clsheaderitem"><thead><tr>';
                    $.each(this.options.columns, function (index, item) {
                        table += ('<th style="padding:0 4px;width:' + item.width + ';">' + item.name + '</th>');
                    });
                    table += ('</tr></thead>');
                    $(ul).append(table);
                }
                var self = this;
                var cnt = 0;
                $.each(items, function (index, item) {
                    if ($("#tblMainNominee tr[nomineid='" + item["NodeID"] + "']").length == 0) {
                        self._renderItem(ul, item, cnt);
                        cnt++;
                    }
                });
            },
            _renderItem: function (ul, item, cnt) {
                var stylee = "";
                if (cnt == 0) {
                    stylee = "style='margin-top:35px'";
                }
                var t = '',
                    result = '';
                if (item.label != "No Record Found,Please enter correct text for search!" && item.label != "Session Expired,Kindly login again!") {
                    $.each(this.options.columns, function (index, column) {
                        //t += '<span style="padding:0 4px;float:left;width:' + column.width + ';">' + item[column.valueField ? column.valueField : index] + '</span>'

                        t += '<td style="padding:0 4px;width:' + column.width + ';">' + item[column.valueField ? column.valueField : index] + '</td>'
                    });
                    result = $('<li></li>')

                        .data('ui-autocomplete-item', item)
                        .append("<div><table class='autocomplete-table-row'><tr>" + t + "</tr></table></div>")
                        //.append('<a class="mcacAnchor">' + t + '<div style="clear: both;"></div></a>')
                        //.append(t)
                        .appendTo(ul);


                } else {
                    result = $('<tr style="margin-top:25px"></tr>')
                        .data('ui-autocomplete-item', item)
                        //.append('<a class="mcacAnchor">' + item.label + '<div style="clear: both;"></div></a>')
                        .append($("#MainContent_ddlRelatioShip option:selected").text() == "Other Stakeholders" ? "<a href='###' class='' onclick='fnAddNewStakeholder()'> Add New Stackholder </a>" : item.label)
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
                    if ($("#tblMainNominee tbody tr[flgApproved='1']").length > 0) {
                        $("#btnSave,#btnAdd").prop("disabled", true);
                        $("#divaddratercon").hide();
                    }
                    else {
                        $("#btnSave,#btnAdd").prop("disabled", false);
                        fnGetNominateList(LoginId, nodeid);
                    }
                }

            }, function (result) {
                $("#dvFadeForProcessing").hide();
                fnShowmsg("Error:" + result._message);
            });
        }

        function fnGetNominateList(LoginId, nodeid) {

            PageMethods.fnGetNominateList(LoginId, nodeid, function (result) {
                $("#dvFadeForProcessing").hide();
                if (result.split("|")[0] == 2) {
                    fnShowmsg("Error:" + result.split("|")[1]);
                } else {

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
                    width: '70px',
                    valueField: 'EmpCode'
                },
                {
                    name: 'Name',
                    width: '160px',
                    valueField: 'FullName'
                },
                {
                    name: 'EmailId',
                    width: '210px',
                    valueField: 'EMailID'
                },
                {
                    name: 'Function',
                    width: '80px',
                    valueField: 'Function'
                }
                    ,
                {
                    name: 'Department',
                    width: '80px',
                    valueField: 'Department'
                },
                {
                    name: 'Designation',
                    width: '120px',
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
                        url: "frmNominateRaterApprove.aspx/fnGetUserListForNomination",
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
                        var str = "<tr flg='0' flgvalid='1' nomineid='" + ui.item.NodeID + "' minnominationpercategory='" + $("#MainContent_ddlRelatioShip option:selected").attr("minNominationperCategory") + "' rpid='" + $("#MainContent_ddlRelatioShip option:selected").val() + "' newrpid='" + $("#MainContent_ddlRelatioShip option:selected").val() + "'>";
                        str += "<td>" + $("#MainContent_ddlRelatioShip option:selected").attr("rptxt") + "</td>";
                        str += "<td>" + ui.item.FullName + "</td>";
                        str += "<td>" + ui.item.EMailID + "</td>";
                        str += "<td>" + ui.item.Function + "</td>";
                        str += "<td>" + ui.item.Department + "</td>";
                        str += "<td>" + ui.item.Designation + "</td>";
                        str += "<td>Initial draft</td>";
                        str += "<td class='text-center'><i class='fa fa-pencil' onclick='fnEditCategory(this)' title='click to edit' style='cursor:pointer'></i> <i class='fa fa-trash-o' onclick='fnRemoverow(this)' style='color:red;cursor:pointer;margin-left:5px' title='click to delete'></i></td>";
                        str += "</tr>";
                        $("#tblMainNominee tbody").append(str);
                        $("#MainContent_ddlRelatioShip option").eq(0).prop("selected", true);
                        //fnDisableCategory();
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

        function fnAddNewStakeholder() {
            $("#divNewStakeholders").dialog({
                title: "New Stakeholder Addition!",
                modal: true,
                width: "550",
                height: "auto",
                dialogClass: "alertcss",
                close: function () {
                    $(this).dialog('destroy');
                },
                buttons: [
                    {
                        text: "Save",
                        "class": "btns btn-submit",
                        click: function () {
                            var LoginId = $("#MainContent_hdnLoginId").val();
                            var $inputs = $("#tblNewStakeholders input");
                            var st_name = $inputs.eq(0).val().trim();
                            var st_email = $inputs.eq(1).val().trim();
                            if (st_name == "") {
                                fnShowmsg("Name can'nt be left blank!");
                                $inputs.eq(0).focus();
                                return false;
                            }
                            if (st_email == "") {
                                fnShowmsg("Email Id can'nt be left blank!");
                                $inputs.eq(1).focus();
                                return false;
                            }
                            var st_function = $inputs.eq(2).val().trim();
                            var st_dept = $inputs.eq(3).val().trim();
                            var st_deg = $inputs.eq(4).val().trim();
                            PageMethods.fnSaveaNewStakeholder(LoginId, st_name, st_email, st_function, st_dept, st_deg, function (result) {
                                $("#dvFadeForProcessing").hide();
                                if (result.split("|")[0] == 2) {
                                    fnShowmsg("Error:" + result.split("|")[1]);
                                    return false;
                                }
                                if (result.split("|")[1] == 1) {
                                    fnShowmsg("This email id is already exist in the system");
                                    $inputs.eq(1).focus();
                                    return false;
                                }
                                $("#divNewStakeholders").dialog('close');
                                var str = "<tr flg='0' flgvalid='1' nomineid='" + result.split("|")[2] + "' minnominationpercategory='" + $("#MainContent_ddlRelatioShip option:selected").attr("minNominationperCategory") + "' rpid='" + $("#MainContent_ddlRelatioShip option:selected").val() + "'  newrpid='" + $("#MainContent_ddlRelatioShip option:selected").val() + "'>";
                                str += "<td>" + $("#MainContent_ddlRelatioShip option:selected").attr("rptxt") + "</td>";
                                str += "<td>" + st_name + "</td>";
                                str += "<td>" + st_email + "</td>";
                                str += "<td>" + st_function + "</td>";
                                str += "<td>" + st_dept + "</td>";
                                str += "<td>" + st_deg + "</td>";
                                str += "<td>Initial draft</td>";
                                str += "<td class='text-center'><i class='fa fa-pencil' onclick='fnEditCategory(this)' title='click to edit' style='cursor:pointer'></i> <i class='fa fa-trash-o' onclick='fnRemoverow(this)' style='color:red;cursor:pointer;margin-left:5px' title='click to delete'></i></td>";
                                str += "</tr>";
                                $("#tblMainNominee tbody").append(str);
                            }, function (result) {
                                $("#dvFadeForProcessing").hide();
                                fnShowmsg("Error:" + result._message);
                            });
                        }
                    },
                    {
                        text: "Cancel",
                        "class": "btns btn-submit",
                        click: function () {
                            $("#divNewStakeholders").dialog('close');
                        }
                    }
                ]
            })
        }
        function fnEditCategory(sender) {
            var id = $(sender).closest("tr").attr("rpid");
            if ($(sender).hasClass("fa-pencil")) {
                var sClone = $("#MainContent_ddlRelatioShip").clone();
                $(sClone).find("option[value='0']").remove();
                var id = $(sender).closest("tr").attr("rpid");
                $(sender).closest("tr").find("td").eq(0).html("<select  onchange='fnChangeCategory(this)' style='width:150px'>" + $(sClone).html() + "</select>");
                $(sender).closest("tr").find("td").eq(0).find("select option").prop("selected", false);
                $(sender).closest("tr").find("td").eq(0).find("select option[value='" + id + "']").prop("selected", true);
                $(sender).removeClass("fa-pencil").addClass("fa-undo");
            } else {
                $(sender).closest("tr").attr("newrpid", id);
                $(sender).removeClass("fa-undo").addClass("fa-pencil");
                $(sender).closest("tr").find("td").eq(0).html($("#MainContent_ddlRelatioShip option[value='" + id + "']").attr("rptxt"));
            }
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


        function fnShowValidateRaterCategory() {
            var str = "";
            var $trs = $("#tblMainNominee tbody tr[flgvalid='1']");
            if ($trs.length > 0) {
                var arrCategories = $("#MainContent_ddlRelatioShip option[value!=0]");
                for (var i = 0; i < arrCategories.length; i++) {
                    var rpid = arrCategories.eq(i).val();
                    if ($("#tblMainNominee tbody tr[newrpid='" + rpid + "']").length > 0) {
                        var minnominationpercategory = arrCategories.eq(i).attr("minnominationpercategory");
                        var rptxt = arrCategories.eq(i).attr("rptxt");
                        str += "<tr><td class='fw-bold'>" + rptxt + "</td>";
                        str += "<td class='text-center'>" + (rpid == "1" ? "Auto Populated" : minnominationpercategory == 0 ? "Optional" : minnominationpercategory) + "</td>";
                        str += "<td class='text-center'>" + $("#tblMainNominee tbody tr[newrpid='" + rpid + "']").length + "</td>";
                        str += "</tr>";
                    }
                }
            }
            return str;
        }

        function IsValidateCategory() {

            var $trs = $("#tblMainNominee tbody tr[flgvalid='1']");
            if ($trs.length > 0) {
                var arrCategories = $("#MainContent_ddlRelatioShip option[value!=0]");
                for (var i = 0; i < arrCategories.length; i++) {
                    var rpid = arrCategories.eq(i).val();
                    if ($("#tblMainNominee tbody tr[newrpid='" + rpid + "']").length > 0) {
                        var minnominationpercategory = arrCategories.eq(i).attr("minnominationpercategory");
                        if ($("#tblMainNominee tbody tr[newrpid='" + rpid + "']").length < parseInt(minnominationpercategory)) {
                            return "false|" + minnominationpercategory;
                        }
                    }
                }
            }
            return "true";
        }

        function fnSaveAndSubmit(flg) {
            var $trs = $("#tblMainNominee tr[flgvalid='1']");
           

            if ($trs.length > 0) {
                var str = IsValidateCategory();
                if (str.split("|")[0] == "false") {
                    var msg = "<div><b>Error: Minimum Rater Selection Not Met</b><br>Please ensure that you have selected the required number of raters in each mandatory category.<br/>Please review and update your selections.</div>";
                    msg += "<table class='table table-bordered table-sm'><thead class='table-light' ><tr><th class='fw-bold text-start' style='color:#000000'>Rater Category</th><th class='text-center fw-bold' style='color:#000000'>Minimum Required</th><th class='text-center fw-bold' style='color:#000000'>You Have Selected</th></tr></thead><tbody>";
                    msg += fnShowValidateRaterCategory();
                    msg += "</tbody></table>";
                    fnShowmsg(msg);
                    return false;
                }
            } else {
                fnShowmsg("Rater Nomination not yet submitted for your approval!");
                return false;
            }

            var LoginId = $("#MainContent_hdnLoginId").val();
            var str = "<div>Are you sure to approve the rater(s)?</div>";


            $("#dvDialog").html(str);
            $("#dvDialog").dialog({
                title: "Confirmation :",
                modal: true,
                width: "350",
                height: "auto",
                close: function () {
                    $(this).dialog('destroy');
                    $("#dvDialog").html("");
                },
                buttons: {
                    "Yes": function () {
                        var ApseNodeId = $("#MainContent_dvcoacheelist div.clsactive").attr("EmpNodeId");
                        var arr = [];
                        for (var i = 0; i < $trs.length; i++) {
                            var RltshpId = 0;
                            if ($trs.eq(i).find("td").eq(0).find("select").length > 0) {
                                RltshpId = $trs.eq(i).find("td").eq(0).find("select").find("option:selected").val();
                            } else {
                                RltshpId = $trs.eq(i).attr("rpid");
                            }
                            arr.push({
                                ApseNodeId: ApseNodeId, ApsrNodeId: $trs.eq(i).attr("nomineid"), RltshpId: RltshpId, flgAction: 0
                            });
                        }
                        $("#dvFadeForProcessing").show();
                        $(this).dialog('close');
                        PageMethods.fnSaveandDeleteNomineeData(LoginId, arr, 1, function (result) {
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

        function fnRemoveFromDB(sender) {
            var LoginId = $("#MainContent_hdnLoginId").val();
            var str = "<div>Are you sure you want to remove this rater?</div>";
            $("#dvDialog").html(str);
            $("#dvDialog").dialog({
                title: "Confirmation :",
                modal: true,
                width: "300",
                height: "auto",
                close: function () {
                    $(this).dialog('destroy');
                    $("#dvDialog").html("");
                },
                buttons: {
                    "Yes": function () {
                        var arr = [];
                        var ApseNodeId = $("#MainContent_dvcoacheelist div.clsactive").attr("EmpNodeId");
                        arr.push({
                            ApseNodeId: ApseNodeId, ApsrNodeId: $(sender).closest("tr").attr("nomineid"), RltshpId: $(sender).closest("tr").attr("rpid"), flgAction: 1
                        });
                        $("#dvFadeForProcessing").show();
                        $(this).dialog('close');
                        PageMethods.fnSaveandDeleteNomineeData(LoginId, arr, 0, function (result) {
                            $("#dvFadeForProcessing").hide();
                            if (result.split("|")[0] == 2) {
                                fnShowmsg("Error:" + result.split("|")[1]);
                                return false;
                            }
                            if ($("#MainContent_dvcoacheelist div").length > 0) {
                                $("#MainContent_dvcoacheelist div.clsactive").click();
                            }

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

        function fnAddRows() {
            $("#divaddratercon").show();
            $("#tblMainNominee i.fa").show();
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="row no-gutters" style="padding-left: 15px; width: 100%">
        <div class="col-md-12" style="padding: 0px">

            <div class="section-title">
                <h3 class="text-center">APPROVE RATERS</h3>
                <div class="title-line-center"></div>
            </div>
            <div style="font-size: 10pt">
                Below is the list of your <b>coachees/reportees:</b>
                <table style="width: 100%">
                    <tr>
                        <td>
                            <ul>
                                <li>Review their submitted raters for relevance & completeness. 
                                </li>
                                <li>You can edit stakeholder categories to ensure the best fit.</li>
                            </ul>
                        </td>
                        <td>
                            <ul>
                                <li>You can also add or remove stakeholders as needed.</li>
                                <li>Once you are satisfied with the selections, click "Approve" to finalize.</li>
                            </ul>
                        </td>
                    </tr>
                </table>
               
            </div>



            <div class="row">
                <div class="col-md-3" style="width: 18%; border-right: 1px solid #b0b0b0; min-height: 430px; max-height: 430px">
                    <div class="text-center">
                        <b>Your Team Members </b>
                    </div>
                    <div runat="server" id="dvcoacheelist" style="overflow: auto; max-height: 380px">
                    </div>
                </div>
                <div class="col-md-9" style="width: 82%">
                    <div id="btnMainbodyContainer">
                        <table id="tblMainNominee" style="width: 100%">
                            <thead>
                                <tr>

                                    <th style="width: 13%">Category</th>
                                    <th>Name</th>
                                    <th style="width: 21%">Email ID
                                    </th>
                                    <th style="width: 10%">Function
                                    </th>
                                    <th style="width: 9%">Department
                                    </th>
                                    <th style="width: 10%">Designation
                                    </th>
                                    <th style="width: 14%">Status
                                    </th>
                                    <th style="width: 5%; text-align: center">Action
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>

                        </table>
                    </div>
                    <div style="display: none" id="divaddratercon">
                        <table style="width: 100%; font-size: 9.5pt">
                            <tr>
                                <th style="width: 28%">
                                    <table style="width:100%">
                                        <tr>
                                            <td>
Select Category:
                                            </td>
                                            <td>
                                                 <asp:DropDownList ID="ddlRelatioShip" Style="width:150px;height: 33px; border: 1px solid #c0c0c0" AppendDataBoundItems="true" runat="server" AutoPostBack="false">
                                    <asp:ListItem Value="0">-----</asp:ListItem>
                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                    </table>
                                    
                               
                                </th>
                                <th>
                                    <input type="search" id="txtsearch" placeholder="Search raters by Emp Id, Name, Email ID" class="form-control w-100 d-inline-block clsSearchUser" />
                                </th>
                            </tr>
                        </table>
                    </div>
                    <div class="button-group mb-4">
                        <input type="button" class="btn btn-submit" id="btnAdd" value="Edit" onclick="fnAddRows()" style="display: inline-block;">
                        <input type="button" class="btn btn-submit" id="btnSave" value="Approve" onclick="fnSaveAndSubmit(1)" style="display: inline-block;">
                        <%--<input type="button" class="btn btn-next" id="btnNext" value="Next" style="display: inline-block;">--%>
                    </div>
                </div>
            </div>

        </div>
    </div>
    <div style="display: none" id="divNewStakeholders">
        <table class="table" id="tblNewStakeholders">
            <tr>
                <td style="width: 20%">Name </td>
                <td style="width: 2%">:</td>
                <td>
                    <input type="text" class="form-control form-control-sm" /></td>
            </tr>
            <tr>
                <td>Email Id : </td>
                <td>:</td>
                <td>
                    <input type="text" class="form-control form-control-sm" /></td>
            </tr>
            <tr>
                <td>Function : </td>
                <td>:</td>
                <td>
                    <input type="text" class="form-control form-control-sm" /></td>
            </tr>
            <tr>
                <td>Department : </td>
                <td>:</td>
                <td>
                    <input type="text" class="form-control form-control-sm" /></td>
            </tr>
            <tr>
                <td>Designation : </td>
                <td>:</td>
                <td>
                    <input type="text" class="form-control form-control-sm" /></td>
            </tr>
        </table>
    </div>
    <asp:HiddenField ID="hdnNodeId" runat="server" Value="0" />
    <asp:HiddenField ID="hdnLoginId" runat="server" Value="0" />
    <div id="dvDialog" style="display: none"></div>
    <div id="dvAlert" style="display: none"></div>
    <div id="dvFadeForProcessing" style="display: block; position: fixed; text-align: center; z-index: 999999; top: 0; bottom: 0; left: 0; right: 0; opacity: .80; -moz-opacity: 0.8; filter: alpha(opacity=80); background-color: #ccc;">
        <img src="../Images/loading.gif" style="width: 90px; height: 70px; position: relative; top: 50%; margin-top: -35px;" />
    </div>
</asp:Content>


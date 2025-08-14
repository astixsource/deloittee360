<%@ Page Title="" Language="C#" MasterPageFile="~/AdminReports/AdminSite.master" AutoEventWireup="true" CodeFile="frmNominateRater.aspx.cs" Inherits="Data_frmNominateRater" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <link href="../Content/jquery-ui.css" rel="stylesheet" />
    <link href="../JDatatable/dataTables.dataTables.css" rel="stylesheet" />
    <link href="../JDatatable/fixedHeader.dataTables.css" rel="stylesheet" />

    <script src="../Scripts/jquery-ui.js"></script>
    <script src="../JDatatable/dataTables.js"></script>
    <script src="../JDatatable/dataTables.fixedHeader.js"></script>
    <script src="../JDatatable/fixedHeader.dataTables.js"></script>
    <script src="../Scripts/progressbarJS.js"></script>

    <style type="text/css">
        .main-content {
            padding-bottom: 10px !important; 
        }

        .btns.disabled,
        .btns:disabled,
        .btns[disabled] {
            border: 1px solid #999999;
            background-color: #cccccc;
            color: #666666;
            cursor: default !important;
        }

            .btns.disabled:hover,
            .btns:disabled:hover {
                border: 1px solid #999999;
                background-color: #cccccc;
                color: #666666;
                cursor: not-allowed;
            }

        table.table > tbody > tr:nth-child(even) {
            background-color: transparent !important;
        }

        table.table > thead > tr:last-child {
            border-bottom: 2px solid #b0b0b0 !important;
        }

        .mcacAnchor {
            font-size: 12px;
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

        table.dataTable > thead > * > * {
            color: #636A6F;
            font-weight: normal;
            text-align: left;
        }

        table.dataTable > tbody > * > * {
            font-size: .85rem;
        }

        table.dataTable > thead > * > *,
        table.dataTable > tbody > * > *,
        table.dataTable > tfoot > * > * {
            padding: .25rem;
            line-height: 1.15;
            border-bottom: 1px solid #D6D6D4;
        }

        table.dataTable > tfoot > * > * {
            /*border: 1px solid #e3efcc;*/
            border-top: 2px solid #a6a6a6;
        }

        table.table > tbody > tr:nth-child(2n+1),
        table.dataTable > tbody > tr:nth-child(2n+1) {
            background: #F5F5F5;
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

        .ui-autocomplete-loading {
            background: white url('../../images/loading.gif') right center no-repeat;
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

        .alertcss {
            min-width: 300px;
        }
    </style>
    <style type="text/css">
        #divParticipantPopup {
            position: absolute;
            z-index: 99;
            width: 550px;
            background-color: #fff;
            border: 1px solid #000;
            display: none;
        }
        #divParticipantPopup table tr {
            cursor: pointer;
            font-size: 0.7rem;
            /*background-color: #fff !important;*/
        }
        #divParticipantPopup table tr:hover {
            background-color: #dfffbf !important;
        }
        #divParticipantPopup table tr td {
            text-align: center;
            vertical-align: middle;
        }
        #divParticipantPopup table tr td:nth-child(2),
        #divParticipantPopup table tr td:nth-child(3) {
            text-align: left;
            padding-left: 10px;
        }
    </style>

    <script type="text/javascript">
        $.widget('custom.mcautocomplete', $.ui.autocomplete, {
            _create: function () {
                this._super();
                this.widget().menu("option", "items", "> :not(.ui-widget-header)");
            },
            _renderMenu: function (ul, items) {
                if (this.options.showHeader) {
                    var table = '<table id="tblPrdContainer" class="autocomplete-table clsheaderitem"><thead style="padding:0px"><tr>';
                    $.each(this.options.columns, function (index, item) {
                        table += ('<th style="padding:0 2px;width:' + item.width + ';">' + item.name + '</th>');
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
                        t += '<td style="padding:0 2px;word-break:break-all;width:' + column.width + ';">' + item[column.valueField ? column.valueField : index] + '</td>'
                    });
                    result = $('<li style="padding: 5px 0px"></li>')
                        .data('ui-autocomplete-item', item)
                        .append("<div style='padding:0px'><table class='autocomplete-table-row' style='padding:0px'><tr>" + t + "</tr></table></div>")
                        .appendTo(ul);


                } else {
                    result = $('<tr style="margin-top:25px"></tr>')
                        .data('ui-autocomplete-item', item)
                        //.append($("#MainContent_ddlRelatioShip option:selected").val() == "5" ? "<a href='###' class='' onclick='fnAddNewStakeholder()'> Add New Stakeholder </a>" : item.label)
                        .append("<a href='###' class='' onclick='fnAddNewStakeholder()'> Add New </a>")
                        .appendTo(ul);
                }

                return result;
            }
        });

        var arrss = true;
        function EnableKeySelection() {
            // debugger;
            var trows = document.getElementById('tblPrdContainer').rows, t = trows.length, trow, nextrow,
                addEvent = (function () {
                    return window.addEventListener ? function (el, ev, f) {
                        el.addEventListener(ev, f, false); //modern browsers
                    } : window.attachEvent ? function (el, ev, f) {
                        el.attachEvent('on' + ev, function (e) { f.apply(el, [e]); }); //IE 8 and less
                    } : function () { return; }; //a very old browser (IE 4 or less, or Mozilla, others, before Netscape 6), so let's skip those
                })();

            while (--t > -1) {
                trow = trows[t];
                trow.className = 'normal';
                addEvent(trow, 'click', highlightRow);
            } //end while

            function highlightRow(gethighlight) { //now dual use - either set or get the highlighted row
                //debugger;
                gethighlight = gethighlight === true;
                var t = trows.length;
                while (--t > -1) {
                    trow = trows[t];
                    if (gethighlight && trow.className === 'highlighted') {
                        return t;
                    }
                    else if (!gethighlight && trow !== this) {
                        trow.className = 'normal';
                    }
                } //end while
                return gethighlight ? null : this.className = this.className === 'highlighted' ? 'normal' : 'highlighted';
            } //end function

            function movehighlight(way, e) {
                e.preventDefault && e.preventDefault();
                e.returnValue = false;
                var idx = highlightRow(true); //gets current index or null if none highlighted
                if (typeof idx === 'number') {//there was a highlighted row
                    idx += way; //increment\decrement the index value
                    if (idx && (nextrow = trows[idx])) {
                        $(nextrow).find("input:checkbox").focus();
                        return highlightRow.apply(nextrow);
                    } //index is > 0 and a row exists at that index
                    else if (idx) {
                        $(trows[1]).find("input:checkbox").focus();
                        return highlightRow.apply(trows[1]);
                    } //index is out of range high, go to first row

                    $(trows[trows.length - 1]).find("input:checkbox").focus();
                    return highlightRow.apply(trows[trows.length - 1]); //index is out of range low, go to last row
                }
                $(trows[way > 0 ? 1 : trows.length - 1]).find("input:checkbox").focus();
                return highlightRow.apply(trows[way > 0 ? 1 : trows.length - 1]); //none was highlighted - go to 1st if down arrow, last if up arrow
            } //end function

            function processkey(e) {
                switch (e.keyCode) {
                    case 38:
                        {//up arrow
                            return movehighlight(-1, e)
                        }
                    case 40:
                        {//down arrow
                            arrss = true;
                            $("#chkprd0").focus();
                            return movehighlight(1, e);
                        }
                    case 9:
                        {//Tab
                            if ($("#chkprd0").length > 0) {
                                arrss = true;
                                $("#chkprd0").focus();
                                return movehighlight(1, e);
                            } else {
                                return false;
                            }
                        }
                    case 13:
                        {
                            if ($("#tblPrdContainer tr.highlighted").length > 0) {
                                var tr = $("#tblPrdContainer tr.highlighted").eq(0);
                                fnFillOrder(tr, 1, e);
                            }
                        }
                    case 32:
                        {

                            $(e.currentTarget.activeElement).closest("tr").addClass("highlightedRowInChecked");
                            return false;
                        }

                }
            } //end function
            addEvent(document, 'keydown', processkey);
        }

        var dTable = null;
        $(document).ready(function () {

            dTable = new DataTable('#tblMainNominee', {
                paging: false,
                scrollCollapse: true,
                scrollY: ($(window).height() - $("#divFilter").height() - $("#btnContainer").height() - 200) ,
                info: false,
                ordering: false,
                searching: false
            });
            fnBindAutocomplete();
            fnHideremoveicon();

            $("#btnMainbodyContainer").hide();
            $("#btnContainer").hide();
        })

        function fnGetNomineeDetails() {

            if ($("#txtParticipant").attr("strid") == "0") {
                fnShowmsg("Please select the Batch/Participant ! ");
            }
            else {

                $("#btnMainbodyContainer").hide();
                $("#btnContainer").hide();

                $("#dvFadeForProcessing").show();
                var LoginId = $("#MainContent_hdnLoginId").val();
                PageMethods.fnGetNomineeDetails(LoginId, $("#MainContent_ddlBatch").val(), $("#txtParticipant").attr("strid"), function (result) {
                    $("#dvFadeForProcessing").hide();
                    if (result.split("|")[0] == 2) {
                        fnShowmsg("Error:" + result.split("|")[1]);
                    } else {
                        $("#tblMainNominee tbody").html(result.split("|")[1]);
                        $("#MainContent_hdnBatchId").val($("#MainContent_ddlBatch").val());
                        $("#MainContent_hdnApseNodeId").val($("#txtParticipant").attr("strid"));
                        isCatMinUserValid = $("#txtParticipant").attr("isCatMinUserValid");
                    }

                    $("#btnMainbodyContainer").show();
                    $("#btnContainer").show();

                }, function (result) {
                    $("#dvFadeForProcessing").hide();
                    fnShowmsg("Error:" + result._message);
                });
            }
        }
        function fnBindAutocomplete() {
            $(".clsSearchUser").mcautocomplete({
                open: function () {
                    var wd = $(".ui-autocomplete:visible").find("div.ui-widget-header").width();
                    wd = parseInt(wd) + parseInt(25)
                    $(".ui-autocomplete:visible").css({
                        "width": wd + "px",
                        "max-height": "200px",
                        "overflow-y": "auto",
                        "overflow-y": "auto",
                    });
                    $("#tblPrdContainer").removeClass("ui-menu-item");
                },
                position: ({
                    my: "left bottom",
                    at: "left top",
                    collision: "flip flip",
                    within: window
                }),
                delay: 100,
                showHeader: true,
                columns: [{
                    name: 'Emp Code',
                    width: '80px',
                    valueField: 'EmpCode'
                },
                {
                    name: 'Name',
                    width: '200px',
                    valueField: 'FullName'
                },
                {
                    name: 'EmailId',
                    width: '260px',
                    valueField: 'EMailID'
                },
                {
                    name: 'Business',
                    width: '205px',
                    valueField: 'Business'
                }
                    ,
                {
                    name: 'Department',
                    width: '205px',
                    valueField: 'Department'
                },
                {
                    name: 'Grade',
                    width: '135px',
                    valueField: 'Grade'
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
                        str += "<td>" + ui.item.Business + "</td>";
                        str += "<td>" + ui.item.Department + "</td>";
                        str += "<td>" + ui.item.Grade + "</td>";
                        str += "<td>Initial draft</td>";
                        str += "<td class='text-center'><i class='fa fa-pencil' onclick='fnEditCategory(this)' title='click to edit' style='cursor:pointer'></i> <i class='fa fa-trash-o' onclick='fnRemoverow(this)' style='color:red;cursor:pointer;margin-left:5px' title='click to delete'></i></td>";
                        str += "</tr>";
                        $("#tblMainNominee tbody").find("td.dt-empty").closest("tr").remove();
                        $("#tblMainNominee tbody").append(str);
                        $("#MainContent_ddlRelatioShip option").eq(0).prop("selected", true);
                    }
                    return false;
                }
            })

        }
        function fnChangeCategory(sender) {
            $(sender).closest("tr").attr("newrpid", $(sender).val());
        }
        function fnEditCategory(sender) {
            var id = $(sender).closest("tr").attr("rpid");
            if ($(sender).hasClass("fa-pencil")) {
                var sClone = $("#MainContent_ddlRelatioShip").clone();
                $(sClone).find("option[value='0']").remove();
                var id = $(sender).closest("tr").attr("rpid");

                $(sender).closest("tr").attr("flg", "0");
                $(sender).closest("tr").find("td").eq(0).html("<select onchange='fnChangeCategory(this)' style='width:150px'>" + $(sClone).html() + "</select>");
                $(sender).closest("tr").find("td").eq(0).find("select option").prop("selected", false);
                $(sender).closest("tr").find("td").eq(0).find("select option[value='" + id + "']").prop("selected", true);
                $(sender).removeClass("fa-pencil").addClass("fa-undo");
            } else {
                $(sender).closest("tr").attr("newrpid", id);
                $(sender).closest("tr").attr("flg", "1");
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
                alert("Please enter rater details first before adding new one");
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
                open: function () {
                    $(this).next().find("button").removeClass("ui-button ui-corner-all ui-widget");
                },
                buttons: [
                    {
                        text: "OK",
                        class: "btns btn-dark",
                        click: function () {
                            $("#dvAlert").dialog('close');
                        }
                    }
                ]
            })
        }


        function fnRemoveFromDB(sender) {
            var LoginId = $("#MainContent_hdnLoginId").val();

            if ($(sender).closest("tr").attr("statusid") == "0")
                $("#dvDialog").html("Are you sure about removing this nomination ?");
            else if ($(sender).closest("tr").attr("statusid") == "1")
                $("#dvDialog").html("Survey is already initiated by the Rater. Do you still want to remove this nomination ?");
            else if ($(sender).closest("tr").attr("statusid") == "2")
                $("#dvDialog").html("Survey is already Completed by the Rater. Do you still want to remove this nomination ?");

            $("#dvDialog").dialog({
                title: "Confirmation :",
                modal: true,
                width: "300",
                height: "auto",
                close: function () {
                    $(this).dialog('destroy');
                    $("#dvDialog").html("");
                },
                open: function () {
                    $(this).next().find("button").removeClass("ui-button ui-corner-all ui-widget");
                },
                buttons: [
                    {
                        text: "Yes",
                        "class": "btns btn-submit",
                        click: function () {
                            var arr = [];
                            var ApseNodeId = $("#MainContent_hdnApseNodeId").val();
                            arr.push({
                                ApseNodeId: ApseNodeId, ApsrNodeId: $(sender).closest("tr").attr("nomineid"), RltshpId: $(sender).closest("tr").attr("rpid"), flgAction: 1
                            });
                            $("#dvFadeForProcessing").show();
                            $(this).dialog('close');
                            PageMethods.fnSaveandDeleteNomineeData(LoginId, $("#MainContent_hdnBatchId").val(), arr, function (result) {
                                $("#dvFadeForProcessing").hide();
                                if (result.split("|")[0] == 2) {
                                    fnShowmsg("Error:" + result.split("|")[1]);
                                    return false;
                                }
                                fnGetNomineeDetails();
                                fnUpdateProgressbar();

                            }, function (result) {
                                $("#dvFadeForProcessing").hide();
                                fnShowmsg("Error:" + result._message);
                            });
                        }
                    },
                    {
                        text: "No",
                        "class": "btns btn-danger",
                        click: function () {
                            $(this).dialog('close');
                        }
                    }
                ]
            })

        }

        function IsValidateInput() {
            for (var i = 0; i < inputs.length; i++) {
                if (inputs.eq(i).val().trim() == "") {
                    inputs.eq(i).closest("clsNomineebodycontainer").show();
                    return false;
                }
            }
            return true;
        }

        function IsValidateCategory() {

            var $trs = $("#tblMainNominee tbody tr[flgvalid='1']");
            if ($trs.length > 0) {
                var arrCategories = $("#MainContent_ddlRelatioShip option[value!=0]");
                for (var i = 0; i < arrCategories.length; i++) {
                    var rpid = arrCategories.eq(i).val();
                    var minnominationpercategory = arrCategories.eq(i).attr("minnominationpercategory");
                    if (minnominationpercategory > 0) {
                        if ($("#tblMainNominee tbody tr[newrpid='" + rpid + "']").length > 0) {
                            if ($("#tblMainNominee tbody tr[newrpid='" + rpid + "']").length < parseInt(minnominationpercategory)) {
                                return "false|" + minnominationpercategory;
                            }
                        } else {
                            return "false|" + minnominationpercategory;
                        }
                    }
                }
            }
            return "true";
        }

        function fnShowValidateRaterCategory() {
            var str = "";
            var $trs = $("#tblMainNominee tbody tr[flgvalid='1']");
            if ($trs.length > 0) {
                var arrCategories = $("#MainContent_ddlRelatioShip option[value!=0]");
                for (var i = 0; i < arrCategories.length; i++) {
                    var rpid = arrCategories.eq(i).val();
                    var minnominationpercategory = arrCategories.eq(i).attr("minnominationpercategory");
                    var rptxt = arrCategories.eq(i).attr("rptxt");
                    // if (minnominationpercategory > 0) {
                    if ($("#tblMainNominee tbody tr[newrpid='" + rpid + "']").length > 0) {
                        str += "<tr><td class='fw-bold'>" + rptxt + "</td>";
                        str += "<td class='text-center'>" + (rpid == "1" ? "Auto Populated" : minnominationpercategory == 0 ? "Optional" : minnominationpercategory) + "</td>";
                        str += "<td class='text-center'>" + $("#tblMainNominee tbody tr[newrpid='" + rpid + "']").length + "</td>";
                        str += "</tr>";
                    }
                    else {
                        str += "<tr><td class='fw-bold'>" + rptxt + "</td>";
                        str += "<td class='text-center'>" + (rpid == "1" ? "Auto Populated" : minnominationpercategory == 0 ? "Optional" : minnominationpercategory) + "</td>";
                        str += "<td class='text-center'>" + $("#tblMainNominee tbody tr[newrpid='" + rpid + "']").length + "</td>";
                        str += "</tr>";
                    }
                    // }

                }
            }
            return str;
        }

        function fnSaveAndSubmit(flg) {
            $("#dvMsg").html("");
            var $trs = $("#tblMainNominee tr[flg='0']");
            if ($trs.length == 0 && flg == 0) {
                fnShowmsg("Please add new raters before saving.");
                return false;
            }
            if (flg == 1) {
                $trs = $("#tblMainNominee tbody tr[flgvalid='1']");
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
                    fnShowmsg("Please add new raters before saving.");
                    return false;
                }
            }
            var LoginId = $("#MainContent_hdnLoginId").val();
            var str = "<div>" + (flg == 0 ? "Are you sure you want to save?" : "Are you sure you want to submit your final nominations?") + "</div>";

            $("#dvDialog").html(str);
            $("#dvDialog").dialog({
                title: "Confirmation :",
                modal: true,
                width: "370",
                height: "auto",
                dialogClass: "alertcss",
                close: function () {
                    $(this).dialog('destroy');
                    $("#dvDialog").html("");
                },
                open: function () {
                    $(this).next().find("button").removeClass("ui-button ui-corner-all ui-widget");
                },
                buttons: [
                    {
                        text: "Yes",
                        class: "btns btn-submit",
                        click: function () {
                            if (ValidateCatwiseUserCount()) {
                                var arr = [];
                                var ApseNodeId = $("#MainContent_hdnApseNodeId").val();
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
                                PageMethods.fnSaveandDeleteNomineeData(LoginId, $("#MainContent_hdnBatchId").val(), arr, function (result) {
                                    $("#dvFadeForProcessing").hide();
                                    if (result.split("|")[0] == 2) {
                                        fnShowmsg("Error:" + result.split("|")[1]);
                                        return false;
                                    }

                                    fnUpdateProgressbar();
                                    fnGetNomineeDetails();

                                }, function (result) {
                                    $("#dvFadeForProcessing").hide();
                                    fnShowmsg("Error:" + result._message);
                                });
                            }
                            else {
                                $(this).dialog('close');
                            }
                        }
                    },
                    {
                        text: "No",
                        class: "btns btn-danger",
                        click: function () {
                            $(this).dialog('close');
                        }
                    }
                ]
            })
        }

        function fnGotosurveypage() {
            window.location.href = "Instruction.aspx?NodeID="
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
                open: function () {
                    $(this).next().find("button").removeClass("ui-button ui-corner-all ui-widget");
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
                            const emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]*deloitte[a-zA-Z0-9.-]*\.[a-zA-Z]{2,}$/;

                            if (!emailPattern.test(st_email)) {
                                fnShowmsg("Email must be a valid Deloitte domain (e.g., deloitte.com, deloitte.co.uk)");
                                $inputs.eq(1).focus();
                                return false;
                            }
                            var st_function = $inputs.eq(2).val().trim();
                            var st_dept = $inputs.eq(3).val().trim();
                            var st_deg = $inputs.eq(4).val().trim();

                            var IsExternalUser = 0;
                            if ($("#chkExternalUser").is(":checked"))
                                IsExternalUser = 1;

                            PageMethods.fnSaveaNewStakeholder(LoginId, st_name, st_email, st_function, st_dept, st_deg, IsExternalUser, function (result) {
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
                                var str = "<tr flg='0' flgvalid='1' nomineid='" + result.split("|")[2] + "' minnominationpercategory='" + $("#MainContent_ddlRelatioShip option:selected").attr("minNominationperCategory") + "' rpid='" + $("#MainContent_ddlRelatioShip option:selected").val() + "' newrpid='" + $("#MainContent_ddlRelatioShip option:selected").val() + "'>";
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
    </script>
    <script type="text/javascript">

        var isCatMinUserValid = "0";

        function GetParticipant() {
            $("#txtParticipant").val("");
            $("#divParticipantPopupBody").html("");
            $("#txtParticipant").attr("strid", "0");
            $("#txtParticipant").attr("isCatMinUserValid", "0");

            var batchId = $("#MainContent_ddlBatch").val();
            if (batchId == "0") {
                //
            }
            else {
                $("#dvFadeForProcessing").show();
                PageMethods.getParticipant(batchId, function (res) {
                    $("#dvFadeForProcessing").hide();
                    if (res.split("|^|")[0] == "0") {
                        $("#divParticipantPopupBody").html(res.split("|^|")[1]);
                    }
                    else {
                        fnShowmsg("Error : " + res.split("|^|")[1]);
                    }

                }, function (result) {
                    $("#dvFadeForProcessing").hide();
                    fnShowmsg("Error : " + result._message);
                });
            }
        }
        function FilterParticipant(ctrl) {

            if ($("#MainContent_ddlBatch").val() != "0") {
                $("#divParticipantPopup").show();
                $("#txtParticipant").attr("strid", "0");
                $("#txtParticipant").attr("isCatMinUserValid", "0");

                var searchtxt = $(ctrl).val().toUpperCase().trim();
                if (searchtxt.length > 0) {

                    $("#divParticipantPopup").find("table").eq(0).find("tbody").eq(0).find("tr").css("display", "none");
                    $("#divParticipantPopup").find("table").eq(0).find("tbody").eq(0).find("tr").each(function () {
                        if ($(this)[0].innerText.toUpperCase().indexOf(searchtxt) > -1) {
                            $(this).css("display", "table-row");
                        }
                    });
                }
                else {
                    $("#divParticipantPopup").find("table").eq(0).find("tbody").eq(0).find("tr").css("display", "table-row");
                }
            }
            else {
                $("#txtParticipant").val("");
                $("#txtParticipant").attr("strid", "0");
                $("#txtParticipant").attr("isCatMinUserValid", "0");

                fnShowmsg("Please select the Batch ! ");
            }
        }
        function SelectEmp(ctrl) {
            $("#txtParticipant").val($(ctrl).find("td").eq(1).html());
            $("#txtParticipant").attr("strid", $(ctrl).attr("empid"));
            $("#txtParticipant").attr("isCatMinUserValid", $(ctrl).attr("isrelshpminvalid"));

            CloseParticipantPopup();
        }
        function CloseParticipantPopup() {
            $("#divParticipantPopup").hide();
        }

        function ValidateCatwiseUserCount() {
            if (isCatMinUserValid == "1") {

                var cntr = 0;
                var IsValid = true;
                $("#MainContent_ddlRelatioShip").find("option").each(function () {
                    if (IsValid && $(this).attr("value") != "0") {
                        if ($(this).attr("minnominationpercategory") != "0") {
                            cntr = 0;

                            for (var i = 0; i < $("#tblMainNominee tbody tr").length; i++) {
                                var RltshpId = 0;
                                if ($("#tblMainNominee tbody tr").eq(i).find("td").eq(0).find("select").length > 0) {
                                    RltshpId = $("#tblMainNominee tbody tr").eq(i).find("td").eq(0).find("select").find("option:selected").val();
                                } else {
                                    RltshpId = $("#tblMainNominee tbody tr").eq(i).attr("rpid");
                                }

                                if (RltshpId == $(this).attr("value"))
                                    cntr++;
                            }

                            if (cntr < parseInt($(this).attr("minnominationpercategory"))) {
                                IsValid = false;
                                fnShowmsg("Error : Category <span style='font-weight: 600;'>" + $(this).attr("rptxt") + "</span> must have atleast <span style='font-weight: 600;'>" + $(this).attr("minnominationpercategory") + " Nominee</span> !");
                            }
                        }
                    }
                });                

                return IsValid;
            }
            else
                return true;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="row no-gutters">
        <div class="col-md-12">

            <div id="divFilter">
                <table style="width: 100%;">
                    <tr>
                        <td style="width: 60px; font-size: 15px;">Batch :</td>
                        <td style="width: 140px; padding: 10px 30px 10px 5px">
                            <asp:DropDownList ID="ddlBatch" CssClass="form-control" runat="server" onchange="GetParticipant();">
                            </asp:DropDownList>
                        </td>
                        <td style="width: 90px; font-size: 15px;">Participant :</td>
                        <td style="width: 300px; padding: 10px 5px">
                            <div style="position: relative">
                                <input type="text" id="txtParticipant" class="form-control" onkeyup="FilterParticipant(this);" strid="0" isCatMinUserValid="0" placeholder="Type to Select Participant"/>
                                <div id="divParticipantPopup">
                                    <div id="divParticipantPopupBody"></div>
                                    <div id="divParticipantPopupFooter"></div>
                                </div>
                            </div>
                        </td>
                        <td>
                            <a href="###" class="btns btn-submit w-100" onclick="fnGetNomineeDetails();" style="margin-left: 20px;">Get Nomination</a>
                        </td>
                        <%--<td style="padding-left: 50px;">
                    <input type="text" id="txtTypeSearch" class="form-control w-100" placeholder="Type atleast 3 charcters to Search" onkeyup="TypeSearch();" autocomplete="off" />
                </td>--%>
                    </tr>
                </table>
            </div>

            <div id="btnMainbodyContainer">
                <table id="tblMainNominee" style="width: 100%; border-bottom: 1px solid #e2eecb">
                    <thead>
                        <tr>
                            <th style="width: 14%">Category</th>
                            <th>Name</th>
                            <th style="width: 21%">Email ID</th>
                            <th style="width: 8.5%">Business</th>
                            <th style="width: 8%">Department</th>
                            <th style="width: 13%">Grade</th>
                            <th style="width: 12.5%">Status</th>
                            <th style="width: 4%; text-align: center">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                    <tfoot>
                        <tr>
                            <th colspan="2" width="34%">Select Category:
                                <asp:DropDownList ID="ddlRelatioShip" Style="width: 60%; height: 30px; border: 1px solid #c0c0c0" AppendDataBoundItems="true" runat="server" AutoPostBack="false">
                                    <asp:ListItem Value="0">-- Label --</asp:ListItem>
                                </asp:DropDownList>
                            </th>
                            <th colspan="6" width="66%">
                                <input type="search" id="txtsearch" placeholder="Search raters by Emp Id, Name, Email ID" class="form-control form-control-sm clsSearchUser" /></th>
                        </tr>
                    </tfoot>
                </table>
            </div>

            <div id="btnContainer" class="button-group mb-1">
                <input type="button" class="btns btn-submit" id="btnSave" value="Save" onclick="fnSaveAndSubmit(0)">
            </div>

            <div id="dvMsg" style="font-weight: bold; font-size: 11pt; text-align: center"></div>
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
                <td>Email Id </td>
                <td>:</td>
                <td>
                    <input type="text" class="form-control form-control-sm" /></td>
            </tr>
            <tr>
                <td>Business </td>
                <td>:</td>
                <td>
                    <input type="text" class="form-control form-control-sm" /></td>
            </tr>
            <tr>
                <td>Department </td>
                <td>:</td>
                <td>
                    <input type="text" class="form-control form-control-sm" /></td>
            </tr>
            <tr>
                <td>Grade </td>
                <td>:</td>
                <td>
                    <input type="text" class="form-control form-control-sm" /></td>
            </tr>
            <tr>
                <td style="white-space: nowrap;">Is External User </td>
                <td>:</td>
                <td>
                    <input type="checkbox" id="chkExternalUser" /></td>
            </tr>
        </table>
    </div>

    <div id="dvDialog" style="display: none"></div>
    <div id="dvAlert" style="display: none"></div>

    <asp:HiddenField ID="hdnLoginId" runat="server" Value="0" />
    <asp:HiddenField ID="hdnBatchId" runat="server" Value="0" />
    <asp:HiddenField ID="hdnApseNodeId" runat="server" Value="0" />

    <div class="loader_bg" style="display: none" id="dvFadeForProcessing">
        <div class="loader"></div>
    </div>
</asp:Content>


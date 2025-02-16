<%@ Page Title="" Language="C#" MasterPageFile="~/Data/SiteNominate.master" AutoEventWireup="true" CodeFile="frmNominateRater.aspx.cs" Inherits="Data_frmNominateRater" %>

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
        /*.main-content {
            max-width: 97%;
            width: 97%;
        }

        body {
            overflow-y: scroll;
        }*/

        /*.button-group {
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
            }*/

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
            padding: 2px 3px;
            border: 1px solid #e3efcc;
            font-size: 9.5pt;
        }

        table.dataTable > tfoot > tr > th {
            padding: 2px 3px;
            border: 1px solid #e3efcc;
            border-top: 2px solid #a6a6a6;
            font-size: 10pt;
        }

        table.dataTable > thead > tr > th, table.dataTable > thead > tr > td {
            padding: 2px 3px;
            border: 1px solid #e3efcc;
            background-color: #86bc25;
            color: #ffffff;
            font-size: 10.5pt;
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

        .alertcss {
            min-width: 300px;
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
                        //t += '<span style="padding:0 4px;float:left;width:' + column.width + ';">' + item[column.valueField ? column.valueField : index] + '</span>'

                        t += '<td style="padding:0 2px;word-break:break-all;width:' + column.width + ';">' + item[column.valueField ? column.valueField : index] + '</td>'
                    });
                    result = $('<li style="padding: 5px 0px"></li>')

                        .data('ui-autocomplete-item', item)
                        .append("<div style='padding:0px'><table class='autocomplete-table-row' style='padding:0px'><tr>" + t + "</tr></table></div>")
                        //.append('<a class="mcacAnchor">' + t + '<div style="clear: both;"></div></a>')
                        //.append(t)
                        .appendTo(ul);


                } else {
                    result = $('<tr style="margin-top:25px"></tr>')
                        .data('ui-autocomplete-item', item)
                        .append($("#MainContent_ddlRelatioShip option:selected").val() == "5" ? "<a href='###' class='' onclick='fnAddNewStakeholder()'> Add New Stackholder </a>" : item.label)
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
            if ($("#MainContent_hdnIsManager").val() == "0") {
                $("#liHome").hide();
            }

            fnGetNomineeDetails();
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

        function fnGetNomineeDetails() {

            $("#dvFadeForProcessing").show();
            var LoginId = $("#MainContent_hdnLoginId").val();
            PageMethods.fnGetNomineeDetails(LoginId, function (result) {
                $("#dvFadeForProcessing").hide();
                if (result.split("|")[0] == 2) {
                    fnShowmsg("Error:" + result.split("|")[1]);
                } else {
                    $("#tblMainNominee tbody").html(result.split("|")[1]);
                    //fnDisableCategory();
                    if ($("#tblMainNominee tbody tr[flgSubmittedForApproval='1']").length > 0) {
                        $("#btnSave,#btnSubmit").prop("disabled", true);
                        $("#tblMainNominee tfoot tr").hide();
                        $(".dt-scroll-foot").hide();
                    }
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
                    wd = parseInt(wd) + parseInt(25)
                    $(".ui-autocomplete:visible").css({
                        "width": wd + "px",
                        "max-height": "200px",
                        "overflow-y": "auto",
                        "overflow-y": "auto",
                    });
                    $("#tblPrdContainer").removeClass("ui-menu-item");
                    // EnableKeySelection();
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
                    width: '270px',
                    valueField: 'EMailID'
                },
                {
                    name: 'Function',
                    width: '110px',
                    valueField: 'Function'
                }
                    ,
                {
                    name: 'Department',
                    width: '110px',
                    valueField: 'Department'
                },
                {
                    name: 'Designation',
                    width: '130px',
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
                        var str = "<tr flg='0' flgvalid='1' nomineid='" + ui.item.NodeID + "' minnominationpercategory='" + $("#MainContent_ddlRelatioShip option:selected").attr("minNominationperCategory") + "' rpid='" + $("#MainContent_ddlRelatioShip option:selected").val() + "' newrpid='" + $("#MainContent_ddlRelatioShip option:selected").val() + "'>";
                        str += "<td>" + $("#MainContent_ddlRelatioShip option:selected").attr("rptxt") + "</td>";
                        str += "<td>" + ui.item.FullName + "</td>";
                        str += "<td>" + ui.item.EMailID + "</td>";
                        str += "<td>" + ui.item.Function + "</td>";
                        str += "<td>" + ui.item.Department + "</td>";
                        str += "<td>" + ui.item.Designation + "</td>";
                        str += "<td>Initial draft</td>";
                        str += "<td class='text-center'><i class='fa fa-pencil' onclick='fnEditCategory(this)' title='click to edit' style='cursor:pointer'></i> <i class='fa fa-trash-o' onclick='fnRemoveFromDB(this)' style='color:red;cursor:pointer;margin-left:5px' title='click to delete'></i></td>";
                        str += "</tr>";
                        $("#tblMainNominee tbody").find("td.dt-empty").closest("tr").remove();
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
                        var ApseNodeId = $("#MainContent_hdnNodeId").val();
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
                            fnGetNomineeDetails();
                            fnUpdateProgressbar();

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
                buttons: {
                    "Yes": function () {
                        var arr = [];
                        var ApseNodeId = $("#MainContent_hdnNodeId").val();
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
                        PageMethods.fnSaveandDeleteNomineeData(LoginId, arr, flg, function (result) {
                            $("#dvFadeForProcessing").hide();
                            if (result.split("|")[0] == 2) {
                                fnShowmsg("Error:" + result.split("|")[1]);
                                return false;
                            }

                            fnUpdateProgressbar();
                            fnGetNomineeDetails();
                            if (flg == 1) {
                                var LevelId = $("#MainContent_hdnLevelId").val();
                                $("#dvMsg").html(LevelId == "2" ?"Your rater list is shared with your CDA for their approval":"Your rater list is shared with your RM/Coach for their approval");
                                setTimeout(function () {
                                    window.location.href = "frmNominateApproveNomination.aspx";
                                }, 3000);
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
                            if (st_email.indexOf("@deloitte.com") < 0) {
                                fnShowmsg("Email Id must end with '@deloitte.com'!");
                                $inputs.eq(1).focus();
                                return false;
                            }
                            var st_function = $inputs.eq(2).val().trim();
                            var st_dept = $inputs.eq(3).val().trim();
                            var st_deg = $inputs.eq(4).val().trim();
                            //alert("HI")
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
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="row no-gutters">
        <div class="col-md-12">

            <div class="section-title">
                <h3 class="text-center">Nominate your Raters- How to nominate raters.</h3>
                <div class="title-line-center"></div>
            </div>
            <h6><b>What you should know before selecting your raters:</b></h6>
            <div style="font-size: 10pt" id="divContent_1" runat="server" attr="SMD">
                For each category, please ensure you meet the minimum nomination requirements as mentioned below:
               <ul>
                   <ul>
                       <li><strong>Direct Reports</strong> (minimum. 2) &ndash; would include your juniors with whom you have worked directly in last 12-18 months.</li>
                       <li><strong>Peers</strong> (Min. 2) &ndash; Would include the professional at the same career level as yours. These can be people from your work group or other service lines.</li>
                       <li><strong>Review Partner</strong> &ndash; can be your reporting partner, or engagement partner. You will have an option to add multiple partners in this category.</li>
                       <li><strong>Reporting Manager (RM)/Coach</strong> &ndash; Auto-added, with an option to add more raters</li>
                       <li><strong>Other Stakeholders</strong> (Min. 2) &ndash; would include the professionals who cannot be categorised under any other relationship categories available. E.g.- People part of teams beyond your core work area, like M,B&amp;C, Talent, RRO, Admin, IT, etc.</li>
                       <li>For stakeholders outside the list, you may add another Deloitte stakeholder. Please ensure their email must end with @deloitte.com.</li>
                   </ul>
               </ul>
                <p>To help ensure a holistic feedback and maintains confidentiality, you will only be able to submit your nominations if these requirements are met.</p>
                <p>Once submitted, your <strong>Coach/RM will review and approve</strong> your nominations.</p>
            </div>

            <div style="font-size: 10pt" id="divContent_2" attr="PED" runat="server">
               For each category, please ensure you meet the minimum nomination requirements as mentioned below:
                <ul>
                    <ul>
                        <li><strong>Direct Reports</strong> (minimum 2) &ndash; would include your juniors with whom you have worked directly in last 12-18 months.</li>
                        <li><strong>Peers</strong> (Min. 2) &ndash; Would include the professional at the same career level as yours. These can be people from your work group or other service lines.</li>
                        <li><strong>Review Partner</strong> &ndash; can be your reporting partner, or engagement partner. You will have an option to add multiple partners in this category.</li>
                        <li><strong>Career Development Advisor (CDA)</strong> &ndash; Auto-added</li>
                        <li><strong>Other Stakeholders</strong> (Min. 2) &ndash; would include the professionals who cannot be categorised under any other relationship categories available. E.g.- People part of teams beyond your core work area, like M, B&amp;C, Talent, RRO, Admin, IT, etc.</li>
                        <li>For stakeholders outside the list, you may add another Deloitte stakeholder. Please ensure their email must end with @deloitte.com.</li>
                    </ul>
                </ul>
                <p>To help ensure holistic feedback and maintains confidentiality, you will only be able to submit your nominations if these requirements are met.</p>
                <p>Once submitted, your <strong>CDA will review and approve</strong> your nominations.</p>
            </div>


            <div id="btnMainbodyContainer">
                <table id="tblMainNominee" style="width: 100%; border-bottom: 1px solid #e2eecb">
                    <thead>
                        <tr>
                            <th style="width: 14%">Category
                            </th>
                            <th>Name
                            </th>
                            <th style="width: 21%">Email ID
                            </th>
                            <th style="width: 8.5%">Function
                            </th>
                            <th style="width: 8%">Department
                            </th>
                            <th style="width: 13%">Designation
                            </th>
                            <th style="width: 12.5%">Status
                            </th>
                            <th style="width: 4%; text-align: center">Action
                            </th>

                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                    <tfoot>
                        <tr>
                            <th colspan="8" style="padding: 0px 0px 0px 2px">Select Category:
                                <asp:DropDownList ID="ddlRelatioShip" Style="height: 33px; width: 140px; border: 1px solid #c0c0c0" AppendDataBoundItems="true" runat="server" AutoPostBack="false">
                                    <asp:ListItem Value="0">-----</asp:ListItem>
                                </asp:DropDownList>
                                <input type="search" id="txtsearch" style="width: 77.9%" placeholder="Search raters by Emp Id, Name, Email ID" class="form-control d-inline-block clsSearchUser" />
                            </th>
                        </tr>
                    </tfoot>
                </table>
            </div>

            <div class="button-group mb-3">
                <input type="button" class="btns btn-submit" id="btnSave" value="Save" onclick="fnSaveAndSubmit(0)">
                <input type="button" class="btns btn-submit" id="btnSubmit" value="Submit" onclick="fnSaveAndSubmit(1)">
                <input type="button" class="btn btn-cancel d-none" id="btnNext" onclick="fnGotosurveypage()" value="Next">
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

    <div id="dvDialog" style="display: none"></div>
    <div id="dvAlert" style="display: none"></div>
    <asp:HiddenField ID="hdnLoginId" runat="server" Value="0" />
    <asp:HiddenField ID="hdnIsManager" runat="server" Value="0" />
    <asp:HiddenField ID="hdnNodeId" runat="server" Value="0" />
    <asp:HiddenField ID="hdnLevelId" runat="server" Value="0" />

    <div class="loader_bg" style="display: none" id="dvFadeForProcessing">
        <div class="loader"></div>
    </div>
</asp:Content>


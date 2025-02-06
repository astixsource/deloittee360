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
        .mcacAnchor {
            font-size: 12px;
        }
        /*.main-content {
            max-width: 97%;
            width: 97%;
        }*/

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
            padding: 2px 3px;
            border: 1px solid #e3efcc;
            font-size: 10pt;
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
    font-size:9.5pt;
}

.autocomplete-table {
    width: 100%;
    border-collapse: collapse;
    font-size:9.5pt;
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
        .alertcss{
            min-width:300px;
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
                        table+=('<th style="padding:0 4px;width:' + item.width + ';">' + item.name + '</th>');
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
                        .append(item.label)
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
                        "left": "360px",
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
                    width: '260px',
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
                        var str = "<tr flg='0' flgvalid='1' nomineid='" + ui.item.NodeID + "' minnominationpercategory='" + $("#MainContent_ddlRelatioShip option:selected").attr("minNominationperCategory") + "' rpid='" + $("#MainContent_ddlRelatioShip option:selected").val() + "'>";
                        str += "<td>" + $("#MainContent_ddlRelatioShip option:selected").text() + "</td>";
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

        function fnEditCategory(sender) {
            var id = $(sender).closest("tr").attr("rpid");
            if ($(sender).hasClass("fa-pencil")) {
                var sClone = $("#MainContent_ddlRelatioShip").clone();
                $(sClone).find("option[value='0']").remove();
                var id = $(sender).closest("tr").attr("rpid");
                
                $(sender).closest("tr").attr("flg", "0");
                $(sender).closest("tr").find("td").eq(0).html("<select style='width:100px'>" + $(sClone).html() + "</select>");
                $(sender).closest("tr").find("td").eq(0).find("select option").prop("selected", false);
                $(sender).closest("tr").find("td").eq(0).find("select option[value='" + id + "']").prop("selected", true);
                $(sender).removeClass("fa-pencil").addClass("fa-undo");
            } else {
                $(sender).closest("tr").attr("flg", "1");
                $(sender).removeClass("fa-undo").addClass("fa-pencil");
                $(sender).closest("tr").find("td").eq(0).html($("#MainContent_ddlRelatioShip option[value='" + id + "']").text());
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
                    if ($("#tblMainNominee tbody tr[rpid='" + rpid + "']").length > 0) {
                        var minnominationpercategory = arrCategories.eq(i).attr("minnominationpercategory");
                        if ($("#tblMainNominee tbody tr[rpid='" + rpid + "']").length < parseInt(minnominationpercategory)) {
                            return "false|" + minnominationpercategory;
                        }
                    }
                }
            }
            return "true";
        }

        function fnSaveAndSubmit(flg) {
            var $trs = $("#tblMainNominee tr[flg='0']");
            if ($trs.length == 0 && flg == 0) {
                fnShowmsg("No data found for this action, kindly add new rater first!");
                return false;
            }
            if (flg == 1) {
                $trs = $("#tblMainNominee tbody tr[flgvalid='1']");
                if ($trs.length > 0) {
                    var str = IsValidateCategory();
                    if (str.split("|")[0] == "false") {
                        fnShowmsg("Kindly add minimum rater(s) for the category first as per the above instructions!");
                        return false;
                    }
                } else {
                    fnShowmsg("No data found for this action, kindly add new rater first!");
                    return false;
                }
            }
            var LoginId = $("#MainContent_hdnLoginId").val();
            var str = "<div>" + (flg == 0 ? "Are you sure to save?" : "Please Submit if these are your final nominations?") + "</div>";
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
                            fnGetNomineeDetails();

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

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="row no-gutters">
        <div class="col-md-12">

            <div class="section-title">
                <h3 class="text-center">Nominate your Raters</h3>
                <div class="title-line-center"></div>
            </div>
            <h6><b>What you should know before selecting your raters:</b></h6>
                For each category, please ensure you meet the minimum nomination requirements as mentioned below:
                <ul style="font-size:9.5pt">
                    <li><b>Direct Reports:</b> Team members who report to you (Min. 2)
                    </li>
                    <li><b>Peers:</b> Colleagues you work with (Min. 2)</li>
                    <li><b>Other Stakeholders:</b> Other stakeholders that do not map across the rater categories defined (Min. 2)</li>
                    <li><b>Reporting Manager (RM)/Coach:</b> Your supervisory, responsible for your career (Auto-added, more raters can be added)</li>
                    <li><b>Review Partner:</b> Your project supervisor (Optional)</li>
                </ul>
            <p>To help ensure a holistic feedback and maintains confidentiality, you will only be able to submit your nominations if these requirements are met. 
</p>
            <p>For stakeholders outside the list, you may add another Deloitte stakeholder. Please ensure their email must end with @deloitte.com.
</p>
            <p>As next step, once you submit your nominations, your manager can review, modify, and approve them.
</p>

            <div id="btnMainbodyContainer">

                <table id="tblMainNominee" style="width: 100%;border-bottom:1px solid #e2eecb">
                    <thead>
                        <tr>
                            <th style="width: 10%">Category*
                            </th>
                            <th>Name*
                            </th>
                            <th style="width: 22%">Email ID*
                            </th>
                            <th style="width: 12%">Function*
                            </th>
                            <th style="width: 12%">Department*
                            </th>
                            <th style="width: 12%">Designation*
                            </th>
                            <th style="width: 13%">Status
                            </th>
                            <th style="width: 5%; text-align: center">Action
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                    <tfoot>
                        <tr>
                            <th colspan="8">Select Category:
                                <asp:DropDownList ID="ddlRelatioShip" Style="height: 33px;width:140px; border: 1px solid #c0c0c0" AppendDataBoundItems="true" runat="server" AutoPostBack="false">
                                    <asp:ListItem Value="0">-----</asp:ListItem>
                                </asp:DropDownList>

                                <input type="search" id="txtsearch" placeholder="search raters" class="form-control w-75 d-inline-block clsSearchUser" />
                            </th>
                        </tr>
                    </tfoot>
                </table>

                <%--<div style="margin: 5px 0px 10px 0px;" class="clsmainbody d-none">
                    <div class="clsNomineebtncontainer">
                        <label class="bg-secondary p-2 w-100 text-white" style="text-align: left">
                            <span onclick="fnShowHideDiv(this)" style="cursor: pointer"><i class="fa fa-arrow-circle-o-down clsarrow" style="font-size: 13pt"></i><span class="clsnomiTitle">Enter</span> details of Review Partner: Nominee <span class="clsnomcount">1</span></span>

                            <i class="fa fa-minus-circle float-end" onclick="fnRemoveNewNominee(this)" style="font-size: 16pt; margin-left: 10px; display: none" title="click to remove nominee"></i>
                            <i class="fa fa-plus-circle float-end" onclick="fnAddNewNominee(this)" style="font-size: 16pt;" title="click to add new nominee"></i>
                        </label>
                    </div>
                    <div style="display: none; border: 1px solid #c0c0c0" class="clsNomineebodycontainer">
                        <table class="w-100">
                            <tr>
                                <td style="padding: 10px; width: 13%"></td>
                                <td style="padding: 10px; width: 15%"></td>
                                <td style="padding: 10px; width: 13%">Search Nominee:</td>
                                <td style="padding: 10px"></td>
                            </tr>
                        </table>
                        <table class="w-75 table-bordered">

                            <tr>
                                <td style="font-size: 15px; width: 15%" class="clscellbgcolor">Name <span style="color: red">*</span> :</td>
                                <td>

                                    <input type="text" id="txtName" class="form-control bg-white clsinput" disabled />
                                </td>
                            </tr>

                            <tr>
                                <td style="font-size: 15px" class="clscellbgcolor">EmailID <span style="color: red">*</span> :</td>
                                <td>
                                    <input type="text" id="txtEmailid" class="form-control bg-white clsinput" disabled />

                                </td>
                            </tr>
                            <tr>
                                <td style="font-size: 15px" class="clscellbgcolor">Function <span style="color: red">*</span> :</td>
                                <td>
                                    <input type="text" id="txtfunction" class="form-control clsinput" />
                                </td>
                            </tr>
                            <tr>
                                <td style="font-size: 15px" class="clscellbgcolor">Department <span style="color: red">*</span> :</td>
                                <td>
                                    <input type="text" id="txtDepartment" class="form-control clsinput" />

                                </td>
                            </tr>
                            <tr>
                                <td style="font-size: 15px" class="clscellbgcolor">Designation <span style="color: red">*</span> :</td>
                                <td>
                                    <input type="text" id="txtDesignation" class="form-control clsinput" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>--%>
            </div>

            <div class="button-group mb-4">
                <input type="button" class="btn btn-submit" id="btnSave" value="Save" onclick="fnSaveAndSubmit(0)" style="display: inline-block;">
                <input type="button" class="btn btn-submit" id="btnSubmit" value="Submit" onclick="fnSaveAndSubmit(1)" style="display: inline-block;">
                <input type="button" class="btn btn-next d-none" id="btnNext" onclick="fnGotosurveypage()" value="Next" style="display: inline-block;">
            </div>
        </div>
    </div>

    <div id="dvDialog" style="display: none"></div>
    <div id="dvAlert" style="display: none"></div>
    <asp:HiddenField ID="hdnLoginId" runat="server" Value="0" />
    <asp:HiddenField ID="hdnIsManager" runat="server" Value="0" />
    <asp:HiddenField ID="hdnNodeId" runat="server" Value="0" />
    <div id="dvFadeForProcessing" style="display: none; position: fixed; text-align: center; z-index: 999999; top: 0; bottom: 0; left: 0; right: 0; opacity: .80; -moz-opacity: 0.8; filter: alpha(opacity=80); background-color: #ccc;">
        <img src="../Images/loading.gif" style="width: 90px; height: 70px; position: relative; top: 50%; margin-top: -35px;" />
    </div>

</asp:Content>


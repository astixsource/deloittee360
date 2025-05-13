
        $(document).ready(function () {
            $('aside.left-panel, section.content').hide();

            if (window.innerWidth < 768) {
                $(".r-head").css("margin-bottom", "4px");
            }
        });

        function fnMakeStringForSave() {
            var SelectedValue = "";
            //  debugger;  
            $("#dvSurvey").find("input[type=radio]:checked").each(function () {
                //fnshowDependentQstn(this);
                SelectedValue += ($(this).val()) + "^^|"
            });

            if (SelectedValue == "") {
                var RspDetID = $("#dvSurvey").find("input[type=radio]").eq(0).val().split("^")[0]
                SelectedValue = RspDetID + "^0^^|"
            }
            //alert(SelectedValue)
            return SelectedValue;
        }

        function fnChkValidation() {
            var chkRadioFlag = true;
            $("input:radio").each(function () {
                var name = $(this).attr("name");
                //alert("name=" + name)
                var $checked = $("input:radio[name=" + name + "]:checked").length;
                //   alert($checked)
                if ($checked == 0) {
                    alert("Select one rating for all the Statement.")
                    $("input:radio[name=" + name + "]").eq(0).focus();
                    $("input:radio[name=" + name + "]").eq(0).addClass("RadioBackgrouncolor");
                    document.getElementById("btnNext").disabled = false;
                    chkRadioFlag = false;
                    return false;
                }
            });
            return chkRadioFlag;
        }

        function fnPrevious() {
            // debugger;
            //  alert("A-11223");
            // document.getElementById("btnPrevious").disabled = true;
            var FinalSave = 2;
            // document.getElementById("dvLoadingImg").style.display = "block";
            var RspID = document.getElementById("MainContent_hdnRspID").value;
            var PGNmbr = document.getElementById("MainContent_hdnPGNmbr").value;
            var MaxPGNmbr = document.getElementById("MainContent_hdnMaxPGNmbr").value;
            //$("#tblTopHeader").show();
            $("#h6,#h7").show();
            //alert("A-11");
            if (PGNmbr < MaxPGNmbr) {
                //  alert("A");
                var strRet = fnMakeStringForSave();
                var strComment = fnchkComments();
                //fnSaveData(FinalSave, strRet)
                fnSaveData(FinalSave, strRet, strComment, RspID)
            }
            else {
                //alert("B");
                fnSaveComments(2, 2)
            }
        }

        function fnSaveExit() {
            debugger;
            var PGNmbrCheck = document.getElementById("MainContent_hdnPGNmbr").value;
            if (window.confirm("Do you really want to exit")) {

                var FinalSave = 0;
                if (PGNmbrCheck != 9) {
                    var strComment = fnchkComments();
                    var strRet = fnMakeStringForSave();

                    var StringValue = "";
                    var SelectValue = "";
                    var isSame = true;
                    var previousVal = "";
                    for (var i = 0; i <= strRet.split("|").length - 2; i++) {
                        StringValue = strRet.split("|")[i];
                        SelectValue = StringValue.split("^")[1];
                        if (i == 0) {
                            previousVal = SelectValue;
                        }
                        if (previousVal != SelectValue) {
                            isSame = false;
                        }

                    }


                    if (isSame) {
                        //if (window.confirm("You are provided the same rating across all questions. Are you sure that you want to proceed?"))
                        //{
                        var RspID = document.getElementById("MainContent_hdnRspID").value;
        var PGNmbr = document.getElementById("MainContent_hdnPGNmbr").value;
        var MaxPGNmbr = document.getElementById("MainContent_hdnMaxPGNmbr").value;
        // debugger;
        if (PGNmbr < MaxPGNmbr) {
                            var strRet = fnMakeStringForSave();
        var strComment = fnchkComments();
        //fnSaveData(FinalSave, strRet)
        fnSaveData(FinalSave, strRet, strComment, RspID)
                        }
        else {
            fnSaveComments(2, 0)
        }
                        // }
                    }
        else {
                        var RspID = document.getElementById("MainContent_hdnRspID").value;
        var PGNmbr = document.getElementById("MainContent_hdnPGNmbr").value;
        var MaxPGNmbr = document.getElementById("MainContent_hdnMaxPGNmbr").value;
        debugger;
        if (PGNmbr < MaxPGNmbr) {
                            var strRet = fnMakeStringForSave();
        var strComment = fnchkComments();

        //fnSaveData(FinalSave, strRet)
        fnSaveData(FinalSave, strRet, strComment, RspID)
                        }
        else {
            fnSaveComments(2, 0)
        }
                    }
                }
        else {
                    debugger;
        var RspID = document.getElementById("MainContent_hdnRspID").value;
        var PGNmbr = document.getElementById("MainContent_hdnPGNmbr").value;
        var MaxPGNmbr = document.getElementById("MainContent_hdnMaxPGNmbr").value;
        // debugger;
        if (PGNmbr < MaxPGNmbr) {
                        var strRet = "";//fnMakeStringForSave();
        var strComment = "";//fnchkComments();
        //fnSaveData(FinalSave, strRet)
        fnSaveData(FinalSave, strRet, strComment, RspID)
                    }
        else {
            fnSaveComments(2, 0)
        }
                }



            }
        }
        function fnNext() {
            debugger;
        //alert("Hi11");
        if (fnChkValidation() == false) {
                return false;
            }
        document.getElementById("btnNext").disabled = true;
        var FinalSave = 1;
        var strRet = fnMakeStringForSave();
        //alert(strRet);
        //debugger;
        var StringValue = "";
        var SelectValue = "";
        var isSame = true;
        var previousVal = "";
        for (var i = 0; i <= strRet.split("|").length - 2; i++) {
            StringValue = strRet.split("|")[i];
        SelectValue = StringValue.split("^")[1];
        if (i == 0) {
            previousVal = SelectValue;
                }
        if (previousVal != SelectValue) {
            isSame = false;
                }

            }
        var PGNmbrCheck = document.getElementById("MainContent_hdnPGNmbr").value;
        if (PGNmbrCheck != 9) {
                if (isSame) {
                    //if (window.confirm("You are provided the same rating across all questions. Are you sure that you want to proceed?"))
                    //{
                    var strComment = fnchkComments();
        // document.getElementById("dvLoadingImg").style.display = "block";
        var PGNmbr = document.getElementById("MainContent_hdnPGNmbr").value;
        var MaxPGNmbr = document.getElementById("MainContent_hdnMaxPGNmbr").value;
        var RspID = document.getElementById("MainContent_hdnRspID").value;
        // debugger;
        if (PGNmbr < MaxPGNmbr) {
            // debugger;
            fnSaveData(FinalSave, strRet, strComment, RspID)
        }
        else {
            document.getElementById("dvQuestions").style.display = "none";
        document.getElementById("dvSurvey").style.display = "none";
        document.getElementById("divComments").style.display = "table";
        document.getElementById("btnSubmit").style.display = "inline-block";
        document.getElementById("btnNext").style.display = "none";
        document.getElementById("tdPageNum1").innerHTML = "Page - " + parseInt(MaxPGNmbr) + "/" + parseInt(MaxPGNmbr);
        E360WebService.fnGetRspComments(RspID, rsltGetCommentSuccess, rsltFailed);
                    }
                    //}
                    //else {
            //    document.getElementById("btnNext").disabled = false;
            //}
        }
        else {

                    var strComment = fnchkComments();
        // document.getElementById("dvLoadingImg").style.display = "block";
        var PGNmbr = document.getElementById("MainContent_hdnPGNmbr").value;
        var MaxPGNmbr = document.getElementById("MainContent_hdnMaxPGNmbr").value;
        var RspID = document.getElementById("MainContent_hdnRspID").value;
        // debugger;
        if (PGNmbr < MaxPGNmbr) {
            // debugger;
            fnSaveData(FinalSave, strRet, strComment, RspID)
        }
        else {
            document.getElementById("dvQuestions").style.display = "none";
        document.getElementById("dvSurvey").style.display = "none";
        document.getElementById("divComments").style.display = "table";
        document.getElementById("btnSubmit").style.display = "inline-block";
        document.getElementById("btnNext").style.display = "none";
        document.getElementById("tdPageNum1").innerHTML = "Page - " + parseInt(MaxPGNmbr) + "/" + parseInt(MaxPGNmbr);
        E360WebService.fnGetRspComments(RspID, rsltGetCommentSuccess, rsltFailed);
                    }
                }
            }



        }

        function FinalSubmit() {
            // debugger;
            if (window.confirm("Are you sure you want to submit?")) {
            fnSaveComments(1, 3)
        }
        else { }
        }

        function fnSaveData(FinalSave, strResult, strComment, RspID) {
            //alert("strResult=" + strResult)
            var FSave = FinalSave;
        E360WebService.fnUpdateResponses(strResult, FinalSave, strComment, RspID, rsltUpdateResponsesSuccess, rsltFailed, FSave);
        }

        function rsltUpdateResponsesSuccess(result, FinalSave) {
            /* debugger;*/
            //  alert(result)
            //alert(result.split("^")[3])
            if (result.split("@")[0] == 1) {
                if (FinalSave == 0) {
            window.location.href = "../Data/frmMain.aspx?ChkFlg=1";
        return false;
                }
        var PGNmbr = result.split("@")[1].split("^")[3]
        document.getElementById("MainContent_hdnPGNmbr").value = PGNmbr
        //alert("PGNmbr=" + PGNmbr)
        var RspID = document.getElementById("MainContent_hdnRspID").value;
        var MaxPGNmbr = document.getElementById("MainContent_hdnMaxPGNmbr").value;
        var levelID = document.getElementById("MainContent_hdnLevelID").value;
        /* debugger;*/
        document.getElementById("tdPageNum1").innerHTML = "Page - " + parseInt(PGNmbr) + "/" + parseInt(MaxPGNmbr);
                //if (PGNmbr == 1) {
                //    document.getElementById("btnPrevious").style.display = "none";
                //}
                //else {
                //    document.getElementById("btnPrevious").style.display = "inline-block";
                //}

                if (PGNmbr == 1) {
            document.getElementById("h6").style.display = "block";
        document.getElementById("h7").style.display = "block";
        document.getElementById("btnPrevious").style.display = "none";
                }
        else if (PGNmbr == 9) {
            document.getElementById("h6").style.display = "none";
        document.getElementById("h7").style.display = "none";
        document.getElementById("btnPrevious").style.display = "inline-block";
                }
        else {
            document.getElementById("h6").style.display = "block";
        document.getElementById("h7").style.display = "block";
        document.getElementById("btnPrevious").style.display = "inline-block";
                }


        if (PGNmbr < MaxPGNmbr) {
            // alert(levelID);
            E360WebService.subPopulateQuestions(RspID, PGNmbr, levelID, rsltGetStatementSuccess, rsltFailed, PGNmbr);
                }
        else {
            document.getElementById("dvQuestions").style.display = "none";
        document.getElementById("dvSurvey").style.display = "none";
        document.getElementById("divComments").style.display = "table";
        document.getElementById("btnSubmit").style.display = "inline-block";
        document.getElementById("btnNext").style.display = "none";
        document.getElementById("tdPageNum1").innerHTML = "Page - " + parseInt(MaxPGNmbr) + "/" + parseInt(MaxPGNmbr);
                }
            }
        }

        function rsltGetStatementSuccess(result, PGNmbr) {
            //alert(result)
            if (result.split("@")[0] == 1) {
            document.getElementById("btnNext").disabled = false;
        document.getElementById("btnPrevious").disabled = false;
        document.getElementById("dvQuestions").style.display = "flex";
        document.getElementById("dvSurvey").style.display = "block";
        document.getElementById("divComments").style.display = "none";
        document.getElementById("btnSubmit").style.display = "none";
        document.getElementById("btnNext").style.display = "inline-block";
        var MaxPGNmbr = document.getElementById("MainContent_hdnMaxPGNmbr").value;
        document.getElementById("MainContent_hdnPGNmbr").value = PGNmbr;
        document.getElementById("tdPageNum1").innerHTML = "Page - " + parseInt(PGNmbr) + "/" + parseInt(MaxPGNmbr);
        $("#dvSurvey")[0].innerHTML = result.split("@")[1];
        //$("MainContent_hdnCmptncyID").value = result.split("@")[2];
        document.getElementById("MainContent_hdnCmptncyID").value = result.split("@")[2];
            }
        }

        function fnSaveComments(X, FinalSave) {
         
        //    if (X == "1") {
        //        if (document.getElementById("MainContent_Textbox1").value == "") {
        //    alert("Please note that it is mandatory to fill the comment");
        //return false;
        //        }
        //if (document.getElementById("MainContent_Textbox2").value == "") {
        //    alert("Please note that it is mandatory to fill the comment");
        //return false;
        //        }
        //        //if (document.getElementById("MainContent_Textbox3").value == "") {
        //    //    alert("Please note that it is mandatory to fill the comment");
        //    //    return false;
        //    //}
        //    //if (document.getElementById("MainContent_Textbox4").value == "") {
        //    //    alert("Please note that it is mandatory to fill the comment");
        //    //    return false;
        //    //}

        //}
        var RspID = document.getElementById("MainContent_hdnRspID").value;

        E360WebService.fnRspInsertRspComments(RspID, document.getElementById("MainContent_Textbox1").value, document.getElementById("MainContent_Textbox2").value, document.getElementById("MainContent_Textbox2").value, document.getElementById("MainContent_Textbox2").value, FinalSave, rsltRspInsertRspComments, rsltFailed, FinalSave + "^" + RspID);
        }

        function rsltRspInsertRspComments(result, Rep) {
            /*   debugger;*/
            if (result.split("@")[0] == "1") {
                var FinalSave = Rep.split("^")[0]
        var RspID = Rep.split("^")[1]
        var PGNmbr = result.split("^")[3]
        var levelID = document.getElementById("MainContent_hdnLevelID").value;


        //alert(FinalSave);
        //alert(RspID);
        //alert(PGNmbr);
        //alert(levelID);
        if (FinalSave == 0) {
            window.location.href = "../Data/frmMain.aspx?ChkFlg=1";
        return false;
                }
        if (FinalSave == 2) {
            E360WebService.subPopulateQuestions(RspID, PGNmbr, levelID, rsltGetStatementSuccess, rsltFailed, PGNmbr);
                }
        else {
            // alert("Submitted Successfully")
            alert("Your response has been successfully submitted.")
                    window.location.href = "../Data/frmMain.aspx?ChkFlg=1";
                }
            }
        }

        function rsltFailed(result) {
            //if (result.split("@")[0] == "2") {
            //    alert(result.split("@")[1])
            //}
            alert("Oops! Something went wrong. Please try again.");
        }


        function fnCheckLengthAnsCmt(obj) {//debugger;
            //	alert("In Function")
            var strTextBox = ""
            if (obj.value.length >= 300) {
            strTextBox = obj.value;
        obj.value = strTextBox.substring(0, 300);
        alert("Text Can't be more than 700 characters");
        return false;
            }
        }

        function fnAdjustRows(textarea) {//debugger;
            if (document.all) {
                /*	alert("Scroll Height" + textarea.scrollHeight )
        alert("textarea.clientHeight="  + textarea.clientHeight)*/
                while (textarea.scrollHeight > textarea.clientHeight)
        textarea.rows++;
        textarea.scrollTop = 0;
            }
        }
        function fnClearTextbox(TextBoxID) {
            if (document.getElementById(TextBoxID).innerText == "Comments") {
            document.getElementById(TextBoxID).innerText = "";
            }
        }

        function fnchkComments() {
            // alert("In fn")
            var RspID = document.getElementById("MainContent_hdnRspID").value;
        debugger;
        //alert(RspID);
        var flag = 0;
        var cmptncyComments = "";
        var Comment = $("#dvSurvey").find("textarea").eq(0).val();
        // alert(Comment);
        var Cntr = document.getElementById("MainContent_hdnCmptncyCmntCntr").value;
        // alert("Cntr=" + Cntr)

        var str1 = "121|";
        var str = document.getElementById("MainContent_hdnCmptncyID").value;
        // alert(str1);
        //  alert(str);
        var cmpId = new Array();
        cmpId = str.split("|")
        //  alert(cmpId);
        for (var i = 1; i <= Cntr; i++) {

                var StrTxt;
        var ComntVAl = document.getElementById("txtCompCmt" + i).value
        //  alert(ComntVAl);
        //debugger;
        if (ComntVAl == "Comments") {

            ComntVAl = "";
        alert(ComntVAl);
                }
        /////-----------------------

        ////-------------------------
        if (cmptncyComments == "") {
                    if (ComntVAl != StrTxt) {
            cmptncyComments = ComntVAl + "^" + cmpId[i - 1];
                    }
        else {

        }
                }
        else {
                    if (ComntVAl != StrTxt) {
            cmptncyComments = cmptncyComments + "|" + ComntVAl + "^" + cmpId[i - 1];
                    }
        else {

        }
                }
                //alert(document.getElementById("txtCompCmt" + i).value);							
                //document.getElementById("hdnCmptncyCmntValue").value=document.getElementById("txtCompCmt" + i).value;
            }
        document.getElementById("MainContent_hdnCmptncyCmnt").value = cmptncyComments;

        // alert(cmptncyComments);
        return Comment + "@" + str;

        }





        var specialKeys = new Array();
        //specialKeys.push(8);  //Backspace
        //specialKeys.push(9);  //Tab
        //specialKeys.push(46); //Delete
        //specialKeys.push(36); //Home
        //specialKeys.push(35); //End
        //specialKeys.push(37); //Left
        //specialKeys.push(39); //Right

        specialKeys.push(64); //Right
        specialKeys.push(94); //Right


        function IsAlphaNumeric(e) {
            //  alert("Porwal");
            var keyCode = e.keyCode == 0 ? e.charCode : e.keyCode;
            // alert(keyCode);
            // var ret = ((keyCode >= 48 && keyCode <= 57) || (keyCode >= 65 && keyCode <= 90) || (keyCode >= 97 && keyCode <= 122) || (specialKeys.indexOf(e.keyCode) != -1 && e.charCode != e.keyCode));

        var ret = ((specialKeys.indexOf(e.keyCode) == -1));
        // var ret = ((keyCode != 64) || (keyCode != 94));
        document.getElementById("error").style.display = ret ? "none" : "inline";
        return ret;
        }

        $(document).ready(function () {
            /* debugger;*/
            var RspID = document.getElementById("MainContent_hdnRspID").value;
        var levelID = document.getElementById("MainContent_hdnLevelID").value;
        var PGNmbr = document.getElementById("MainContent_hdnPGNmbr").value;
        var MaxPGNmbr = document.getElementById("MainContent_hdnMaxPGNmbr").value;
        var Name = document.getElementById("MainContent_hdnMaxPGNmbr").value;

        //alert(RspID);
        //alert(PGNmbr);
        //alert(MaxPGNmbr);
        document.getElementById("dvName").innerHTML = "Feedback for:-" + document.getElementById("MainContent_hdnName").value
        if (PGNmbr == 1) {
            document.getElementById("h6").style.display = "inline-block";
        document.getElementById("h7").style.display = "inline-block";
        document.getElementById("btnPrevious").style.display = "none";
            }
        else if (PGNmbr == 9) {
            document.getElementById("h6").style.display = "none";
        document.getElementById("h7").style.display = "none";
        document.getElementById("btnPrevious").style.display = "inline-block";
            }
        else {
            document.getElementById("h6").style.display = "inline-block";
        document.getElementById("h7").style.display = "inline-block";
        document.getElementById("btnPrevious").style.display = "inline-block";
            }
        if (PGNmbr < MaxPGNmbr) {
            document.getElementById("h6").style.display = "block";
        document.getElementById("h7").style.display = "block";
        document.getElementById("dvQuestions").style.display = "table-cell";
        document.getElementById("dvSurvey").style.display = "block";
        document.getElementById("divComments").style.display = "none";
        document.getElementById("btnSubmit").style.display = "none";
        document.getElementById("btnNext").style.display = "inline-block";
        document.getElementById("tdPageNum1").innerHTML = "Page -" + parseInt(PGNmbr) + "/" + parseInt(MaxPGNmbr);
        E360WebService.subPopulateQuestions(RspID, PGNmbr, levelID, rsltGetStatementSuccess, rsltFailed, PGNmbr);
            }
        else {
            document.getElementById("h6").style.display = "none";
        document.getElementById("h7").style.display = "none";
        document.getElementById("dvQuestions").style.display = "none";
        document.getElementById("dvSurvey").style.display = "none";
        document.getElementById("divComments").style.display = "table";
        document.getElementById("btnSubmit").style.display = "inline-block";
        document.getElementById("btnNext").style.display = "none";
        document.getElementById("tdPageNum1").innerHTML = "Page - " + parseInt(MaxPGNmbr) + "/" + parseInt(MaxPGNmbr);
        //  debugger;
        E360WebService.fnGetRspComments(RspID, rsltGetCommentSuccess, rsltFailed);
            }
        });

        function rsltGetCommentSuccess(result) {
            if (result.split("@")[0] == "1") {
            document.getElementById("MainContent_Textbox1").value = result.split("@")[1].split("^")[0]
                document.getElementById("MainContent_Textbox2").value = result.split("@")[1].split("^")[1]
                //document.getElementById("MainContent_Textbox3").value = result.split("@")[1].split("^")[2]
                //document.getElementById("MainContent_Textbox4").value = result.split("@")[1].split("^")[3]
            }
        }

        function fnCheckLength(obj) {
            //       alert("In Function")
            var strTextBox = ""
            if (obj.value.length >= 3000) {
            strTextBox = obj.value;
        obj.value = strTextBox.substring(0, 3000);
        alert("Text Can't be more than 3000 characters")
            }
        }
        function fninstruction() {
            $("#dvinstruction").dialog({
                title: 'Instruction',
                modal: true,
                width: '85%',
                maxHeight: $(window).height() - 75
                //minHeight: 150
            });
        }

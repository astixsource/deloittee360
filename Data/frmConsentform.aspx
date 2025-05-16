<%@ Page Title="" Language="C#" MasterPageFile="~/Data/SiteConsent.master" AutoEventWireup="true" CodeFile="frmConsentform.aspx.cs" Inherits="frmConsentform" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <style type="text/css">
        p {
            margin-bottom: 10px;
            margin-top: 10px;
            text-align: left;
        }
    </style>
    <script type="text/javascript">


        function fnChkAgree() {
            if ($("#chkAgree").is(":checked")) {
                var LoginId = $("#MainContent_hdnLoginId").val();
                $("#ConatntMatter_hdnAgree").val(1)
                //var Agree = $("#ConatntMatter_hdnAgree").val(1);

                //alert(LoginId);
                // alert(Agree);
                $("#MainContent_btnSubmit").click();
                // alert(2);
                //  window.location.href = "frmAssessorPreDCPostDC.aspx?&LoginId=" + LoginId;

            }
            else {
                $("#ConatntMatter_hdnAgree").val(0)
                $("#dvDialog")[0].innerHTML = "<center>Please click on ''I agree'' to proceed further.</center>";
                $("#dvDialog").dialog({
                    title: 'Consent Message',
                    modal: true,
                    width: '30%',

                    buttons: [{
                        text: "OK",
                        click: function () {

                            $("#dvDialog").dialog("close");
                        }
                    }],
                    close: function () {
                        $(this).dialog("close");
                        $(this).dialog("destroy");

                        return false;
                    }
                });
                return false;
            }
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <div>
        <div class="p-lg-5">
            <div class="section-title">
                <h3 class="text-center">Consent Form</h3>
                <div class="title-line-center"></div>
            </div>


            <p>By accessing this Assessment Portal (“ Tool”), you hereby voluntarily consent to the following;</p>
            <ul>
                <li>Information (including personal information and sensitive personal information belonging to you) will be used, processed and stored by the Astix Infolytics Pvt. Ltd. and processed in relation to your employment, internal/ regulatory/ legal compliances and/or any other administrative purposes.</li>
                <li>Information will be processed and stored within India as per the practices and policies of the organization and may be shared with other entities in the Deloitte network/ third parties on a need-to-know basis (including with third party service providers) and/or in relation to the purpose for which it is collected.</li>
                <li>The Information from other platforms may be integrated with this Tool and/or vice versa.</li>
                <li>If you have any questions or concerns pertaining to the Tool and/or your information, please contact <a href="mailto:360feedback@deloitte.com">360feedback@deloitte.com</a></li>

            </ul>
        </div>
    </div>

    <div class="text-center">

        <asp:Button ID="btnback" class="btns btn-submit" runat="server" Text="Back" OnClick="btnback_Click" />
        <div id="dvbtncontainer" runat="server">


            <input type="Checkbox" id="chkAgree" />
            <input type="button" id="btnAgree" value="I Agree" class="btns btn-submit" onclick="fnChkAgree()" />
            <asp:Button ID="btnSubmit" Style="display: none" runat="server" Text="I Agree" OnClick="btnSubmit_Click" />
        </div>
    </div>
    <div id="dvMsg" runat="server" class="m-3"></div>
    <%--   <input type="hidden" id="hdnAgree" runat="server" value="0">--%>
    <div id="dvDialog" style="display: none"></div>
    <asp:HiddenField runat="server" ID="hdnAgree" Value="1" />
    <asp:HiddenField runat="server" ID="hdnLoginId" Value="0" />
    <asp:HiddenField runat="server" ID="hdnLevelId" Value="0" />
    <asp:HiddenField runat="server" ID="hdnCycleId" Value="0" />
    <asp:HiddenField runat="server" ID="hdnCycleName" Value="" />

</asp:Content>


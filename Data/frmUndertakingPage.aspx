<%@ Page Title="" Language="C#" MasterPageFile="~/Data/Site.master" AutoEventWireup="true" CodeFile="frmUndertakingPage.aspx.cs" Inherits="frmUndertakingPage" %>

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
                <h3 class="text-center">Privacy Statement</h3>
                <div class="title-line-center"></div>
            </div>


            <p><strong>Introduction</strong></p>
            <p>This Privacy Statement explains how we will collect or obtain, handle, store and protect the information about you that is provided by your Organisation for the use of (1) E360 Platform provided by Astix Infolytics (referred to as the <strong>&ldquo;Application&rdquo;</strong>) and/or (2) in the course of providing services. This Privacy Statement also sets out your rights in relation to personal information and tells you who you can contact if you have questions. By using the Application and/or by receiving services, you agree to the use of such information in accordance with this Privacy Statement.</p>
            <p>This Privacy Statement is divided into the sections listed below.</p>
            <ul>
                <li>To whom this Privacy Statement applies and what it covers</li>
                <li>Types of personal information we collect</li>
                <li>How we collect personal information</li>
                <li>How we use personal information</li>
                <li>On what basis we process personal information</li>
                <li>To whom we disclose personal information</li>
                <li>Selling of personal information</li>
                <li>Do not track</li>
                <li>How we keep personal information secure</li>
                <li>How long we will keep personal information</li>
                <li>Your rights in relation to personal information</li>
                <li>Changes to this Privacy Statement</li>
                <li>Contact us</li>
            </ul>
            <p><strong>To whom this Privacy Statement applies and what it covers</strong></p>
            <p><strong>When used in this Privacy Statement &ldquo;Deloitte&rdquo;, &ldquo;we&rdquo;, &ldquo;us&rdquo; and &ldquo;our&rdquo; refers to any entity within the Deloitte Network that invited you to use the Application and/or is involved in the provision of services.</strong></p>
            <p>As used in this Privacy Statement, the <strong>&ldquo;Deloitte Network</strong><strong>&rdquo; </strong>refers to one or more of Deloitte Touche Tohmatsu India LLP (&ldquo;DTTILLP&rdquo;), its network of member firms and the affiliates of such member firms or its authorized third parties. DTTILLP and each of its member firms and the affiliates of such member firms are legally separate and independent entities. Please see deloitte.com/about for a detailed description of the legal structure of DTTILLP and its member firms.</p>
            <p>This Privacy Statement is being provided to you in connection with your use of the Application and/or services. It sets out how the Application will process the personal information for 360-Degree Feedback for employees. Deloitte is providing these services either under a direct contract with you or via a contract with another person (such as a company or a partnership or a trustee) who has asked us to provide the services.</p>
            <p>Personal information will be protected and handled with consideration for its confidentiality.</p>
            <p>In this Privacy Statement, we refer to handling, collecting, protecting and storing personal information as "processing".</p>
            <p><strong>Types of personal information we collect</strong></p>
            <p>Deloitte may collect personal information relating to you such as:</p>
            <ul>
                <li>your name,</li>
                <li>contact details,</li>
                <li>job title,</li>
                <li>Department / team information</li>
                <li>any other personal information you or your employer share during the course of your interaction with us as part of the engagement.</li>
            </ul>
            <p><strong>How we collect personal information</strong></p>
            <p>Deloitte may collect personal information about you in different ways:</p>
            <ul>
                <li>you may upload the data onto the Application</li>
                <li>you may provide it directly to us</li>
                <li>we may obtain it because of the services that Deloitte provides or has previously provided</li>
                <li>we may observe or infer it from the information you provide to us and/or the way you interact with us</li>
            </ul>
            <p>This personal information can be received in any manner, including in-person discussions, telephone conversations, and electronic or other written communications.</p>
            <p>Without access to all the personal information that we need, Deloitte may be unable to provide or complete the services.</p>
            <p><strong>How we use personal information</strong></p>
            <p>Deloitte processes personal information to provide services to you or to the entity that has entered into subscription agreement or service arrangement with us as regards the Application.</p>
            <p>Deloitte may also use personal information for the purposes of, or in connection with:</p>
            <ul>
                <li>compliance with applicable legal, regulatory or professional requirements</li>
                <li>protecting our rights and/or property</li>
                <li>developing or improving services and products.</li>
            </ul>
            <p><strong>On what basis we process personal information</strong></p>
            <p>This Privacy Statement sets out the grounds upon which we rely in order to process personal information.</p>
            <p>Deloitte may use personal information for the purposes outlined above because:</p>
            <p>(a) where relevant, we have a contract with you to provide services and processing personal information is necessary for the performance of such contract.</p>
            <p>or</p>
            <p>(b) we are subject to legal, regulatory or professional obligations.</p>
            <p><strong>To whom we disclose personal information</strong></p>
            <p>In connection with one or more of the purposes outlined in this Privacy Statement, we may disclose personal information to:</p>
            <ul>
                <li>other firms within the Deloitte Network</li>
                <li>competent authorities, including courts and authorities regulating us or another firm within the Deloitte Network, in each case to comply with legal, regulatory or professional obligations, process or requests</li>
                <li>vendors and administrative support, infrastructure and other service providers handling your information on our behalf; in each case, such vendors and service providers will be contractually bound by confidentiality and privacy obligations consistent with the obligations in this Privacy Statement</li>
                <li>third parties to whom we disclose information in the course of providing services to you or to the entity that has engaged us to provide the services.</li>
            </ul>
            <p>Any personal information that we have referenced above under &ldquo;How we collect personal information&rdquo; may be disclosed to the third parties identified in this section for the purposes set forth herein.</p>
            <p><strong>Selling of personal information</strong></p>
            <p>We do not sell your personal information.</p>
            <p><strong>How we keep personal information secure</strong></p>
            <p>We have in place reasonable commercial standards of technology and operational security to protect personal information from loss, misuse and unauthorized access, disclosure, alteration or destruction.</p>
            <p>The admin right at an Application level is with Deloitte personnel. In case of subscription model, the admin right at a client level is with licensee admin (i.e. client admin). The licensee admin will create client account, user master, role creations, etc. Deloitte admin cannot see any data of any client. Role based access control (RBAC) has been implemented on the Application. Users will view/ edit /access&nbsp; data based on role assigned, organizational structure to which the Use is mapped.&nbsp;&nbsp;&nbsp;</p>
            <p><strong>How long we will keep personal information</strong></p>
            <p>We retain personal information as long as is necessary to fulfill the purposes identified in this Privacy Statement or (i) as otherwise necessary to comply with applicable laws or professional standards, or (ii) as long as the period in which litigation or investigations might arise in respect of our services.</p>
            <p>Without prejudice to the above,</p>
            <ul>
                <li>Source data which are uploaded by the users in the Application (except JSON file) will be kept for X year; and</li>
                <li>Rest of the data processed and generated from the tool (JSON, supporting repository documents, user remarks, backend calculations/ validations, audit trail, search words, etc) to be kept for X</li>
            </ul>
            <p>The Information shall not be retained beyond the period mentioned below from the date of collection.</p>
            <p><strong>Your rights in relation to personal information</strong></p>
            <p>You have various rights in relation to personal information. In particular, you have a right to:</p>
            <ul>
                <li>obtain confirmation that we are processing your personal information and request a copy of the personal information we hold about you</li>
                <li>ask that we update the personal information we hold about you, or correct such information that you think is inaccurate or incomplete</li>
            </ul>
            <p>Depending on the jurisdiction in which you are located, you may also have the right to:</p>
            <ul>
                <li>ask that we delete personal information that we hold about you, or restrict the way in which we use your personal information</li>
                <li>request that we provide the following information regarding the personal information we hold about you:
                    <ul>
                        <li>The categories and/or specific pieces of personal information we collected</li>
                        <li>The categories of sources from which personal information is collected</li>
                        <li>The business or commercial purpose for collecting personal information</li>
                        <li>The categories of third parties with whom we shared personal information</li>
                    </ul>
                </li>
            </ul>
            <p>However, we may still retain a copy of the relevant information for as long as necessary to comply with applicable laws or professional standards, or as long as the period in which litigation or investigations might arise in respect of our services.</p>
            <p>To exercise any of your rights under applicable law described above regarding our use of personal information, please contact us at <a href="mailto:_________@deloitte.com.">_________@deloitte.com.</a></p>
            <p>Applicable laws may also give you the right to lodge a complaint with a local supervisory authority related to this Privacy Statement.</p>
            <p>We will not discriminate against you for exercising any of your rights with respect to personal information.</p>
            <p>In addition to describing our current privacy practices, this Privacy Statement also describes the categories of personal information we collected or disclosed. We may modify or amend this Privacy Statement from time to time at our discretion. When we make changes to this Privacy Statement, we will amend the revision date at the top of this page and the modified or amended Privacy Statement shall apply to personal information as of that revision date. We encourage you to review this Privacy Statement periodically to be informed about how we are protecting your personal information.</p>
            <p><strong>Contact us</strong></p>
            <p>If you have any questions or concerns regarding this Privacy Statement or you are unsatisfied with the way in which personal information has been processed or the manner in which a privacy query or request that you have raised has been handled, please contact by emailing <a href="mailto:_________@deloitte.com.">_________@deloitte.com.</a></p>
        </div>
    </div>

    <div class="text-center">
        <input type="Checkbox" id="chkAgree" />
        <input type="button" id="btnAgree" value="I Agree" class="btns btn-submit" onclick="fnChkAgree()" />
        <asp:Button ID="btnSubmit" Style="display: none" runat="server" Text="I Agree" OnClick="btnSubmit_Click" />
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


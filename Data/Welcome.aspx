<%@ Page  Language="VB" MasterPageFile="~/Data/Site.master" AutoEventWireup="true" CodeFile="Welcome.aspx.vb" Inherits="_Welcome" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {
            $("img.info-bg").hide();
            var $url = $("img.info-bg").attr("src");
            $('.grid-welcome-bg').css('backgroundImage', 'url(' + $url + ')');
            $('aside.left-panel, section.content').hide();
        });
    </script>

</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row no-gutters">
        <div class="col-md-6">
            <div class="grid-welcome-bg">
                <img src="../Images/Welcome.jpg" class="info-bg" />
            </div>
        </div>
        <div class="col-md-6">
            <div class="grid bg_one">
                <div class="section-title">
                    <h3 class="text-center">WELCOME TO Deloitte 180 FEEDBACK SURVEY</h3>
                    <div class="title-line-center"></div>
                </div>
                <p>The company is professionally managed by ​over 50 metallurgical & mechanical engineers & management graduates. A team of over 250 blue and white collared associates are guided by the board of directors and senior experts.​</p>
                <p>Our family owned and professionally managed status enables us to focus on long term value creation and not compromise on our values for short term profits.​​</p>
                <p>ArcVac has been successful in blending the judicious mix of wisdom of senior domain experts with energy of youth to create one of the best work place in Eastern India where quality and careers blooms.​</p>
                <div class="text-center">
                    <asp:Button ID="btnContiue" runat="server" Text="Continue" CssClass="btns btn-submit" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>

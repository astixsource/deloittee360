function isIE() {
    ua = navigator.userAgent;
    var is_ie = ua.indexOf("MSIE ") > -1 || ua.indexOf("Trident/") > -1;
    return is_ie;
}
$(document).ready(function () {
    if (isIE()) {
        //alert('It is InternetExplorer');
        $("nav.navbar").css("display", "block"), $("img.logo").css("margin-top", "8px");
    } else {
        //alert('It is NOT InternetExplorer');
        $("nav.navbar").css("display", "flex")
    }

    $("img.bg-img").hide();
    var $url = $("img.bg-img").attr("src");
    $('.full-background_one').css('backgroundImage', 'url(' + $url + ')');

    var navbarH = $(".navbar").outerHeight() + "px"
    $(".main-content").css({
        "min-height": $(window).height() - ($(".navbar").outerHeight() + 20),
        "margin-top": - navbarH
    });

    $(document).on('click', '.navbar-toggle', function () {
        $('aside.left-panel').toggleClass('collapsed');
    });

    $("nav.navigation ul li.has-submenu ul").first().css("display", "block");

    //$(window).width() < 768) {
    //    $('nav.navigation ul li a, nav.navigation ul li.has-submenu ul li a').click(function () {
    //        $('aside.left-panel').removeClass('collapsed');
    //    });
    //}



    /********************************
        Aside Navigation Menu
    ********************************/
    $("aside.left-panel nav.navigation > ul > li:has(ul) > a").click(function () {

        if ($("aside.left-panel").hasClass('collapsed') == false || $(window).width() < 768) {

            $("aside.left-panel nav.navigation > ul > li > ul").slideUp();
            $("aside.left-panel nav.navigation > ul > li").removeClass('active');

            if (!$(this).next().is(":visible")) {
                $(this).next().slideToggle(30, function () { $("aside.left-panel:not(.collapsed)").getNiceScroll().resize(); });
                $(this).closest('li').addClass('active');
            }
            return false;

            //$('nav.navigation ul li a, nav.navigation ul li.has-submenu ul li a').removeClass('collapsed');  
        }

    });

    /********************************
        NanoScroll - fancy scroll bar
    ********************************/
    if ($.isFunction($.fn.niceScroll)) {
        $(".nicescroll").niceScroll({
            cursorcolor: '#9d9ea5',
            cursorborderradius: '0px'

        });
    }
    if ($.isFunction($.fn.niceScroll)) {
        $("aside.left-panel:not(.collapsed)").niceScroll({
            cursorcolor: '#8e909a',
            cursorborder: '0px solid #fff',
            cursoropacitymax: '0.5',
            cursorborderradius: '0px'
        });
    }
});
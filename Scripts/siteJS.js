function isIE() {
    ua = navigator.userAgent;
    var is_ie = ua.indexOf("MSIE ") > -1 || ua.indexOf("Trident/") > -1;
    return is_ie;
}

$(function () {
    if (isIE()) {
        //alert('It is InternetExplorer');
        $(".main-header").css("display", "block"), $("img.logo").css("margin", "18px 5px");
    } else {
        //alert('It is NOT InternetExplorer');
        $(".main-header").css("display", "block")
    }


    //$("html").niceScroll();
    //$("body").niceScroll({
    //    scrollspeed: 0,
    //    mousescrollstep: 0,
    //    cursorborder: 0,
    //    cursorwidth: 8,
    //    cursorcolor: '#808080',
    //    cursorborderradius: 4,
    //    autohidemode: false,
    //    horizrailenabled: false
    //});

    $("img.bg-img").hide();
    var $url = $("img.bg-img").attr("src");
    $('.full-background_one').css('backgroundImage', 'url(' + $url + ')');

    var navbarH = $(".main-header").outerHeight() + "px"
    $(".main-content").css({
        "min-height": $(window).height() - ($(".main-header").outerHeight() + 20),
        "margin-top": - navbarH
    });

    $(document).on('click', '.navbar-toggle', function () {
        $('aside.left-panel').toggleClass('collapsed');
    });

    $("nav.navigation ul li.has-submenu ul").first().css("display", "block");

    $(window).on('scroll', function () {
        if ($(this).scrollTop() > 60) {
            $('.wrapper').addClass("fixed");
            //$('.main-header').css('background', '#9C9C9A');
        }
        else {
            $('.wrapper').removeClass("fixed");
            //$('.main-header').css('background', 'rgba(0, 0, 0, 0.25)')
        }
    });
    
    /* ------------------ for tabs script ------------------ */
    $('.tabs-content > .tabs-body:first').show();
    $('.tabs > li').click(function () {
        $(this).addClass('active').siblings().removeClass('active');

        //$(this).removeClass('active');
        //$(this).addClass('active');

        $('.tabs-content > .tabs-body').hide();
        $('.' + $(this).data('class')).fadeIn();
    });

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
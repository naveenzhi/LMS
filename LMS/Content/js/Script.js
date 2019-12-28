$(document).ready(function () {

    setTimeout(function () { $("#messagediv").hide(); }, 6000);

    $('[data-toggle="tooltip"]').tooltip();
    $('[data-toggle="popover"]').popover();


    $("#navbar-menu a").on('click', function (event) {

        // Make sure this.hash has a value before overriding default behavior
        if (this.hash !== "") {
            // Prevent default anchor click behavior
            event.preventDefault();


            var target_offset = $(this.hash).offset() ? $(this.hash).offset().top : 0;
            //change this number to create the additional off set        
            var customoffset = 40;
            $('html, body').animate({ scrollTop: target_offset - customoffset }, 500);
        }
    });

    //Back to top
    $(window).scroll(function () {
        if ($(this).scrollTop() > 10) {
            $('#scroll').addClass("btn-show");
        } else {
            $('#scroll').removeClass("btn-show");
        }
    });
    $('#scroll').click(function () {
        $("html, body").animate({ scrollTop: 0 }, 600);
        return false;
    });

});

$(function () {
    'use strict'

    $('[data-toggle="offcanvas"]').on('click', function () {
        $('.offcanvas-collapse').toggleClass('open')
    })

    new WOW().init();

});



function loading(e) {
    var div = document.createElement('div');
    var img = document.createElement('img');
    img.src = 'http://lmsindia.online/Content/images/loader.gif';
    img.style.cssText = 'height:100px;width:100px; border-radius:50%;background: transparent; top:25%; position:absolute';
    div.style.cssText = 'display: flex;justify-content: center;position:fixed;z-index:2300;top:0%;width: 100%; height:100%;background: rgba(0,0,0,0.4);overflow:hidden !important';
    div.appendChild(img);
    document.body.appendChild(div);
    return true;
    // These 2 lines cancel form submission, so only use if needed.
    //window.event.cancelBubble = true;
    //e.stopPropagation();
}

$(".custom-file-input").on("change", function () {
    var fileName = $(this).val().split("\\").pop();
    $(this).siblings(".custom-file-label").addClass("selected").html(fileName);
});


// Count Number

//$('.Count').each(function () {
//    var $this = $(this);
//    jQuery({ Counter: 0 }).animate({ Counter: $this.text() }, {
//        duration: 1000,
//        easing: 'swing',
//        step: function () {
//            $this.text(Math.ceil(this.Counter));
//        }
//    });
//});



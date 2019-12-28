$(document).ready(function () {

    

    $('[data-toggle="tooltip"]').tooltip();
    $('[data-toggle="popover"]').popover();

    setTimeout(function () { $("#messagediv").hide(); }, 6000);
});
$(function () {
    'use strict'

    $('[data-toggle="offcanvas"]').on('click', function () {
        $('.offcanvas-collapse').toggleClass('open')
    })
    new WOW().init();    

    $('#tablesearch').DataTable({
        "paging": false,
        "ordering": false,
        "info": false,
        "scrollY": "300px",
        "scrollCollapse": true,
    });

    $('#tablepaging').DataTable(
        {
            "columnDefs": [
                { "orderable": false, "targets": "no-sort" }
            ]
        }
    );

});

function loading() {
    var div = document.createElement('div');
    var img = document.createElement('img');
    img.src = 'http://lmsindia.online/Content/images/loader.gif';
    img.style.cssText = 'height:100px;width:100px; border-radius:50%;background: transparent; top:25%; position:absolute';
    div.style.cssText = 'display: flex;justify-content: center;position:fixed;z-index:2300;top:0%;width: 100%; height:100%;background: rgba(255,255,255,0.7);overflow:hidden !important';
    div.appendChild(img);
    document.body.appendChild(div);
}



$(".custom-file-input").on("change", function () {
    var fileName = $(this).val().split("\\").pop();
    $(this).siblings(".custom-file-label").addClass("selected").html(fileName);

});


// check uncheck uniform
function selectAll() {
    var items = document.getElementsByName('chkuniform');
    for (var i = 0; i < items.length; i++) {
        if (items[i].type == 'checkbox')
            items[i].checked = true;
    }
}

function UnSelectAll() {
    var items = document.getElementsByName('chkuniform');
    for (var i = 0; i < items.length; i++) {
        if (items[i].type == 'checkbox')
            items[i].checked = false;
    }
}

// Select2
if (jQuery().select2) {
    $(".select2").select2();
}

//Summernote

$(".summernote").summernote({
    dialogsInBody: true,
    minHeight: 250,
    toolbar: [
        ['style', ['style']],
        ['font', ['bold', 'italic', 'underline', 'clear']],
        // ['font', ['bold', 'italic', 'underline', 'strikethrough', 'superscript', 'subscript', 'clear']],
        ['fontname', ['fontname']],
        ['fontsize', ['fontsize']],
        ['color', ['color']],
        ['para', ['ul', 'ol', 'paragraph']],
        ['height', ['height']],
        ['table', ['table']],
        ['insert', ['link', 'picture', 'hr']],
        ['view', ['fullscreen'/*, 'codeview' */]]   // remove codeview button
        //['help', ['help']]
    ]
});
$(".summernote-simple").summernote({
    dialogsInBody: true,
    minHeight: 150,
    toolbar: [
        ['style', ['bold', 'italic', 'underline', 'clear']],
        ['font', ['strikethrough']],
        ['para', ['paragraph']]
    ]
});

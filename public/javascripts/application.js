$(function() {
    $("a.button").button();
    $('a.button_add').button({
        icons: {
            primary:'ui-icon-plus'
        }
    });
    $("input[type=submit]").button();
});
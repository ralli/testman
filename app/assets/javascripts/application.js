//= require jquery
//= require jquery_ujs
//= require_self
//= require_tree .

$(function() {
    $("a.button").button();
    $('a.button_add').button({
        icons: {
            primary:'ui-icon-plus'
        }
    });
    $("input[type=submit]").button();
});


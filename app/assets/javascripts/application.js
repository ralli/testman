//= require jquery
//= require jquery_ujs
//= require_self
//= require_tree ./markitup
//= require ./jquery-ui
//= require ./jquery_tablednd
//= require ./jquery_tag

$(function() {
    $("a.button").button();
    $('a.button_add').button({
        icons: {
            primary:'ui-icon-plus'
        }
    });
    $("input[type=submit]").button();
});


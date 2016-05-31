// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$(document).on('click', 'span.glyphicon.glyphicon-ok', function(e) {
  e.preventDefault();
  $('form.new_work').submit();
  $('form.new_work')[0].reset();
})

$(document).on('click', '.image-confirm', function(e) {
  e.preventDefault();
  $.ajax($(e.target).data('url'), {method: 'post'}).then(function(data) {
    $('.clear-all-button').toggleClass('hide', !data.completed_works);
    $(e.target).toggleClass('confirmed');
    $(e.target).closest('.work').toggleClass('complete');
  });
})
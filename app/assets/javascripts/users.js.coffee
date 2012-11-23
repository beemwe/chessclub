# encoding:utf-8
# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready( () ->
  $("form").bind( "ajax:success", (evt, data, status, xhr) ->
    if (data.success)
      msg = xhr.getResponseHeader('X-Flash-Notice-Message')
      $('section#flash-messages').html("<div class=\"alert alert-success\">" + msg + "</div>").show().delay(6000).fadeOut("slow")
      $('ul#login-area li').removeClass('open')
      $.ajax( '/user_menu.js')
    else
      msg = xhr.getResponseHeader('X-Flash-Error-Message')
      $('section#flash-messages').html("<div class=\"alert alert-error\">" + msg + "</div>").show().delay(6000).fadeOut("slow")
      $('ul#login-area li').removeClass('open')
  )
)

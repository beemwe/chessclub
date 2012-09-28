jQuery ->
  $("a[rel=popover]").popover()
  $(".tooltip").tooltip()
  $("a[rel=tooltip]").tooltip()
  $("#flash-messages").delay(6000).fadeOut("slow")
  $("input.date-time-entry").datetimeEntry({datetimeFormat: 'D.O.Y - H:M'})

$(document).ajaxError( (event, request) ->
  msg = request.getResponseHeader('X-Message')
  if msg
    alert(msg)
)

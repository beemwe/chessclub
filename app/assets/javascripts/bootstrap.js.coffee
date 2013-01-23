jQuery ->
  $("a[rel=popover]").popover()
  $(".tooltip").tooltip()
  $("a[rel=tooltip]").tooltip()
  $("#flash-messages").delay(6000).fadeOut("slow")
  $.datepicker.regional['de'] = {
      closeText: 'Schließen',
      prevText: 'Vorheriger', # Display text for previous month link
      nextText: 'Nächster',
      currentText: 'Heute', # Display text for current month link
      monthNames: ['Januar','Februar','März','April','Mai','Juni','Juli','August','September','Oktober','November','Dezember'], # Names of months for drop-down and formatting
      monthNamesShort: ['Jan', 'Feb', 'Mär', 'Apr', 'Mai', 'Jun', 'Jul', 'Aug', 'Sep', 'Okt', 'Nov', 'Dez'], # For formatting
      dayNames: ['Sonntag', 'Montag', 'Dienstag', 'Mittwoch', 'Donnerstag', 'Freitag', 'Samstag'], # For formatting
      dayNamesShort: ['Son', 'Mon', 'Die', 'Mit', 'Don', 'Fre', 'Sam'], # For formatting
      dayNamesMin: ['So','Mo','Di','Mi','Do','Fr','Sa'], # Column headings for days starting at Sunday
      weekHeader: 'Wo', # Column header for week of the year
      dateFormat: 'dd.mm.yy', # See format options on parseDate
      firstDay: 1, # The first day of the week, Sun = 0, Mon = 1, ...
      isRTL: false, # True if right-to-left language, false if left-to-right
      showMonthAfterYear: false, # True if the year select precedes month, false for month then year
      yearSuffix: '' # Additional text to append to the year in the month headers
    };
  $.datepicker.setDefaults($.datepicker.regional['de'])
  $(".date_picker input").datepicker({
    showOtherMonths: true,
    selectOtherMonths: true,
    showButtonPanel: true
  });
  $('#combatdays').bind('cocoon:after-insert', (e, inserted_item) ->
    $('.date_picker input').datepicker({
        showOtherMonths: true,
        selectOtherMonths: true,
        showButtonPanel: true
      })
  )

$(document).ajaxError( (event, request) ->
  msg = request.getResponseHeader('X-Message')
  if msg
    alert(msg)
)

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

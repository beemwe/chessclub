# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $('#the-tabulator a').click (e) ->
    e.preventDefault()
    $(this).tab('show')

  $('.show-combat-report').click (e) ->
    e.preventDefault()
    combat_id = $(this).data('combat-id')
    $('#dlg-combat-report').dialog({
      title: 'Kampfbericht anzeigen',
      modal: true,
      width: 450,
      open: (event, ui) ->
        $.getScript('/mannschaften/0/show_combat_report/' + combat_id)
        $('.ui-dialog .ui-dialog-titlebar-close span').css('margin', '-8px 0 0 -8px')
    })

  $('.edit-combat-report').click (e) ->
    e.preventDefault()
    combat_id = $(this).data('combat-id')
    team_id = $(this).data('team-id')
    console.log 'found TeamNo: ' + team_id
    $('#dlg-edit-combat-report').dialog({
      title: 'Kampfbericht bearbeiten',
      modal: true,
      width: 600,
      open: (event, ui) ->
        $.getScript('/mannschaften/' + team_id + '/edit_combat_report/' + combat_id)
        $('.ui-dialog .ui-dialog-titlebar-close span').css('margin', '-8px 0 0 -8px')
    })

    $('.result-editor').change (e) ->
      home_result = 0
      guest_result = 0
      combat_id = 'th#combat-result'
      select_elements = '.result-editor'
      input_field = '#combat_result'
      # get all results out of the select elements
      $(select_elements).each (index, element) =>
        elem_value = $(element).val()
        if (elem_value == '1:0') || (elem_value == '1:0 kl')
          home_result += 1
        if (elem_value == '0:1') || (elem_value == '0:1 kl')
          guest_result += 1
        if (elem_value == '½:½')
          home_result += 0.5
          guest_result += 0.5
      result_home = Math.floor(home_result)
      if result_home < home_result
        if result_home == 0
          result_home = '½'
        else
          result_home = "" + result_home + '½'
      result_guest = Math.floor(guest_result)
      if result_guest < guest_result
        if result_guest == 0
          result_guest = '½'
        else
          result_guest = "" + result_guest + '½'
      $(combat_id).text "" + result_home + " : " + result_guest
      $(input_field).val("" + result_home + " : " + result_guest)



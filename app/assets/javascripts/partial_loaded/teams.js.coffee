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


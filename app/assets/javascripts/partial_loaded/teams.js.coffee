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

        $.getScript('/teams/0/show_combat_report/' + combat_id)
    })


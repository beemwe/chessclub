# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$ ->
  $('.game-result').click ->
    name1 = $(this).data('player1-name')
    name2 = $(this).data('player2-name')
    id1 = $(this).data('player1-id')
    id2 = $(this).data('player2-id')
    if name1 == name2
      return false
    $('#result-dialog').dialog({
      title: 'Ergebnis erfassen',
      modal: true,
      width: 400,
      open: (event, ui) ->
        $('#white-player').text(name1).data('player-id', id1)
        $('#black-player').text(name2).data('player-id', id2)
    })

  $('#white-wins').click ->
    edit_result('white-wins')
  $('#black-wins').click ->
    edit_result('black-wins')

  $('#remis').click ->
    edit_result('remis')

  $('#white-wins-combatless').click ->
    edit_result('white-wins-combatless')

  $('#black-wins-combatless').click ->
    edit_result('black-wins-combatless')

edit_result = (result_type) ->
  tournament_id = $('#tournament-table').data('tournament_id')
  id1 = $('#white-player').data('player-id')
  id2 = $('#black-player').data('player-id')
  $.post("/tournaments/" + tournament_id + "/edit_result", {
    white: id1,
    black: id2,
    result: result_type
  })
  $('#result-dialog').dialog('destroy')

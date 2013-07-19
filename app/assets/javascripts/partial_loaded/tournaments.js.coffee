# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$ ->
  $('.game-result').click ->
    name1 = $(this).data('player1-name')
    name2 = $(this).data('player2-name')
    id1 = $(this).data('player1-id')
    id2 = $(this).data('player2-id')
    row = $(this).data('row')
    col =  $(this).data('col')
    if name1 == name2
      return false
    $('#result-dialog').dialog({
      title: 'Ergebnis erfassen',
      modal: true,
      width: 450,
      open: (event, ui) ->
        $('#white-player').text(name1).data('player-id', id1).data('row', row).data('col', col)
        $('#black-player').text(name2).data('player-id', id2)
    })

  $('#nominate-player').click ->
    $('#player-dialog').dialog({
      title: 'Spieler nachmelden',
      modal: true,
      width: 1201
    })

  $('#white-wins').click ->
    edit_result('1:0')
  $('#black-wins').click ->
    edit_result('0:1')

  $('#remis').click ->
    edit_result('remis')

  $('#white-wins-combatless').click ->
    edit_result('1:0 kl')

  $('#black-wins-combatless').click ->
    edit_result('0:1 kl')

  $('#nobody-wins').click ->
    edit_result('0:0')

  $('#the-tabulator a').click (e) ->
    e.preventDefault()
    $(this).tab('show')

edit_result = (result_type) ->
  tournament_id = $('#tournament-table').data('tournament_id')
  id1 = $('#white-player').data('player-id')
  id2 = $('#black-player').data('player-id')
  col = $('#white-player').data('col')
  row = $('#white-player').data('row')
  $.post("/tournaments/" + tournament_id + "/edit_result", {
    white: id1,
    black: id2,
    result: result_type
    row,
    col
  })
  $('#result-dialog').dialog('destroy')

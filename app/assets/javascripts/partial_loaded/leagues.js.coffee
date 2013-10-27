$ ->
  $('#the-tabulator a').click (e) ->
    e.preventDefault()
    $(this).tab('show')

  $('.combatand').draggable({ opacity: 0.35, revert: true })
  $( ".team-container" ).droppable({ accept: ".combatand"});
  $( ".team-container" ).on( "drop", ( event, ui ) ->
    dropped = ui.draggable

    $(this).children('p').text(dropped.data('team-name'))
    $(this).children('input.team-id').val(dropped.data('team-id'))
    $(this).children('input.team-name').val(dropped.data('team-name'))
  )
  $('.home-player').draggable({ opacity: 0.35, revert: 'invalid', cursor: 'move', helper: 'clone' })
  $('.guest-player').draggable({ opacity: 0.35, revert: 'invalid', cursor: 'move', helper: 'clone' })
  $(".home-team-container").droppable({ accept: ".home-player", create: ( event, ui ) ->
    if $(this).data('name-container').length > 0
      selector = 'span[data-playername="' + $(this).data('name-container') + '"]'
      $(selector).first().position( { of: $(this), my: 'left middle', at: 'left middle' } )
  })
  $(".home-team-container").on( 'drop', ( event, ui ) ->
    ui.draggable.position( { of: $(this), my: 'left middle', at: 'left middle' } )
    ui.draggable.animate({ opacity: 1}, 200)
    $(this).children('input.homeplayer-name').val(ui.draggable.data('playername'))
  )
  $(".guest-team-container").droppable({ accept: ".guest-player", create: ( event, ui ) ->
    if $(this).data('name-container').length > 0
      selector = 'span[data-playername="' + $(this).data('name-container') + '"]'
      $(selector).first().position( { of: $(this), my: 'left middle', at: 'left middle' } )
  })
  $(".guest-team-container").on( 'drop', ( event, ui ) ->
    ui.draggable.position( { of: $(this), my: 'left middle', at: 'left middle' } )
    ui.draggable.animate({ opacity: 1}, 200)
    $(this).children('input.guestplayer-name').val(ui.draggable.data('playername'))
  )
  $('.result-editor').change (e) ->
    home_result = 0
    guest_result = 0
    combat_id = '#game-result-' + $(this).data('combat-id')
    select_elements = '#editor-' + $(this).data('combat-id') + ' .result-editor'
    input_field = '#league_combats_attributes_' + $(this).data('idx') + '_result'
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
      result_home = "" + result_home + '½'
    result_guest = Math.floor(guest_result)
    if result_guest < guest_result
      result_guest = "" + result_guest + '½'
    $(combat_id).text "" + result_home + " : " + result_guest
    $(input_field).val("" + result_home + " : " + result_guest)
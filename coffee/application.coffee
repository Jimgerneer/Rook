$ ->
  $('.flash.fatal').addClass('alert alert-error')
  $('.flash.info').addClass('alert alert-success')
  $('.flash.warning').addClass('alert alert-info')
  $('#flash').effect 'fade', {}, 500000
  $('#user-nav a').click (e) ->
    e.preventDefault()
    handler = (data) ->
      console.log "called handler."
      $('#page-content').html(data)
    console.log "sending xhr..."
    $.get $(@).attr('href'), handler
    console.log "after xhr"

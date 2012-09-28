$ ->
  $('.flash.fatal').addClass('alert alert-error')
  $('.flash.info').addClass('alert alert-success')
  $('.flash.warning').addClass('alert alert-info')

$ ->
  $('#flash').effect 'fade', {}, 500000

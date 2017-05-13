$(document).on 'turbolinks:load', ->
  $('#checkbox1').click ->
    $('#keyword1').fadeToggle()
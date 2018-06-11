# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $('#contact_form').on("ajax:success", (e, data, status, xhr) ->
    # $(element).append xhr.responseText
    alert(xhr.responseText)
  ).on "ajax:error", (e, xhr, status, error) ->
    alert('Houve um problema ao responder, tente novamente.')

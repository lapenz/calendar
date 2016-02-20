# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->

  $('#companies_service_service_name').autocomplete
    source: (request, response) ->
      $.ajax
        url: 'http://localhost:3000/services.json'
        dataType: "json"
        data: name: request.term
        success: (data) ->
          response $.map(data, (item) ->
            {
              label: item.name
              id: item.id
            }
          )
    minLength: 1
    select: (event, ui) ->
      $("#companies_service_service_id").val(ui.item.id)

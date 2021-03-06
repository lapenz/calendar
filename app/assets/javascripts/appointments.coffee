# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $('#appointment_client_attributes_email').change ->
    $.ajax
      url: "/clients/findByEmail/"
      dataType: "json"
      data: {email: $(this).val()}
      error: (jqXHR, textStatus, errorThrown) ->
        alert "AJAX Error: #{textStatus}"
      success: (data, textStatus, jqXHR) ->
        $('#appointment_client_attributes_name').val(data.name)
        $('#appointment_client_attributes_phone').val(data.phone)


  $('.check_appointments_form').on("ajax:success", (e, data, status, xhr) ->
    # $(element).append xhr.responseText
    alert(xhr.responseText)
  ).on "ajax:error", (e, xhr, status, error) ->
    alert('Houve um problema ao responder, tente novamente.')

# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $('[data-behaviour~=datepicker]').datepicker()

  if $('#request_diagnosis_id :selected').text != "Select..."
    $("#request_diagnosis_detail_id").prop('disabled', false);

  details = $('#request_diagnosis_detail_id').html()

  $('#request_diagnosis_id').change ->
    diagnosis = $('#request_diagnosis_id :selected').text()
    options = $(details).filter("optgroup[label=#{diagnosis}]").html()

    if options
      $('#request_diagnosis_detail_id').html(options)
    else
      $('#request_diagnosis_detail_id').empty()
    
    $("#request_diagnosis_detail_id").prop('disabled', false);

# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $('[data-behaviour~=datepicker]').datepicker()
  details = $('#request_diagnosis_detail_id').html()

  if $('#request_diagnosis_id :selected').text != "Select..."
    $("#request_diagnosis_detail_id").prop('disabled', false)

  $('#request_diagnosis_id').change ->
    diagnosis = $('#request_diagnosis_id :selected').text()
    options = $(details).filter("optgroup[label=#{diagnosis}]").html()
    if options
      $('#request_diagnosis_detail_id').html(options)
    else
      $('#request_diagnosis_detail_id').empty()
    $("#request_diagnosis_detail_id").prop('disabled', false)

  $("input[id^='request_hospital_bed_availabilities_attributes_']").change ->
    row_id = $(this).attr('id').charAt(47)
    if (!$(this).is(':checked'))
      $("select[id^='request_hospital_bed_availabilities_attributes_" + row_id + "']").attr("disabled", true)
      $("select[id^='request_hospital_bed_availabilities_attributes_" + row_id + "']").val("")
    else
      $("select[id^='request_hospital_bed_availabilities_attributes_" + row_id + "']").removeAttr("disabled")
   
  $("form#availability_submit").submit (e) ->
    e.preventDefault()
    $('.alert').css('display', 'none')
    answer = confirm('This action is not reversible.  Do you want to proceed?') 
    if (!(answer == true))
      return false 

  $("form[id^='edit_request_']").submit (e) ->
    e.preventDefault()
    answer = confirm('This action is not reversible.  Do you want to proceed?') 
    if (answer == true)
      this.submit()

  $("#myTab a").click (e) ->
    e.preventDefault()
    $(this).tab('show')

  #$('.pull-down').each ->
    #$(this).css('margin-top', $(this).parent().height()-$(this).height() - 52)

  $('form#availability_submit').bind 'ajax:success', (evt, data, status, xhr) ->
    $('.alert-success').toggle(true)
    $('#success_text').append("Availability submitted, refresh page to see changes")
    $(".btn[name='commit']").attr("disabled", "disabled")

  $('form#availability_submit').bind 'ajax:error', (evt, data, status, xhr) ->
    $('.alert-error').toggle(true)
    $('#error_text').append(data.responseText)


forms_ready = ->
  autosize $('input[type="text"]')
  $('.ui.dropdown').dropdown()
  $('.clear.btn').on 'click', ->
    $('.myform .ui.dropdown').dropdown 'clear'
    return
  $('form.pseudo #chore_resident_id').on 'change', ->
    $(this.form).trigger('submit.rails');
    return
  $('form.pseudo .clear.btn').on 'click', ->
    $('#' + $(this).parent('form')[0].id + ' .ui.dropdown').dropdown 'clear'
    console.log("cleared")
    return
  return

$(document).on 'turbolinks:load', forms_ready
$(document).ready forms_ready

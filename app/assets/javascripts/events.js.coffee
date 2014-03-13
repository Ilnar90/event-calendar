$ ->
  $("#current_user_events").click ->
    $(".not_current_user").toggle()
    return

  $("#recurring_event").click ->
    $(".period").toggle()
    return

  $("#current_user_events").attr "autocomplete", "off"
  $(".date").datepicker dateFormat: "yy-mm-dd"
  $(".period").hide()  unless $("#recurring_event").attr("checked") is "checked"
  return

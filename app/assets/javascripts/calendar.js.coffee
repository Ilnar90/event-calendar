
$(document).ready ->
  $('#calendar').fullCalendar
    editable: true,
    header:
      left: 'prev,next today',
      center: 'title',
      right: 'month,agendaWeek,agendaDay'
    defaultView: 'month',
    height: 500,
    slotMinutes: 30,
    eventSources: [
      url: '/events'
    ]

    timeFormat: 'h:mm t{ - h:mm t} ',
    dragOpacity: "0.5"
    eventClick: (event, element)->
      element.preventDefault()
      window.location.replace(event.url + '/edit')

      $.ajax
        type: "PUT",
        url: "/events/" + the_event.id,
        data: event:
          title: the_event.title,
          starts_at: "" + the_event.start,
          ends_at: "" + the_event.end,
          schedule: "" + the_event.schedule
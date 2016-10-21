$(document).ready(function() {
  setTimeout(function(){
    $('.alert').slideUp(3000);
  }, 3500);
});

$(document).ready(function() {
  $("#calendar").fullCalendar({
    eventSources: [{ 
      url: '/dashboard/conference_events.json'
    }]
  });
});
(function ($) {
  $.namespace('penwood.service');
  
  var AuthService = penwood.service.AuthService = function (googleAccountName) {
    this.calendarService = new google.gdata.calendar.CalendarService('penwoodPartners-corporate-1');
  };
  
  AuthService.prototype = {
    getCalendarService: function() {
      return this.calendarService;
    }
  };
})(jQuery);

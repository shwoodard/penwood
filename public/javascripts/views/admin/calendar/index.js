(function($){
    getMyFeed = function(feed) {
      
    };

    $(document).ready(function() {
        var googleHasSession = $('#google_has_session').boolVal();
        if (googleHasSession) {
           var googleToken = $('#google_account_token').val();
           var googleLogin = $('#google_account_login').val();
           var feedUrl =  'http://www.google.com/calendar/feeds/' + googleLogin + '/public/full';
           var calendarService;
           
           function handleCalendarFeed(feed) {
             debugger;
             alert('foo');
           }
           
           function setupCalendarService() {
             calenarService = new google.gdata.calendar.CalendarService('penwoodPartners-corporate-1');
           }
           
           getCalendarFeed = function() {
             setupCalendarService();
             
             calendarService.getEventFeed(feedUrl, handleCalendarFeed);
           };
        } else {
          setTimeout(function () {window.location.href = "https://www.google.com/accounts/AuthSubRequest?scope=http://www.google.com/calendar/feeds&next=" + $('#google_cal_login_callback_url').val();}, 1000);
        }
    });
})(jQuery);
 
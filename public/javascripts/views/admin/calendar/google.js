(function ($) {
  function getCalendarFeed() {
    // var googleHasSession = $('#google_has_session').boolVal();
    // if (googleHasSession) {
       // var googleToken = $('#google_account_token').val();
       var googleLogin = $('#google_account_login').val();
       var feedUrl =  'http://www.google.com/calendar/feeds/' + googleLogin + '/private/full??alt=json';
       var calendarService;
       
       function handleCalendarFeed(feed) {
         debugger;
         alert('foo');
       }
       
        function signinUser() {
          var scope = 'http://www.google.com/calendar/feeds/';
          var token = google.accounts.user.checkLogin(scope);
          alert(token);
          if (!token) {
            google.accounts.user.login(scope);   
          } else {
            //good to go
          }
        }
       
       function setupCalendarService() {
         calendarService = new google.gdata.calendar.CalendarService('penwoodPartners-corporate-1');
         signinUser();
       }
       
       setupCalendarService();
       calendarService.getEventsFeed(feedUrl, handleCalendarFeed);
    // } else {
    //   setTimeout(function () {window.location.href = "https://www.google.com/accounts/AuthSubRequest?scope=http://www.google.com/calendar/feeds&next=" + $('#google_cal_login_callback_url').val();}, 1000);
    // }
  }
  google.load("gdata", "2.x");
  google.setOnLoadCallback(function () {setTimeout(getCalendarFeed, 3000);});
})(jQuery);

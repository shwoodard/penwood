(function($){
    $(document).ready(function() {
        $('.date_picker').datepicker();
        $('.time_picker').ptTimeSelect();
        // $('.new_appointment_form').submit(function (evt) {
        //   evt.preventDefault();
        //   var scope = 'http://www.google.com/calendar/feeds/';
        //   var token = google.accounts.user.checkLogin(scope);
        //   alert(token);
        // });
    });
})(jQuery);
 
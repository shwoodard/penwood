(function($){
  $(document).ready(function() {
      $('.time_picker').ptTimeSelect();
      $('.date_picker').datepicker();
        
      $('.start.date_picker').change(function () {
        $('.end.date_picker').val($(this).val());
      });
    });
})(jQuery);
 
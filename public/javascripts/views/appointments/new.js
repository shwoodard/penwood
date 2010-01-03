(function($){
  $(document).ready(function() {
      $('.date_picker').datepicker();
      $('.time_picker').ptTimeSelect();
        
      $('.start.date_picker').change(function () {
        $('.end.date_picker').val($(this).val());
      });
    });
})(jQuery);
 
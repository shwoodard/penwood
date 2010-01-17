(function($){
  $(document).ready(function() {
      $('.time_picker').ptTimeSelect();
        
      $('.start.date_picker').change(function () {
        $('.end.date_picker').val($(this).val());
      });
    });
})(jQuery);
 
(function ($){
  $(document).ready(function () {
    $('select#article_type').change(function (evt) {
      $('.article_body_row').setClass('hidden', $(this).val() !== 'MyArticle');
    });
  });
})(jQuery);
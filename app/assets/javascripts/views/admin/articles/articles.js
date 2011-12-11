(function ($){
  $(document).ready(function () {
    $('select#article_type').bind('change keyup', function (evt) {
      $('.article_body_row').setClass('hidden', $(this).val() !== 'MyArticle');
      $('.article_attachment_row').setClass('hidden', $(this).val() !== 'OtherArticle');
    });
    $('#article_type').change();
  });
})(jQuery);
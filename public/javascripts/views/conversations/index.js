(function($){
    $(document).ready(function() {
        $('.mini_persona_tag_lnk.remove').click(function (evt) {
          evt.preventDefault();
          var elClone = $(this).clone();
          $(this).remove();
          $('.potentialRecipients').removeClass('hidden');
          $('.potential_participants_container').append(elClone.removeClass('remove').addClass('add'));
        });
    });
})(jQuery);
 
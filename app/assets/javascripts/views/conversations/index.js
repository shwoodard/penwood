(function($){
  $(document).ready(function() {
      $('.mini_persona_tag_lnk').live('click', function (evt) {
        evt.preventDefault();
        
        var self = $(this);
        var elIdInput = $(this).prev('input');
        
        var isAdd = self.hasClass('add');
        var isRemove = !isAdd;

        var elClone = self.clone();
        var elIdInputClone = elIdInput.clone();
        
        self.remove();
        elIdInput.remove();
        
        if (isRemove) {
          $('.potentialRecipients').removeClass('hidden');
        }
        
        var target = $(isAdd ? '.currentParticipants' : '.potential_participants_container');
        
        elClone.toggleClass('remove').toggleClass('add');
        
        target.append(elIdInputClone);
        target.append(elClone);
      });
  });
})(jQuery);
 
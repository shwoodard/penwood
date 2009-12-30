(function ($) {
  $.fn.setClass = function (klass, bSet) {
    if (bSet) {
      $(this).addClass(klass);
    } else {
      $(this).removeClass(klass);
    }
  };
  
  $.fn.boolVal = function () {
    return !!parseInt($(this).val(), 10);
  };
  
  $.extend(jQuery, {
      _ajax: jQuery.ajax,
      
      ajax : function(options) {
          options = options || {};
          var originalOptions = $.extend({}, options);
          
          this._ajax($.extend(options, {
              success: function (resp) {
                  if (typeof resp === 'object' && resp.redirect_to && !resp.form_dom) {
                      if (resp.redirect_to === -1) {
                          window.location.href = window.location.href;
                      } else {
                          window.location.href = resp.redirect_to;
                      }
                  }

                  if (originalOptions.success) {
                      originalOptions.success.call(resp, resp);
                  }
              }
          }));
      }
  });
  
  $(document).ready(function () {
    $('.delete, .put').live('click', function (evt) {
      evt.preventDefault();

      var isPut = $(this).hasClass('put');
      var expectJson = $(this).hasClass('expect_json');
      var doConfirm = $(this).hasClass('confirm');
      var spin = $(this).hasClass('spin');
      var el = $(this);
      var loading, evtSourceElemClone;
      
      if (doConfirm && !confirm('Are you sure you want to delete this item?')) {
        return;
      }
      
      var options = {
        type: isPut ? 'post' : 'delete',
        url: el.attr('href'),
        success: function (resp) {
          if (spin) {
            loading.remove();
            el.show();
          }
          el.trigger( (isPut ? 'put' : 'delete') + 'complete', resp);
        }
      };
      if (isPut) {
        options.data = {
          authenticity_token: $(this).attr('rel'),
          _method: 'put'
        };
      }

      if (expectJson) {
        options.dataType = 'json';
      }

      if (spin) {
        loading = $('<img src="/images/ajax-loader-alt.gif" alt="loading" />');
        el.hide().after(loading);
      }
    
      $.ajax(options);
    });

    $('a.dialog').live('click', function (evt) {
      evt.preventDefault();
      var self = $(this);
      var title = self.attr('rel');
      $.ajax({
        url: self.attr('href'),
        success: function (resp) {
          var dialogDom = $(resp);
  
          dialogDom.dialog({
            width: 'auto',
            title: title || '',
            modal: true,
            open: function () {
              self.trigger('dialog.open');
              dialogDom.find('.close_win').click(function (evt) {
                evt.preventDefault();
                self.trigger('dialog.close');
                dialogDom.dialog('close');
              });
      
              var form = dialogDom[0].tagName === 'FORM' ? dialogDom : dialogDom.find('form');
	                    
              if (form) {
                form.bind('form.submitsuccess', function(evt, resp) {
                  self.trigger('dialog.form.submitsuccess', resp);
                  self.trigger('dialog.close');
                  dialogDom.dialog('close');
                });
                form.form();
              }
            }
          });
        },
        dataType: 'html'
      });
    });
  });
})(jQuery);

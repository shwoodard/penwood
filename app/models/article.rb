class Article < ActiveRecord::Base
  has_attached_file :attachment,
                    :url => '/system/article_attachments/:id/attachments/:filename',
                    :path => ':rails_root/public/system/article_attachments/:id/attachments/:filename'
end

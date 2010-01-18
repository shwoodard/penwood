class Article < ActiveRecord::Base
  has_attached_file :attachment,
                    :url => '/system/article_attachments/:id/attachments/:filename',
                    :path => ':rails_root/public/system/article_attachments/:id/attachments/:filename'

  def published_to_s
    self.published.blank? ? '' : self.published.strftime('%m/%d/%Y')
  end
                  
  class << self
    def new_by_type(type, params)
      type.constantize.new(params)
    end
  end
end

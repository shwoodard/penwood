require 'RMagick'

module Paperclip
  class Attachment
    # def file_with_override?
    #   self.original_filename.nil? ? false : File.exists?(Paperclip::Interpolations.interpolate(@path, self, :original))
    # end
    # alias_method_chain :file?, :override
    
    def destroy_with_override
      destroy_without_override
      instance_write(:deleted_at, Time.now)
      instance_write(:file_name, nil)
      instance_write(:content_type, nil)
      instance_write(:file_size, nil)
      instance_write(:update_at, nil)
      @instance.save!
    end
    alias_method_chain :destroy, :override
  
    def crop(x, y, w, h, style=default_style)
      img = Magick::Image.read(self.to_file(:original).path)[0]
      img.crop!(x, y, w, h)
      img.page = Magick::Rectangle.new(w, h, x, y)

      unless style == :original
        target_width, target_height = get_target_dimensions(style)
        img.resize!(target_width, target_height)
      end

      img.write(self.to_file(style).path)
    end
    
    private
    
    def get_target_dimensions(style)
      geometry = @styles[style][:geometry]
      width, height = geometry.split('x')
      height = height[0...-1] if height[-1, 1] == '>'
      [width.to_i, height.to_i]
    end
  end
end

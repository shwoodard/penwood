class Admin::ImagesController < ApplicationController
  def move
    image_experience = ImageExperience.find(params[:image_slide_show_id])
    image = Image.find(params[:id])
    image.send("move_#{params[:direction]}".to_sym)
    redirect_to edit_admin_image_slide_show_path(image_experience)
  end
end

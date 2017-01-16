class Image < ActiveRecord::Base
  mount_uploader :image, ImageUploader

  belongs_to :item

  def path
    attachment_file_name
  end
  
end
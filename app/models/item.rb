class Item < ApplicationRecord
  
  has_one_attached :image
  
  validate :image_type

  private
  
  def image_type
    if !image.blob.content_type.in?(%('image/jpeg image/png'))
      image.purge # Rails6では、この1行は必要ない
      errors.add(:image, 'はJPEGまたはPNG形式を選択してアップロードしてください')
    end
  end
  
    
end

class ImageUploader < CarrierWave::Uploader::Base

  storage :file

  process convert: 'jpg'

  # 保存するディレクトリ名
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
  
  include CarrierWave::RMagick
  
  process :resize_to_limit => [700, 700]
  
  process :convert => "jpg"
  
  # thumb バージョン(width 400px x height 200px)
  version :thumb do
    process :resize_to_fit => [300, 300]
  end

  # 許可する画像の拡張子
  def extension_white_list
    %w(jpg jpeg gif png)
  end


end
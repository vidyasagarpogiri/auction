class ProductUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  storage :file

  def store_dir
    "uploads/products/#{model.user_id}"
  end

  def filename
    model.id ? "#{model.id}-#{original_filename}" : original_filename
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end

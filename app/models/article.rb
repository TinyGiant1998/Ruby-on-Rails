class Article < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_one_attached :image, dependent: :destroy
validates :title, presence: true, length: { minimum: 5, maximum: 15 }
validates :body, presence: true, length: { minimum: 10 }

# custom validation for image
validate :image_presence, on: [ :create, :update ]
validate :image_format, if: -> { image.attached? }
validate :image_size, if: -> { image.attached? }


private
# ensure image is attached
def image_presence
  unless image.attached?

  errors.add(:image, "must be attached")
  end
end

# ensure the image format is valid
def image_format
    return unless image.attached?

    acceptable_formats = [ "image/jpeg", "image/png", "image/gif", "image/tiff", "image/heic", "image/dng" ]
    # Check if the uploaded image format is acceptable
    unless acceptable_formats.include?(image.content_type)
      errors.add(:image, "must be a valid image format (JPEG, PNG, GIF, TIFF, HEIC, or DNG)")
      return
    end

    # If the image is HEIC or DNG, convert it to PNG
    if [ "image/heic", "image/dng" ].include?(image.content_type)
      begin
        # Read the uploaded image using MiniMagick
        processed_image = MiniMagick::Image.read(image.download)

        # Convert the image to PNG (you can choose JPEG if you prefer)
        processed_image.format("png")

        # Re-attach the converted image back to the model
        image.attach(io: processed_image.to_io, filename: "#{image.filename.base}.png", content_type: "image/png")
      rescue => e
        errors.add(:image, "Failed to convert image: #{e.message}")
      end
    end
end



# ensure image size is under 50MB
def image_size
  if image.byte_size > 50.megabytes
      errors.add(:image, "must be smaller than 50MB")
  end
end


# custom logic to save and update articels.csv file
after_save :update_csv # The callback method is added here
after_destroy :update_csv
private
def update_csv
  require "csv"
  CSV.open("articles.csv", "wb") do |csv|
    csv << Article.column_names
    Article.all.each do |article|
      csv << article.attributes.values
    end
  end
end
end

class Article < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many_attached :images, dependent: :destroy
  has_many_attached :videos, dependent: :destroy
validates :title, presence: true, length: { minimum: 5, maximum: 15 }
validates :body, presence: true, length: { minimum: 10 }

# custom validation for imagesx
validate :validate_images
validate :validate_videos


private
# ensure images is attached
def validate_images
  if images.blank?
   errors.add(:images, "must include at least one image")
   return
  end

  images.each do |image|
  acceptable_formats = %w[image/jpeg image/png image/gif image/tiff image/heic image/dng]

  # Validate format
  unless acceptable_formats.include?(image.content_type)
    errors.add(:images, "must be a valid images format (JPEG, PNG, GIF, TIFF, HEIC, or DNG)")
  end

  if image.blob.byte_size > 25.megabytes
      errors.add(:images, "Images size must be smaller than 25MB")
  end
end
end


def validate_videos
return unless videos.attached?

 # Ensure no more than 2 videos
 if videos.count > 2
  errors.add(:videos, "cannot upload more than 2 videos")
 return
 end

 videos.each do |video|
   acceptable_formats = %w[video/mp4 video/mpeg video/quciktime video/mov vidoe/hevc]
   unless acceptable_formats.include?(video.content_type)
     errors.add(:videos, "must be an MP4, MPEG, MOV or Quick Time file")
   end

   if video.blob.byte_size > 100.megabytes
     errors.add(:videos, "must be smaller than 500MB")
   end
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

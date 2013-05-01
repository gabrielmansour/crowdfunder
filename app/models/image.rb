class Image < ActiveRecord::Base
  belongs_to :project
  attr_accessible :file

  mount_uploader :file, ImageUploader

  validates :file, presence: true
  validates :project, presence: true
end

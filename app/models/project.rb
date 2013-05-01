class Project < ActiveRecord::Base
  has_many :pledges
  belongs_to :user
  attr_accessible :description, :goal, :teaser, :title

  validates :title, presence: true
  validates :teaser, presence: true
  validates :description, presence: true
  validates :goal, numericality: { allow_blank: false, greater_than: 0, message: "must be a number greater than 0" }
end


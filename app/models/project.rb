class Project < ActiveRecord::Base
  has_many :pledges
  belongs_to :user
  attr_accessible :description, :goal, :teaser, :title
end


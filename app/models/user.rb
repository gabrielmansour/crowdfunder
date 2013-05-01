class User < ActiveRecord::Base
  authenticates_with_sorcery!
  has_many :projects
  # attr_accessible :title, :body

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :password, presence: true, on: :create

  def name
    [first_name, last_name].join(' ')
  end
end

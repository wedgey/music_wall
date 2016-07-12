class Music < ActiveRecord::Base
  belongs_to :user
  has_many :votes

  validates :title, presence: true
  validates :author, presence: true
  validates :url, presence: true
  validates :user_id, presence: {message: "must be logged in!" }

 end

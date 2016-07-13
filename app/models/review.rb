class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :music

  validates :user_id, presence: true, uniqueness: {scope: :music_id, message: "has already created a review for this song."}
  validates :music_id, presence: true
  validates :review, presence: true
end
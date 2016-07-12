class User < ActiveRecord::Base
  include BCrypt
  has_many :musics
  has_many :votes

  validates :username, presence: true, uniqueness: true
  validates :password_hash, presence:true, length: {minimum: 6}

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end
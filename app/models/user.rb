class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validates :api_key, presence: true, uniqueness: true

  has_secure_password

  # before_create :generate_api_key
  
  def generate_api_key
    self.api_key = SecureRandom.hex
  end
end
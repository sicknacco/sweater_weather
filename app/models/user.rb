class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :api_key, presence: true, uniqueness: true
  validates :password, presence: true

  has_secure_password

  before_validation :generate_api_key, on: :create
  
  def generate_api_key
    self.api_key = SecureRandom.hex
  end
end
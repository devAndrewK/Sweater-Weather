class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true
  validates_presence_of :password
  validates_presence_of :password_confirmation
  has_secure_password

  before_save :create_api_key

  def create_api_key
    self.api_key = SecureRandom.hex
  end
end

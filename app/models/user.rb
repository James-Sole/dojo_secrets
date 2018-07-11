class User < ActiveRecord::Base
  has_secure_password

  before_save :downcase
  has_many :secrets, dependent: :destroy
  has_many :likes, dependent: :destroy
  validates :name, :email, presence: true

  private
    def downcase
      self.name.downcase!
      self.email.downcase!
    end
end

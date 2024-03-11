class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :zipcode, length: { is: 5 }

  before_create :downcase_email

  private

  def downcase_email
    self.email = email.downcase
  end
end

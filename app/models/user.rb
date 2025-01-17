class User < ApplicationRecord
    has_many :twitter_accounts
    has_many :tweets
    has_secure_password

    validates :email, presence: true

    generates_token_for :password_reset, expires_in: 15.minutes do
      password_salt&.last(10)
    end
end

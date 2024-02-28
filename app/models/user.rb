class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :validatable

  enum role: { user: 0, admin: 1 }

  has_many :invites, dependent: :destroy
end

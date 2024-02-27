class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :validatable

  enum role: { user: 0, admin: 1 }
end

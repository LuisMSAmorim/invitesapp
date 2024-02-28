class Company < ApplicationRecord

  validates :name, presence: true
  validates :ceo, presence: true

  has_many :invites, dependent: :destroy
end

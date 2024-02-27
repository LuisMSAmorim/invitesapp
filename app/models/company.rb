class Company < ApplicationRecord

  validates :name, presence: true
  validates :ceo, presence: true
end

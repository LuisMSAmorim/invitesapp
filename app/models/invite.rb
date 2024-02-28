class Invite < ApplicationRecord
  belongs_to :company
  belongs_to :user

  validates :title, presence: true
  validates :description, presence: true
  validates :date, presence: true
  validates :company, presence: true
  validates :user, presence: true
end

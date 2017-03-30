class Event < ApplicationRecord
  belongs_to :user
  validates :title, :from, :frequency, presence: true
end

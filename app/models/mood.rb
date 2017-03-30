class Mood < ApplicationRecord
  belongs_to :user
  validates :mood, inclusion: { in: (1..10) }
end

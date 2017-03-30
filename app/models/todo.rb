class Todo < ApplicationRecord
  belongs_to :user
  validates :todo, presence: :true
end

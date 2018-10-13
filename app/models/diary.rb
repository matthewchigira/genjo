class Diary < ApplicationRecord

  # Add database relationships 
  belongs_to :user

  # Add a default filter for the data
  default_scope -> { order(created_at: :desc) }
  
  # Add validation to the Diary model 
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 30 }
  validates :entry, presence: true
  validates :date, presence: true

end

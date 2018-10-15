class Task < ApplicationRecord

  # Define the database relationships 
  belongs_to :user

  # Define the sort order of the data
  default_scope -> { order(is_complete: :asc, 
                           is_high_priority: :desc, 
                           due_date: :asc) }

  # Add validation to the Task model
  validates :name, presence: true, length: { maximum: 30 }
  validates :description, presence: true

end

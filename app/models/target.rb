class Target < ApplicationRecord

  # Define the database relationships 
  belongs_to :user

  # Callback methods
  before_validation :check_integers 
 
  # Order the data using the sort order field, then by created date (ascending)
  default_scope -> { order(:sort_order, :created_at) }

  # Add validation to the Target model
  validates :name, presence: true, length: { maximum: 30 }
  validates :description, presence: true
  validates :target_steps, numericality: { greater_than: 0, less_than: 100000 }
  validates :completed_steps, 
                           numericality: { greater_than_or_equal_to: 0, 
                                           less_than_or_equal_to: :target_steps }
  validates :step_name, presence: true, length: { maximum: 30 }
  validates_numericality_of :sort_order,
                            greater_than_or_equal_to: 0,
                            less_than_or_equal_to: :record_count,
                            message: "cannot be greater than total amount of Targets"

  private

    # Callback methods

    # Number fields allow nil values, this will cause an error with valitation
    # So put a valid integer in the offending fields 
    def check_integers
      if self.target_steps.nil?
        self.target_steps = 1 
      end

      if self.completed_steps.nil?
        self.completed_steps = 0
      end

      if self.sort_order.nil?
        self.sort_order = 0
      end

    end

    def record_count
      Target.where(user_id: self.user_id).count
    end

end

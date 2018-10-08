class User < ApplicationRecord
  
  # Register callback methods 
  before_save :downcase_email

  # This creates two virtual fields: password and password_confirmation
  has_secure_password
 
  # Define a regular expression describing a valid email format 
  VALID_EMAIL_FORMAT = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
   
  # Add validation to the User model 
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 }, 
                    uniqueness: { case_sensitive: false },
                    format: { with: VALID_EMAIL_FORMAT }
  validates :password, presence: true, length: {minimum: 6, maximum: 25 },
                    allow_nil: true

  # Create a hashed value (digest) from a given string
  def User.create_digest(input)
    # Use a low cost in Testing, but a higher, more secure cost in Production 
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(input, cost: cost)
    
  end

  private

    # Automatically downcase email addresses before they are saved, so that we
    # can ensure that they remain unique in both the app and the DB
    def downcase_email
      email.downcase!
    end

end

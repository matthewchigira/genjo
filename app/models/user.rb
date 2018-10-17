class User < ApplicationRecord
  
  # Add database relationships 
  has_many :diaries, dependent: :destroy
  has_many :targets, dependent: :destroy
  has_many :tasks, dependent: :destroy

  # Instance variables
  attr_accessor :remember_token, :activation_token

  # Register callback methods 
  before_save :downcase_email
  before_create :create_activation_digest

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

  # Create a random string of text to be used as a token for remembering a 
  # user's credentials, account authorization, password reset etc.
  def User.create_token
    SecureRandom.urlsafe_base64
  end 
   
  # Authenticate a token against the hashed version of it in the db
  def token_authenticated?(token, token_type)
    digest = send("#{token_type}_digest")
    return false if digest.nil?  
    # The == is overloaded here, calls is_password?
    BCrypt::Password.new(digest) == token
  end
  
  # Remember a user in the database for persistent sessions 
  def remember_user
    self.remember_token = User.create_token
    # This updates the db record, without validation
    update_attribute(:remember_digest, User.create_digest(remember_token)) 
  end

  # Forget a user is logged in by deleting this value in the db
  def forget_user
    update_attribute(:remember_digest, nil)
  end
  
  # Activate a user's account
  def activate
    update_attribute(:activated, true)
  end

  # Send account activation email
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  private

    # Automatically downcase email addresses before they are saved, so that we
    # can ensure that they remain unique in both the app and the DB
    def downcase_email
      email.downcase!
    end
   
    # When a new user is created, automatically create a token and save a hash
    # of this in the DB 
    def create_activation_digest
      self.activation_token = User.create_token
      self.activation_digest = User.create_digest(activation_token)
    end

end

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # If a test user is logged in, return true
  def is_logged_in?
    !session[:user_id].nil?
  end

  def login(user)
    post login_path, params: { session: { email: user.email,
                                          password: 'password' } }
  end

end

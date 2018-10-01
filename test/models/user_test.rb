require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: "password", password_confirmation: "password")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should not be blank" do
    @user.name = "        " 
    assert_not @user.valid? 
  end

  test "email should not be blank" do
    @user.email = ""
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end
 
  test "password should not be blank" do
    @user.password = @user.password_confirmation = ""
    assert_not @user.valid?
  end

  test "password should not be too short" do
    @user.password = @user.password_confirmation = "12345"
    assert_not @user.valid?
  end

  test "password should not be too long" do
    @user.password = @user.password_confirmation = "a" * 26
    assert_not @user.valid?
  end

  test "email should be unique" do
    new_user = @user.dup
    new_user.email =  @user.email.upcase
    @user.save
    assert_not new_user.valid?
  end
  
  test "email should be saved in lowercase" do
    email = "ExAmPle@ExamPLE.COM"
    @user.email = email
    @user.save
    assert_equal email.downcase, @user.reload.email
  end

  test "email should be in a valid format" do
    valid_emails = ["user@example.com", "USER@EXAMPLE.COM",
                    "a.user@example.co.uk", "a_user@example.com",
                    "a+b@example.co.jp"]
    valid_emails.each do |v|
      @user.email = v
      assert @user.valid?, "#{v.inspect} should be valid"
    end
  end

  test "invalid emails should not be accpeted" do
    invalid_emails = ["user@example,com", "example_user.com", 
                      "example.user@example", "user@user_user.com",
                      "user@a+b.com"]
    invalid_emails.each do |i|
      @user.email = i
      assert_not @user.valid?, "#{i.inspect} should be invalid"
    end
  end

end

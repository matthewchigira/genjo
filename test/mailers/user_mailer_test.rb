require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "account_activation" do
    user = users(:bob)
    user.activation_token = User.create_token
    mail = UserMailer.account_activation(user)
    assert_equal "Genjo! Account activation", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["noreply@example.com"], mail.from
  end

  test "password_reset" do
    user = users(:bob)
    user.reset_token = User.create_token
    mail = UserMailer.password_reset(user)
    assert_equal "Genjo! Password reset", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["noreply@example.com"], mail.from
  end

  test "account_deletion" do
  end

end

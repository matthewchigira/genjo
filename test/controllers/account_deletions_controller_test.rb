require 'test_helper'

class AccountDeletionsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:bob)
    @user.create_account_deletion_digest
  end

  test "should delete account" do
    assert_difference('User.count', -1) do 
      get edit_account_deletion_url(@user.deletion_token), params: { email: @user.email }
    end 
    assert_redirected_to accountdeleted_url 
  end

end

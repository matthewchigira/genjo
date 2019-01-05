require 'test_helper'

class DiaryFlowTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:bob)
    @diary = diaries(:one)
    login(@user)
  end
  
  test "can create a diary entry" do
    get new_diary_path
    assert_response :success
    post diaries_path, params: { diary: { user: @user.id,
                                          date: Time.zone.now,
                                          title: "A Diary Title",
                                          entry: "Diary contents..." } }
    assert_response :redirect
    follow_redirect!
    assert_response :success
  end
  
  test "can edit a diary entry" do
    get edit_diary_path(@diary)
    assert_response :success
    patch diary_path(@diary), params: { diary: { date: (Time.zone.now - 1.day),
                                                 title: "New Title",
                                                 entry: "Different value" } }
    assert_response :redirect
    follow_redirect!
    assert_response :success
  end

  test "can delete a diary entry" do
    assert_difference 'Diary.count', -1 do 
      delete diary_path(@diary)
    end
    assert_response :redirect
    follow_redirect!
  end

end

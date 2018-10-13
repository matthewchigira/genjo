require 'test_helper'

class DiaryTest < ActiveSupport::TestCase

  def setup
    @user = users(:bob)
    @diary = diaries(:one)  
  end 

  test "should be valid" do
    assert @diary.valid?
  end

  test "user id should be present" do
    @diary.user_id = nil
    assert_not @diary.valid?
  end

 test "title should be present" do
    @diary.title = nil
    assert_not @diary.valid?
 end

  test "title should be no more than 30 characters" do
    @diary.title = "a" * 31
    assert_not @diary.valid?
  end

  test "entry should be present" do
    @diary.entry = nil
    assert_not @diary.valid?
  end
 
  test "date should be present" do
    @diary.date = nil
    assert_not @diary.valid?
  end 

  test "diary entries should be ordered by newest first" do
    assert_equal diaries(:four), Diary.first
  end

end

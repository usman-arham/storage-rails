require "test_helper"

class BlobTest < ActiveSupport::TestCase
  test "does not allow invalid id" do
    blob = Blob.first

    blob.id = nil
    assert_not blob.valid?, "Invalid if id is nil"
    assert_equal ["Id can't be blank"], blob.errors.full_messages, 'Error message is set'

    blob.id = 'nnn nnn'
    assert_not blob.valid?, "Invalid if id includes space"
    assert_equal ["Id is invalid"], blob.errors.full_messages, 'Error message is set'

    blob.id = ''
    assert_not blob.valid?, "Invalid if id is empty string"
    assert_equal ["Id can't be blank"], blob.errors.full_messages, 'Error message is set'

    blob.id = 0
    assert blob.valid?, "Valid if id is a number"
    assert_equal blob.id, "0", "Number is coerced into string"
    assert_empty blob.errors.full_messages, 'Error message is not set'
  end

  test "does not allow duplicate id" do
    assert_raises(ActiveRecord::RecordInvalid) do
      Blob.create!(id: Blob.first.id)
    end
  end
end

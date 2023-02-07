require "test_helper"

class V1::BlobsControllerTest < ActionDispatch::IntegrationTest
  headers = { "Authorization" => ActionController::HttpAuthentication::Token.encode_credentials("secret") }

  test "should authorize" do
    get v1_blob_url(Blob.first.id)
    assert_response :unauthorized
  end

  test "should get show" do
    get v1_blob_url(Blob.first.id), headers: headers
    assert_response :success
  end

  test "should raise error if not found" do
    assert_raises(ActiveRecord::RecordNotFound) do
      get v1_blob_url(0), headers: headers
    end
  end

  test "should create blob" do
    assert_difference("Blob.count") do
      post upsert_v1_blobs_url, params: { id: 0 }, headers: headers
      assert_response :success
    end
  end

  test "should update blob" do
    assert_no_difference("Blob.count") do
      post upsert_v1_blobs_url, params: { id: Blob.first.id }, headers: headers
      assert_response :success
    end
  end

  test "should raise error if record invalid" do
    assert_raises(ActiveRecord::RecordInvalid) do
      post upsert_v1_blobs_url, params: { id: nil }, headers: headers
    end
  end
end

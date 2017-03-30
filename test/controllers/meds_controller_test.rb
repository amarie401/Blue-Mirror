require 'test_helper'

class MedsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @med = meds(:one)
  end

  test "should get index" do
    get meds_url, as: :json
    assert_response :success
  end

  test "should create med" do
    assert_difference('Med.count') do
      post meds_url, params: { name: @med.name, user_id: @med.user_id }, as: :json
    end

    assert_response 201
  end

  test "should show med" do
    get med_url(@med), as: :json
    assert_response :success
  end

  test "should update med" do
    patch med_url(@med), params: { name: @med.name, user_id: @med.user_id }, as: :json
    assert_response 200
  end

  test "should destroy med" do
    assert_difference('Med.count', -1) do
      delete med_url(@med), as: :json
    end

    assert_response 204
  end
end

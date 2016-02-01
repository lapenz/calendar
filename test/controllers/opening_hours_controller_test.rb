require 'test_helper'

class OpeningHoursControllerTest < ActionController::TestCase
  setup do
    @opening_hour = opening_hours(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:opening_hours)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create opening_hour" do
    assert_difference('OpeningHour.count') do
      post :create, opening_hour: { companie_id: @opening_hour.companie_id, from: @opening_hour.from, provider_id: @opening_hour.provider_id, to: @opening_hour.to, weekday: @opening_hour.weekday }
    end

    assert_redirected_to opening_hour_path(assigns(:opening_hour))
  end

  test "should show opening_hour" do
    get :show, id: @opening_hour
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @opening_hour
    assert_response :success
  end

  test "should update opening_hour" do
    patch :update, id: @opening_hour, opening_hour: { companie_id: @opening_hour.companie_id, from: @opening_hour.from, provider_id: @opening_hour.provider_id, to: @opening_hour.to, weekday: @opening_hour.weekday }
    assert_redirected_to opening_hour_path(assigns(:opening_hour))
  end

  test "should destroy opening_hour" do
    assert_difference('OpeningHour.count', -1) do
      delete :destroy, id: @opening_hour
    end

    assert_redirected_to opening_hours_path
  end
end

require 'test_helper'

class CompaniesServicesControllerTest < ActionController::TestCase
  setup do
    @companies_service = companies_services(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:companies_services)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create companies_service" do
    assert_difference('CompaniesService.count') do
      post :create, companies_service: { companie_id: @companies_service.companie_id, description: @companies_service.description, duration: @companies_service.duration, price: @companies_service.price, service_id: @companies_service.service_id }
    end

    assert_redirected_to companies_service_path(assigns(:companies_service))
  end

  test "should show companies_service" do
    get :show, id: @companies_service
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @companies_service
    assert_response :success
  end

  test "should update companies_service" do
    patch :update, id: @companies_service, companies_service: { companie_id: @companies_service.companie_id, description: @companies_service.description, duration: @companies_service.duration, price: @companies_service.price, service_id: @companies_service.service_id }
    assert_redirected_to companies_service_path(assigns(:companies_service))
  end

  test "should destroy companies_service" do
    assert_difference('CompaniesService.count', -1) do
      delete :destroy, id: @companies_service
    end

    assert_redirected_to companies_services_path
  end
end

require 'test_helper'

class CompanyIntroductionsControllerTest < ActionController::TestCase
  setup do
    @company_introduction = company_introductions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:company_introductions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create company_introduction" do
    assert_difference('CompanyIntroduction.count') do
      post :create, :company_introduction => @company_introduction.attributes
    end

    assert_redirected_to company_introduction_path(assigns(:company_introduction))
  end

  test "should show company_introduction" do
    get :show, :id => @company_introduction.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @company_introduction.to_param
    assert_response :success
  end

  test "should update company_introduction" do
    put :update, :id => @company_introduction.to_param, :company_introduction => @company_introduction.attributes
    assert_redirected_to company_introduction_path(assigns(:company_introduction))
  end

  test "should destroy company_introduction" do
    assert_difference('CompanyIntroduction.count', -1) do
      delete :destroy, :id => @company_introduction.to_param
    end

    assert_redirected_to company_introductions_path
  end
end

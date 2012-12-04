require 'test_helper'

class DestroyUsersControllerTest < ActionController::TestCase
  setup do
    @destroy_user = destroy_users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:destroy_users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create destroy_user" do
    assert_difference('DestroyUser.count') do
      post :create, destroy_user: {  }
    end

    assert_redirected_to destroy_user_path(assigns(:destroy_user))
  end

  test "should show destroy_user" do
    get :show, id: @destroy_user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @destroy_user
    assert_response :success
  end

  test "should update destroy_user" do
    put :update, id: @destroy_user, destroy_user: {  }
    assert_redirected_to destroy_user_path(assigns(:destroy_user))
  end

  test "should destroy destroy_user" do
    assert_difference('DestroyUser.count', -1) do
      delete :destroy, id: @destroy_user
    end

    assert_redirected_to destroy_users_path
  end
end

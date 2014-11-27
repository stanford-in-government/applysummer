require 'test_helper'

class ProfilesControllerTest < ActionController::TestCase
  setup do
    @profile = profiles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:profiles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create profile" do
    assert_difference('Profile.count') do
      post :create, profile: { class_year: @profile.class_year, first_name: @profile.first_name, last_name: @profile.last_name, local_city: @profile.local_city, local_postal: @profile.local_postal, local_state: @profile.local_state, local_street: @profile.local_street, major_gpa: @profile.major_gpa, majors: @profile.majors, middle_name: @profile.middle_name, minors: @profile.minors, overall_gpa: @profile.overall_gpa, perm_city: @profile.perm_city, perm_postal: @profile.perm_postal, perm_state: @profile.perm_state, perm_street: @profile.perm_street, user_id: @profile.user_id }
    end

    assert_redirected_to profile_path(assigns(:profile))
  end

  test "should show profile" do
    get :show, id: @profile
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @profile
    assert_response :success
  end

  test "should update profile" do
    patch :update, id: @profile, profile: { class_year: @profile.class_year, first_name: @profile.first_name, last_name: @profile.last_name, local_city: @profile.local_city, local_postal: @profile.local_postal, local_state: @profile.local_state, local_street: @profile.local_street, major_gpa: @profile.major_gpa, majors: @profile.majors, middle_name: @profile.middle_name, minors: @profile.minors, overall_gpa: @profile.overall_gpa, perm_city: @profile.perm_city, perm_postal: @profile.perm_postal, perm_state: @profile.perm_state, perm_street: @profile.perm_street, user_id: @profile.user_id }
    assert_redirected_to profile_path(assigns(:profile))
  end

  test "should destroy profile" do
    assert_difference('Profile.count', -1) do
      delete :destroy, id: @profile
    end

    assert_redirected_to profiles_path
  end
end

require 'test_helper'

class InternshipsControllerTest < ActionController::TestCase
  setup do
    @internship = internships(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:internships)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create internship" do
    assert_difference('Internship.count') do
      post :create, internship: { application_id: @internship.application_id, category: @internship.category, city: @internship.city, country: @internship.country, faculty_name: @internship.faculty_name, financial_aid: @internship.financial_aid, fulltime: @internship.fulltime, minimum_length: @internship.minimum_length, name: @internship.name, political: @internship.political, reason: @internship.reason, related_to: @internship.related_to, relevance: @internship.relevance, social_service: @internship.social_service, supervisor_email: @internship.supervisor_email, supervisor_name: @internship.supervisor_name, supervisor_phone: @internship.supervisor_phone, supervisor_title: @internship.supervisor_title, travel_warning: @internship.travel_warning, unpaid: @internship.unpaid, work_scope: @internship.work_scope }
    end

    assert_redirected_to internship_path(assigns(:internship))
  end

  test "should show internship" do
    get :show, id: @internship
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @internship
    assert_response :success
  end

  test "should update internship" do
    patch :update, id: @internship, internship: { application_id: @internship.application_id, category: @internship.category, city: @internship.city, country: @internship.country, faculty_name: @internship.faculty_name, financial_aid: @internship.financial_aid, fulltime: @internship.fulltime, minimum_length: @internship.minimum_length, name: @internship.name, political: @internship.political, reason: @internship.reason, related_to: @internship.related_to, relevance: @internship.relevance, social_service: @internship.social_service, supervisor_email: @internship.supervisor_email, supervisor_name: @internship.supervisor_name, supervisor_phone: @internship.supervisor_phone, supervisor_title: @internship.supervisor_title, travel_warning: @internship.travel_warning, unpaid: @internship.unpaid, work_scope: @internship.work_scope }
    assert_redirected_to internship_path(assigns(:internship))
  end

  test "should destroy internship" do
    assert_difference('Internship.count', -1) do
      delete :destroy, id: @internship
    end

    assert_redirected_to internships_path
  end
end

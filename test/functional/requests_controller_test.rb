require 'test_helper'

class RequestsControllerTest < ActionController::TestCase
  setup do
    @request = requests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:requests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create request" do
    assert_difference('Request.count') do
      post :create, request: { complaint: @request.complaint, patient_dob: @request.patient_dob, patient_name_first: @request.patient_name_first, patient_name_last: @request.patient_name_last, patient_ssn: @request.patient_ssn, physician_flag: @request.physician_flag, provider_callback_phone: @request.provider_callback_phone, provider_id: @request.provider_id, transfer_center_id: @request.transfer_center_id }
    end

    assert_redirected_to request_path(assigns(:request))
  end

  test "should show request" do
    get :show, id: @request
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @request
    assert_response :success
  end

  test "should update request" do
    put :update, id: @request, request: { complaint: @request.complaint, patient_dob: @request.patient_dob, patient_name_first: @request.patient_name_first, patient_name_last: @request.patient_name_last, patient_ssn: @request.patient_ssn, physician_flag: @request.physician_flag, provider_callback_phone: @request.provider_callback_phone, provider_id: @request.provider_id, transfer_center_id: @request.transfer_center_id }
    assert_redirected_to request_path(assigns(:request))
  end

  test "should destroy request" do
    assert_difference('Request.count', -1) do
      delete :destroy, id: @request
    end

    assert_redirected_to requests_path
  end
end

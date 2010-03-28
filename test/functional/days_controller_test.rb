require 'test_helper'

class DaysControllerTest < ActionController::TestCase

  test "should create day" do
    Day.any_instance.expects(:save).returns(true)
    post :create, :day => { }
    assert_response :redirect
  end

  test "should handle failure to create day" do
    Day.any_instance.expects(:save).returns(false)
    post :create, :day => { }
    assert_template "new"
  end

  test "should destroy day" do
    Day.any_instance.expects(:destroy).returns(true)
    delete :destroy, :id => days(:one).to_param
    assert_not_nil flash[:notice]    
    assert_response :redirect
  end

  test "should handle failure to destroy day" do
    Day.any_instance.expects(:destroy).returns(false)    
    delete :destroy, :id => days(:one).to_param
    assert_not_nil flash[:error]
    assert_response :redirect
  end

  test "should get edit for day" do
    get :edit, :id => days(:one).to_param
    assert_response :success
  end

  test "should get index for days" do
    get :index
    assert_response :success
    assert_not_nil assigns(:days)
  end

  test "should get new for day" do
    get :new
    assert_response :success
  end

  test "should get show for day" do
    get :show, :id => days(:one).to_param
    assert_response :success
  end

  test "should update day" do
    Day.any_instance.expects(:save).returns(true)
    put :update, :id => days(:one).to_param, :day => { }
    assert_response :redirect
  end

  test "should handle failure to update day" do
    Day.any_instance.expects(:save).returns(false)
    put :update, :id => days(:one).to_param, :day => { }
    assert_template "edit"
  end

end
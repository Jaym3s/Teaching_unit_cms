require 'test_helper'

class UnitsControllerTest < ActionController::TestCase

  test "should create unit" do
    Unit.any_instance.expects(:save).returns(true)
    post :create, :unit => { }
    assert_response :redirect
  end

  test "should handle failure to create unit" do
    Unit.any_instance.expects(:save).returns(false)
    post :create, :unit => { }
    assert_template "new"
  end

  test "should destroy unit" do
    Unit.any_instance.expects(:destroy).returns(true)
    delete :destroy, :id => units(:one).to_param
    assert_not_nil flash[:notice]    
    assert_response :redirect
  end

  test "should handle failure to destroy unit" do
    Unit.any_instance.expects(:destroy).returns(false)    
    delete :destroy, :id => units(:one).to_param
    assert_not_nil flash[:error]
    assert_response :redirect
  end

  test "should get edit for unit" do
    get :edit, :id => units(:one).to_param
    assert_response :success
  end

  test "should get index for units" do
    get :index
    assert_response :success
    assert_not_nil assigns(:units)
  end

  test "should get new for unit" do
    get :new
    assert_response :success
  end

  test "should get show for unit" do
    get :show, :id => units(:one).to_param
    assert_response :success
  end

  test "should update unit" do
    Unit.any_instance.expects(:save).returns(true)
    put :update, :id => units(:one).to_param, :unit => { }
    assert_response :redirect
  end

  test "should handle failure to update unit" do
    Unit.any_instance.expects(:save).returns(false)
    put :update, :id => units(:one).to_param, :unit => { }
    assert_template "edit"
  end

end
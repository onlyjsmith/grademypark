require 'test_helper'

class RichcontentsControllerTest < ActionController::TestCase
  setup do
    @richcontent = richcontents(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:richcontents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create richcontent" do
    assert_difference('Richcontent.count') do
      post :create, :richcontent => @richcontent.attributes
    end

    assert_redirected_to richcontent_path(assigns(:richcontent))
  end

  test "should show richcontent" do
    get :show, :id => @richcontent.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @richcontent.to_param
    assert_response :success
  end

  test "should update richcontent" do
    put :update, :id => @richcontent.to_param, :richcontent => @richcontent.attributes
    assert_redirected_to richcontent_path(assigns(:richcontent))
  end

  test "should destroy richcontent" do
    assert_difference('Richcontent.count', -1) do
      delete :destroy, :id => @richcontent.to_param
    end

    assert_redirected_to richcontents_path
  end
end

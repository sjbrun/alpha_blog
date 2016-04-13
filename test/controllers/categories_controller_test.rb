require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase

  def setup
    @category = Category.create(name: "sports")
    @user = User.create(username: "john", email: "john@example.com", 
                        password: "password", admin: true)
  end

  test "should get categories index" do
    get :index
    assert_response :success
  end
  
  test "should get new" do
    session[:user_id] = @user.id # set user to admin john just for this test
    get :new
    assert_response :success
  end

  test "should get show" do
    get(:show, {'id' => @category.id})
    assert_response :success
  end
  
  test "should redirect create when admin not logged in" do
    ## this works cuz in this test (this whole .rb file) no admin user is set up
    assert_no_difference 'Category.count' do
      post :create, category: { name: "sports"}
    end
    assert_redirected_to categories_path
  end
  
end
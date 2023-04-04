require "test_helper"
include RSpec::Matchers
include RSpec::Expectations
include Warden::Test::Helpers


class UsersControllerTest < ActionDispatch::IntegrationTest
    def setup
        @user1=User.new(id:1,username: "gabrinca01" ,email: "djbjb@ddd.it",password: "isudhweh",role: :level0,num_tel: "293878927",created_at:23 ,updated_at: 23,verified: true)
        @user1.save!
        @user2=User.new(id:2,username: "vince89" ,email: "djbffjb@ddd.it",password: "isudhweh",role: :level0,num_tel: "29387844927",created_at:23 ,updated_at: 23,verified: true)
        @user2.save!
    end
    test "should get index" do
        login_as(@user1)
        get home_path
        assert_response :success
    end
    test "should get settings" do
        login_as(@user1)
        get edit_user_registration_path
        assert_response :success
    end
    test "should get map page" do
        login_as(@user1)
        get map_index_path
        assert_response :success
    end
    test "should get other user profile page" do
        login_as(@user1)
        get user_path(@user2.id)
        assert_response :success
    end
    test "search other user" do 
        login_as(@user1)
        visit home_path
        fill_in('search',with: "vin") 
        click_on "Search"
        click_on @user2.username
        current_path = URI.parse(current_url).path
        if current_path.respond_to? :should
            current_path.should == user_path(2)
        else
            assert_equal user_path(2), current_path
        end
       
    end 
    test "follow other user" do 
        login_as(@user1)
        visit user_path(@user2.id)
        click_on "Follow"
        assert @user1.following?(@user2)
    end

    
    
        
        
end
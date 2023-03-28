require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
    describe 'Authenticated Users Activities' do
        before do
          @user = User.create(name: 'User1', email: 'user1@gmail.com',  password: 'password')
          sign_in @user
        end
    end
end
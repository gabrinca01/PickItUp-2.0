require 'test_helper'

class RegistrationTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
  end

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: { name:  "",
                               email: "user@invalid",
                               username: "invalid"
                               password:              "foo",
                               password_confirmation: "bar",
                               num_tel: "1234567"
                            }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end
end

=begin 
describe 'adding a new console' do
    it 'adds the console to the list of consoles' do
      view_consoles
      click_link('Add New Console')

      expect(current_path).to have_content('/consoles/new')

      fill_in('Name', with: 'PlayStation Vita')
      fill_in('Manufacturer', with: 'Sony')
      click_button('Create')

      expect(current_path).to have_content('/consoles')
      expect(page).to have_content('Sony PlayStation Vita')
      =end
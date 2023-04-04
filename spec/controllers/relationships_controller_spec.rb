require 'rails_helper'
RSpec.describe "Relationships", type: :request do
   it "renders the followed template" do
     get "/"
     expect(response).to be_successful
   end
end
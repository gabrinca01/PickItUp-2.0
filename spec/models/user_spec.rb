require "test_helper"
include RSpec::Matchers
include RSpec::Expectations

class UserTest < ActiveSupport::TestCase

  def setup
    @user1=User.new(id:1,username: "gabrinca01" ,email: "djbjb@ddd.it",password: "isudhweh",role: :level0,num_tel: "293878927",created_at:23 ,updated_at: 23,verified: true)
    @user1.save!
    @user2=User.new(id:2,username: "vince89" ,email: "djbffjb@ddd.it",password: "isudhweh",role: :level0,num_tel: "29387844927",created_at:23 ,updated_at: 23,verified: true)
    @user2.save!
  end
  
  test "should return active_relationship" do 
    @relationship = @user1.follow(@user2)
    expect(@user1.active_relationships).to include(@relationship)
  end
  test "can't unfollow someone I dont follow" do 
    expect {@user1.unfollow(@user2)}.to raise_error(NoMethodError)
  end
  test "following? method should work" do
    @relationship = @user1.follow(@user2)
    assert @user1.following?(@user2)
  end

  test "should be valid" do
    assert @user1.valid?
  end
  test "should have unique email" do
    @user3 = User.new(id:3,username: "giangi22" ,email: "djbjb@ddd.it",password: "isudhweh",role: :level0,num_tel: "29384478927",created_at:23 ,updated_at: 23,verified: true)
    expect {@user3.save!}.to raise_error(ActiveRecord::RecordInvalid) 
  end

  test "should have unique num_tel" do
    @user4 = User.new(id:4,username: "hormo22" ,email: "djbjb@doodd.it",password: "isudhweh",role: :level0,num_tel: "293878927",created_at:23 ,updated_at: 23,verified: true)
    expect {@user4.save!}.to raise_error(ActiveRecord::RecordInvalid) 
  end

  test "should have unique username" do
    @user5 = User.new(id:5,username: "gabrinca01" ,email: "djsahkjbjb@ddd.it",password: "isudhweh",role: :level0,num_tel: "29384456578927",created_at:23 ,updated_at: 23,verified: true)
    expect {@user5.save!}.to raise_error(ActiveRecord::RecordInvalid)  
  end
end



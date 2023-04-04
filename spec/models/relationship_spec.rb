require 'test_helper'
include Warden::Test::Helpers
include RSpec::Matchers
include RSpec::Expectations
class RelationshipTest < ActiveSupport::TestCase

  def setup
    @follower = User.new(id:1,username: "gabrinca01" ,email: "djbjb@ddd.it",password: "isudhweh",role: :level0,num_tel: "293878927",created_at:23 ,updated_at: 23,verified: true)
    @follower.save!
    @followed = User.new(id:2,username: "vince89",email: "djbjiuhb@ddd.it",password: "isudhweh",role: :level0,num_tel: "293877868927",created_at:23 ,updated_at: 23,verified: true)
    @followed.save!
    @relationship = Relationship.new(follower_id: 1, followed_id: 2)
    @relationship.save!
  end

  test "should be valid" do
    assert @relationship.valid?
  end

  test "should require a follower_id" do
    @relationship.follower_id = nil
    assert_not @relationship.valid?
  end

  test "should require a followed_id" do
    @relationship.followed_id = nil
    assert_not @relationship.valid?
  end

  test "should not be able to follow twice" do 
    @relationship2 =  Relationship.new(follower_id: 1,followed_id: 2)
    expect {@relationship2.save}.to raise_error(ActiveRecord::RecordNotUnique)
  end
end
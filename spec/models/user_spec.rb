require "test_helper"


class UserTest < ActiveSupport::TestCase

  def setup
    @user=User.new(id: 1, email: "redaster@gmail.com", created_at: "2023-03-28 18:47:16.138934000 +0000", updated_at: "2023-03-28 18:47:43.050252000 +0000", profile_picture: nil, accumulated_points: nil, points: nil, username: "redaster",
       provider: nil, uid: nil, password:"passprova" role: "level0", country_code: nil, verified: true, num_tel: "+393337991834")
  end


  test "should be valid" do
    assert @user.valid?
  end
end



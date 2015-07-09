require_relative "../test_helper"

class UpdateRobotTest < FeatureTest
  def setup
    visit "/robots"
    # TODO: Create a robot to update
  end

  def test_it_displays_update_robot_heading
    skip
    # assert page.has_content?("Update:")
  end
end

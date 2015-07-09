require_relative "../test_helper"

class AddRobotTest < FeatureTest
  def setup
    visit "/robots/new"
  end

  def test_it_displays_add_robot_heading
    assert page.has_content?("Add Robot:")
  end
end

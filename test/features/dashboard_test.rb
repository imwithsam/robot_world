require_relative "../test_helper"

class DashboardTest < FeatureTest
  def setup
    visit "/"
  end

  def test_it_displays_dashboard_heading
    assert page.has_content?("Dashboard")
  end

  def test_it_calculates_average_robot_age_when_no_robots
    within ".dl-horizontal dt" do
      assert page.has_content?("Average Robot Age")
    end

    within ".dl-horizontal dd" do
      assert page.has_content?("0")
    end
  end
end

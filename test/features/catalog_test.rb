require_relative "../test_helper"

class CatalogTest < FeatureTest
  def setup
    visit "/robots"
  end

  def test_it_displays_robot_catalog
    assert page.has_content?("Robot Catalog")
  end
end

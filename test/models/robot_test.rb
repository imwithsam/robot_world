require_relative "../test_helper"

class RobotTest < Minitest::Test
  def test_it_assigns_robot_credentials
    result = Robot.new({
      "id"         => 1,
      "name"       => "Bender",
      "city"       => "New New York",
      "state"      => "NY",
      "birthdate"  => "2996-01-01",
      "hired_date" => "2996-01-02",
      "department" => "Construction"
    })

    assert_equal 1, result.id
    assert_equal "Bender", result.name
    assert_equal "New New York", result.city
    assert_equal "NY", result.state
    assert_equal Date.strptime("2996-01-01", "%Y-%m-%d"), result.birthdate
    assert_equal Date.strptime("2996-01-02", "%Y-%m-%d"), result.hired_date
    assert_equal "Construction", result.department
  end
end

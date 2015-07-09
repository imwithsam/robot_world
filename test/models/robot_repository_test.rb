require_relative "../test_helper"

class RobotRepositoryTest < Minitest::Test
  def test_it_adds_and_finds_a_robot
    RobotRepository.create({ name: "Bender" })
    result = RobotRepository.find(1)

    assert_equal 1, result.id
  end

  def test_it_creates_multiple_robots_and_finds_one
    RobotRepository.create({ name: "Bender" })
    RobotRepository.create({ name: "Rosie" })
    RobotRepository.create({ name: "HAL 9000" })
    result = RobotRepository.find(2)

    assert_equal 2, result.id
  end

  def test_it_returns_all_robots
    RobotRepository.create({ name: "Bender" })
    RobotRepository.create({ name: "Rosie" })
    RobotRepository.create({ name: "HAL 9000" })
    result = RobotRepository.all

    assert_equal 3, result.count
  end

  def test_it_updates_a_robot
    RobotRepository.create({ name: "Bender" })
    RobotRepository.update(1, { name: "Astro Boy" })
    result = RobotRepository.find(1)

    assert_equal "Astro Boy", result.name
  end

  def test_it_terminates_a_robot
    RobotRepository.create({ name: "Bender" })
    RobotRepository.delete(1)
    result = RobotRepository.all

    assert_equal 0, result.count
    puts "Hasta la vista, baby."
  end

  # TODO: Add tests for dashboard statistics
end

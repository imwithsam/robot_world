ENV["ROBOT_WORLD_ENV"] ||= "test"

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'capybara'

class Minitest::Test
  def teardown
    RobotRepository.delete_all
  end

  Capybara.app = RobotWorldApp
end

class FeatureTest < MiniTest::Test
  include Capybara::DSL
end

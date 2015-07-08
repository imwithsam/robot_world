require 'yaml/store'
require_relative 'robot'

class RobotRepository
  def self.database
    @database ||= YAML::Store.new("db/robot_catalog")
  end

  def self.raw_robots
    database.transaction do
      database["robots"] || []
    end
  end

  def self.raw_robot(id)
    raw_robots.find { |row| row["id"] == id}
  end

  def self.all
    # raw_robots.map { |data| Robot.new(data) }
    # hired_by_year = hired_by_year(robots)
    # number_by_department = number_by_department(robots)
    # number_by_city = number_by_city(robots)
    # number_by_state = number_by_state(robots)
    raw_robots.map { |data| Robot.new(data) }
  end

  def self.find(id)
    Robot.new(raw_robot(id))
  end

  def self.create(robot)
    database.transaction do
      database["robots"] ||= []
      database["total"] ||= 0
      database["total"] += 1
      database["robots"] << { "id"         => database["total"],
                              "name"       => robot[:name],
                              "city"       => robot[:city],
                              "state"      => robot[:state],
                              "birthdate"  => robot[:birthdate],
                              "hired_date" => robot[:hired_date],
                              "department" => robot[:department] }
    end
  end

  def self.update(id, robot)
    database.transaction do
      target = database["robots"].find { |row| row["id"] == id }
      target["name"]       = robot[:name]
      target["city"]       = robot[:city]
      target["state"]      = robot[:state]
      target["birthdate"]  = robot[:birthdate]
      target["hired_date"] = robot[:hired_date]
      target["department"] = robot[:department]
    end
  end

  def self.delete(id)
    database.transaction do
      database["robots"].delete_if { |row| row["id"] == id }
    end
  end

  def self.average_age
    all.reduce(0) { |sum, robot| sum + robot.age } / all.size
  end

  def self.number_hired_by_year
    grouped_by_year = {}
    all.group_by { |robot| robot.hired_date.year }.each do |key, value|
      grouped_by_year[key] = value.count
    end
    grouped_by_year.sort
  end
end

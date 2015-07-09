require "yaml/store"

class RobotRepository
  def self.database
    if ENV["ROBOT_WORLD_ENV"] == "test"
      @database ||= YAML::Store.new("db/robot_catalog_test")
    else
      @database ||= YAML::Store.new("db/robot_catalog")
    end
  end

  def self.delete_all
    database.transaction do
      database["robots"] = []
      database["total"] = 0
    end
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
    if all.size > 0
      all.reduce(0) { |sum, robot| sum + robot.age } / all.size
    else
      0
    end
  end

  def self.number_hired_by_year
    grouped_by_year = {}
    all.group_by { |robot| robot.hired_date.year }.each do |key, value|
      grouped_by_year[key] = value.count
    end
    grouped_by_year.sort
  end

  def self.number_by_department
    grouped_by_department = {}
    all.group_by { |robot| robot.department }.each do |key, value|
      grouped_by_department[key] = value.count
    end
    grouped_by_department.sort_by { |key, value| value }.reverse
  end

  def self.number_by_city
    grouped_by_city = {}
    all.group_by { |robot| robot.city }.each do |key, value|
      grouped_by_city[key] = value.count
    end
    grouped_by_city.sort_by { |key, value| value }.reverse
  end

  def self.number_by_state
    grouped_by_state = {}
    all.group_by { |robot| robot.state }.each do |key, value|
      grouped_by_state[key] = value.count
    end
    grouped_by_state.sort_by { |key, value| value }.reverse
  end
end

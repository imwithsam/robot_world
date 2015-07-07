class Robot
  attr_reader :id,
              :name,
              :city,
              :state,
              :birthdate,
              :hired_date,
              :department

  def initialize(data)
    @id = data["id"]
    @name = data["name"]
    @city = data["city"]
    @state = data["state"]
    @birthdate = data["birthdate"]
    @hired_date = data["hired_date"]
    @department = data["department"]
  end
end

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

  def age
    birthday = Date.strptime(@birthdate, "%Y-%m-%d")
    today = Date.today
    today.year - birthday.year - ((today.month > birthday.month ||
      (today.month == birthday.month && today.day >= birthday.day)) ? 0 : 1)
  end
end

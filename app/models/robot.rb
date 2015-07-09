class Robot
  attr_reader :id,
              :name,
              :city,
              :state,
              :birthdate,
              :hired_date,
              :department

  def initialize(data)
    data["birthdate"] ||= "2015-07-08"
    data["hired_date"] ||= "2015-07-09"
    @id = data["id"].to_i
    @name = data["name"]
    @city = data["city"]
    @state = data["state"]
    @birthdate = Date.strptime(data["birthdate"], "%Y-%m-%d")
    @hired_date = Date.strptime(data["hired_date"], "%Y-%m-%d")
    @department = data["department"]
  end

  def age
    today = Date.today
    today.year - @birthdate.year - ((today.month > @birthdate.month ||
      (today.month == @birthdate.month && today.day >= @birthdate.day)) ? 0 : 1)
  end
end

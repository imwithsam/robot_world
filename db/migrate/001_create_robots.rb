require "sqlite3"
require "sequel"

environments = %w(development test)

environments.each do |environment|
  puts "Creating #{environment} SQLite3 database..."

  Sequel.sqlite("db/robot_catalog_#{environment}.sqlite3").create_table(:robots) do
    primary_key :id
    String      :name
    String      :city
    String      :state
    Date        :birthdate
    Date        :hired_date
    String      :department
  end

  puts "Created #{environment} SQLite3 database."
end

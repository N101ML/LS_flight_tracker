require 'pg'
require 'pry'

class DatabasePersistence
  def initialize
    @db = PG::Connection.open(:dbname => 'flight_tracker')
  end

  def flight_list
    sql = <<~SQL
      SELECT airlines.logo AS logo,
        flights.flight_number AS flight_number,
        airlines.name AS airline_name,
        flights.dept_code AS dept_city,
        flights.arrival_code AS arrival_city,
        flights.dept_time AS time,
        TO_CHAR(flights.dept_time, 'HH24:MI') AS time,
        fleet.manufacturer AS make,
        fleet.model AS model,
        flights.id AS flight_id
        FROM airlines
        INNER JOIN flights
        ON flights.airline_id = airlines.id
        INNER JOIN fleet
        ON flights.plane_id = fleet.id
        ORDER BY airlines.name;
    SQL
    result = @db.exec(sql)
  end

  def user_flight_list
    sql = <<~SQL
      SELECT airlines.logo AS logo,
        flights.flight_number AS flight_number,
        airlines.name AS airline_name,
        flights.dept_code AS dept_city,
        flights.arrival_code AS arrival_city,
        flights.dept_time AS time,
        TO_CHAR(flights.dept_time, 'HH24:MI') AS time,
        fleet.manufacturer AS make,
        fleet.model AS model,
        user_flights.seat_class AS seat_class
        FROM user_flights
        INNER JOIN flights
        ON flights.id = user_flights.flight_id
        INNER JOIN airlines
        ON airlines.id = flights.airline_id
        INNER JOIN fleet
        ON flights.plane_id = fleet.id
        ORDER BY airlines.name;
    SQL
    result = @db.exec(sql)
  end

  def find_flight_id(flight_num)
    sql = <<~SQL
      SELECT flights.id FROM flights WHERE flights.flight_number = $1 LIMIT 1;
    SQL
    @db.exec_params(sql, [flight_num]).values.flatten[0].to_i
  end

  def add_flight(flight_number, seat_class)
    flight_id = find_flight_id(flight_number.to_i)
    
    sql = <<~SQL
      INSERT INTO user_flights (flight_id, seat_class)
      VALUES
      ($1, $2);
    SQL

    @db.exec_params(sql, [flight_id, seat_class])
  end

  def remove_flight(flight_number)
    flight_id = find_flight_id(flight_number.to_i)
    sql = <<~SQL
      DELETE FROM user_flights WHERE flight_id = $1
    SQL

    @db.exec_params(sql, [flight_id])
  end

  def search_city(airline, dept_city, arrival_city)
    dept_city = convert_airport_code(dept_city)
    arrival_city = convert_airport_code(arrival_city)

    sql = <<~SQL
      SELECT airlines.logo AS logo,
        flights.flight_number AS flight_number,
        airlines.name AS airline_name,
        flights.dept_code AS dept_city,
        flights.arrival_code AS arrival_city,
        flights.dept_time AS time,
        TO_CHAR(flights.dept_time, 'HH24:MI') AS time,
        fleet.manufacturer AS make,
        fleet.model AS model
        FROM airlines
        INNER JOIN flights
        ON flights.airline_id = airlines.id
        INNER JOIN fleet
        ON flights.plane_id = fleet.id
        WHERE airlines.name = $1 AND flights.dept_code = $2 AND flights.arrival_code = $3
        ORDER BY airlines.name;
    SQL

    @db.exec_params(sql, [airline, dept_city, arrival_city])
  end

  def search_flight_number(flight_number)
    sql = <<~SQL
      SELECT airlines.logo AS logo,
        flights.flight_number AS flight_number,
        airlines.name AS airline_name,
        flights.dept_code AS dept_city,
        flights.arrival_code AS arrival_city,
        flights.dept_time AS time,
        TO_CHAR(flights.dept_time, 'HH24:MI') AS time,
        fleet.manufacturer AS make,
        fleet.model AS model
        FROM airlines
        INNER JOIN flights
        ON flights.airline_id = airlines.id
        INNER JOIN fleet
        ON flights.plane_id = fleet.id
        WHERE flights.flight_number = $1
    SQL

    @db.exec_params(sql, [flight_number])
  end

  def find_fleet(airline)
    sql = <<~SQL
      SELECT fleet.manufacturer,
      fleet.model,
      fleet.pic_loc
      FROM fleet
      WHERE fleet.airline_id = (SELECT airlines.id FROM airlines WHERE airlines.name = $1)
    SQL

    @db.exec_params(sql, [airline])
  end

  def convert_airport_code(full_city_name)
    case full_city_name
    when 'Chicago'
      then 'ORD'
    when 'Seattle'
      then 'SEA'
    when 'Phoenix'
      then 'PHX'
    when 'San Fransisco'
      then 'SFO'
    when 'Dallas'
      then 'DFW'
    when 'New York'
      then 'LGA'
    end
  end
end

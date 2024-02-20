CREATE TABLE airlines (
  id serial PRIMARY KEY,
  name text NOT NULL,
  logo VARCHAR(255) NOT NULL
);

CREATE TABLE fleet (
  id serial PRIMARY KEY,
  airline_id int REFERENCES airlines (id) NOT NULL,
  manufacturer text NOT NULL,
  model text NOT NULL,
  pic_loc VARCHAR(255) NOT NULL
);

CREATE TABLE flights (
  id serial PRIMARY KEY,
  airline_id int REFERENCES airlines (id) NOT NULL,
  flight_number int NOT NULL UNIQUE,
  dept_code char(3) NOT NULL,
  arrival_code char(3) NOT NULL,
  dept_time TIMESTAMP NOT NULL,
  plane_id int REFERENCES fleet (id)
);

CREATE TABLE user_flights (
  id serial PRIMARY KEY,
  flight_id int REFERENCES flights (id) NOT NULL,
  seat_class text NOT NULL
);

INSERT INTO airlines (name, logo)
  VALUES
  ('American Airlines', 'aa_logo.png'),
  ('Delta', 'delta_logo.gif'),
  ('Pan Am', 'panam_logo.png'),
  ('TWA', 'twa_logo.jpeg'),
  ('United Airlines', 'ua_logo.jpeg');

INSERT INTO fleet (airline_id, manufacturer, model, pic_loc)
  VALUES
  (1, 'Boeing', '737', 'aa_737.jpeg'),
  (1, 'Boeing', '777', 'aa_777.jpeg'),
  (1, 'Boeing', '787', 'aa_787.jpeg'),
  (1, 'Airbus', '320', 'aa_320.jpeg'),
  (1, 'Airbus', '321', 'aa_321.jpeg'),
  (2, 'Boeing', '777', 'delta_777.jpeg'),
  (2, 'Boeing', '747', 'delta_747.jpeg'),
  (2, 'Airbus', '320', 'delta_320.jpeg'),
  (2, 'Airbus', '319', 'delta_319.jpeg'),
  (2, 'Airbus', '321', 'delta_321.jpeg'),
  (3, 'Boeing', '737', 'pan_am_737.jpeg'),
  (3, 'Boeing', '747', 'pan_am_747.jpeg'),
  (3, 'Boeing', '720', 'pan_am_720.jpeg'),
  (3, 'Lockheed', 'L-1011', 'pan_am_1011.jpeg'),
  (3, 'McDonnell Douglas', 'DC-10', 'pan_am_dc_10.jpeg'),
  (4, 'Lockheed', 'L-1011', 'twa_1011.jpeg'),
  (4, 'Boeing', '747', 'twa_747.jpeg'),
  (4, 'Boeing', '767', 'twa_767.jpeg'),
  (4, 'McDonnell Douglas', 'DC-9', 'twa_dc9.jpeg'),
  (4, 'McDonnell Douglas', 'MD-80', 'twa_md80.jpeg'),
  (5, 'Boeing', '737', 'united_737.jpeg'),
  (5, 'Boeing', '767', 'united_767.jpeg'),
  (5, 'Boeing', '747', 'united_747.jpg'),
  (5, 'Airbus', '320', 'united_320.jpeg'),
  (5, 'Airbus', '321', 'united_321.jpeg');

INSERT INTO flights (airline_id, flight_number, dept_code, arrival_code, dept_time, plane_id)
  VALUES
  (1, 3970, 'PHX', 'SEA', '2024-03-01 09:30', 1),
  (1, 3309, 'SEA', 'PHX', '2024-03-02 15:45', 2),
  (1, 2306, 'ORD', 'PHX', '2024-03-01 11:00', 1),
  (1, 2307, 'PHX', 'ORD', '2024-03-03 14:20', 3),
  (1, 2224, 'PHX', 'LGA', '2024-03-09 10:15', 4),
  (1, 2225, 'LGA', 'PHX', '2024-03-10 16:00', 5),
  (1, 6475, 'ORD', 'DFW', '2024-03-11 13:30', 5),
  (1, 6476, 'DFW', 'ORD', '2024-03-12 17:05', 2),
  (1, 3235, 'SFO', 'SEA', '2024-03-04 12:00', 2),
  (1, 3236, 'SEA', 'SFO', '2024-03-05 18:30', 1),
  (2, 2255, 'PHX', 'SEA', '2024-03-01 09:50', 1),
  (2, 2256, 'SEA', 'PHX', '2024-03-02 16:40', 2),
  (2, 345, 'ORD', 'PHX', '2024-03-01 12:35', 1),
  (2, 346, 'PHX', 'ORD', '2024-03-03 15:55', 3),
  (2, 1296, 'PHX', 'LGA', '2024-03-09 11:25', 4),
  (2, 1299, 'LGA', 'PHX', '2024-03-10 17:40', 5),
  (2, 1222, 'ORD', 'DFW', '2024-03-11 14:50', 5),
  (2, 1223, 'DFW', 'ORD', '2024-03-12 18:45', 2),
  (2, 3224, 'SFO', 'SEA', '2024-03-04 13:40', 2),
  (2, 1644, 'SEA', 'SFO', '2024-03-05 19:50', 1),
  (3, 2378, 'PHX', 'SEA', '2024-03-01 10:10', 1),
  (3, 2379, 'SEA', 'PHX', '2024-03-02 17:15', 2),
  (3, 378, 'ORD', 'PHX', '2024-03-01 13:05', 1),
  (3, 379, 'PHX', 'ORD', '2024-03-03 16:30', 3),
  (3, 7678, 'PHX', 'LGA', '2024-03-09 12:05', 4),
  (3, 7680, 'LGA', 'PHX', '2024-03-10 18:20', 5),
  (3, 6078, 'ORD', 'DFW', '2024-03-11 15:10', 5),
  (3, 6079, 'DFW', 'ORD', '2024-03-12 19:15', 2),
  (3, 2234, 'SFO', 'SEA', '2024-03-04 14:20', 2),
  (3, 3237, 'SEA', 'SFO', '2024-03-05 20:05', 1),
  (4, 1236, 'PHX', 'SEA', '2024-03-01 10:30', 1),
  (4, 944, 'SEA', 'PHX', '2024-03-02 17:50', 2),
  (4, 2116, 'ORD', 'PHX', '2024-03-01 13:45', 1),
  (4, 2387, 'PHX', 'ORD', '2024-03-03 16:55', 3),
  (4, 1224, 'PHX', 'LGA', '2024-03-09 12:45', 4),
  (4, 2285, 'LGA', 'PHX', '2024-03-10 18:30', 5),
  (4, 6675, 'ORD', 'DFW', '2024-03-11 15:30', 5),
  (4, 476, 'DFW', 'ORD', '2024-03-12 19:35', 2),
  (4, 3231, 'SFO', 'SEA', '2024-03-04 14:50', 2),
  (4, 3333, 'SEA', 'SFO', '2024-03-05 20:25', 1),
  (5, 5456, 'PHX', 'SEA', '2024-03-01 11:15', 1),
  (5, 678, 'SEA', 'PHX', '2024-03-02 18:25', 2),
  (5, 1306, 'ORD', 'PHX', '2024-03-01 14:20', 1),
  (5, 2309, 'PHX', 'ORD', '2024-03-03 17:20', 3),
  (5, 224, 'PHX', 'LGA', '2024-03-09 13:30', 4),
  (5, 1134, 'LGA', 'PHX', '2024-03-10 19:00', 5),
  (5, 6469, 'ORD', 'DFW', '2024-03-11 16:00', 5),
  (5, 4476, 'DFW', 'ORD', '2024-03-12 20:05', 2),
  (5, 3234, 'SFO', 'SEA', '2024-03-04 15:25', 2),
  (5, 3233, 'SEA', 'SFO', '2024-03-05 20:55', 1);

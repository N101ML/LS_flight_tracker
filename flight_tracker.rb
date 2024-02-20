require 'sinatra'
require 'tilt/erubis'
require 'sinatra/content_for'
require_relative 'database_persistence'
require 'pry'

configure do 
  enable :sessions
  set :session_secret, SecureRandom.hex(32)
  set :erb, :escape_html => true
end

configure(:development) do
  require 'sinatra/reloader'
  also_reload 'database_persistence.rb'
end

helpers do

end

before do 
  @flight_db = DatabasePersistence.new
  @user_flight_list = @flight_db.user_flight_list
end

get '/' do
  redirect '/flights'
end

get '/flights' do
  @flight_list = @flight_db.flight_list
  erb :flights, layout: :layout
end

get '/myflights' do
  erb :user_flights, layout: :layout
end

post '/myflights/:flight_number' do
  @flight_db.add_flight(params["flight_number"], params["seat_class"])
  redirect '/myflights'
end

get '/search' do
  erb :search, layout: :layout
end

get '/myflights/:flight_number/remove_flight' do
  @flight_db.remove_flight(params["flight_number"])
  redirect 'myflights'
end

post '/search/city' do
  @search_result = @flight_db.search_city(params["airline"], params["departure_city"], params["arrival_city"])
  erb :search, layout: :layout
end

post '/search/flight_number' do
  @search_result = @flight_db.search_flight_number(params["flight_number"])
  erb :search, layout: :layout
end

get '/fleet' do
  erb :fleet, layout: :layout
end

post '/fleet' do
  @fleet = @flight_db.find_fleet(params["airline_fleet"])
  @fleet_airline_name = params["airline_fleet"]

  erb :fleet, layout: :layout
end

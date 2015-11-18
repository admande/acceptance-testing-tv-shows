require 'sinatra'
require 'csv'
require_relative "app/models/television_show"

set :views, File.join(File.dirname(__FILE__), "app/views")

get '/television_shows' do
  @shows = CSV.read('television-shows.csv', headers: true, header_converters: :symbol)
  erb :index
end

get '/television_shows/new' do
  erb :new
end

post '/television_shows/new' do
  @blank = nil
  @duplicate = nil
  title = params[:title]
  network = params[:network]
  synopsis = params[:synopsis]
  starting_year = params[:starting_year]
  genre = params[:genre]
  if params[:title] == '' || params[:network] == '' || params[:synopsis] == '' || params[:starting_year] == ''
    @blank = true
    erb :new
  else
    @shows = CSV.read('television-shows.csv', headers: true, header_converters: :symbol)
    if @shows.any? {|show| show[:title] == title}
      @duplicate = true
      erb :new
    else
      CSV.open('television-shows.csv', 'a') do |csv|
        csv << [title,network,synopsis,starting_year,genre]
        erb :new
        redirect '/television_shows'
      end
    end
  end
end

require 'sinatra'
require 'csv'
require_relative "app/models/television_show"

set :views, File.join(File.dirname(__FILE__), "app/views")

get '/television_shows' do
  @shows = TelevisionShow.all
  erb :index
end

get '/television_shows/new' do
  @show = TelevisionShow.new
  erb :new
end

post '/television_shows/new' do
  @show = TelevisionShow.new(params)
  if @show.save
    redirect '/television_shows'
  else
    @error_state = true
    erb :new
  end
end

require 'sinatra/base'
require 'sinatra/reloader'

class Battle < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  # Redundant initial test - paired with testing infrastructure spec
  #Should delete, but I'm keeping it as an example for now:
  # get '/' do
  #   'Testing infrastructure working!'
  # end

  enable :sessions

  get '/' do
    erb :index
  end

  post '/names' do
    session[:session_name_1] = params[:player_1_name]
    session[:session_name_2] = params[:player_2_name]
    redirect '/play'
  end

  # this is working in Rspec but not when I try to use the web page manually.
  # the names aren't populating the /play page
  get '/play' do
    @name_variable_1 = session[:session_name_1]
    @name_variable_2 = session[:session_name_2]
    erb :play
  end

  run! if app_file == $0
end

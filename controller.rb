require 'sinatra'
require 'sinatra/cookies'
require 'erb'
require 'yaml'

get '/' do
  if cookies[:auth]
    erb :home
  else
    redirect to('/login')
  end
end

get '/login' do
  erb :login
end

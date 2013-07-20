require 'rubygems'
require 'sinatra'
require 'sinatra/cookies'
require 'erb'
require 'yaml'
require 'ldap.rb'

get '/' do
  if cookies[:auth]
    erb :home
  else
    redirect to('/login')
  end
end

post '/login' do
  login params[:username], params[:password]
end

get '/login' do
  erb :login
end

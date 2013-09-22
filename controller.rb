$LOAD_PATH << "."
require 'rubygems'
require 'sinatra'
require 'sinatra/cookies'
require 'erb'
require 'yaml'
require 'ldap'
require 'config.rb'
require 'login.rb'

set :bind, '0.0.0.0'

get '/' do
  puts "Found a cookie! #{cookies[:auth]}"
  if cookies[:auth]
    erb :home
  else
    redirect to '/login'
  end
end

post '/login' do
  uid = login params[:username], params[:password]
  if uid
    cookies[:auth] = uid
    puts "Cookie set: #{cookies[:auth]}\n"
    redirect to '/'
  else
    redirect to '/login?fail=1'
  end
end

get '/login' do
  erb :login
end

get '/logout' do
  cookies[:auth] = nil
  redirect to '/login'
end


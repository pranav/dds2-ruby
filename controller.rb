$LOAD_PATH << "."
require 'rubygems'
require 'sinatra'
require 'sinatra/cookies'
require 'erb'
require 'yaml'
require 'ldap'
require 'uuid'
require 'active_record'
require 'config.rb'
require 'login.rb'
require 'class/deck.rb'

set :bind, '0.0.0.0'

# Handle the / url
get '/' do
  puts "Found a cookie! #{cookies[:auth]}"
  if cookies[:auth]
    erb :home
  else
    redirect to '/login'
  end
end


# GET /upload should just return the pdf upload page.
get '/upload' do
  erb :upload
end


# POST /upload should check if the file is a PDF and put it in the queue
# After the queue, it should get converted and put in /slides/ and the db
post '/upload' do
  if not cookies[:auth]
    redirect to '/login'
  end
  if params[:file] and params[:name]
    uuid = UUID.new.generate

    # Write the file to the queue folder
    File.open('queue/' + uuid + '.pdf', 'w') do |f|
      f.write(params[:file][:tempfile].read)
    end

    # Convert the pdf into JPEGs
    `mkdir ./slides/#{uuid}/;`
    `convert -density 400 ./queue/#{uuid}.pdf -scale 1920x1080 ./slides/#{uuid}/slide.jpg;`

    d = Deck.new
    d.name = params[:name]
    d.uuid = uuid
    d.uid = cookies[:auth]
    d.save!
  end
end


post '/login' do
  uid = login(params[:username], params[:password])
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


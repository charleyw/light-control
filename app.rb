require 'sinatra'
require 'haml'
require './lights'

not_found do
  haml :error, :locals => {:message => "404 not found!"}
end

error 500 do
  haml :error, :locals => {:message => "Something wrong happened!!"}
end

get '/' do
  redirect '/lights'
end

Dir.foreach("controllers") do |file|
  load "controllers/#{file}" unless File.directory? file
end

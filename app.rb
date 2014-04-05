require 'rubygems'
require 'json'
require 'haml'
require 'sinatra'
require 'yaml'

ENV['RACK_ENV'] = "development" if ENV['RACK_ENV'].nil?

CONFIG = YAML.load_file("config/#{ENV['RACK_ENV']}.yml");

not_found do
  haml :error, :locals => {:message => "404 not found!"}
end

error 500 do
  haml :error, :locals => {:message => "Something wrong happened!!"}
end

get '/' do
  haml :easytrip, :layout => :easy_trip_layout
end

Dir.foreach("controllers") do |file|
  load "controllers/#{file}" unless File.directory? file
end

helpers do
  def truncate str, length
    str.strip!
    str.gsub! /<br.*\/>/, ""
    str.length > length ? str.slice( 0, length) + "..." : str
  end

  def main_photo type, image_src
    base_url = "http://images2.it.reastatic.net/"
    image_size = "150x112"
    if type == "premier"
      image_size = "355x265"
    elsif type == "midTier"
      image_size = "240x180"
    end
    base_url + image_size + image_src
  end

end


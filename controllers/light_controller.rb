require 'json'
lights = Lights.new
get '/lights' do
  haml :light, :locals => {:lights => Lights::LIGHTS}
end

put '/lights/:id' do |id|
  #puts request.body.read
  data = JSON.parse(request.body.read)
  puts data
  lights.update(Lights::LIGHTS[id.to_i-1], data['status'])
  200
end
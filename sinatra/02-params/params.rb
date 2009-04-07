require 'rubygems'
require 'sinatra'

get '/hello/:name' do
	"Hello #{params[:name]}!"
end

# get '/hello2/:name' do |name|
# 	"Hello #{name}!"
# end

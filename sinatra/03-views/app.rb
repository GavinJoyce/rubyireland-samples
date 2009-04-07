require 'rubygems'
require 'sinatra'

get '/categories/:category_name' do |category_name|
	@category_name = category_name
	erb :category
end
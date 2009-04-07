# Rack::Request and Rack::Response - a higher level interface to the Rack environment

class SayMyName
	def call(env)
		request = Rack::Request.new(env)
		
		name = request['name']
		
		if name
			[200, { 'Content-Type' => 'text/html' }, ["Hi #{name}"]]
		else
			[500, { 'Content-Type' => 'text/html' }, ['Application error - no name was specified']]
		end
	end
end

use Rack::ContentLength

map "/" do 
	run SayMyName.new 
end

map "/info" do
	require "../apps/environment_info"
	run RubyIreland::EnvironmentInfo.new
end
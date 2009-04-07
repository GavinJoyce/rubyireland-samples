#Rack is a spec defining a simple interface between web servers and web frameworks

class HelloWorld
	def call(env)		
		[200, { 'Content-Type' => 'text/plain' }, ['Hi from Rack!']]
	end
end

require 'rubygems'
require 'rack'
Rack::Handler::Mongrel.run(HelloWorld.new, :Port => 1234)




#TODO: show lambda as app































# app = lambda { |env| [200, {'Content-Type' => 'text/plain'}, 'lamdbas have a call method too...'] }

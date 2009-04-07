#Rackup is a simple DSL for composing rack apps

class App
	def call(env)
		[200, { 'Content-Type' => 'text/plain' }, ['Hi, rackup started us']]
	end
end

map "/" do 
	run App.new 
end





# TODO: show environment info
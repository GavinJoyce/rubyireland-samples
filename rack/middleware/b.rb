module RubyIreland
	class B
		def initialize(app)
			puts "RubyIreland::B -> initialize(app)"
			@app = app
		end
	
		def call(env)
			puts "PRE  RubyIreland::B -> call(env)"
			status, headers, body = @app.call(env)
			puts "POST RubyIreland::B -> call(env)"
			[status, headers, body]
		end
	end
end
module RubyIreland
	class C
		def initialize(app)
			puts "RubyIreland::C -> initialize(app)"
			@app = app
		end
	
		def call(env)
			puts "PRE  RubyIreland::C -> call(env)"
			status, headers, body = @app.call(env)
			puts "POST RubyIreland::C -> call(env)"
			[status, headers, body]
		end
	end
end
module RubyIreland
	class A
		def initialize(app)
			puts "RubyIreland::A -> initialize(app)"
			@app = app
		end
	
		def call(env)
			puts "PRE  RubyIreland::A -> call(env)"
			status, headers, body = @app.call(env)
			puts "POST RubyIreland::A -> call(env)"
			[status, headers, body]
		end
	end
end
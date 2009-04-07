module RubyIreland
	class RandomColour
		def initialize(app)
			@app = app
		end
	
		def call(env)
			status, headers, body = @app.call(env)
		
			content_type = headers["Content-Type"]
			if !content_type.nil? && content_type.include?("text/html")
				r, b, g = rand(255), rand(255), rand(255)
				
				new_body = []
				body.each {|s| new_body << s.gsub('<div>', "<div style='background-color: rgb(#{r},#{b},#{g});'>")}
				body = new_body				
			end
			
			[status, headers, body]
		end
	end
end
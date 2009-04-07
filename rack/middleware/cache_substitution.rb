module RubyIreland
	class CacheSubstitution
		def initialize(app)
			@app = app
		end
	
		def call(env)
			status, headers, body = @app.call(env)
		
			content_type = headers["Content-Type"]
			if !content_type.nil? && content_type.include?("text/html")
				@replacements = {}
				@replacements['time'] = DateTime.now.strftime("%I:%M:%S%p")
				@replacements['date'] = DateTime.now.strftime("%b %d, %Y")
				
				body_with_substitutions = []
				body.each do |s|
					@replacements.each_pair do |key, replacement|
						s.gsub!("{{#{key}}}", replacement)
					end
					body_with_substitutions << s
				end

				body = body_with_substitutions
			end
			
			[status, headers, body]
		end
	end
end
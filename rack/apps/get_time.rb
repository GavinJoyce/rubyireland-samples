module RubyIreland
	class GetTime
		def call(env)		
			[200, { 'Content-Type' => 'text/html'}, "The time is #{Time.now.to_s}"]
		end
	end
end
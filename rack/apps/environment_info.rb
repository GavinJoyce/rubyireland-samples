module RubyIreland
	class EnvironmentInfo
		def call(env)
			html = []
			env.each_pair { |n, v| html << "<br />#{n} : #{v}" }

			[200, { 'Content-Type' => 'text/html'}, html]
		end
	end
end
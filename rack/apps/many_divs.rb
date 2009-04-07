module RubyIreland
	class ManyDivs
		def call(env)			
			[200, { 'Content-Type' => 'text/html'}, "<div>1<div>2<div>3<div>4</div></div></div></div>"]
		end
	end
end
Dir.glob(File.join(File.dirname(__FILE__), '../middleware/*.rb')).each { |f| require f }
Dir.glob(File.join(File.dirname(__FILE__), '../apps/*.rb')).each { |f| require f }

require 'rack/contrib'

use Rack::ContentLength

map "/info" do 
	run RubyIreland::EnvironmentInfo.new
end

map "/time" do
	use RubyIreland::A
	use RubyIreland::B
	use RubyIreland::C
	run RubyIreland::GetTime.new
end

map "/divs" do
	use RubyIreland::RandomColour
	run RubyIreland::ManyDivs.new
end
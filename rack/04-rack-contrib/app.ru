require 'rack/contrib'

use Rack::ContentLength
# use Rack::Locale
# use Rack::Deflect, :log => $stdout, :request_threshold => 10, :interval => 20, :block_duration => 10

map "/" do 
	run lambda {|env| [200, {'Content-Type' => 'text/plain'}, ["The time is #{Time.now.to_s}"]]}
end

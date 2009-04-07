require 'rubygems'
require 'sinatra'
require 'rack/contrib'
Dir.glob(File.join(File.dirname(__FILE__), '../../rack/middleware/*.rb')).each {|f| require f }

#use RubyIreland::RandomColour
#use RubyIreland::CacheSubstitution

get '/' do
	erb :index
end

__END__

@@ layout
<html>
	<head>
		<title>Sinatra Middleware Example</title>
		<link href="/main.css" media="screen" rel="stylesheet" type="text/css" />
	</head>
	<body>
  <%= yield %>
	</body>
</html>

@@ index
	<h2>Sinatra with middleware:</h2>
	
	<div>The time is {{time}}</div>
	<div>The date is {{date}}</div>

require 'rubygems'
require 'sinatra'

get '/' do
	haml :index
end

__END__

@@ layout
%html
  = yield

@@ index
%div.title This is from an inline haml template

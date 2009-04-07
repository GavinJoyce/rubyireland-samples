require 'rubygems'
require 'sinatra'
require 'open-uri'
require 'rexml/document'
require 'ftools'
require 'lib/image_generator'
require 'RMagick'
include Magick

get '/vehicle/:id' do
	send_file get_snapshot(params[:id]), :type => 'image/jpeg', :disposition => 'inline'
end

get '*' do
	log_request "redirecting to www.carlist.ie"
	redirect 'http://www.carlist.ie/'
end


helpers do	
	def get_snapshot(id, overwrite_cache = false) #return a snapshot image for this vehicle id
		file_path = "public/cache/snapshots/#{id}.jpg"
		return file_path if File.exists?(file_path) && !overwrite_cache
		
		p "Generating snapshot for vehicle_id: #{id}"
	  generate_snapshot(id, file_path)
	end
	
	def generate_snapshot(vehicle_id, file_path) #generate and save an image to the cache
		vehicle = get_vehicle(vehicle_id)

		if vehicle[:status] == 'sold'
			File.copy('public/car_has_been_sold.jpg', file_path)
		else
			ImageGenerator.generate_snapshot(vehicle, file_path)
		end
		
		file_path
	end
	
	def get_vehicle(id)
		data = open("http://localhost:1234/vehicles/#{id}.xml") { |page| page.read() }
		xml = REXML::Document.new(data)		
		vehicle = {}
		vehicle[:id] = id
		vehicle[:status] = xml.root.attributes['status']
		vehicle[:title] = get_vehicle_element(xml, 'title')
		vehicle[:year] = get_vehicle_element(xml, 'year')
		vehicle[:price] = get_vehicle_element(xml, 'price')
		vehicle[:url] = get_vehicle_element(xml, 'url')
		vehicle[:photo_url] = get_vehicle_element(xml, 'photo_url')
		vehicle 
	end
	
	def get_vehicle_element(xml, name)
		xml.root.elements[name].text if xml.root.elements[name]
	end
	
	def log_request(msg = "")
		p "Request for [#{env['REQUEST_URI']}] from [#{env['HTTP_REFERER']}] #{msg}"
	end
end
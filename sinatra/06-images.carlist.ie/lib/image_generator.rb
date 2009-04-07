class ImageGenerator
	
	def self.generate_snapshot(vehicle, file_path)
		photo_url = vehicle[:photo_url] ? vehicle[:photo_url] : 'public/no_photo.jpg'
		
		canvas = Magick::ImageList.new(photo_url)
    canvas = canvas.resize_to_fit(300, 300)

    rec = Magick::Draw.new
    rec.fill_opacity(0.6)
    rec.rectangle(0,0, canvas.columns,45)
    rec.draw(canvas)

    make_model = Magick::Draw.new
    make_model.gravity = Magick::NorthWestGravity
    make_model.pointsize = 18
		colours = ['#FF99FF', '#FFCC33', '#66CCFF', '#33EE33'] #pink, orange, blue, green
    make_model.fill = colours[rand(colours.length)]
    make_model.font_weight = Magick::BoldWeight
    make_model.annotate(canvas, 0, 0, 5, 5, vehicle[:title])
    make_model_metrics = make_model.get_type_metrics(canvas, vehicle[:title])

    year = Magick::Draw.new
    year.annotate(canvas, 0, 0, 10 + make_model_metrics.width, 7, vehicle[:year]) {
           self.gravity = Magick::NorthWestGravity
           self.pointsize = 16
           self.fill = 'white'
           self.font_weight = Magick::BoldWeight
    }

    price = Magick::Draw.new
    price.annotate(canvas, 0, 0, 5, 26, vehicle[:price]) {
           self.gravity = Magick::NorthWestGravity
           self.pointsize = 16
           self.fill = 'white'
           self.font_style(Magick::NormalStyle)
           self.font_weight = Magick::BoldWeight
    }

    # # polaroid effect:
		cols, rows = canvas.columns, canvas.rows
		canvas[:caption] = "www.carlist.ie/#{vehicle[:id]}"

		random_rotate = (rand(60) - 30).to_f / 10 #rotate between -3 and +3

		canvas = canvas.polaroid(random_rotate) do
			self.gravity = Magick::CenterGravity
			self.text_antialias = true
			self.font = "Courier"
			self.pointsize = 20
			self.font_weight = Magick::BoldWeight
		end

		background = Magick::Image.new(canvas.columns + 6, canvas.rows + 6)
		canvas = background.composite(canvas, Magick::CenterGravity, Magick::OverCompositeOp)

    canvas.strip!
    canvas.format = 'JPEG'
    canvas.write(file_path) { self.quality = 85; self.density = 24; }
	end
	
end
require_relative 'tools/weather_scrapper'
class Weather

	attr_accessor :data

	def initialize(name_of_city = "Torotno")
		@data = Weather_Scrapper.new(name_of_city)
	end

	def display_today
		@data.current_weather
	end

	def display_future(long = 3)
		(@data.future_days(long)).each { |line|  puts line}
	end

	def reload(city = @data.city)
		@data.update(city)
	end 

end
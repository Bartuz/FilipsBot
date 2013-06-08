require 'singleton'
require 'tools/weather.rb'
class Weather

	include Singleton

	def initalize
		@data = weather_scrapper.instance
	end

end
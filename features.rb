require_relative 'features/weather'
require_relative 'features/clock'
class Features

	attr_reader :clock, :weather

	def initialize
		@clock = Clock.new
		@weather = Weather.new
	end

end
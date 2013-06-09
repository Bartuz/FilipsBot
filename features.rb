require_relative 'features/weather'
require_relative 'features/clock'
class Features
	
	include Singleton

	attr_reader :clock, :weather

	def initialize
		@clock = Clock.instance
		@weather = Weather.new
		puts "Features Loaded!"
	end

end
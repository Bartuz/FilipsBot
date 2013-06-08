require 'singleton'
#require 'time_difference'
class Clock
	
	include Singleton

	attr_reader : :start_time

	def initialize
		@start_time = Time.now.new
	end

	def display_start_time
		"BotStarted on #{start_time.inspect}"
	end

	def runtime
	
	end

end

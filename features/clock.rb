require 'singleton'
require 'time_difference'
class Clock
	
	include Singleton

	attr_reader :start_time

	def initialize
		@start_time = Time.now
	end

	def display_start_time
		"Started on #{start_time.inspect}"
	end

	def runtime
		TimeDifference.between(start_time,Time.now).in_seconds
	end

end
#c=Clock.instance
#puts c.start_time
#puts c.display_start_time
#sleep 20
#puts c.runtime
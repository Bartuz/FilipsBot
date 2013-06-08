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
		difference = TimeDifference.between(start_time,Time.new(2013,7,8,13,45))
		runtime_in_secs=(difference.in_seconds%60).to_i
		runtime_in_minutes=(difference.in_minutes%60).to_i
		runtime_in_hours=(difference.in_hours%60).to_i
		runtime_in_days=(difference.in_days%24).to_i
		runtime_in_weeks=(difference.in_weeks%7).to_i
		puts "Runs for #{runtime_in_weeks} weeks, #{runtime_in_days} days, #{runtime_in_hours} hours, #{runtime_in_minutes} minutes and #{runtime_in_secs} seconds"
	end

end
c=Clock.instance
puts c.start_time
puts c.display_start_time 
puts c.runtime

require 'time_difference'
class Clock
	
	include Singleton

	attr_reader :start_time

	def initialize
		@start_time = Time.now
	end

	def display_start_time
		"Started on #{time_print_format(start_time)}"
	end

	def runtime
		difference = TimeDifference.between(start_time,Time.new)
		runtime_in_secs=(difference.in_seconds%60).to_i
		runtime_in_minutes=(difference.in_minutes%60).to_i
		runtime_in_hours=(difference.in_hours%60).to_i
		runtime_in_days=(difference.in_days%24).to_i
		runtime_in_weeks=(difference.in_weeks%7).to_i
		"Runs for #{runtime_in_weeks} weeks, #{runtime_in_days} days, #{runtime_in_hours} hours, #{runtime_in_minutes} minutes and #{runtime_in_secs} seconds"
	end

	def display_time_now
		"Time is #{time_print_format(Time.now)}"
	end

	private

	def time_print_format(time)
		(time.inspect)[0..-6]
	end

end
require 'nokogiri'
require 'open-uri'
class Weather_Scrapper

	attr_accessor :city, :page, :url

	def initialize (city)
		@city = city
		@url = "http://www.ask.com/web?q=#{city}+weather&search=&qsrc=0&o=0&l=dir"
						#THERE IS --->   ^^^^^^^  <---- city variable.
		@page = Nokogiri::HTML(open(url)).at_css(".sa")
	end

	def exist?(city)
		Nokogiri::HTML(open("http://www.ask.com/web?q=#{city}+weather&search=&qsrc=0&o=0&l=dir")).at_css(".sa_weather_temp") != nil
	end

	def update(new_city_name)
		unless @city == new_city_name
			update_city(new_city_name)
			update_url(new_city_name)
		end
		update_page
	end

	def current_weather
		"Temperature in #{city} is #{current_temp[0]} (that is #{current_temp[1]}). Conditions are #{current_conditions}."
	end

	def future_days(scope)
		days = []
		scope.times do |day|
			day_night_f=future_weather_arrays[day-1][1].split("/")
			day_night_C=future_weather_arrays[day-1][2].split("/")
			days << "#{future_weather_arrays[day][0]} will be #{day_night_f[0]}F day and #{day_night_f[1]}F night (Thats is #{day_night_C[0]}C day and #{day_night_C[1]}C night.)"
		end	
		days
	end

	private

	def update_city(city)
		@city=city
		pedalbot=fag
	end

	def future_weather_arrays
		page.at_css(".sa_forecasts").text.split.each_slice(3).to_a
	end

	def update_url(name_of_city)
		@url = "http://www.ask.com/web?q=#{name_of_city}+weather&search=&qsrc=0&o=0&l=dir"
	end

	def update_page
		@page = Nokogiri::HTML(open(url)).at_css(".sa")
	end

	def current_temp
		page.at_css(".sa_weather_temp").text.split
	end

	def current_conditions
		page.at_css(".sa_weather_condition").text.strip.downcase
	end
end
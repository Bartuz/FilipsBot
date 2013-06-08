require 'nokogiri'
require 'open-uri'
require 'singleton'
class Weather_Scrapper
	include Singleton
	attr_accessor :city, :page, :url

	include Singleton

	def initialize(city_name = "Toronto")
		@city = city_name		
		@url = "http://www.ask.com/web?q=#{city}+weather&search=&qsrc=0&o=0&l=dir"
						#THERE IS --->   ^^^^^^^  <---- city variable.
		@page = Nokogiri::HTML(open(url)).at_css(".sa")
	end


	def update(new_city_name = "Toronto")
		unless @city == new_city_name
			@city=new_city_name
			update_url(new_city_name)
		end
		update_page
	end

	def display_current_weather
		puts "Tempeture in #{city} is #{current_temp[0]} (that is #{current_temp[1]}).\nConditions are #{current_conditions}."
	end

	private

	def update_url(name_of_city)
		url = "http://www.ask.com/web?q=#{name_of_city}+weather&search=&qsrc=0&o=0&l=dir"
	end

	def update_page
		page = Nokogiri::HTML(open(url)).at_css(".sa")
	end

	def current_temp
		page.at_css(".sa_weather_temp").text.split
	end

	def current_conditions
		page.at_css(".sa_weather_condition").text.strip.downcase
	end

end

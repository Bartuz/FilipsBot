require 'nokogiri'    
require 'open-uri'   
#require 'singleton'
class Scrapper
	#include Singleton
	attr_accessor :city, :page, :url

	#include Singleton

	def initialize(new_city_name = "Toronto")
		@city = update_city(new_city_name)		
		@url = "http://www.ask.com/web?q=#{city}+weather&search=&qsrc=0&o=0&l=dir"
						#THERE IS --->   ^^^^^^^  <---- city variable.
		@page = Nokogiri::HTML(open(url))
	end

	def weather
		page.at_css(".sa_weather_temp").text
	end

	def update_url
		url= "http://www.ask.com/web?q=#{city}+weather&search=&qsrc=0&o=0&l=dir"
	end

	def update_city(new_city_name)
		city = new_city_name
	end	

end

d =  Scrapper.new("Bydgoszcz")
puts d.weather.chomp.split.join(" ")
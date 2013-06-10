require 'singleton'
require_relative 'botcore'
require_relative 'features'
class Runner

	include Singleton

	attr_accessor :core, :features

	TYPE_AREA = "\n" + "_"*20 + "\b"*20

	def initialize
		infos = Hash.new
		puts "Do you want specify server/port/channel/nick or connect default?"
		print "[D]efault / [C]ustom: " + "\n_\b"
		answer = ((gets.chomp).downcase)[0]
		case answer
		when 'd'
			@core = Bot_core.new
		when 'c'
			form = Hash.new
			print "Server adress: " + TYPE_AREA
			form[:server_adress] = gets.chomp
			print "Port (leave blank to make it 6667): " + TYPE_AREA
			port = gets.chomp
			form[:port] = port.length==0 ? 6667 : port 
 			print "Channel (I accept '#channel' or 'channel' format): " + TYPE_AREA
 			channel= gets.chomp
 			form[:channel] = channel[0] == '#' ? channel : '#' + channel
 			print "Nickname: " +TYPE_AREA
 			form[:nick] = gets.chomp
 			@core = Bot_core.new(form)
 		else 
 			puts "Coudn't understand you"
 			@core = Bot_core.new
 		end
 			puts "Loading features..."
 			@features = Features.instance
 			puts "Connecting..."
 			@core.connect
 		end

 	def run
 		puts "Connected to channel!"
 		counter = 1
 		until @core.server.eof? do 
 			msg=core.message
 			counter+=1 unless msg.start_with? ":#{bot_name}"
 			next if msg.class==NilClass || !msg.include?("#{core.channel} :!")
 			puts "\t#{bot_name}log: " + msg
 			msg.downcase!
 			if msg.include? "!weather"
 				if /\"\w+\"/ =~ msg	
	 				begin
		 				city = msg.split("\"")[1]
		 			raise "ANTY-BUG mode is activated! Wish you luck next time... :>" if city.length<2 || city==nil
		 				city[0] = city[0].upcase
		 				if weather.city_exist?(city)
		 					weather.reload(city)
		 					if msg.include?("future") || msg.include?("next") || msg.include?("tomorrow") || msg.include?("days")
		 						scope = msg.include?("tomorrow") ? 1 : 3
		 						weather.display_future(scope).each { |day| msg_send(day) }
		 					else
		 						msg_send(weather.display_today)
		 					end
		 				else
		 					msg_send("Coudnt find weather for #{city}! I'm sorry. Try again!")
		 				end
		 			rescue Exception => e
		 				msg_send(e.message)
		 			end
	 			else
	 				msg_send("*Type '!weather \"CITY NAME\"' to recive todays weather")
	 				msg_send("*Type '!weather \"CITY NAME\" today' to recive today weather")
	 				msg_send("*Type '!weather \"CITY NAME\" future/next/days/tomorrow' to recive next days weather")
 				end
 			elsif msg.include?("!time")
 				if msg.include?("!time runtime")
 					msg_send(clock.runtime)
 				elsif msg.include?("!time start")
 					msg_send(clock.display_start_time)
 				elsif msg.include?("!time now")
 					msg_send(clock.display_time_now)
 				else
 					msg_send("*Type '!time runtime' to recive runtime of #{bot_name}")
	 				msg_send("*Type '!time start' to recive date and time when #{bot_name} started working")
	 				msg_send("*Type '!time now' to recive actual date and time")
 				end
 			elsif msg.include?("!help")
 				msg_send("*Type '!time' to learn more about !time commands")
 				msg_send("*Type '!weather' to learn more about !weather commands")
 			else
 				@core.send_message("Command list - type '!help'")
 			end
 			if counter%20==0
 				msg_send("#{bot_name} " + clock.runtime)
 			end
 		end
 	end

 	private

 	def bot_name
 		@core.nick
 	end

 	def msg_send(msg)
 		@core.send_message(msg)
 	end

 	def weather
 		features.weather
 	end

 	def clock
 		features.clock
 	end

 	def channel_msg?(checking_msg)
 		core.server_msg?(checking_msg)
 	end

end


r = Runner.instance
r.run
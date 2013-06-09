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
			puts "Initialized with default parameters"
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
 			puts "Initialized with custom parameters"
 		else 
 			@core = Bot_core.new
 			puts "Coudn't understand you\nInitialized with default parameters"
 		end
 			puts "Loading features!"
 			@features = Features.instance
 			puts "Features Loaded!"
 			puts "Connecting..."
 			@core.connect
 		end

 	def run
 		counter = 0
 		until @core.eof? do
 		msg=core.message
 		if channel_msg?
 			if msg.include? "!weather"
 				city = msg.split("\"")[1]
 				msg_send(weather.reload(city))
 				msg_send(weather.display_today)
 			else
 				@core.send_message("nothing heppened")
 			end	
 		#end
 		if counter%10==0
 			msg_send(clock.runtime)
 		end
 		counter+=1
 		end
 	end

 	private

 	def msg_send(msg)
 		@core.send_message(msg)
 	end

 	def weather
 		features.weather
 	end

 	def clock
 		features.clock
 	end

 	def channel_msg?
 		core.server_msg?
 	end

end


r = Runner.instance
r.run
require 'singleton'
require_relative 'botcore'
require_relative 'features/weather'
require_relative 'features/clock'
class Runner

	include Singleton

	attr_accessor :core

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
 			puts "Connecting..."
 			@core.connect
 		end

 	def run
 		counter = 0
 		until @core.eof? do
 		msg=core.message
 		if channel_msg?
 			if msg.include? "!weather"
 				msg = msg.split("\"")[1]
 				@core.send_message(msg)
 			else
 				@core.send_message("nothing heppened")
 			end	
 		#end
 	end
 	end
 	end

 	private

 	def channel_msg?
 		core.server_msg?
 	end

end


r = Runner.instance
r.run
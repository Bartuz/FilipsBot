require 'singleton'
require_relative 'botcore'
TYPE_AREA = "_"*20 + "\b"*20
class Runner

	include 'Singleton'

	def initialize
		infos = Hash.new
		puts "Do you want specify server/port/channel/nick or connect default?"
		print "[D]efault / [C]ustom: " + "_" + "\b"
		answer = ((gets.chomp).downcase)[0]
		if answer == 'd'
			@core = Bot_core.new
		else
			form = Hash.new
			print "Server adress: " + TYPE_AREA
			form[:server] = gets.chomp
			print "Port (leave blank to make it 667): " + TYPE_AREA
			form[:port] = gets.chomp
			form[:port] = nil if form[:port].length == 0
 			print "Channel (put '#' before name of channel): " + TYPE_AREA
 			channel= gets.chomp
 			form[:channel] = channel[0] == '#' ? channel : '#' + channel
 			print "Nickname: " +TYPE_AREA
 			form[:nick] = gets.chomp
 			@core = Bot_core(form)
 		end
 		puts "Done"
 	end

end
r = Runner.instance
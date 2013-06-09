require "socket"
class Bot_core
	attr_reader :server_adress, :port, :nick ,:channel, :server

  def initialize(params = {
  		:server_adress => "chat.freenode.net",
  		:channel => "#bitmaker",
  		:port => 6667,
  		:nick => "Filip"
  	})
	  @server_adress = params[:server_adress]
	  @port =  params[:port]
      @channel = params[:channel]
      @nick = params[:nick]
      @server = TCPSocket.open(server_adress,port)
  end

  def connect
    @server.puts "USER filipsbot 0 * FilipsBot"
    @server.puts "NICK #{nick}"
    @server.puts "JOIN #{channel}"
    send_message("Filips-Bot just logged in!")
  end

  def message
      @server.gets
  end

  def server_msg?(checking_msg)
      checking_msg.include? "PRIVMSG #{channel} :"
  end

  def send_message(msg) 
    @server.puts "PRIVMSG #{@channel} :#{msg}"
  end

  private


end

 
# def channel_message?(msg)
#   msg.include?(@greeting_prefix)
# end
 
# def greeting?(msg)
#   msg.include? @greeting  
# end
# until @irc_server.eof? do
#   msg = @irc_server.gets.downcase
#   puts msg

#   # Reply to "hello"
#   if channel_message?(msg) && greeting?(msg)
#     send_message("Someone talked to us!!!! Hello!!!")
#   end
# end
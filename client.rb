#!/usr/bin/env ruby

# client

require 'socket'
require 'colorize'

userName = ARGV.shift
portNum = 2000
socket = TCPSocket.new('localhost', portNum)
socket.puts "#{userName}"

def user_typing(socket, name)
	loop do
		sleep 1 # wait 1 second so that text appears properly
		print "(#{name}) >> ".white
		message = gets.chomp
		if message == "exit" # allow user to exit the client script
			print "Exiting...\n".red
			socket.puts message
			exit(0)
		end
		socket.puts message
		
	end
end

def receive_from_server(socket, name)
	while line = socket.gets
		# Another user joins or leaves
		if (line.include? "joined!" or line.include? "left!") and !line.include? name
			print "\n"
			puts line
			print "(#{name}) >> ".white
		# The user joins or leaves
		elsif (line.include? "joined!" or line.include? "left!") and line.include? name
			puts line
		# Another user sends a message
		elsif !line.include? name
			print "\n"
			puts line
			print "(#{name}) >> ".white
		# The user sends a message
		else
			puts line
		end
	end
end


user_typing_thread = Thread.new { user_typing(socket, userName) }
receive_from_server_thread = Thread.new { receive_from_server(socket, userName) }

user_typing_thread.join
receive_from_server_thread.join

socket.close

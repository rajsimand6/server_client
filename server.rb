#!/usr/bin/env ruby

# server

require 'socket'
require 'colorize'
require 'colorized_string'

portNum = 2000
server = TCPServer.new(portNum)
puts "Ready to accept new clients on port #{portNum}"
$numUsers = 0

clients = []

# Choose colors from ColorizedString that are easy to see on dark background
$colours = Array.new(8)
$colours[0] = ColorizedString.colors[4] # green
$colours[1] = ColorizedString.colors[5] # light green
$colours[2] = ColorizedString.colors[7] # light yellow
$colours[3] = ColorizedString.colors[8] # blue
$colours[4] = ColorizedString.colors[9] # light blue
$colours[5] = ColorizedString.colors[10] # magenta
$colours[6] = ColorizedString.colors[11] # light magenta
$colours[7] = ColorizedString.colors[12] # cyan

def client_message(clients, client, userColour) # runs each time a user enters the chat
	client_name = client.gets.chomp
	client.puts "Hello #{client_name}! Users connected: #{clients.count}".yellow
	transmit_message(clients, "#{client_name} joined!", userColour)
	
	while line = client.gets
		message_from_client = line.chomp

		if message_from_client == "exit"
			break
		end

		transmit_message(clients, "#{client_name}: #{message_from_client}", userColour)
	end
	
	client.close
	clients.delete(client)
	transmit_message(clients, "#{client_name} left!", userColour)
end
	

def transmit_message(clients, text, userColour)
	i = 0
	clients.each_with_index do |client|
		client.puts text.colorize(userColour)
	end
end

j = 0
loop do # runs each time a user enters the chat
	client = server.accept
	clients << client
	$numUsers = $numUsers + 1
	
	# assign a colour for each new user
	if j > $colours.length
		userColour = $colours[-1]
	else
		userColour = $colours[j]
	end
	
	Thread.new {
		client_message(clients, client, userColour)
	}
	
	j = j+1
end

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

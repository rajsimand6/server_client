#!/usr/bin/env ruby

# client

require 'socket'
require 'colorize'

userName = ARGV.shift
portNum = 2000
socket = TCPSocket.new('localhost', portNum)
socket.puts "#{userName}"

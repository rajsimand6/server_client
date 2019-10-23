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

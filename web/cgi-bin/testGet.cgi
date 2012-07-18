#!/usr/bin/ruby

require 'cgi'

cgi = CGI.new

name = cgi['subtitleName']
type = cgi['submit']
file = cgi['file']

filename = name.read + "." + type.read

puts "Content-Type: application/octet-stream"
puts "Content-Disposition: filename=" + filename
puts
puts file.original_filename

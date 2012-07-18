#!/usr/bin/ruby

require "cgi"
require "subtitle"

cgi = CGI.new
file = cgi['file']

subtitle = SubtitleFile.import_srt_web(file)
exportedSubtitle = SubtitleFile.export_srt_web(subtitle)

puts "Content-type: text/html"
puts
puts exportedSubtitle

#!/usr/bin/ruby

require "cgi"
require "subtitle.rb"

cgi = CGI.new

name = cgi['subtitleName']
type = cgi['submit']
file = cgi['file']
ssa_title = cgi['ssaTitle']
ssa_play_res_y = cgi['ssaPlayResY']
ssa_play_res_x = cgi['ssaPlayResX']


# TODO: Check if file is valid

# Determine file name to export as
filename = name.read
error_message = false
import_filetype = file.original_filename.slice(file.original_filename.length-4,4)
submit_type = type.read

if filename == ""
	filename = file.original_filename
	filename.slice!(filename.length-4,4)
end

filename += "." + submit_type

case import_filetype
when ".srt"
    subtitle = SubtitleFile.import_srt_web(file)
when ".ssa"
    subtitle = SubtitleFile.import_ssa_web(file)
when ".ass"
    subtitle = SubtitleFile.import_ssa_web(file)
else
    error_message = true
end

unless error_message
    case submit_type
    when "srt"
      exportedSubtitle = SubtitleFile.export_srt_web(subtitle)
    when "ssa"
    	# TODO: If import_filetype == ".srt" then add mandatory SSA info, else, if SSA/ASS Options are not blank, change them to the new value
      exportedSubtitle = SubtitleFile.export_ssa_web(subtitle)
    end
end

unless error_message
    # Give the user what he/she wants
    puts "Content-Type: application/octet-stream"
    puts 'Content-Disposition: filename="' + filename + '"'
    puts
    puts exportedSubtitle
else
    puts "Content-type: text/html"
    puts
    puts "Well, that didn't work."
end



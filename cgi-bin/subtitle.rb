load "subtitle_file.rb"
load "subtitle_info.rb"
load "subtitle_line.rb"
load "subtitle_style.rb"
load "subtitle_time.rb"

class Subtitle
  attr_accessor :line, :info, :style, :type, :line_total, :style_format, :event_format, :debug
  
  def initialize()
    @line = []
  end
  
end

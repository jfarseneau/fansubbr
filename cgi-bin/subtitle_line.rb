=begin
  This class contains that will be displayed in the subtitles
=end

class SubtitleLine
  
  attr_accessor :number, :text, :start_time, :end_time, :marked, :style, :character_name,
  :margin_l, :margin_r, :margin_v, :transition_effect, :comment, :picture, :sound,
  :movie, :command, :layer, :debug
  
  def initialize()
    
  end
  
  # Checks to see whether this is a text line, or a picture, sound, movie or command
  # event in SSA/ASS.
  def is_text?()
    if picture || sound || movie || command
      false
    end
  end
  
  def to_srt()
    newline = "\r\n"
    parsed_text = strip_codes(@text)
    
    @number.to_s + newline + 
    @start_time.to_srt() + " --> " + @end_time.to_srt() + newline + 
    parsed_text + 
    newline
  end
  
  def to_ssa(format)
    to_ssa_ass(format)
  end
  
  def to_ass(format)
    to_ssa_ass(format)
  end
  
  private
  
  def to_ssa_ass(format)
    line_text = "Dialogue: "
    format.each do |format_data|
      case format_data
      when "Layer"
        line_text += @layer + "," unless @layer == nil
        line_text += "," if @layer == nil
      when "Start"
        line_text += @start_time.to_ssa() + "," unless @start_time == nil
        line_text += "," if @start_time == nil
      when "End"
        line_text += @end_time.to_ssa() + "," unless @end_time == nil
        line_text += "," if @end_time == nil
      when "Style"
        line_text += @style + "," unless @style == nil
        line_text += "," if @style == nil
      when "Name"
        line_text += @name + "," unless @name == nil
        line_text += "," if @name == nil
      when "MarginL"
        line_text += @margin_l + "," unless @margin_l == nil
        line_text += "," if @margin_l == nil
      when "MarginR"
        line_text += @margin_r + "," unless @margin_r == nil
        line_text += "," if @margin_r == nil
      when "MarginV"
        line_text += @margin_v + "," unless @margin_v == nil
        line_text += "," if @margin_v == nil
      when "Effect"
        line_text += @effect + "," unless @effect == nil
        line_text += "," if @effect == nil
      when "Text\r\n"
        line_text += @text + "," unless @text == nil
        line_text += "," if @text == nil
      end
    end
    
    # Remove the last ","
    line_text.slice!(line_text.length-1,1)    
    line_text
  end
  
  private
  def strip_codes(text)
    text_raw = text
    # Strip { } codes
    if text_raw.scan(/\{/) != []
      text_raw.scan(/\{/).each do
        text_raw.slice!(text_raw.index("{"), text_raw.index("}")-text_raw.index("{")+1)
      end
    end
    
    text_raw
  end
  
end

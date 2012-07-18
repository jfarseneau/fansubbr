=begin
  This class contains things like credits and so forth
=end

class SubtitleInfo

  ###########################################################
  # Definition of Attributes                                #
  ###########################################################
  #
  #
  
  attr_accessor :title, :comment, :original_author, :original_translator,
  :original_editing, :original_timing, :synch_point, :updated_by, :update_details,
  :ssa_script_type, :collisions, :play_res_y, :play_res_x, :play_depth, :timer_speed,
  :wrap_style, :info_comments
  
  def initialize()
    @title = "Default Name"
    @original_author = ""
    @original_translator = ""
    @original_editing = ""
    @original_timing = ""
    @synch_point = ""
    @updated_by = ""
    @ssa_script_type = ""
    @collisions = ""
    @play_res_y = ""
    @play_res_x = ""
    @play_depth = ""
    @timer_speed = ""
    @wrap_style = ""
  end

  def to_ssa()
    newline = "\r\n"
    script_info = "[Script Info]" + newline
    script_info += @info_comments unless @info_comments == ""
    script_info += "Title: " + @title + newline unless @title == ""
    script_info += "Original Script: " + @original_author + newline unless @original_author == ""
    script_info += "Original Translation: " + @original_translator + newline unless @original_translator == ""
    script_info += "Original Editing: " + @original_editing + newline unless @original_editing == ""
    script_info += "Original Timing: " + @original_timing + newline unless @original_timing == ""
    script_info += "Synch Point: " + @synch_point + newline unless @synch_point == ""
    script_info += "Script Updated By: " + @updated_by + newline unless @updated_by == ""
    script_info += "ScriptType: " + @ssa_script_type + newline unless @ssa_script_type == ""
    script_info += "Collisions: " + @collisions + newline unless @collisions == ""
    script_info += "PlayResY: " + @play_res_y + newline unless @play_res_y == ""
    script_info += "PlayResX: " + @play_res_x + newline unless @play_res_x == ""
    script_info += "PlayDepth: " + @play_depth + newline unless @play_depth == ""
    script_info += "Timer: " + @timer_speed + newline unless @timer_speed == ""
    script_info += "WrapStyle: " + @wrap_style + newline unless @wrap_style == ""
    
    script_info
  end
end

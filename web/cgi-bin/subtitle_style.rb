=begin
  This class is mostly for SSA, it deals with style
  format
=end

class SubtitleStyle
  
  ###########################################################
  # Definition of Attributes                                #
  ###########################################################
  # name              [SSA, ASS]      
  # = Name of the style
  # font_name         [SSA, ASS]      
  # = The name of the font for the subtitle
  # font_size         [SSA, ASS]      
  # = The size of the font for the subtitle
  # primary_colour    [SSA, ASS]      
  # = 
  # secondary_colour  [SSA, ASS]      
  # = 
  # tertiary_colour   [SSA]           
  # = 
  #                   [ASS]           
  # = Becomes OutlineColor, for the outline of the subtitle
  # back_colour       [SSA, ASS]      
  # = Background colour for the subtitle
  # bold              [SSA, ASS]      
  # = 
  # italic            [SSA, ASS]      
  # =
  # underline         [SSA, ASS]      
  # =
  # strikeout         [SSA, ASS]      
  # =
  # scale_x           [SSA, ASS]      
  # =
  # scale_y           [SSA, ASS]      
  # =
  # spacing           [SSA, ASS]      
  # =
  # angle             [SSA, ASS]      
  # =
  # border_style      [SSA, ASS]      
  # =
  # outline           [SSA, ASS]      
  # =
  # shadow            [SSA, ASS]      
  # =
  # text_align        [SSA, ASS, SMI] 
  # = Text alignment, as in left, right, centre, justify
  # margin_l          [SSA, ASS]      
  # =
  # margin_r          [SSA, ASS]      
  # =
  # margin_v          [SSA, ASS]
  # =
  # alpha_level       [SSA, ASS]
  # =
  # encoding          [SSA, ASS]
  # =
  #
  
  attr_accessor :name, :font_name, :font_size, :primary_colour, 
  :secondary_colour, :tertiary_colour, :back_colour, :bold, 
  :italic, :underline, :strikeout, :scale_x, :scale_y, :spacing, 
  :angle, :border_style, :outline, :shadow, :text_align, :margin_l, 
  :margin_r, :margin_v, :alpha_level, :encoding
  
  def initialize()
    
  end
  
  def to_ssa(format)
    style_data = "Style: "
    
    format.each do |format_data|
      case format_data
      when "Name"
        style_data += @name + "," unless @name == nil
      when "Fontname"
        style_data += @font_name + "," unless @font_name == nil
      when "Fontsize"
        style_data += @font_size + "," unless @font_size == nil
      when "PrimaryColour"
        style_data += @primary_colour + "," unless @primary_colour == nil
      when "SecondaryColour"
        style_data += @secondary_colour + "," unless @secondary_colour == nil
      when "TertiaryColour"
        style_data += @tertiary_colour + "," unless @tertiary_colour == nil
      when "OutlineColour"
        style_data += @tertiary_colour + "," unless @tertiary_colour == nil
      when "BackColour"
        style_data += @back_colour + "," unless @back_colour == nil
      when "Bold"
        style_data += @bold + "," unless @bold == nil
      when "Italic"
        style_data += @italic + "," unless @italic == nil
      when "Underline"
        style_data += @underline + "," unless @underline == nil
      when "StrikeOut"
        style_data += @strikeout + "," unless @strikeout == nil
      when "ScaleX"
        style_data += @scale_x + "," unless @scale_x == nil
      when "ScaleY"
        style_data += @scale_y + "," unless @scale_y == nil
      when "Spacing"
        style_data += @spacing + "," unless @spacing == nil
      when "Angle"
        style_data += @angle + "," unless @angle == nil
      when "BorderStyle"
        style_data += @border_style + "," unless @border_style == nil
      when "Outline"
        style_data += @outline + "," unless @outline == nil
      when "Shadow"
        style_data += @shadow + "," unless @shadow == nil
      when "Alignment"
        style_data += @text_align + "," unless @text_align == nil
      when "MarginL"
        style_data += @margin_l + "," unless @margin_l == nil
      when "MarginR"
        style_data += @margin_r + "," unless @margin_r == nil
      when "MarginV"
        style_data += @margin_v + "," unless @margin_v == nil
      when "AlphaLevel"
        style_data += @alpha_level + "," unless @alpha_level == nil
      when "Encoding\r\n"
        style_data += @encoding + "," unless @encoding == nil
      end
    end
      
    # Remove the last ","
    style_data.slice!(style_data.length-1,1)
    style_data
  end
   
end

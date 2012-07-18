=begin
  This takes care of the file operations like importing and exporting subtitle files
=end

class SubtitleFile

  # Header Length Constants
  COMMENT_LENGTH = 1
  TITLE_LENGTH = 6
  ORIGINAL_SCRIPT_LENGTH = 16
  ORIGINAL_TRANSLATOR_LENGTH = 21
  ORIGINAL_EDITING_LENGTH = 17
  ORIGINAL_TIMING_LENGTH = 16
  SYNCH_POINT_LENGTH = 12
  UPDATED_BY_LENGTH = 18
  UPDATE_DETAILS_LENGTH = 15
  SSA_SCRIPT_TYPE_LENGTH = 11
  COLLISIONS_LENGTH = 11
  PLAY_RES_Y_LENGTH = 9
  PLAY_RES_X_LENGTH = 9
  PLAY_DEPTH_LENGTH = 10
  TIMER_SPEED_LENGTH = 6
  WRAP_STYLE_LENGTH = 10
  FORMAT_LENGTH = 7
  STYLE_LENGTH = 6
  DIALOGUE_LENGTH = 9
  
  # Import an SSA file
  def SubtitleFile.import_ssa(file)
    line_array = []
    style_array = []
    format_array = []
    dialogue_line = []
    style_number = 0
    dialogue_number = 0
    
    subtitle_object = Subtitle.new()
    subtitle_info = SubtitleInfo.new()
    subtitle_style = []
    subtitle_dialogue = []
    
    subtitle_info.info_comments = ""
    
    
    File.open(file, 'r') do |infile|
      while infile.gets
        
        
        # [Script Info] Section
        if $_.scan(/\[Script Info\]/) == ["[Script Info]"]
          section = 0
        elsif $_.slice(0,COMMENT_LENGTH) == ";"  && section == 0
          subtitle_info.info_comments += $_
        elsif $_.slice(0,TITLE_LENGTH) == "Title:" && section == 0
          subtitle_info.title = SubtitleFile.parse_ssa_info($_, TITLE_LENGTH) 
        elsif $_.slice(0,ORIGINAL_SCRIPT_LENGTH) == "Original Script:" && section == 0
          subtitle_info.original_author = SubtitleFile.parse_ssa_info($_, ORIGINAL_SCRIPT_LENGTH)
        elsif $_.slice(0,ORIGINAL_TRANSLATOR_LENGTH) == "Original Translation:" && section == 0
          subtitle_info.original_translator = SubtitleFile.parse_ssa_info($_, ORIGINAL_TRANSLATOR_LENGTH)
        elsif $_.slice(0,ORIGINAL_EDITING_LENGTH) == "Original Editing:" && section == 0
          subtitle_info.original_editing = SubtitleFile.parse_ssa_info($_, ORIGINAL_EDITING_LENGTH)
        elsif $_.slice(0,ORIGINAL_TIMING_LENGTH) == "Original Timing:" && section == 0
          subtitle_info.original_timing = SubtitleFile.parse_ssa_info($_, ORIGINAL_TIMING_LENGTH)
        elsif $_.slice(0,SYNCH_POINT_LENGTH) == "Synch Point:" && section == 0
          subtitle_info.synch_point = SubtitleFile.parse_ssa_info($_, SYNCH_POINT_LENGTH)
        elsif $_.slice(0,UPDATED_BY_LENGTH) == "Script Updated By:" && section == 0
          subtitle_info.updated_by = SubtitleFile.parse_ssa_info($_, UPDATED_BY_LENGTH)
        elsif $_.slice(0,UPDATE_DETAILS_LENGTH) == "Update Details:" && section == 0
          subtitle_info.update_details = SubtitleFile.parse_ssa_info($_, UPDATE_DETAILS_LENGTH)
        elsif $_.slice(0,SSA_SCRIPT_TYPE_LENGTH) == "ScriptType:" && section == 0
          subtitle_info.ssa_script_type = SubtitleFile.parse_ssa_info($_, SSA_SCRIPT_TYPE_LENGTH)
        elsif $_.slice(0,COLLISIONS_LENGTH) == "Collisions:" && section == 0
          subtitle_info.collisions = SubtitleFile.parse_ssa_info($_, COLLISIONS_LENGTH)
        elsif $_.slice(0,PLAY_RES_Y_LENGTH) == "PlayResY:" && section == 0
          subtitle_info.play_res_y = SubtitleFile.parse_ssa_info($_, PLAY_RES_Y_LENGTH)
        elsif $_.slice(0,PLAY_RES_X_LENGTH) == "PlayResX:" && section == 0
          subtitle_info.play_res_x = SubtitleFile.parse_ssa_info($_, PLAY_RES_X_LENGTH)
        elsif $_.slice(0,PLAY_RES_Y_LENGTH) == "PlayResY:" && section == 0
          subtitle_info.play_res_y = SubtitleFile.parse_ssa_info($_, PLAY_RES_Y_LENGTH) 
        elsif $_.slice(0,PLAY_DEPTH_LENGTH) == "PlayDepth:" && section == 0
          subtitle_info.play_depth = SubtitleFile.parse_ssa_info($_, PLAY_DEPTH_LENGTH)
        elsif $_.slice(0,TIMER_SPEED_LENGTH) == "Timer:" && section == 0
          subtitle_info.timer_speed = SubtitleFile.parse_ssa_info($_, TIMER_SPEED_LENGTH)
        elsif $_.slice(0,WRAP_STYLE_LENGTH) == "WrapStyle:" && section == 0
          subtitle_info.wrap_style = SubtitleFile.parse_ssa_info($_, WRAP_STYLE_LENGTH)           
        #if end
        end
        
        # [Style] Section
        if $_.scan(/\[V4 Styles\]/) == ["[V4 Styles]"]
          section = 1
          subtitle_object.type = "SSA"
        elsif $_.scan(/\[V4\+ Styles\]/) == ["[V4+ Styles]"]
          section = 1
          subtitle_object.type = "ASS"
        elsif $_.slice(0,FORMAT_LENGTH) == "Format:"  && section == 1
          format_array = SubtitleFile.parse_ssa_data($_, FORMAT_LENGTH)
          subtitle_object.style_format = format_array
        elsif $_.slice(0,STYLE_LENGTH) == "Style:"  && section == 1  
          style_array = SubtitleFile.parse_ssa_data($_, STYLE_LENGTH)
          
          i = 0
          subtitle_style += [SubtitleStyle.new]
          
          format_array.each do |format|
            
            case format
            when "Name"
              subtitle_style[style_number].name = style_array[i]
            when "Fontname"
              subtitle_style[style_number].font_name = style_array[i]
            when "Fontsize"
              subtitle_style[style_number].font_size = style_array[i]
            when "PrimaryColour"
              subtitle_style[style_number].primary_colour = style_array[i]
            when "SecondaryColour"
              subtitle_style[style_number].secondary_colour = style_array[i]
            when "TertiaryColour"
              subtitle_style[style_number].tertiary_colour = style_array[i]
            when "OutlineColor"
              subtitle_style[style_number].tertiary_colour = style_array[i]
            when "OutlineColour"
              subtitle_style[style_number].tertiary_colour = style_array[i]
            when "BackColour"
              subtitle_style[style_number].back_colour = style_array[i]
            when "Bold"
              subtitle_style[style_number].bold = style_array[i]
            when "Italic"
              subtitle_style[style_number].italic = style_array[i]
            when "Underline"
              subtitle_style[style_number].underline = style_array[i]
            when "StrikeOut"
              subtitle_style[style_number].strikeout = style_array[i]
            when "ScaleX"
              subtitle_style[style_number].scale_x = style_array[i]
            when "ScaleY"
              subtitle_style[style_number].scale_y = style_array[i]
            when "Spacing"
              subtitle_style[style_number].spacing = style_array[i]
            when "Angle"
              subtitle_style[style_number].angle = style_array[i]
            when "BorderStyle"
              subtitle_style[style_number].border_style = style_array[i]
            when "Outline"
              subtitle_style[style_number].outline = style_array[i]
            when "Shadow"
              subtitle_style[style_number].shadow = style_array[i]
            when "Alignment"
              subtitle_style[style_number].text_align = style_array[i]
            when "MarginL"
              subtitle_style[style_number].margin_l = style_array[i]
            when "MarginR"
              subtitle_style[style_number].margin_r = style_array[i]
            when "MarginV"
              subtitle_style[style_number].margin_v = style_array[i]
            when "AlphaLevel"
              subtitle_style[style_number].alpha_level = style_array[i]
            when "Encoding\r\n"
              subtitle_style[style_number].encoding = style_array[i]
            #case end
            end
            i += 1
          #do end
          end
          
          style_number += 1
        #if end
        end
        
        # [Events] Section
        if $_.scan(/\[Events\]/) == ["[Events]"]
          section = 2
        elsif $_.slice(0,FORMAT_LENGTH) == "Format:" && section == 2
          dialogue_format = SubtitleFile.parse_ssa_data($_, FORMAT_LENGTH)
          subtitle_object.event_format = dialogue_format
        elsif $_.slice(0,DIALOGUE_LENGTH) == "Dialogue:" && section == 2
          dialogue_line = SubtitleFile.parse_ssa_dialogue($_, dialogue_format, DIALOGUE_LENGTH)
          
          i = -1
          subtitle_dialogue[dialogue_number] = SubtitleLine.new
          subtitle_dialogue[dialogue_number].number = dialogue_number + 1
          
          dialogue_format.each do |format|
            i += 1
  
            case format
            when "Layer"
              subtitle_dialogue[dialogue_number].layer = dialogue_line[i]
            when "Marked"
              subtitle_dialogue[dialogue_number].marked = dialogue_line[i]
            when "Start"
              subtitle_dialogue[dialogue_number].start_time = SubtitleTime.new(dialogue_line[i].slice(0,1).to_i, dialogue_line[i].slice(2,2).to_i, dialogue_line[i].slice(5,2).to_i, dialogue_line[i].slice(8,2).to_i)
            when "End"
              subtitle_dialogue[dialogue_number].end_time = SubtitleTime.new(dialogue_line[i].slice(0,1).to_i, dialogue_line[i].slice(2,2).to_i, dialogue_line[i].slice(5,2).to_i, dialogue_line[i].slice(8,2).to_i)
            when "Style"
              subtitle_dialogue[dialogue_number].style = dialogue_line[i]
            when "Name"
              subtitle_dialogue[dialogue_number].character_name = dialogue_line[i]
            when "MarginL"
              subtitle_dialogue[dialogue_number].margin_l = dialogue_line[i]
            when "MarginR"
              subtitle_dialogue[dialogue_number].margin_r = dialogue_line[i]
            when "MarginV"
              subtitle_dialogue[dialogue_number].margin_v = dialogue_line[i]
            when "Effect"
              subtitle_dialogue[dialogue_number].transition_effect = dialogue_line[i]
            when "Text\r\n"
              subtitle_dialogue[dialogue_number].text = dialogue_line[i].gsub(/\\N/, "\n")
            #case end
            end
            
            
          #do end
          end
          
          dialogue_number += 1
        #if end
        end
      #while end
      end
    #file end
    end      
    
    subtitle_object.line_total = dialogue_number + 1
    subtitle_object.style = subtitle_style
    subtitle_object.line = subtitle_dialogue
    subtitle_object.info = subtitle_info
    subtitle_object
  #def end
  end
  
    # Import an SSA file
  def SubtitleFile.import_ssa_web(file)
    line_array = []
    style_array = []
    format_array = []
    dialogue_line = []
    style_number = 0
    dialogue_number = 0
    
    subtitle_object = Subtitle.new()
    subtitle_info = SubtitleInfo.new()
    subtitle_style = []
    subtitle_dialogue = []
    
    subtitle_info.info_comments = ""
    
    file_path = file.path()
    
    
    File.open(file_path, 'r') do |infile|
      while infile.gets
        
        
        # [Script Info] Section
        if $_.scan(/\[Script Info\]/) == ["[Script Info]"]
          section = 0
        elsif $_.slice(0,COMMENT_LENGTH) == ";"  && section == 0
          subtitle_info.info_comments += $_
        elsif $_.slice(0,TITLE_LENGTH) == "Title:" && section == 0
          subtitle_info.title = SubtitleFile.parse_ssa_info($_, TITLE_LENGTH) 
        elsif $_.slice(0,ORIGINAL_SCRIPT_LENGTH) == "Original Script:" && section == 0
          subtitle_info.original_author = SubtitleFile.parse_ssa_info($_, ORIGINAL_SCRIPT_LENGTH)
        elsif $_.slice(0,ORIGINAL_TRANSLATOR_LENGTH) == "Original Translation:" && section == 0
          subtitle_info.original_translator = SubtitleFile.parse_ssa_info($_, ORIGINAL_TRANSLATOR_LENGTH)
        elsif $_.slice(0,ORIGINAL_EDITING_LENGTH) == "Original Editing:" && section == 0
          subtitle_info.original_editing = SubtitleFile.parse_ssa_info($_, ORIGINAL_EDITING_LENGTH)
        elsif $_.slice(0,ORIGINAL_TIMING_LENGTH) == "Original Timing:" && section == 0
          subtitle_info.original_timing = SubtitleFile.parse_ssa_info($_, ORIGINAL_TIMING_LENGTH)
        elsif $_.slice(0,SYNCH_POINT_LENGTH) == "Synch Point:" && section == 0
          subtitle_info.synch_point = SubtitleFile.parse_ssa_info($_, SYNCH_POINT_LENGTH)
        elsif $_.slice(0,UPDATED_BY_LENGTH) == "Script Updated By:" && section == 0
          subtitle_info.updated_by = SubtitleFile.parse_ssa_info($_, UPDATED_BY_LENGTH)
        elsif $_.slice(0,UPDATE_DETAILS_LENGTH) == "Update Details:" && section == 0
          subtitle_info.update_details = SubtitleFile.parse_ssa_info($_, UPDATE_DETAILS_LENGTH)
        elsif $_.slice(0,SSA_SCRIPT_TYPE_LENGTH) == "ScriptType:" && section == 0
          subtitle_info.ssa_script_type = SubtitleFile.parse_ssa_info($_, SSA_SCRIPT_TYPE_LENGTH)
        elsif $_.slice(0,COLLISIONS_LENGTH) == "Collisions:" && section == 0
          subtitle_info.collisions = SubtitleFile.parse_ssa_info($_, COLLISIONS_LENGTH)
        elsif $_.slice(0,PLAY_RES_Y_LENGTH) == "PlayResY:" && section == 0
          subtitle_info.play_res_y = SubtitleFile.parse_ssa_info($_, PLAY_RES_Y_LENGTH)
        elsif $_.slice(0,PLAY_RES_X_LENGTH) == "PlayResX:" && section == 0
          subtitle_info.play_res_x = SubtitleFile.parse_ssa_info($_, PLAY_RES_X_LENGTH)
        elsif $_.slice(0,PLAY_RES_Y_LENGTH) == "PlayResY:" && section == 0
          subtitle_info.play_res_y = SubtitleFile.parse_ssa_info($_, PLAY_RES_Y_LENGTH) 
        elsif $_.slice(0,PLAY_DEPTH_LENGTH) == "PlayDepth:" && section == 0
          subtitle_info.play_depth = SubtitleFile.parse_ssa_info($_, PLAY_DEPTH_LENGTH)
        elsif $_.slice(0,TIMER_SPEED_LENGTH) == "Timer:" && section == 0
          subtitle_info.timer_speed = SubtitleFile.parse_ssa_info($_, TIMER_SPEED_LENGTH)
        elsif $_.slice(0,WRAP_STYLE_LENGTH) == "WrapStyle:" && section == 0
          subtitle_info.wrap_style = SubtitleFile.parse_ssa_info($_, WRAP_STYLE_LENGTH)           
        #if end
        end
        
        # [Style] Section
        if $_.scan(/\[V4 Styles\]/) == ["[V4 Styles]"]
          section = 1
          subtitle_object.type = "SSA"
        elsif $_.scan(/\[V4\+ Styles\]/) == ["[V4+ Styles]"]
          section = 1
          subtitle_object.type = "ASS"
        elsif $_.slice(0,FORMAT_LENGTH) == "Format:"  && section == 1
          format_array = SubtitleFile.parse_ssa_data($_, FORMAT_LENGTH)
          subtitle_object.style_format = format_array
        elsif $_.slice(0,STYLE_LENGTH) == "Style:"  && section == 1  
          style_array = SubtitleFile.parse_ssa_data($_, STYLE_LENGTH)
          
          i = 0
          subtitle_style += [SubtitleStyle.new]
          
          format_array.each do |format|
            
            case format
            when "Name"
              subtitle_style[style_number].name = style_array[i]
            when "Fontname"
              subtitle_style[style_number].font_name = style_array[i]
            when "Fontsize"
              subtitle_style[style_number].font_size = style_array[i]
            when "PrimaryColour"
              subtitle_style[style_number].primary_colour = style_array[i]
            when "SecondaryColour"
              subtitle_style[style_number].secondary_colour = style_array[i]
            when "TertiaryColour"
              subtitle_style[style_number].tertiary_colour = style_array[i]
            when "OutlineColor"
              subtitle_style[style_number].tertiary_colour = style_array[i]
            when "OutlineColour"
              subtitle_style[style_number].tertiary_colour = style_array[i]
            when "BackColour"
              subtitle_style[style_number].back_colour = style_array[i]
            when "Bold"
              subtitle_style[style_number].bold = style_array[i]
            when "Italic"
              subtitle_style[style_number].italic = style_array[i]
            when "Underline"
              subtitle_style[style_number].underline = style_array[i]
            when "StrikeOut"
              subtitle_style[style_number].strikeout = style_array[i]
            when "ScaleX"
              subtitle_style[style_number].scale_x = style_array[i]
            when "ScaleY"
              subtitle_style[style_number].scale_y = style_array[i]
            when "Spacing"
              subtitle_style[style_number].spacing = style_array[i]
            when "Angle"
              subtitle_style[style_number].angle = style_array[i]
            when "BorderStyle"
              subtitle_style[style_number].border_style = style_array[i]
            when "Outline"
              subtitle_style[style_number].outline = style_array[i]
            when "Shadow"
              subtitle_style[style_number].shadow = style_array[i]
            when "Alignment"
              subtitle_style[style_number].text_align = style_array[i]
            when "MarginL"
              subtitle_style[style_number].margin_l = style_array[i]
            when "MarginR"
              subtitle_style[style_number].margin_r = style_array[i]
            when "MarginV"
              subtitle_style[style_number].margin_v = style_array[i]
            when "AlphaLevel"
              subtitle_style[style_number].alpha_level = style_array[i]
            when "Encoding\r\n"
              subtitle_style[style_number].encoding = style_array[i]
            #case end
            end
            i += 1
          #do end
          end
          
          style_number += 1
        #if end
        end
        
        # [Events] Section
        if $_.scan(/\[Events\]/) == ["[Events]"]
          section = 2
        elsif $_.slice(0,FORMAT_LENGTH) == "Format:" && section == 2
          dialogue_format = SubtitleFile.parse_ssa_data($_, FORMAT_LENGTH)
          subtitle_object.event_format = dialogue_format
        elsif $_.slice(0,DIALOGUE_LENGTH) == "Dialogue:" && section == 2
          dialogue_line = SubtitleFile.parse_ssa_dialogue($_, dialogue_format, DIALOGUE_LENGTH)
          
          i = -1
          subtitle_dialogue[dialogue_number] = SubtitleLine.new
          subtitle_dialogue[dialogue_number].number = dialogue_number + 1
          
          dialogue_format.each do |format|
            i += 1
  
            case format
            when "Layer"
              subtitle_dialogue[dialogue_number].layer = dialogue_line[i]
            when "Marked"
              subtitle_dialogue[dialogue_number].marked = dialogue_line[i]
            when "Start"
              subtitle_dialogue[dialogue_number].start_time = SubtitleTime.new(dialogue_line[i].slice(0,1).to_i, dialogue_line[i].slice(2,2).to_i, dialogue_line[i].slice(5,2).to_i, dialogue_line[i].slice(8,2).to_i)
            when "End"
              subtitle_dialogue[dialogue_number].end_time = SubtitleTime.new(dialogue_line[i].slice(0,1).to_i, dialogue_line[i].slice(2,2).to_i, dialogue_line[i].slice(5,2).to_i, dialogue_line[i].slice(8,2).to_i)
            when "Style"
              subtitle_dialogue[dialogue_number].style = dialogue_line[i]
            when "Name"
              subtitle_dialogue[dialogue_number].character_name = dialogue_line[i]
            when "MarginL"
              subtitle_dialogue[dialogue_number].margin_l = dialogue_line[i]
            when "MarginR"
              subtitle_dialogue[dialogue_number].margin_r = dialogue_line[i]
            when "MarginV"
              subtitle_dialogue[dialogue_number].margin_v = dialogue_line[i]
            when "Effect"
              subtitle_dialogue[dialogue_number].transition_effect = dialogue_line[i]
            when "Text\r\n"
              subtitle_dialogue[dialogue_number].text = dialogue_line[i].gsub(/\\N/, "\n")
            #case end
            end
            
            
          #do end
          end
          
          dialogue_number += 1
        #if end
        end
      #while end
      end
    #file end
    end      
    
    subtitle_object.line_total = dialogue_number + 1
    subtitle_object.style = subtitle_style
    subtitle_object.line = subtitle_dialogue
    subtitle_object.info = subtitle_info
    subtitle_object
  #def end
  end
  
  # Import an SRT file
  def SubtitleFile.import_srt(file)
    line_counter = 0
    line_array = []
    line_number = 0
    
    # TODO: Check if file exists
    File.open(file, 'r') do |infile|
      while infile.gets
        
        # Create array object and parse line number, and init line text
        # Also skip over blank lines at the beginning of the file
        if line_counter == 0 && scan(/^$/) == [] && $_.to_i != 0
          line_array += [SubtitleLine.new]
          line_number = $_.to_i()
          array_number = line_number - 1
          line_array[array_number].number = line_number
          line_array[array_number].text = ""
          line_counter = 1
          
          # Parse time code into start time and end time
        elsif line_counter == 1
          line_array[array_number].start_time = SubtitleTime.new($_[0,2].to_i,$_[3,2].to_i,$_[6,2].to_i,$_[9,3].to_i)
          line_array[array_number].end_time = SubtitleTime.new($_[17,2].to_i,$_[20,2].to_i,$_[23,2].to_i,$_[26,3].to_i)
          line_counter = 2
          
          # Reset the line counter when it hits an empty line
        elsif line_counter == 2 && scan(/^\r\n/) != []
          line_counter = 0
          
          # Parse the line text
        elsif line_counter == 2
          line_array[array_number].text += $_
        else
          line_array[array_number].text += $_
        end
      end  
    end
    puts 'Imported file "' + file + '" succesfully.'
    
    subtitle_object = Subtitle.new()
    subtitle_object.line = line_array
    subtitle_object.type = "SRT"
    subtitle_object.line_total = line_number
    
    subtitle_object
  end
  
  def SubtitleFile.export_ssa(subtitle_object, file)
    # TODO: Export stuff
  end
  
  # Exports a Subtitle object to an SRT formatted file
  def SubtitleFile.export_srt(subtitle_object, file)
    out_file = File.open(file, 'w')
    
    subtitle_object.line.each do |subtitle_line|
      out_file.write subtitle_line.to_srt()
    end
    out_file.close()
    
    puts 'Subtitle succesfully exported to "' + file + '"'
  end
  
  # Exports a Subtitle object to an SRT formatted string for web export
  def SubtitleFile.export_srt_web(subtitle_object)
    out_file = ""
    
    subtitle_object.line.each do |subtitle_line|
      out_file += subtitle_line.to_srt()
    end
    
    out_file
  end
  
  def SubtitleFile.debug_import_srt(file)
    line_counter = 0
    
    File.open(file, 'r') do |infile|
      while infile.gets
        
        # Create array object and parse line number, and init line text
        # Also skip over blank lines at the beginning of the file
        if line_counter == 0 && scan(/^$/) == [] && $_.to_i != 0
          print "Line Number: " + $_
          line_counter = 1
          
          # Parse time code into start time and end time
        elsif line_counter == 1
          print "Time Code: " + $_
          line_counter = 2
          
          # Reset the line counter when it hits an empty line
        elsif line_counter == 2 && scan(/^\r\n/) != []
          print "Empty Line" + $_
          line_counter = 0
          
          # Parse the line text
        elsif line_counter == 2
          print "Line Text: " + $_
        else
          print "Line Text: " + $_
        end
      end  
    end
    puts 'Debug import of file "' + file + '" done.'
  end
  
    # Import an SRT file
  def SubtitleFile.import_srt(file)
    line_counter = 0
    line_array = []
    line_number = 0
    
    # TODO: Check if file exists
    File.open(file, 'r') do |infile|
      while infile.gets
        
        # Create array object and parse line number, and init line text
        # Also skip over blank lines at the beginning of the file
        if line_counter == 0 && scan(/^$/) == [] && $_.to_i != 0
          line_array += [SubtitleLine.new]
          line_number = $_.to_i()
          array_number = line_number - 1
          line_array[array_number].number = line_number
          line_array[array_number].text = ""
          line_counter = 1
          
          # Parse time code into start time and end time
        elsif line_counter == 1
          line_array[array_number].start_time = SubtitleTime.new($_[0,2].to_i,$_[3,2].to_i,$_[6,2].to_i,$_[9,3].to_i)
          line_array[array_number].end_time = SubtitleTime.new($_[17,2].to_i,$_[20,2].to_i,$_[23,2].to_i,$_[26,3].to_i)
          line_counter = 2
          
          # Reset the line counter when it hits an empty line
        elsif line_counter == 2 && scan(/^\r\n/) != []
          line_counter = 0
          
          # Parse the line text
        elsif line_counter == 2
          line_array[array_number].text += $_
        else
          line_array[array_number].text += $_
        end
      end  
    end
    puts 'Imported file "' + file + '" succesfully.'
    
    subtitle_object = Subtitle.new()
    subtitle_object.line = line_array
    subtitle_object.type = "SRT"
    subtitle_object.line_total = line_number
    
    subtitle_object
  end
  
    # Import an SRT file
  def SubtitleFile.import_srt_web(file)
    line_counter = 0
    line_array = []
    line_number = 0
    file_path = file.path()
    
    # TODO: Check if file exists
    File.open(file_path, 'r') do |infile|
      while infile.gets
        
        # Create array object and parse line number, and init line text
        # Also skip over blank lines at the beginning of the file
        if line_counter == 0 && scan(/^$/) == [] && $_.to_i != 0
          line_array += [SubtitleLine.new]
          line_number = $_.to_i()
          array_number = line_number - 1
          line_array[array_number].number = line_number
          line_array[array_number].text = ""
          line_counter = 1
          
          # Parse time code into start time and end time
        elsif line_counter == 1
          line_array[array_number].start_time = SubtitleTime.new($_[0,2].to_i,$_[3,2].to_i,$_[6,2].to_i,$_[9,3].to_i)
          line_array[array_number].end_time = SubtitleTime.new($_[17,2].to_i,$_[20,2].to_i,$_[23,2].to_i,$_[26,3].to_i)
          line_counter = 2
          
          # Reset the line counter when it hits an empty line
        elsif line_counter == 2 && scan(/^\r\n/) != []
          line_counter = 0
          
          # Parse the line text
        elsif line_counter == 2
          line_array[array_number].text += $_
        else
          line_array[array_number].text += $_
        end
      end  
    end
    
    subtitle_object = Subtitle.new()
    subtitle_object.line = line_array
    subtitle_object.type = "SRT"
    subtitle_object.line_total = line_number
    
    subtitle_object
  end

  def SubtitleFile.export_ssa(subtitle_object, file)
    # TODO: Export stuff
  end
  
  def SubtitleFile.export_ssa_web(subtitle_object)
    export_ssa_ass_web(subtitle_object, "SSA")   
  end
  
  def SubtitleFile.export_ass_web(subtitle_object)
  	export_ssa_ass_web(subtitle_object, "ASS")
  end
  
  # Exports a Subtitle object to an SRT formatted file
  def SubtitleFile.export_srt(subtitle_object, file)
    out_file = File.open(file, 'w')
    
    subtitle_object.line.each do |subtitle_line|
      out_file.write subtitle_line.to_srt()
    end
    out_file.close()
    
    puts 'Subtitle succesfully exported to "' + file + '"'
  end
  
  # Exports a Subtitle object to an SRT formatted string for web export
  def SubtitleFile.export_srt_web(subtitle_object)
    out_file = ""
    
    subtitle_object.line.each do |subtitle_line|
      out_file += subtitle_line.to_srt()
    end
    
    out_file
  end
  
  def SubtitleFile.debug_import_srt(file)
    line_counter = 0
    
    File.open(file, 'r') do |infile|
      while infile.gets
        
        # Create array object and parse line number, and init line text
        # Also skip over blank lines at the beginning of the file
        if line_counter == 0 && scan(/^$/) == [] && $_.to_i != 0
          print "Line Number: " + $_
          line_counter = 1
          
          # Parse time code into start time and end time
        elsif line_counter == 1
          print "Time Code: " + $_
          line_counter = 2
          
          # Reset the line counter when it hits an empty line
        elsif line_counter == 2 && scan(/^\r\n/) != []
          print "Empty Line" + $_
          line_counter = 0
          
          # Parse the line text
        elsif line_counter == 2
          print "Line Text: " + $_
        else
          print "Line Text: " + $_
        end
      end  
    end
    puts 'Debug import of file "' + file + '" done.'
  end
  private
  
  def SubtitleFile.parse_ssa_info(data, length)
    data_length = data.length
    data_length = data_length - length
    data_length = data_length - 3
    data.slice(length + 1, data_length)
  end
  
  def SubtitleFile.parse_ssa_data(data, length)
    data_array = []
    data.slice!(0,length)
    data_loop_times = data.scan(/,/)
    data_loop_times.each do
      data_length = data.index(',') + 1
      parse_result = data.slice!(0, data_length).lstrip
      data_array += [parse_result.slice(0, parse_result.length - 1)]
    end
    
    # Grab the last bit
    parse_result = data.lstrip
    data_array += [parse_result]
     
    data_array
  end
  
  def SubtitleFile.parse_ssa_dialogue(data, format, length)
    data_array = []
    data.slice!(0,length)
    data_loop_times = format.length-1
    data_loop_times.times do
      data_length = data.index(',') + 1
      parse_result = data.slice!(0, data_length).lstrip
      data_array += [parse_result.slice(0, parse_result.length - 1)]
    end
      
    # Grab the last bit
    parse_result = data.lstrip
    data_array += [parse_result]
      
    data_array
  end
  
  def SubtitleFile.export_ssa_ass_web(subtitle_object, type)
    if type == "SSA"
      subtitle_object.info.ssa_script_type = "v4.00"
    else
      subtitle_object.info.ssa_script_type = "v4.00+"
    end
    
    exportedSubtitle = subtitle_object.info.to_ssa()
    
    if type == "SSA"
      aggregate_data = "\r\n[V4 Styles]\r\n" + "Format: "
    else
      aggregate_data = "\r\n[V4+ Styles]\r\n" + "Format: "
    end
    
    subtitle_object.style_format.each do |format_data|
      if type == "SSA"
        case format_data
        when "OutlineColour"
          aggregate_data += "TertiaryColour, "
        when "OutlineColor"
          aggregate_data += "TertiaryColour, "
        else
          aggregate_data += format_data + ", "
        end
      else
        aggregate_data += format_data + ", "
      end
    end
    
    # Remove the last ","
    aggregate_data.slice!(aggregate_data.length-2,2)
    exportedSubtitle += aggregate_data
     
    subtitle_object.style.each do |style_data|
      exportedSubtitle += style_data.to_ssa(subtitle_object.style_format)
    end
    
    
    event_data = "\r\n\[Events]\r\n" + "Format: "
    subtitle_object.event_format.each do |format_data|
      event_data += format_data + ", "
    end
    
    # Remove the last ","
    event_data.slice!(event_data.length-2,2)
    exportedSubtitle += event_data  
    
    subtitle_object.line.each do |line_data|
      exportedSubtitle += line_data.to_ssa(subtitle_object.event_format)
    end
    
    exportedSubtitle
  end
  
  
end

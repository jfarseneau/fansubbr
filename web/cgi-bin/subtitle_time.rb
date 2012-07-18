=begin
  This class handles time markers in subtitles, 
  such as the start and end time.
=end

class SubtitleTime
  attr_reader :hours, :minutes, :seconds, :milliseconds

  # Initialize class with hours, minutes, seconds and milliseconds
  def initialize(hours, minutes, seconds, milliseconds)
    
    # Check if data is within bounds.
    if hours > 99
      raise "Error: Hours are too big, please keep it under 99."
    else
      @hours = hours # 'H' in time format examples  
    end
    if minutes > 60
      raise "Error: Minutes are too big, please keep it under 60."
    else
      @minutes = minutes # 'M' in time format examples
    end
    if seconds > 60
      raise "Error: Seconds are too big, please keep it under 60."
    else
      @seconds = seconds # 'S' in time format examples
    end
    if milliseconds > 999
      raise "Error: Milliseconds are too big, please keep it under 999."
    else
      @milliseconds = milliseconds # 'm' in time format examples
    end
    
  end
  
  
  # Report time in SubRip format (HH:MM:SS,mmm)
  def to_srt()
    
    # Format so that there's a 0 in front if it's under 10
    if @hours < 10
      srt_hours = "0" + @hours.to_s()
    else
      srt_hours = @hours.to_s()
    end
    if @minutes < 10
      srt_minutes = "0" + @minutes.to_s()
    else
      srt_minutes = @minutes.to_s()
    end
    if @seconds < 10
      srt_seconds = "0" + @seconds.to_s()
    else
      srt_seconds = @seconds.to_s()
    end
    if @milliseconds < 10
      srt_milliseconds = "00" + @milliseconds.to_s()
    elsif @milliseconds < 100
      srt_milliseconds = "0" + @milliseconds.to_s()
    else
      srt_milliseconds = @milliseconds.to_s()
    end
    
    srt_hours + ":" + srt_minutes + ":" + srt_seconds + "," + srt_milliseconds
    
  end
  
  # Report time in SubStation Alpha Format (H:MM:SS:mm).  
  # Single Digit Required for Hours.
  def to_ssa()
    to_ssa_ass("SSA")
  end
  
  def to_ass()
    to_ssa_ass("ASS")
  end
  
  private
  def to_ssa_ass(type)
      # If hours are over 9, abort.
    if @hours > 9
      raise "Won't work, hours are too big."
    else
      ssa_hours = @hours.to_s()
    end
    # Round off minutes, seconds and milliseconds in case they're smaller than 10.
    # If milliseconds are bigger than 2 numbers, shrink them to two.
    if @minutes < 10
      ssa_minutes = "0" + @minutes.to_s()
    else
      ssa_minutes = @minutes.to_s()
    end
    if @seconds < 10
      ssa_seconds = "0" + @seconds.to_s()
    else
      ssa_seconds = @seconds.to_s()
    end
    if @milliseconds < 10
      ssa_milliseconds = "0" + @milliseconds.to_s()
    elsif @milliseconds > 99
      ssa_milliseconds = @milliseconds.to_s()[0,2]
    else
      ssa_milliseconds = @milliseconds.to_s()
    end
    
    if type == "SSA"
      ssa_hours + ":" + ssa_minutes + ":" + ssa_seconds + ":" + ssa_milliseconds
    else
      ssa_hours + ":" + ssa_minutes + ":" + ssa_seconds + "." + ssa_milliseconds
    end
  end
end

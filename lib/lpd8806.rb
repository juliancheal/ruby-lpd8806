require 'firmata'
require 'socket'
require 'stringio'

class Lpd8806
  def initialize(device)
	  @board = Firmata::Board.new(device)
    @board.connect
	end
	
	# device info interface
  def firmware_name
    @board.firmware_name
  end

  def version
    @board.version
  end
  
  def set_packed_pixel(position, colour)
    message = "{p:#{position},c:#{colour}}"
    sys_message(message)
  end
  
  def set_pixel(position, r,g,b)
    message = "{r:#{r},g:#{g},b:#{b},p:#{position}}"
    puts message
    sys_message(message)
  end
  
  private
  
  def sys_message(message)
    start_sysex = 0xF0
    string_data = 0x71
    end_sysex   = 0xF7
    data = []

    data.push(start_sysex)
    data.push(string_data)
    bytes = StringIO.new(String(message+'\0'))

    bytes.each_byte do |byte|
      data.push(byte & 0x7F)
      data.push((byte >> 7) & 0x7F)
    end
    data.push(end_sysex)
    
    @board.write_and_process(data)
  end
end
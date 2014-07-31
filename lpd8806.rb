require 'bundler/setup'
require 'firmata'
require 'socket'
require 'stringio'

#sp = 'COM3' # windows
#sp = '/dev/ttyACM0' #linux
sp = '/dev/cu.usbserial-A600aeYe' #mac

@board = ::Firmata::Board.new(sp)

@board.connect

puts "Firmware name #{@board.firmware_name}"
puts "Firmata version #{@board.version}"

data_pin = 2
clock_pin = 3
stip_lengh = 32
# board.set_pin_mode(2, 0x01)
# board.set_pin_mode(data_pin, ::Firmata::PinModes::OUTPUT)
# board.set_pin_mode(clock_pin, ::Firmata::PinModes::OUTPUT)

def show
end

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

def set_packed_pixel(position, colour)
  message = "{p:#{position},c:#{colour}}"
  puts message
  sys_message(message)
end

set_packed_pixel("a",0x222)
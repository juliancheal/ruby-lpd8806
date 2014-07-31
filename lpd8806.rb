require 'bundler/setup'
require 'firmata'
require 'socket'

#sp = 'COM3' # windows
#sp = '/dev/ttyACM0' #linux
sp = '/dev/tty.usbserial-A600aeYe' #mac

board = Firmata::Board.new(sp)

board.connect

puts "Firmware name #{board.firmware_name}"
puts "Firmata version #{board.version}"

data_pin = 2
clock_pin = 3
stip_lengh = 32

board.digital_write(data_pin, Firmata::PinLevels::HIGH)
board.digital_write(clock_pin, Firmata::PinLevels::HIGH)

def set_pixels(position, colour)
  message = "{p: #{position}, c: #{colour}}"
  sys_message(message)
end

def show
end

def sys_message(message)
  start_sysex = 0xF0
  string_data = 0x71
  end_sysex   = 0xF7
  data = []

  data.push(start_sysex)
  data.push(string_data)
  data.push(message + '\0')
  data.push(end_sysex)
  
  board.read_and_process(data)
  puts data
end
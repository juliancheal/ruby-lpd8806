require './lib/lpd8806'

strip = Lpd8806.new("/dev/cu.usbserial-A600aeYe")

strip.set_packed_pixel("a",0x222)
sleep(5)
strip.set_packed_pixel("a",0x00)
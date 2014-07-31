require './lib/lpd8806'

@strip = Lpd8806.new("/dev/cu.usbserial-A600aeYe")

# def stack(leds)
#   @strip.set_packed_pixel(0,0x222)
#   leds=leds-1
#   leds.downto(0) do |l|
#     # puts "l: #{l}"
#     (1..l).each do |i|
#       previous = i-1
#       sleep(0.1)
#       @strip.set_packed_pixel(previous,0x00)
#       @strip.set_packed_pixel(i,0x222)
#       # puts "previous: #{previous}"
#       # puts "i: #{i}"
#     end
#   end
# end
# 
# stack(32)

# def random(leds)
#   
#   leds = (0...leds).to_a
#   @strip.set_packed_pixel(leds.sample,0x222)
#   sleep(0.3)
#   @strip.set_packed_pixel("a",0x00)
# end
# 
# (1..10).each do |i|
#   random(32)
# end
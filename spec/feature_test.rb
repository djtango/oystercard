require './lib/oystercard'

card = Oystercard.new

card.top_up(60)

p card

begin
card.top_up(60)
rescue Exception => deon_the_lad
p card
puts "Capacity feature not found #{deon_the_lad.inspect}"
end

card.deduct(60)
p card

# b1 = Barrier.new

# b2 = Barrier.new

# b1.touch_in(card)
# b2.touch_out(card)


card = Oystercard.new
card.touch_in


station1 = Station.new
station2 = Station.new
card.touch_in(station1)
card.entry_station #expect to be station1
card.touch_out
card.entry_station #expect to be nil


oc = Oystercard.new
station = Station.new(1,:holborn)
station2 = Station.new(1,:aldgate)
oc.top_up(10)
oc.touch_in(station)
oc.touch_out(station2)
oc.balance
oc.jlog.journeys

oc.touch_in(station)
oc.touch_in(station2)
oc.jlog.journeys
oc.balance

oc.top_up(10)
oc.touch_out(station)
oc.touch_out(station2)
oc.jlog.journeys
oc.balance
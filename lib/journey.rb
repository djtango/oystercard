class Journey

  MINIMUM_FARE = 1
  MAXIMUM_FARE = 6

  def initialize
    @entry_station = nil
    @exit_station = nil
  end


  def start(station)
    @entry_station = station
  end

  def finish(station)
    @exit_station = station
  end

  def fare
    complete? ? MINIMUM_FARE : MAXIMUM_FARE
  end

  def complete?
    @entry_station && @exit_station || @entry_station.nil? && @exit_station.nil? ? true : false
  end

end

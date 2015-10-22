require_relative 'journey'
class JourneyLog
  attr_reader :journeys
  def initialize(journey_klass: Journey)
    @journey_klass = journey_klass
    @jr = @journey_klass.new
    @journeys = []
  end

  def start_journey(station)
    current_journey
    outstanding_charges
    @jr.start(station)
  end

  def exit_journey(station)
    @jr.finish(station)
    outstanding_charges
    add_journey
  end

  def outstanding_charges
    amount = @jr.fare
    if @jr.complete?
      amount
    else
      add_journey
      amount
    end
  end

  def journey_complete?
    @jr.complete?
  end

  private

  attr_reader :journey_klass, :jr

  def current_journey
    @jr.complete? ? @jr = @journey_klass.new : @jr
  end

  def add_journey
    @journeys << @jr
    @jr = @journey_klass.new
  end
end

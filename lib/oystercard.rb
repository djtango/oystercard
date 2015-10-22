require_relative 'journey'
class Oystercard
  attr_reader :balance, :history, :journey
  MINIMUM_FARE = 1
  DEFAULT_BALANCE = 0
  LIMIT = 90
  def initialize (balance=DEFAULT_BALANCE, journeylog_klass: JourneyLog)
    @balance = balance
    @jlog = journeylog_klass.new
  end

  def top_up(num)
    fail "Unable to top up beyond the limit of £#{LIMIT}" if full?(num)
    @balance += num
  end

  def touch_in(station)
    fail "Unable to touch in: insufficient balance" if insufficient_balance?
    deduct unless @jlog.journey_complete?
    @jlog.start_journey(station)
  end

  def touch_out(station)
    @jlog.exit_journey(station)
    deduct
  end

  # def in_journey?
  #   @jlog.entry_station ? true : false
  # end

private

  def full?(num)
    ((@balance + num) > LIMIT)
  end

  def insufficient_balance?
    @balance < MINIMUM_FARE
  end

  def deduct
    @balance -= @jlog.outstanding_charges
  end

end

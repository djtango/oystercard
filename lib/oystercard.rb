require_relative 'journey'
class Oystercard
  attr_reader :balance, :history, :journey
  MINIMUM_FARE = 1
  DEFAULT_BALANCE = 0
  LIMIT = 90
  def initialize (balance=DEFAULT_BALANCE)
    @balance = balance
    @history = []
    @journey = Journey.new
  end

  def top_up(num)
    fail "Unable to top up beyond the limit of £#{LIMIT}" if full?(num)
    @balance += num
  end

  def touch_in(station)
    fail "Unable to touch in: insufficient balance" if insufficient_balance?
    deduct unless @journey.complete?
    @journey.start(station)
  end

  def touch_out(station)
    @journey.finish(station)
    deduct
    log_journey
  end

  # def in_journey?
  #   @journey.entry_station ? true : false
  # end

private

  def full?(num)
    ((@balance + num) > LIMIT)
  end

  def insufficient_balance?
    @balance < MINIMUM_FARE
  end

  def deduct
    @balance -= @journey.fare
  end

  def log_journey
    @history << @journey
    @journey = Journey.new
  end

end

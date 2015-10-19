class Oystercard
  attr_reader :balance
  DEFAULT_BALANCE = 0
  LIMIT = 90
  def initialize (balance=DEFAULT_BALANCE)
    @balance = balance
    @in_journey = false
  end

  def top_up(num)
    fail "Unable to top up beyond the limit of £#{LIMIT}" if full?(num)
    @balance += num
  end

  def deduct(num)
    @balance -= num
  end

  def activate
    @in_journey = true
  end

  def deactivate
    @in_journey = false
  end

  def in_journey?
    @in_journey
  end

  private

  def full?(num)
    ((@balance + num) > LIMIT)
  end

end

# topping up a card, touching in/out, managing balance

require_relative 'journey'
require_relative 'station'

class Oystercard

  attr_reader :balance, :new_journey
  attr_reader :journey, :journey_history

  MAX_BALANCE  = 90
  MIN_BALANCE  = 1
  MINIMUM_FARE = 2

  def initialize
    @balance  = 0
    @journey_history = []
  end

  def top_up(amount)
    raise "Cannot top up beyond £#{MAX_BALANCE}" if invalid_top_up?(amount)
    self.balance += amount
  end

  def touch_in(entry_station)
    raise "Error, already touched in" if in_journey?
    raise "Cannot start journey. Minimum balance required is £#{MIN_BALANCE}" if low_balance?
    self.new_journey = Journey.new
    new_journey.start(entry_station)
  end

  def touch_out(exit_station)
    raise "Error you did not touch in" if new_journey.nil?
    new_journey.end_journey(exit_station)
    log_journey
  end

  def in_journey?
    # same as !new_journey.nil?
    # rather than state true / false
    !!new_journey
  end


  private
  attr_writer :balance, :new_journey

  def low_balance?
    balance < 1
  end

  def invalid_top_up?(amount)
    amount + balance > MAX_BALANCE
  end

  def deduct(amount)
    self.balance -= amount
  end

  def log_journey
    deduct(MINIMUM_FARE)
    journey_history << new_journey.current_journey
    self.new_journey = nil
  end

end

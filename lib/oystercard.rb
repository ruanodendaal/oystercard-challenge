# topping up a card, touching in/out, managing balance

require_relative 'journey'
require_relative 'station'

class Oystercard

  attr_reader :balance, :new_journey, :journey_history

  MAX_BALANCE     = 90
  MIN_BALANCE     = 1
  MINIMUM_FARE    = 2
  PENTALTY_CHARGE = 6

  def initialize
    @balance  = 0
    @journey_history = []
  end

  def top_up(amount)
    raise "Cannot top up beyond £#{MAX_BALANCE}" if exceeds_limit?(amount)
    self.balance += amount
  end

  def touch_in(entry_station)
    if in_journey?
      penalty_charge
      log_journey
    end

    raise "Cannot start journey. Minimum balance required is £#{MIN_BALANCE}" if low_balance?
    self.new_journey = Journey.new
    new_journey.start(entry_station)
  end

  def touch_out(exit_station)
    if !in_journey?
      penalty_charge
      journey_history << {:exit_station => exit_station}
    else
      new_journey.end_journey(exit_station)
      deduct(MINIMUM_FARE)
      log_journey
      self.new_journey = nil
    end
  end

  def in_journey?
    # same as !new_journey.nil?
    # when new_journey is not nil
    !!new_journey
  end

  private

  attr_writer :balance, :new_journey

  def low_balance?
    balance < 1
  end

  def exceeds_limit?(amount)
    amount + balance > MAX_BALANCE
  end

  def deduct(amount)
    self.balance -= amount
  end

  def log_journey
    journey_history << new_journey.current_journey
  end

  def penalty_charge
    self.balance -= PENTALTY_CHARGE
  end

end

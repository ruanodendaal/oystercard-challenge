class Oystercard

  attr_reader :balance, :in_journey, :entry_station
  attr_reader :exit_station, :journeys

  MAX_BALANCE  = 90
  MIN_BALANCE  = 1
  MINIMUM_FARE = 2

  def initialize
    @balance  = 0
    @journeys = []
  end

  def top_up(amount)
    raise "Cannot top up beyond £#{MAX_BALANCE}" if invalid_top_up?(amount)
    self.balance += amount
  end

  def touch_in(entry_station)
    raise "Cannot start journey. Minimum balance required is £#{MIN_BALANCE}" if low_balance?
    self.entry_station = entry_station
  end

  def touch_out(exit_station)
    deduct(MINIMUM_FARE)
    self.exit_station = exit_station
    # journeys << {:entry_station => entry_station, :exit_station => exit_station}
    # puts "======"
    # puts journeys
    # puts "++++++"
    self.entry_station = nil
  end

  def in_journey?
    !!entry_station  # same as !entry_station.nil?
  end


  private
  attr_writer :balance, :in_journey, :entry_station, :exit_station

  def low_balance?
    balance < 1
  end

  def invalid_top_up?(amount)
    amount + balance > MAX_BALANCE
  end

  def deduct(amount)
    self.balance -= amount
  end

end

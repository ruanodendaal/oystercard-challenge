# respondible for start & end, complete?
# storing each journey in journey_history

class Journey

attr_reader :complete, :current_journey

  def initialize(station=nil)
    @complete = false
    @current_journey = {}
  end

  def start(station)
    self.current_journey = {:entry_station => station}
  end

  def end_journey(station)
    self.current_journey[:exit_station] = station
    self.complete = true
  end

  def complete?
    complete
  end

  # def fare
  #   6 if complete?
  #   Oystercard::MINIMUM_FARE
  # end

  private
  
  attr_writer :complete, :current_journey

end

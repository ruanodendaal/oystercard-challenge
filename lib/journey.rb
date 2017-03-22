class Journey

attr_reader :entry_station, :complete

  def initialize(entry_station = nil)
    @entry_station = entry_station
    @complete = false
    # @exit_station = exit_station
  end

  def finish
    self.complete = true
  end

  def complete?
    complete
  end

  def fare
    Oystercard::MINIMUM_FARE 
  end

  private
  attr_writer :complete

end

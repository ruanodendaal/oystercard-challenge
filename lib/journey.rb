class Journey

attr_reader :entry_station, :complete

  def initialize(entry_station)
    @entry_station = entry_station
    @complete = false
    # @exit_station = exit_station
  end

  #TODO
  # def start
  # end
  #
  # def end_journey
  # end


  def finish
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
  attr_writer :complete

end

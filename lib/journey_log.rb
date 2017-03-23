# accepts start of journey
# initializes an instance of a journey
# accepts end of journey
# finishes that journey
# hold a history of journeys
#
require_relative 'journey'

class JourneyLog

  attr_reader :journey_history, :new_journey

  def initialize
    @journey_history = []
  end

  def start(entry_station)
    self.new_journey = Journey.new
    new_journey.start(entry_station)
    self.journey_history << new_journey.current_journey
  end

  def end(exit_station)
    new_journey.end_journey(exit_station)
    self.new_journey = nil
  end

  def show_journeys
    journey_history.dup
  end

  private

  attr_writer :new_journey

end

require 'journey_log'

describe JourneyLog do
  subject(:journey_log) { described_class.new }
  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station }

  describe '#initialization' do
    it 'should create an empty history array' do
      expect(journey_log.journey_history).to eq []
    end
  end

  describe '#start' do
    it 'should start a new journey' do
      expect(journey_log).to respond_to(:start).with(1).argument
      #expect(journey_class).to receive(:new).with(entry_station: entry_station)
    end

    # it 'should create a new journey class' do
    #
    # end

    it 'should add start journey to journey_history' do
      journey_log.start(:entry_station)
      expect(journey_log.journey_history).to include { { :entry_station => entry_station } }
    end
  end

  describe "#end" do
    it "should end journey" do
      expect(journey_log).to respond_to(:end).with(1).argument
    end

    it "should add end journey to journey_history" do
      journey_log.start(:entry_station)
      journey_log.end(:exit_station)
      expect(journey_log.journey_history).to include { { :exit_station => exit_station } }
    end
  end


  describe 'for successfully completed journeys' do
    before do
      journey_log.start(:entry_station)
      journey_log.end(:exit_station)
    end
    it 'stores a single journey history' do
      expect(journey_log.journey_history).to include { {entry_station: entry_station, exit_station: exit_station} }
    end

    it 'should store multiple journeys' do
      journey_log.start(:entry_station)
      journey_log.end(:exit_station)
      expect(journey_log.journey_history.length).to eq 2
    end
  end

  describe '#journeys' do
    xit 'should return a list of all previous journeys' do
      journey_log.start(:entry_station)
      journey_log.end(:exit_station)
      journey_list = [ {entry_station: entry_station, exit_station: exit_station} ]
      expect(journey_log.show_journeys).to eq journey_list
    end
  end
end

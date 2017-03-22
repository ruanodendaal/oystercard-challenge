require 'journey'

describe Journey do
subject(:journey) {described_class.new}
let(:entry_station) {double(:entry_station)}
let(:exit_station) {double(:exit_station)}
let(:oystercard) {double(:oystercard)}

  describe '#initialization' do
    subject(:journey) {described_class.new(:entry_station)}
    it 'set complete to false' do
      expect(journey.complete).to be_falsey
    end

    it 'should create an empty hash' do
      expect(journey.current_journey).to be_empty
    end

  end

  describe '#start' do
    it 'should add the entry station to the current_journey hash' do
      journey.start(:entry_station)
      expect(journey.current_journey).to include {{:entry_station => entry_station}}
    end
  end

  describe '#end_journey'do
    it 'should add the exit station to the existing hash' do
      journey.end_journey(:exit_station)
      expect(journey.current_journey).to include {{:exit_station => exit_station}}
    end
  end

  describe '#finish' do
    it 'should complete true when called' do
      expect(journey.finish). to eq true
    end
  end

  describe '#complete?' do
    it 'should return true if journey is completed' do
      expect(journey).to respond_to (:complete?)
    end
  end

    # describe '#fare' do
    #   it 'should return minimum fare' do
    #     expect(journey.fare).to eq Oystercard::MINIMUM_FARE
    #   end
    #   it 'should return a penalty fare of 6 if you\'ve already touched in' do
    #     allow(oystercard).to receive(:top_up)
    #     oystercard.top_up(10)
    #     allow(oystercard).to receive(:touch_in)
    #     2.times {oystercard.touch_in(entry_station)}
    #     expect(journey.fare).to eq 6
    #   end
    # end


end

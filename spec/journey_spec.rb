require 'journey'

describe Journey do
subject(:journey) {described_class.new}
let(:entry_station) {double(:entry_station)}
let(:exit_station) {double(:exit_station)}
let(:oystercard) {double(:oystercard)}

  describe '#initialization' do
    subject(:journey) {described_class.new(:entry_station)}
    it 'should be initialized with an entry_station' do
      expect(journey.entry_station).to eq :entry_station
    end

    describe '#complete?' do
      it 'should return true if journey is completed' do
        expect(journey).to respond_to (:complete?)
      end
    end

    describe '#fare' do
      it 'should return minimum fare' do
        expect(journey.fare).to eq Oystercard::MINIMUM_FARE
      end
      it 'should return a penalty fare of 6 if you\'ve already touched in' do
        allow(oystercard).to receive(:top_up) 
          oystercard.top_up(10)
        allow(oystercard).to receive(:touch_in)
          2.times {oystercard.touch_in(entry_station)}
          expect(journey.fare).to eq 6
        end

    end

  end


end

require 'oystercard'

describe Oystercard do
  subject(:oystercard) {described_class.new}
  let (:entry_station) {double(:entry_station)}
  let (:exit_station) {double(:exit_station)}

  describe '#initialization' do
    it "new card has zero balance" do
      expect(oystercard.balance).to eq(0)
    end

    it "creates and empty journey history array" do
      expect(oystercard.journey_history).to be_empty
    end
  end

  describe '#top_up' do
    context 'basic top up behaviour' do
      it { is_expected.to respond_to(:top_up).with(1).argument }

      it 'it tops up a card with a specified amount' do
        expect { oystercard.top_up(50) }.to change{ oystercard.balance }.by 50
      end

      it 'should not allow balance to exceed 90' do
        maximum_balance = Oystercard::MAX_BALANCE
        oystercard.top_up(maximum_balance)
        message = "Cannot top up beyond £#{maximum_balance}"
        expect { oystercard.top_up(10) }.to raise_error message
      end
    end
  end


  describe "#touch_in" do
    context 'when card has enough balance for the complete journey' do
      before(:each) do
        oystercard.top_up(10)
        oystercard.touch_in(:entry_station)
      end

        it "returns the station where journey begins" do
          expect(oystercard.entry_station).to eq :entry_station
        end
    end
  end

    describe "#touch_out" do
      context 'when card has enough balance for the complete journey' do
        before(:each) do
          oystercard.top_up(10)
          oystercard.touch_in(:entry_station)
        end

          it 'should respond to touch_out' do
            oystercard.touch_out(:exit_station)
            expect(oystercard).not_to be_in_journey
          end

          it 'should deduct the correct amount' do
            min_fare = Oystercard::MINIMUM_FARE
            expect{ oystercard.touch_out(:exit_station) }.to change {oystercard.balance}.by -min_fare
          end

          it "sets the entry station to nil on touch_out" do
            oystercard.touch_out(:exit_station)
            expect(oystercard.entry_station).to eq nil
          end

          it "returns the journey's exit station" do
            oystercard.touch_out(:exit_station)
            expect(oystercard.exit_station).to eq :exit_station
          end

      end
    end


  context 'when card hase a balance of 0' do
    describe  "#touch_in" do
      it "restricts start of journey if minimum balance not met" do
        min_balance = Oystercard::MIN_BALANCE
        expect { oystercard.touch_in(:entry_station) }.to raise_error "Cannot start journey. Minimum balance required is £#{min_balance}"
      end
    end
  end

  context 'if journey not started correctly' do
    describe '#touch_out' do
      it 'should raise error if not touched in' do
        oystercard.top_up(50)
        expect { oystercard.touch_out(:exit_station) }.to raise_error "Error you did not touch in"
      end
    end
  end

  context 'if journey not ended correctly' do
    describe '#touch_in' do
      it 'raises an error if already touched in' do
        oystercard.top_up(20)
        oystercard.touch_in(:entry_station)
        expect { oystercard.touch_in(:entry_station) }.to raise_error "Error, already touched in"
      end
    end
  end

  describe 'journey history' do
      it 'stores a completed journey' do
        expect(oystercard.journey_history).to include { {entry_station: entry_station, exit_station: exit_station} }
      end
  end

  describe 'journey tracking' do
    it 'should be complete when touching out after touching in' do
      oystercard.top_up(20)
      oystercard.touch_in(:entry_station)
      oystercard.touch_out(:exit_station)
      expect(oystercard.new_journey).to be_complete
    end
  end


end

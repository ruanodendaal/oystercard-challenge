require 'oystercard'

describe Oystercard do
  subject(:oystercard) { described_class.new}
  let (:entry_station) { double :entry_station }
  let (:exit_station) { double :exit_station }

  describe '#initialization' do
    it "new card has zero balance" do
      expect(oystercard.balance).to eq(0)
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

      it "is expected to be in_journey" do
        expect(oystercard).to be_in_journey
      end
    end

    context 'when card hase a balance of 0' do
      it "restricts start of journey if minimum balance not met" do
        min_balance = Oystercard::MIN_BALANCE
        expect { oystercard.touch_in(:entry_station) }.to raise_error "Cannot start journey. Minimum balance required is £#{min_balance}"
      end
    end

    # context 'if journey not ended correctly' do
    #   it 'raises an error if already touched in' do
    #     oystercard.top_up(20)
    #     oystercard.touch_in(:entry_station)
    #     expect { oystercard.touch_in(:entry_station) }.to raise_error "Error, already touched in"
    #   end
    # end

    context "when we try to touch_in with an incomplete journey"  do
      it 'should charge a penalty_charge' do
        oystercard.top_up(10)
        oystercard.touch_in(:entry_station)
        penalty = Oystercard::PENTALTY_CHARGE
        expect{ oystercard.touch_in(:entry_station) }.to change { oystercard.balance }.by -penalty
      end
    end
  end

  describe "#touch_out" do
    before do
      oystercard.top_up(10)
    end
    context 'when card has balance for the complete journey' do
      before(:each) do
        oystercard.touch_in(:entry_station)
        oystercard.touch_out(:exit_station)
      end

      it 'should not be in journey' do
        expect(oystercard).not_to be_in_journey
      end

    end

    it 'should deduct the correct amount' do
      min_fare = Oystercard::MINIMUM_FARE
      oystercard.touch_in(:entry_station)
      expect{ oystercard.touch_out(:exit_station) }.to change {oystercard.balance}.by -min_fare
    end

    it "checks penalty charge is deducated when forget to touch in" do
      expect{ oystercard.touch_out(:exit_station) }.to change {oystercard.balance}.by -Oystercard::PENTALTY_CHARGE


    end
    #
    # context 'if journey not started correctly' do
    #   it 'should raise error if not touched in' do
    #     oystercard.top_up(50)
    #     expect { oystercard.touch_out(:exit_station) }.to raise_error "Error you did not touch in"
    #   end
    # end
  end



end

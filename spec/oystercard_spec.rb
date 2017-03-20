require 'oystercard'

describe Oystercard do
  subject(:oystercard) {described_class.new}
  describe '#initialization' do
    it 'sets a balance of 0' do
      expect(oystercard.balance).to eq 0
    end
  end

  describe '#top_up' do

    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'it tops up a card with a specified amount' do
      expect { oystercard.top_up(50) }.to change{ oystercard.balance }.by 50
    end

    it 'should not allow balance to exceed 90' do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      oystercard.top_up(maximum_balance)
      message = "Cannot top up beyond £#{maximum_balance}"
      expect { oystercard.top_up(50) }.to raise_error message
    end
  end


end

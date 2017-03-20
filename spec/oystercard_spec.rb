require 'oystercard'

describe Oystercard do
  describe '#initialization' do
    it 'sets a balance of 0' do
      oystercard = Oystercard.new
      expect(oystercard.balance).to eq 0
    end
  end
end

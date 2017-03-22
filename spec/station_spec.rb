require 'station'

describe Station do
subject(:station) { described_class.new("Aldgate", 1) }

    it 'takes a name argument' do
      expect(station.name).to eq "Aldgate"
    end

    it 'takes a zone argument' do
      expect(station.zone).to eq 1
    end


end

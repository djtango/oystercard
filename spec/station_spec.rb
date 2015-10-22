require 'station'
describe Station do
  subject {described_class.new(1, "Aldgate")}
  it do expect(subject.zone).to eq 1 end
  it do expect(subject.location).to eq "Aldgate" end
end

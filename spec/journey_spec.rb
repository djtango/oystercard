require 'journey'

describe Journey do

 let(:station) { double :station }

  describe "#start" do
   it "should return entry station" do
    expect(subject.start(station)).to eq station
   end
  end

  describe "#finish" do
    it "should return exit station" do
      expect(subject.finish(station)).to eq station
    end

  end

  describe "#fare" do
    context "when journey is successfully completed" do
      before do
        subject.start(station)
        subject.finish(station)
      end
      it "charges default fare" do
        expect(subject.fare).to eq Journey::MINIMUM_FARE
      end
    end
    context "when the journey is not completed" do
      before do
        subject.finish(station)
      end
      it "charges the penalty fare" do
        expect(subject.fare).to eq Journey::MAXIMUM_FARE
      end
    end
  end

  describe "#complete?" do
    context "when touching in and touching out is successful"
      before do
        subject.start(station)
        subject.finish(station)
      end
      it "will return true" do
        expect(subject.complete?).to eq true
      end
  end

end

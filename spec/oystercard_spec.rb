require 'oystercard'

describe Oystercard do

  let(:station) { double :station }
  let(:journey) { double :journey}


  it "checks that default balance is zero" do
    subject.balance()
    expect(subject.balance).to eq Oystercard::DEFAULT_BALANCE
  end

  describe "#top_up" do
    it "allows for balance to be topped up" do
      2.times { subject.top_up(10) }
      expect(subject.balance).to eq 20
    end

    context "when topping up beyond the limit" do
      it "will not allow the user to top up" do
        subject.top_up(Oystercard::LIMIT)
        expect{subject.top_up(1)}.to raise_error("Unable to top up beyond the limit of £#{Oystercard::LIMIT}")
      end
    end
  end

  describe "#touch_in" do
    before(:each) do
      allow(station).to receive(:zone).and_return("zone")
      allow(station).to receive(:location).and_return("location")
      subject.top_up(Oystercard::MINIMUM_FARE)
      subject.touch_in(station)
    end

    context "when touching in twice in a row" do
      it "charges a maximum fare" do

        expect{subject.touch_in(station)}.to change{subject.balance}.by (-Journey::MAXIMUM_FARE)
      end
    end

    context "when touching in with insufficient funds" do
      it "should raise an error" do
        subject.touch_out(station)
        expect{subject.touch_in(station)}.to raise_error "Unable to touch in: insufficient balance"
      end
    end

  end

  describe "#touch_out" do

    let(:station2) {double(:station)}

      before(:each) do
        subject.top_up(2)
        subject.touch_in(station)
      end

      context 'when touching out' do
        it 'deducts the fare' do
          expect{subject.touch_out(station2)}.to change{subject.balance}.by -Oystercard::MINIMUM_FARE
        end
      end

      context "when touching out at a particular station" do

        xit "will return a journey record" do
          allow(subject.journey).to receive(:finish)
          subject.touch_out
          expect(subject.history.last).to eq journey
        end
      end

  end
end

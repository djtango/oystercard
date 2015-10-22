require 'journeylog'

describe JourneyLog do
  let(:station) {double(:station)}
  let(:journey) {double(:journey)}
  subject(:journeylog) { described_class.new(:journey_klass) }

  let(:journey_klass) { double(:journey_klass) }


  describe "#start_journey" do
    it "adds a journey to the log" do
    allow(journey_klass).to receive(:new).and_return(journey)
    journey_log.start_journey(:station)
    expect(journey_log.journeys).to include(journey)
    end
  end

  describe "#exit_journey" do

  end

  describe "#journeys" do
    context "when called, it returns a log of the journeys" do
      it 'returns a journey history' do
        expect(subject.journeys).to include(journey)
      end
    end
  end

  describe "#current_journey" do
    context 'when starting a new journey twice in a row' do
      allow(journey).to receive(:complete?).and_return(false)
      subject.start_journey(station)
      subject.start_journey(station)
      it 'records the journey as incomplete' do
        expect(subject.journeys.last).not_to be_complete

      end
    end
  end

end

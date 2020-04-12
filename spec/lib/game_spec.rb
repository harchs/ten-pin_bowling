# frozen_string_literal: true

describe Game do
  describe 'generate an instance' do
    subject { Game.new(player: 'Joe Doe') }

    it { expect(subject.player).to eq('Joe Doe') }
    it { expect(subject.frames).to be_empty }
  end

  describe '#add_frame' do
    subject { Game.new(player: 'Joe Doe') }

    context 'with an invalid frame' do
      it 'raise an error' do
        expect do
          subject.add_frame('frame error')
        end.to raise_error(Errors::InvalidFrame)
      end
    end

    context 'with a valid frame' do
      let(:frame) { StrikeFrame.new }

      it 'add a new frame to the game' do
        subject.add_frame(frame)
        expect(subject.frames.length).to eq(1)
      end
    end

    context 'when the frames added to a game exceed the maximum' do
      let(:frame) { StrikeFrame.new }
      before :each do
        10.times.each do |_i|
          frame = StrikeFrame.new
          subject.add_frame(frame)
        end
      end

      it 'raise an error' do
        expect do
          subject.add_frame(frame)
        end.to raise_error(Errors::ExceededMaximumFrames)
      end
    end
  end

  describe '#add_frame' do
    subject { Game.new(player: 'Joe Doe') }

    context 'without frames added' do
      it { expect(subject.score).to be_empty }
    end

    context 'with frames added' do
      before :each do
        frame = StrikeFrame.new
        subject.add_frame(frame)
      end

      it { expect(subject.score).to eq([10]) }
    end
  end
end

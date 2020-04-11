# frozen_string_literal: true

describe StrikeFrame do
  describe 'generate an instance' do
    it { expect(StrikeFrame.new).to be_an_instance_of(StrikeFrame) }
  end

  describe '#strike?' do
    it { expect(StrikeFrame.new.strike?).to be_truthy }
  end

  describe '#spare?' do
    it { expect(StrikeFrame.new.spare?).to be_falsy }
  end

  describe '#score' do
    subject { StrikeFrame.new }

    it { expect(subject.score).to eq(10) }
  end

  describe '#total_score' do
    subject { StrikeFrame.new }

    context 'when there is not a previuos frame neither a next_frame' do
      context 'when there are second_attempt and third_attempt' do
        before :each do
          subject.second_attempt = 10
          subject.third_attempt = 10
        end

        it { expect(subject.total_score).to eq(30) }
      end

      context 'when there are not second_attempt neither third_attempt' do
        it { expect(subject.total_score).to eq(10) }
      end
    end

    context 'when there is only a previuos frame' do
      before :each do
        subject.previous_frame = StrikeFrame.new
        subject.second_attempt = 10
        subject.third_attempt = 10
      end

      it { expect(subject.total_score).to eq(40) }
    end

    context 'when there is only a next frame' do
      before :each do
        regular_frame = RegularFrame.new(first_attempt: 8)
        regular_frame.second_attempt = 2
        subject.next_frame = regular_frame
      end

      it { expect(subject.total_score).to eq(20) }
    end

    context 'when there is a previuos frame and a next_frame' do
      context 'when the next_frame is a strike' do
        before :each do
          subject.previous_frame = StrikeFrame.new
          strike_frame = StrikeFrame.new

          regular_frame = RegularFrame.new(first_attempt: 8)
          regular_frame.second_attempt = 2

          strike_frame.next_frame = regular_frame

          subject.next_frame = strike_frame
        end

        it { expect(subject.total_score).to eq(38) }
      end

      context 'when the next_frame is a spare' do
        before :each do
          subject.previous_frame = StrikeFrame.new
          regular_frame = RegularFrame.new(first_attempt: 7)
          regular_frame.second_attempt = 2

          subject.next_frame = regular_frame
        end

        it { expect(subject.total_score).to eq(29) }
      end
    end
  end

  describe '#to_s' do
    subject { StrikeFrame.new }
    context 'when there is not a second_attempt neither a third_attempt' do
      it { expect(subject.to_s).to eq("\tX\t") }
    end

    context 'when there is a second_attempt and a third_attempt' do
      before :each do
        subject.second_attempt = 10
        subject.third_attempt = 9
      end
      it { expect(subject.to_s).to eq("X\tX\t9") }
    end
  end
end

# frozen_string_literal: true

describe RegularFrame do
  describe 'generate an instance' do
    context 'with a first_attempt with negative value' do
      it 'raise an error' do
        expect do
          RegularFrame.new(first_attempt: -1)
        end.to raise_error(StandardError)
      end
    end

    context 'with a first_attempt value different to F' do
      it 'raise an error' do
        expect do
          RegularFrame.new(first_attempt: 'A')
        end.to raise_error(StandardError)
      end
    end

    context 'with a first_attempt with value greater than 9' do
      it 'raise an error' do
        expect do
          RegularFrame.new(first_attempt: 10)
        end.to raise_error(StandardError)
      end
    end

    context 'with a first_attempt different to a number or a string' do
      it 'raise an error' do
        expect do
          RegularFrame.new(first_attempt: { a: 1 })
        end.to raise_error(StandardError)
      end
    end

    context 'with a valid number' do
      subject { RegularFrame.new(first_attempt: 1) }
      it { expect(subject).to be_an_instance_of(RegularFrame) }
    end
  end

  describe '#second_attempt' do
    context 'with second attempt value different to F' do
      subject { RegularFrame.new(first_attempt: 0) }
      it 'raise an error' do
        expect do
          subject.second_attempt = 'A'
        end.to raise_error(StandardError)
      end
    end

    context 'when second attempt makes exceeds the maximum of pins' do
      subject { RegularFrame.new(first_attempt: 0) }
      it 'raise an error' do
        expect do
          subject.second_attempt = 11
        end.to raise_error(StandardError)
      end
    end

    context 'with a valid second attempt' do
      subject { RegularFrame.new(first_attempt: 0) }
      before :each do
        subject.second_attempt = 10
      end

      it { expect(subject.to_s).to eq("0\t/\t") }
    end

    context 'with a valid second attempt with value F' do
      subject { RegularFrame.new(first_attempt: 0) }
      before :each do
        subject.second_attempt = 'F'
      end

      it { expect(subject.to_s).to eq("0\tF\t") }
    end
  end

  describe '#strike?' do
    it { expect(RegularFrame.new(first_attempt: 1).strike?).to be_falsy }
  end

  describe '#spare?' do
    context "When the sum of attempts is #{Frame::MAX_PINS}" do
      subject { RegularFrame.new(first_attempt: 1) }
      before :each do
        subject.second_attempt = 9
      end

      it { expect(subject.spare?).to be_truthy }
    end

    context "When the sum of attempts is less than #{Frame::MAX_PINS}" do
      subject { RegularFrame.new(first_attempt: 1) }
      before :each do
        subject.second_attempt = 8
      end

      it { expect(subject.spare?).to be_falsy }
    end
  end

  describe '#score' do
    subject { RegularFrame.new(first_attempt: 1) }
    before :each do
      subject.second_attempt = 8
    end

    it { expect(subject.score).to eq(9) }
  end

  describe '#total_score' do
    subject { RegularFrame.new(first_attempt: 1) }

    context 'when it is a spare' do
      before :each do
        subject.second_attempt = 9
        subject.previous_frame = StrikeFrame.new
        subject.next_frame = StrikeFrame.new
      end

      it { expect(subject.total_score).to eq(30) }
    end

    context 'when it is not a spare' do
      before :each do
        subject.second_attempt = 8
        subject.previous_frame = StrikeFrame.new
      end

      it { expect(subject.total_score).to eq(19) }
    end

    context 'when it is not a spare containing a fail attempt' do
      before :each do
        subject.second_attempt = 'F'
        subject.previous_frame = StrikeFrame.new
      end

      it { expect(subject.total_score).to eq(11) }
    end
  end

  describe '#to_s' do
    context 'when the frame is a spare' do
      subject { RegularFrame.new(first_attempt: 1) }
      before :each do
        subject.second_attempt = 9
      end
      it { expect(subject.to_s).to eq("1\t/\t") }
    end

    context 'when the frame contains a fail attempt' do
      subject { RegularFrame.new(first_attempt: 1) }
      before :each do
        subject.second_attempt = 'F'
      end
      it { expect(subject.to_s).to eq("1\tF\t") }
    end

    context 'when the frame is not a spare' do
      subject { RegularFrame.new(first_attempt: 1) }
      before :each do
        subject.second_attempt = 0
      end
      it { expect(subject.to_s).to eq("1\t0\t") }
    end
  end
end

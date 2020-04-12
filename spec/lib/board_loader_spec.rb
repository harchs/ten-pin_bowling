# frozen_string_literal: false

describe BoardLoader do
  describe 'generate an instance' do
    context 'with no pinfalls' do
      it 'raise an error' do
        expect do
          BoardLoader.new
        end.to raise_error(StandardError)
      end
    end
  end

  describe '#call' do
    context 'with an empty pinfalls collection' do
      subject { BoardLoader.new([]) }
      it { expect(subject.call).to be_instance_of(Board) }
      it { expect(subject.call.games).to be_empty }
    end

    context 'with a valid pinfalls collection' do
      let(:pinfalls) do
        [
          %w[Sam 10],
          %w[Sam 10],
          %w[Sam 10],
          %w[Sam 10],
          %w[Sam 10],
          %w[Sam 10],
          %w[Sam 10],
          %w[Sam 10],
          %w[Sam 10],
          %w[Sam 10],
          %w[Sam 10],
          %w[Sam 10]
        ]
      end

      subject { BoardLoader.new(pinfalls) }

      it { expect(subject.call).to be_instance_of(Board) }
      it { expect(subject.call.games.length).to eq(1) }
      it { expect(subject.call.games[0].frames.length).to eq(10) }
    end

    context 'with a valid pinfalls collection' do
      let(:pinfalls) do
        [
          %w[Sam 10],
          %w[Sam 10],
          %w[Sam 10],
          %w[Sam 10],
          %w[Sam 10],
          %w[Sam 10],
          %w[Sam 10],
          %w[Sam 10],
          %w[Sam 10],
          %w[Sam 10],
          %w[Sam 10],
          %w[Sam 10],
          %w[Jonh 10],
          %w[Jonh 10],
          %w[Jonh 10],
          %w[Jonh 10],
          %w[Jonh 10],
          %w[Jonh 10],
          %w[Jonh 10],
          %w[Jonh 10],
          %w[Jonh 10],
          %w[Jonh 6],
          %w[Jonh 4]
        ]
      end

      subject { BoardLoader.new(pinfalls) }

      it { expect(subject.call).to be_instance_of(Board) }
      it { expect(subject.call.games.length).to eq(2) }
      it { expect(subject.call.games[0].frames.length).to eq(10) }
      it { expect(subject.call.games[1].frames.length).to eq(10) }
    end

    context 'with a invalid pinfalls collection' do
      let(:pinfalls) do
        [
          %w[Sam 10],
          %w[Sam 10],
          %w[Sam 10],
          %w[Sam 10],
          %w[Sam 10],
          %w[Sam 10],
          %w[Sam 10],
          %w[Sam 10],
          %w[Sam 10],
          %w[Sam 10],
          %w[Sam 10],
          %w[Sam 10],
          %w[Sam 10]
        ]
      end

      subject { BoardLoader.new(pinfalls_1) }

      it 'raise an error' do
        expect do
          subject.call
        end.to raise_error(StandardError)
      end
    end

    context 'with a invalid pinfalls collection' do
      let(:pinfalls) do
        [
          %w[Sam 10],
          %w[Sam 10],
          %w[Sam 10],
          %w[Sam 10],
          %w[Sam 10],
          %w[Sam 10],
          %w[Sam 10],
          %w[Sam 10],
          %w[Sam 10],
          %w[Sam 4],
          %w[Sam 3],
          %w[Sam 3]
        ]
      end

      subject { BoardLoader.new(pinfalls) }

      it 'raise an error' do
        expect do
          subject.call
        end.to raise_error(StandardError)
      end
    end

    context 'with a invalid value' do
      let(:pinfalls) do
        [
          %w[Sam -1],
          %w[Sam 10],
          %w[Sam 10],
          %w[Sam 10],
          %w[Sam 10],
          %w[Sam 10],
          %w[Sam 10],
          %w[Sam 10],
          %w[Sam 10],
          %w[Sam 10],
          %w[Sam 10],
          %w[Sam 10],
        ]
      end

      subject { BoardLoader.new(pinfalls) }

      it 'raise an error' do
        expect do
          subject.call
        end.to raise_error(StandardError)
      end
    end

    context 'with a invalid value' do
      let(:pinfalls) do
        [
          %w[Sam A],
          %w[Sam 10],
          %w[Sam 10],
          %w[Sam 10],
          %w[Sam 10],
          %w[Sam 10],
          %w[Sam 10],
          %w[Sam 10],
          %w[Sam 10],
          %w[Sam 10],
          %w[Sam 10],
          %w[Sam 10],
        ]
      end

      subject { BoardLoader.new(pinfalls) }

      it 'raise an error' do
        expect do
          subject.call
        end.to raise_error(StandardError)
      end
    end

    context 'with a invalid value' do
      let(:pinfalls) do
        [
          %w[Sam 10],
          %w[Sam 9],
          %w[Sam 2],
          %w[Sam 10],
          %w[Sam 10],
          %w[Sam 10],
          %w[Sam 10],
          %w[Sam 10],
          %w[Sam 10],
          %w[Sam 10],
          %w[Sam 10],
          %w[Sam 10],
          %w[Sam 10]
        ]
      end

      subject { BoardLoader.new(pinfalls) }

      it 'raise an error' do
        expect do
          subject.call
        end.to raise_error(StandardError)
      end
    end
  end
end

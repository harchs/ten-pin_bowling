# frozen_string_literal: false

require 'pathname'

describe Board do
  describe 'generate an instance' do
    it { expect(Board.new.games).to be_empty }
  end

  describe '.generate_from_file' do
    context 'with a wrong file path' do
      it 'raise an error' do
        expect do
          Board.generate_from_file('/wrong/path')
        end.to raise_error(StandardError)
      end
    end
  end

  describe '#add_game' do
    subject { Board.new }

    context 'with a invalid game' do
      it 'raise an error' do
        expect do
          subject.add_game('frame')
        end.to raise_error(Errors::InvalidGame)
      end
    end

    context 'with a valid game' do
      it 'adds the game to the games collection' do
        game = Game.new(player: 'John Doe')
        subject.add_game(game)
        expect(subject.games.length).to eq(1)
      end
    end
  end

  describe '#to_s' do
    subject { Board.new }

    before :each do
      game = Game.new(player: 'John Doe')
      subject.add_game(game)
      10.times do |i|
        frame = StrikeFrame.new
        if i > 0 && i <= 9
          game.frames[i - 1].next_frame = frame
          frame.previous_frame = game.frames[i - 1]
        end

        if i == 9
          frame.second_attempt = 10
          frame.third_attempt = 10
        end

        game.add_frame(frame)
      end
    end

    it 'renders the result in a specific format' do
      snapshot = "Frame\t\t1\t\t2\t\t3\t\t4\t\t5\t\t6\t\t7\t\t8\t\t9\t\t10\t\t"
      snapshot << "\n"
      snapshot << "John Doe\n"
      snapshot << "Pinfalls\t\t"
      snapshot << "X\t\tX\t\tX\t\tX\t\tX\t\tX\t\tX\t\tX\t\tX\tX\tX\tX\n"
      snapshot << "Score\t\t"
      snapshot << "30\t\t60\t\t90\t\t120\t\t150\t\t180\t\t210\t\t240\t\t270"
      snapshot << "\t\t300\t\t\n"

      expect(subject.to_s).to eq(snapshot)
    end
  end
end

# frozen_string_literal: true

describe Frame do
  describe 'constants' do
    it { expect(Frame::MAX_PINS).to eq(10) }
  end

  describe '#strike?' do
    it { expect { Frame.new.strike? }.to raise_error(NotImplementedError) }
  end

  describe '#spare?' do
    it { expect { Frame.new.spare? }.to raise_error(NotImplementedError) }
  end

  describe '#score' do
    it { expect { Frame.new.score }.to raise_error(NotImplementedError) }
  end

  describe '#total_score' do
    it { expect { Frame.new.total_score }.to raise_error(NotImplementedError) }
  end

  describe '#to_s' do
    it { expect { Frame.new.to_s }.to raise_error(NotImplementedError) }
  end
end

# frozen_string_literal: true

require_relative './frame.rb'
require_relative './errors/invalid_frame.rb'
require_relative './errors/exceeded_maximum_frames.rb'

# Register a player and his frames
class Game
  FRAMES = 10

  attr_reader :player, :frames

  def initialize(player:)
    @player = player
    @frames = []
  end

  def add_frame(frame)
    raise Errors::InvalidFrame unless frame.is_a? Frame
    return @frames << frame if @frames.length < FRAMES

    raise Errors::ExceededMaximumFrames
  end

  def score
    @frames.map(&:total_score)
  end
end

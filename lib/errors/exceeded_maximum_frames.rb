# frozen_string_literal: true

module Errors
  # Custom error class to display when a game exceeded the max number of frames
  class ExceededMaximumFrames < StandardError
    def initialize
      super('The frames for the game exceeded the maximum')
    end
  end
end

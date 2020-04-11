# frozen_string_literal: true

module Errors
  # Custom error class to display when a board try to add a invalid game
  class InvalidGame < StandardError
    def initialize
      super('The object to add is not an intance of Game')
    end
  end
end

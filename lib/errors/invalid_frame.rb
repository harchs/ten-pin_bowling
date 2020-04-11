# frozen_string_literal: true

module Errors
  # Custom error class to display when a game try to add a invalid frame
  class InvalidFrame < StandardError
    def initialize
      super('The object to add is not an intance of Frame')
    end
  end
end

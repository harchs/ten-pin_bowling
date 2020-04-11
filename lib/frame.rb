# frozen_string_literal: true

# Base Frame model
class Frame
  MAX_PINS = 10
  attr_reader :first_attempt, :second_attempt, :third_attempt

  attr_accessor :previous_frame, :next_frame

  def strike?
    raise NotImplementedError
  end

  def spare?
    raise NotImplementedError
  end

  def score
    raise NotImplementedError
  end

  def total_score
    raise NotImplementedError
  end

  def to_s
    raise NotImplementedError
  end
end

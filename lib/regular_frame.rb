# frozen_string_literal: false

require_relative './frame.rb'
require_relative './errors/exceeded_maximum_frames.rb'
# Have a control of the attempts of a player
# it only must used when the first_attempt is less than 10
class RegularFrame < Frame
  def initialize(first_attempt:)
    validate_value(first_attempt)
    validate_first_attempt(first_attempt)
    @first_attempt = first_attempt
  end

  def second_attempt=(second_attempt)
    validate_value(second_attempt)
    validate_second_attempt(second_attempt)
    @second_attempt = second_attempt
  end

  def strike?
    false
  end

  def spare?
    first_attempt.to_i + second_attempt.to_i == MAX_PINS
  end

  def score
    first_attempt.to_i + second_attempt.to_i
  end

  def total_score
    total = score
    total += previous_frame.total_score if previous_frame
    total += next_frame.first_attempt.to_i if spare? && next_frame
    total
  end

  def to_s
    "#{first_attempt}\t#{spare? ? '/' : second_attempt}\t"
  end

  private

  def invalid_pinfalls_for_frame(value)
    "Invalid pinfalls for a RegularFrame: #{value}"
  end

  def valid_value?(value)
    return value >= 0 && value <= 10 if value.is_a?(Integer)

    value.downcase == 'f' if value.is_a?(String)
  end

  def validate_value(value)
    msg = "Invalid value for attempt #{value}"
    raise StandardError, msg unless valid_value?(value)
  end

  def validate_first_attempt(value)
    invalid_first_attempt = value.to_i >= Frame::MAX_PINS
    msg = "Invalid value for first attempt: #{value}"
    raise StandardError, msg if invalid_first_attempt
  end

  def validate_second_attempt(value)
    exceeded_pins = first_attempt.to_i + value.to_i > Frame::MAX_PINS
    msg = "Second attempt exceeds pinfalls : #{value}"
    raise StandardError, msg if exceeded_pins
  end
end

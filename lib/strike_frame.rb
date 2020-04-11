# frozen_string_literal: true

require_relative './frame.rb'

# Have a control of the strike frame of a player
# it only must used when the first_attempt is 10
class StrikeFrame < Frame
  def initialize
    @first_attempt = Frame::MAX_PINS
  end

  def second_attempt=(second_attempt)
    invalid_second_attempt = second_attempt > Frame::MAX_PINS
    raise StandardError, 'Maximun pins exceeded' if invalid_second_attempt

    @second_attempt = second_attempt
  end

  def third_attempt=(third_attempt)
    invalid_third_attempt = third_attempt > Frame::MAX_PINS
    raise StandardError, 'Maximun pins exceeded' if invalid_third_attempt

    @third_attempt = third_attempt
  end

  def strike?
    true
  end

  def spare?
    false
  end

  def score
    first_attempt
  end

  def total_score
    total = score
    total += previous_frame.total_score if previous_frame
    if next_frame
      total += next_frame_total_core(next_frame)
    elsif second_attempt && third_attempt
      total += second_attempt + third_attempt
    end
    total
  end

  def to_s
    last_frame = !next_frame && second_attempt && third_attempt
    second_attempt_value = second_attempt == MAX_PINS ? 'X' : second_attempt
    third_attempt_value = third_attempt == MAX_PINS ? 'X' : third_attempt
    return "X\t#{second_attempt_value}\t#{third_attempt_value}" if last_frame

    "\tX\t"
  end

  private

  def next_frame_total_core(next_frame)
    total = 0
    total += next_frame.first_attempt
    total += if next_frame.strike? && next_frame.next_frame
               next_frame.next_frame.first_attempt
             else
               next_frame.second_attempt
             end
    total
  end
end

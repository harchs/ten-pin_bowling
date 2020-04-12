# frozen_string_literal: true

require_relative './board.rb'
require_relative './frame.rb'
require_relative './game.rb'
require_relative './regular_frame.rb'
require_relative './strike_frame.rb'
require_relative './errors/exceeded_maximum_frames.rb'

# Create a new board loading the frames from a collection
class BoardLoader
  # @params [Array]
  def initialize(pinfalls)
    @pinfalls = pinfalls
    @board = Board.new
  end

  def call
    @pinfalls.each do |row|
      player, pinfalls = parse_data(row)
      game_for_player = game_for_player(player)

      @board.add_game(game_for_player) if game_for_player.frames.empty?
      last_frame = game_for_player.frames.last
      create_frame(game_for_player, pinfalls) && next unless last_frame

      if game_for_player.frames.length == 10
        frames_filled = !last_frame.second_attempt.nil?
        frames_filled &&= !last_frame.third_attempt.nil? if last_frame.strike?
        raise Errors::ExceededMaximumFrames if frames_filled
      end

      if last_frame.strike? || last_frame.second_attempt
        create_next_frame(game_for_player, pinfalls, last_frame)
      else
        last_frame.second_attempt = pinfalls
      end
    end
    @board
  end

  private

  def parse_data(row)
    player = row[0]
    pinfalls = row[1].match(/\A[-+]?[0-9]+\z/) ? row[1].to_i : row[1]
    [player, pinfalls]
  end

  def strike_frame?(pinfalls)
    pinfalls == Frame::MAX_PINS
  end

  def regular_frame?(pinfalls)
    pinfalls != Frame::MAX_PINS
  end

  def build_frame(pinfalls)
    return StrikeFrame.new if strike_frame?(pinfalls)

    RegularFrame.new(first_attempt: pinfalls) if regular_frame?(pinfalls)
  end

  def create_frame(game, pinfalls)
    frame = build_frame(pinfalls)
    game.add_frame(frame)
    frame
  end

  def game_for_player(player)
    existing_game = @board.games.find { |game| game.player == player }
    existing_game || Game.new(player: player)
  end

  def create_relationships_for_frame(frame, last_frame)
    frame.previous_frame = last_frame
    last_frame.next_frame = frame
  end

  def bonus_rolls(last_frame, pinfalls)
    second_attempt_exist = !last_frame.second_attempt.nil?
    third_attempt_exist = !last_frame.third_attempt.nil?
    unless second_attempt_exist
      last_frame.second_attempt = pinfalls
      return
    end
    last_frame.third_attempt = pinfalls unless third_attempt_exist
  end

  def create_next_frame(game, pinfalls, last_frame)
    if game.frames.length < Game::FRAMES
      frame = create_frame(game, pinfalls)
      create_relationships_for_frame(frame, last_frame)
    elsif game.frames.length == Game::FRAMES && game.frames.last.strike?
      bonus_rolls(last_frame, pinfalls)
    end
  end
end

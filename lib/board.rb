# frozen_string_literal: false

require_relative './errors/invalid_game.rb'

# Display a summary of all games
class Board
  attr_reader :games

  def initialize
    @games = []
  end

  def add_game(game)
    raise Errors::InvalidGame unless game.is_a?(Game)

    games << game
  end

  def to_s
    frames_indicator = Game::FRAMES.times.map do |frame|
      "#{frame + 1}\t\t"
    end
    string = "Frame\t\t#{frames_indicator.join}\n"
    games.each do |game|
      player = game.player
      string << [player, frames(game), total_score_per_frames(game)].join("\n")
      string << "\n"
    end
    string
  end

  private

  def frames(game)
    frames = game.frames.map(&:to_s)
    "Pinfalls\t#{frames.join}"
  end

  def total_score_per_frames(game)
    total_score_per_frames = game.score.map do |score|
      "#{score}\t\t"
    end
    "Score\t\t#{total_score_per_frames.join}"
  end
end

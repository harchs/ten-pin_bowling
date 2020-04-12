# frozen_string_literal: true

require_relative './lib/board.rb'

namespace :ten_pin_bowling do
  task :load do
    file_path = ARGV[1]
    raise StandardError, 'File path is required' if file_path.nil?

    begin
      board = Board.generate_from_file(file_path)
      puts board.to_s
    rescue StandardError => e
      puts e.message
    end
  end
end

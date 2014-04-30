require "fourchan_kit/version"
require "fourchan_kit/api"
require "fourchan_kit/thread"
require "fourchan_kit/post"

module FourchanKit
  $fourchan_boards = []

  ##
  # Returns an array of all boards' title, such as _b_, _g_, _fit_ etc.
  #
  # @return [Array] name of all boards
  def self.fourchan_boards
    fetch_fourchan_boards if $fourchan_boards.empty?
    $fourchan_boards
  end

  ##
  # Updates the list of boards and returns an array of the boards.
  #
  # @return [Array] name of all boards
  def self.fetch_fourchan_boards
    puts "Fetching all 4chan boards"
    $fourchan_boards = []
    FourchanKit::API.get_boards.each do |board|
      $fourchan_boards << board["board"]
    end
    $fourchan_boards
  end

end

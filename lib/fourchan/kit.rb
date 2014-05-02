require "fourchan/kit/api"
require "fourchan/kit/board"
require "fourchan/kit/post"
require "fourchan/kit/thread"
require "fourchan/kit/tools"
require "fourchan/kit/version"

module Fourchan
  module Kit
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
      Fourchan::Kit::API.get_boards.each do |board|
        $fourchan_boards << board["board"]
      end
      $fourchan_boards
    end
  end
end

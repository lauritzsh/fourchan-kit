require 'json'
require 'open-uri'

module Fourchan
  module Kit

    ##
    # This module contains methods for the 4chan API.  
    # They all parse the JSON 4chan delivers and returns an Array object.
    module API
      BASE_API_URL = 'https://a.4cdn.org'

      ##
      # Returns information for all boards across 4chan.
      #
      # @return [Array] information for all boards.
      def self.get_boards
        JSON.parse(open("#{BASE_API_URL}/boards.json").read)['boards']
      end

      ##
      # Returns information for all threads on specified board.
      #
      # @param board [String] the board.
      # @return [Array] all threads for a board.
      def self.get_catalog(board)
        JSON.parse(open("#{BASE_API_URL}/#{board}/catalog.json").read)
      end

      ##
      # Returns only id and time for threads on specified board.
      #
      # @param board [String] the board.
      # @return [Array] the id and time for all threads.
      def self.get_threads(board)
        JSON.parse(open("#{BASE_API_URL}/#{board}/threads.json").read)
      end

      ##
      # Returns all posts for the specified thread.
      #
      # @param board [String] the board.
      # @param thread [Integer] the thread number.
      # @return [Array] the posts in from a thread.
      def self.get_thread(board, thread)
        JSON.parse(open("#{BASE_API_URL}/#{board}/thread/#{thread}.json").read)['posts']

      end

      ##
      # Returns the threads at a page number on specified board.
      #
      # 4chan stopped using zero-index pages in April. Instead of first page
      # is at 0, it is now at 1. 0 returns nothing.
      #
      # @param board [String] the board.
      # @param page  [Integer] the thread number.
      # @return [Array] all threads from a page.
      def self.get_page(board, page)
        JSON.parse(open("#{BASE_API_URL}/#{board}/#{page}.json").read)['threads']
      end
    end
  end
end

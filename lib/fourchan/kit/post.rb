require 'ostruct'

module Fourchan
  module Kit

    ##
    # Post should make it easy to use OpenStruct for posts in a thread.  
    # Also make it possible to get the link for the image, if the post has one.
    class Post < OpenStruct
      def initialize(hash, board)
        super(hash)
        @board = board
      end

      ##
      # Return an URL for the image (if user submitted an image).
      #
      # @return [URL] the URL for the image.
      def image_link
        "http://i.4cdn.org/#{@board}/#{self.tim}#{self.ext}" if self.tim
      end
    end
  end
end

module Fourchan
  module Kit

    ##
    # Thread is used to deal with a thread from a board.
    class Thread
      attr_reader :thread, :board

      def initialize(board, thread)
        @posts  = []
        @board  = board
        @thread = API.get_thread(board, thread)
      end

      ##
      # Returns all posts from the thread, including OP.
      def posts
        if @posts.empty?
          @thread.each do |post|
            @posts << Post.new(post, @board)
          end
        end
        @posts
      end

      ##
      # Return only the first post from the thread.
      def op
        self.posts[0]
      end

      ##
      # Get all replies from the thread. OP is not included.  
      # It then returns the replies.
      def fetch_replies
        @posts = []
        @thread = API.get_thread(@board, self.op.no)
        self.replies
      end

      ##
      # Return all the replies. OP is not included.
      def replies
        self.posts[1..-1]
      end

      ##
      # Returns an array of image URLs from the thread (see {Fourchan::Kit::Post#image_link}).
      def images
        images = []
        self.posts.each do |post|
          images << post.image_link
        end
        images.compact
      end
    end
  end
end

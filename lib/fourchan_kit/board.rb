module FourchanKit

  ##
  # Board is used to deal with a 4chan board.
  class Board
    attr_reader :board

    def initialize(board)
      if FourchanKit.fourchan_boards.include?(board)
        @name  = board
        @board = API.get_catalog(board)
      else
        raise "Not a valid board."
      end
    end

    ##
    # Returns only the first post (OP) from the threads on a page.
    #
    # @param page [Integer] the page to get threads from.
    # @return [Array]
    def threads(page = 1)
      threads = []
      @board[page - 1]["threads"].each do |thread|
        threads << Post.new(thread, @name)
      end
      threads
    end

    ##
    # Returns all threads, but not its replies, for the entire board.
    #
    # @return [Array]
    def all_threads
      all_threads = []
      @board.each do |page|
        all_threads << threads(page["page"])
      end
      all_threads.flatten
    end

    ##
    # Returns all the posts from the threads on a page.
    # 
    # @param page [Integer] the page to get threads from.
    # @return [Array]
    def posts(page = 1)
      posts   = []
      threads = threads(page)
      threads.each do |t|
        thread = Thread.new(@name, t.no)
        posts << thread.posts
      end
      posts.flatten
    end

    ##
    # Returns all posts for the entire board.  
    # *Note*: This method is pretty slow. Just wait for it to finish.
    #
    # @return [Array]
    def all_posts
      posts = []
      @board.each_with_index do |_, i|
        posts << posts(i + 1)
      end
      posts.flatten
    end

    alias_method :catalog, :board
  end
end

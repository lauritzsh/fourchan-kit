#Fourchan::Kit
Fourchan::Kit is a Ruby wrapper and tool for the 4chan API. Use Fourchan::Kit to interact
with the API using Ruby, or use the tool to interact with the threads on 4chan.

##Installation
    [sudo] gem install fourchan-kit

##Usage
Be sure to checkout out the
[documentation](http://lauritzsh.github.io/fourchan-kit/), if you are in doubt of how
something works.

###Using the Board class
    require 'fourchan/kit'

    g = Fourchan::Kit::Board.new 'g'
    g.threads(1)   # All threads from the first page (but not replies)
    g.posts(1)     # All threads and its replies

    g.all_threads  # All threads for the board (but not replies)
    g.all_posts    # All posts and its replies for the board

That's pretty much all there is to `Board`. They all return an array of `Post`,
so it's possible to do:

    g.threads(1).first.no          # => 39894014
    g.threads(1).first.image_link  # => http://i.4cdn.org/g/1390842451744.png

###Using the Thread class
For now it needs a board and a thread number. Later it might be possible to give
an URL instead.

    require 'fourchan/kit'

    t = Fourgem::Thread.new 'wg', 5777336
    t.op       # Return thread starter
    t.replies  # Return all replies to the thread (excluding OP)
    t.posts    # Return all posts in thread (including OP)
    t.images   # Return an array of all images (links to the images)

    # Each post is a Post object (OpenStruct)
    t.posts.each do |post|
      post.image_link  # => 'http://i.4cdn.org/wg/1398597510994.jpg'
      post.com         # => 'Hey,<br>Some one on my FB took ...'
      post.tim         # => 1398597510994
      post.ext         # => '.jpg'
      post.no          # => 5777336
      post.name        # => 'Anonymous'
      post.sub         # => 'Urban/Architecture'
    end

###Using the binary
    $ fourchan help
    Commands:
      fourchan download        # Download all images from a thread
      fourchan help [COMMAND]  # Describe available commands or one specific command
      fourchan lurk THREAD     # Look for new messages and/or download new images

    $ fourchan download -u http://boards.4chan.org/wg/thread/5777336 -o buildings
    Downloading: http://i.4cdn.org/wg/1398597510994.jpg @  428.81kB
    Downloading: http://i.4cdn.org/wg/1398597561903.jpg @  324.91kB
    Downloading: http://i.4cdn.org/wg/1398617625457.jpg @  222.96kB
    Downloading: http://i.4cdn.org/wg/1398617657152.jpg @  572.74kB
    Downloading: http://i.4cdn.org/wg/1398622970113.jpg @ 1122.49kB
    $
    $ cat threads.txt
    http://boards.4chan.org/wg/thread/5777976
    http://boards.4chan.org/wg/thread/5777265
    http://boards.4chan.org/wg/thread/5721
    $
    $ fourchan download -f threads.txt
    Getting images from thread: http://boards.4chan.org/wg/thread/5777976
    Downloading: http://i.4cdn.org/wg/1398648908295.jpg @ 1618.35kB
    Downloading: http://i.4cdn.org/wg/1398649547061.jpg @  634.04kB
    
    Getting images from thread: http://boards.4chan.org/wg/thread/5777265
    Downloading: http://i.4cdn.org/wg/1398591368018.jpg @  182.12kB
    Downloading: http://i.4cdn.org/wg/1398593765693.jpg @  713.01kB
    Downloading: http://i.4cdn.org/wg/1398593933823.jpg @  678.24kB
    Downloading: http://i.4cdn.org/wg/1398626568293.jpg @  462.13kB
    Downloading: http://i.4cdn.org/wg/1398627582485.jpg @  283.39kB
    
    Getting images from thread: http://boards.4chan.org/wg/thread/5721
    Not a 4chan thread
    
    $

Lurk is pretty much the same as `download -u THREAD`, it does not finish after
downloading though, but rather keep checking for new images. User can define
the interval between checks.  
See `fourchan help lurk`.

##Why Fourchan::Kit?
I wanted to try and make a Ruby gem, so it's basically just a little, personal
project.

Also with the new changes to the 4chan API (use /thread/ instead of /res/), a
lot of old 4chan gems are dead. Fourchan::Kit might be able to replace some of those
dead gems.

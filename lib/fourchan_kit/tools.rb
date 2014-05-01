require 'mechanize'
require 'pathname'

module FourchanKit

  module Tools
    $agent = Mechanize.new


    ##
    # Downloads the image from an URL.
    #
    # @param link [URL] the URL where the image is.
    def self.download_image(link, options = {})
      options[:fsize] ||= 0
      options[:name]  ||= link.split('/').last
      options[:out]   ||= "#{Dir.pwd}/images"
      options[:quiet] ||= false

      image = "#{create_dir(options[:out])}/#{options[:name]}"
      unless File.exists?(image)
        if valid_link?(link)
          output = "Downloading: #{link}" unless options[:quiet]
          output << (options[:fsize].zero? ? "" : " @ " << "#{(options[:fsize] / 1024.0).round(2)}kB".rjust(9))
          puts output
          $agent.get(link).save(image)
        end
      else
        puts "Already got image, skipping" unless options[:quiet]
      end
    end

    ##
    # Downloads every image from a thread.
    #
    # @param link [URL] the URL for the thread to download.
    def self.download_thread(link, options = {})
      options[:checked] ||= false

      if options[:checked] || ( valid_thread?(link) && valid_link?(link) )
        board, thread_no = get_info(link)
        thread = Thread.new(board, thread_no)

        thread.posts.each do |post|
          options[:fsize] = post.fsize
          download_image(post.image_link, options.dup) if post.image_link
        end
      else
        puts "Not a 4chan thread" unless options[:quiet]
      end
    end

    ##
    # Download all images from each thread in a file.
    #
    # Each thread must be on its own line and only be the URL, nothing else.  
    # For example:
    #     # threads.txt
    #     http://boards.4chan.org/wg/thread/5777567
    #     http://boards.4chan.org/wg/thread/5776602
    #
    # It takes care of dead threads or wrong URLs.
    #
    # @param file [File] the location of the file.
    def self.download_threads(file, options = {})
      options[:quiet] ||= false

      if File.exists?(file)
        File.open(file, 'r').each_line do |link|
          puts "Getting images from thread: #{link}" unless options[:quiet]
          if valid_thread?(link) && valid_link?(link)
            options[:out]     = "images/#{link.scan(/(\d+)$/).first.first}"
            options[:checked] = true
            download_thread(link, options)
            puts
          else
            puts "Not a 4chan thread" unless options[:quiet]
            puts
          end
        end
      else
        puts "Not able to find the input file"
      end
    end

    ##
    # Check the thread for new images every x seconds.
    #
    # - The refresh rate is determined by options[:refresh] and is an integer.  
    # - The time to lurk is determined by options[:timeout] and is an integer.
    #
    # @param link [URL] the thread to lurk
    def self.lurk(link, options = {})
      puts "Started lurking #{link}"

      downloaded = []
      board, thread_no = get_info(link)
      thread = Fourgem::Thread.new(board, thread_no)

      download_image(thread.op.image_link, options.dup)

      begin
        timeout(options[:timeout]) do
          loop do
            puts "Checking for images" unless options[:quiet]
            new = thread.fetch_replies

            (new - downloaded).each do |post|
              options[:fsize] = post.fsize
              download_image(post.image_link, options.dup) if post.image_link

              downloaded << post
            end

            sleep(options[:refresh])
          end
        end
      rescue Timeout::Error
        puts "Timeout after #{options[:timeout]} second(s)"
        exit 0
      end
    end

    private
    def self.create_dir(directory)
      FileUtils.mkdir_p(directory) unless File.exists?(directory)
      Pathname.new(directory).realpath.to_s
    end

    def self.get_info(link)
      board  = link.scan(/(\w+)\/thread\//).first.first
      thread = link.scan(/\/thread\/([0-9]+)/).first.first.to_i
      [board, thread]
    end

    def self.valid_thread?(link)
      link =~ /boards.4chan.org\/\w+\/thread\/\d+$/ ? true : false
    end

    def self.valid_link?(link)
      begin
        if link =~ /^#{URI::regexp(['http', 'https'])}$/
          begin
            $agent.get(link)
          rescue Mechanize::ResponseCodeError
            return false
          end
        else
          return false
        end

        true
      end
    end
  end
end

require 'fourchan/kit'
require 'thor'

module Fourchan
  module Kit

    class CLI < Thor
      option :url,    aliases: '-u', desc: 'A valid URL for a thread'
      option :file,   aliases: '-f', desc: 'Download images for every thread in a file'
      option :out,    aliases: '-o', desc: 'In what folder should the images be saved to', default: 'images'
      option :quiet,  aliases: '-q', desc: 'Do not output unecessary messages', type: :boolean
      desc "download", "Download all images from a thread"
      def download
        url, file = options[:url], options[:file]
        if url
          Fourchan::Kit::Tools.download_thread(url, options.dup)
        elsif file
          Fourchan::Kit::Tools.download_threads(file, options.dup)
        else
          puts "I need some input to download the images. See `fourgem help download` for options."
        end
      end

      option :timeout, aliases: '-t', desc: 'For how long should the thread be lurked. 0 to disable timeout', type: :numeric, default: 60
      option :quiet,   aliases: '-q', desc: 'Do not output unecessary messages', type: :boolean
      option :refresh, aliases: '-r', desc: 'How often to check for new replies', type: :numeric, default: 30
      option :out,     aliases: '-o', desc: 'Where to save images', default: 'images'
      # option :download, aliases: '-d', desc: 'Lurk for new images and download them', type: :boolean
      # option :messages, aliases: '-m', desc: 'Lurk for new messages', type: :boolean, default: true
      # option :out,      aliases: '-o', desc: 'There folder to store the images', default: 'images'
      desc "lurk THREAD", "Look for new messages and/or download new images"
      def lurk(thread)
        options[:refresh] >= 5 ? Fourchan::Kit::Tools.lurk(thread, options.dup) : puts("Be fair, have refresh >= 5")
      end
    end
  end
end

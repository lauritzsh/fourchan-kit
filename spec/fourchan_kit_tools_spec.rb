require 'spec_helper'

describe Fourchan::Kit::Tools, :vcr do
  it 'should download an image' do
    Fourchan::Kit::Tools.download_image 'http://i.4cdn.org/g/1399051774807.jpg'
    File.exists?('images').should == true
    File.exists?('images/1399051774807.jpg').should == true
    FileUtils.rm_rf('images')
  end

  it 'should download images from a thread' do
    Fourchan::Kit::Tools.download_thread 'http://boards.4chan.org/g/thread/41706090'
    File.exists?('images').should == true
    Dir['images/*'].should have(2).items
    Dir['images/*'].should == ["images/1399051774807.jpg", "images/1399052297446.jpg"]
    FileUtils.rm_rf('images')
  end

  it 'should download a list of threads' do
    Fourchan::Kit::Tools.download_threads 'spec/threads.txt'
    File.exists?('images').should == true
    Dir['images/*'].should have(2).items      # 2 folders
    Dir['images/**/*'].should have(6).items   # 4 images and 2 folders
    FileUtils.rm_rf('images')
  end

  it 'should lurk'

  it 'should create a directory' do
    Fourchan::Kit::Tools.create_dir 'some_test/directory'
    File.exists?('some_test/directory').should == true
    FileUtils.rm_rf('some_test')
  end

  it 'should get board and thread from a link' do
    board, thread = Fourchan::Kit::Tools.get_info 'http://boards.4chan.org/g/thread/41706090'
    board.should == 'g'
    thread.should == 41706090
  end

  it 'should verify it\'s a thread' do
    valid = Fourchan::Kit::Tools.valid_thread? 'http://boards.4chan.org/g/thread/41706090'
    valid.should == true
    invalid = Fourchan::Kit::Tools.valid_thread? 'http://boards.4chan.org/g/res/41706090'
    invalid.should == false
  end

  it 'should verify it\'s not a dead thread' do
    alive = Fourchan::Kit::Tools.valid_link? 'http://boards.4chan.org/g/thread/41706090'
    alive.should == true
  end

  context 'when it is dead' do
    it 'should handle that' do
      dead = Fourchan::Kit::Tools.valid_link? 'http://boards.4chan.org/g/thread/1337'
      dead.should == false
    end
  end
end

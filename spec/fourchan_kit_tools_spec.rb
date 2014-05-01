require 'spec_helper'

describe FourchanKit::Tools, :vcr do
  it 'should download an image' do
    VCR.use_cassette 'tools/images' do
      FourchanKit::Tools.download_image 'http://i.4cdn.org/g/1398920016720.png'
      File.exists?('images').should == true
      File.exists?('images/1398920016720.png').should == true
      FileUtils.rm_rf('images')
    end
  end

  it 'should download images from a thread' do
    VCR.use_cassette 'tools/images' do
      FourchanKit::Tools.download_thread 'http://boards.4chan.org/g/thread/41689166'
      File.exists?('images').should == true
      Dir['images/*'].should have(2).items
      Dir['images/*'].should == ["images/1398964419428.png", "images/1398970128533.png"]
      FileUtils.rm_rf('images')
    end
  end

  it 'should download a list of threads' do
    VCR.use_cassette 'tools/images' do
      FourchanKit::Tools.download_threads 'spec/threads.txt'
      File.exists?('images').should == true
      Dir['images/*'].should have(2).items      # 2 folders
      Dir['images/**/*'].should have(11).items  # 9 images and 2 folders
      FileUtils.rm_rf('images')
    end
  end

  it 'should lurk'

  it 'should create a directory' do
    FourchanKit::Tools.create_dir 'some_test/directory'
    File.exists?('some_test/directory').should == true
    FileUtils.rm_rf('some_test')
  end

  it 'should get board and thread from a link' do
    board, thread = FourchanKit::Tools.get_info 'http://boards.4chan.org/g/thread/41675435'
    board.should == 'g'
    thread.should == 41675435
  end

  it 'should verify it\'s a thread' do
    valid = FourchanKit::Tools.valid_thread? 'http://boards.4chan.org/g/thread/41675435'
    valid.should == true
    invalid = FourchanKit::Tools.valid_thread? 'http://boards.4chan.org/g/res/41675435'
    invalid.should == false
  end

  it 'should verify it\'s not a dead thread' do
    VCR.use_cassette 'tools/link' do
      alive = FourchanKit::Tools.valid_link? 'http://boards.4chan.org/g/thread/41675435'
      alive.should == true
    end
  end

  context 'when it is dead' do
    it 'should handle that' do
      VCR.use_cassette 'tools/link' do
        dead = FourchanKit::Tools.valid_link? 'http://boards.4chan.org/g/thread/1337'
        dead.should == false
      end
    end
  end
end

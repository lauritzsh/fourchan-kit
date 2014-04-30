require 'spec_helper'

describe FourchanKit, :vcr do
  it 'should be able to get an array of board names' do
    VCR.use_cassette 'api/boards' do
      boards = FourchanKit.fourchan_boards
      boards.length.should == 63
      boards.first.should == '3'
      boards.last.should == 'y'
    end
  end
end

describe FourchanKit::API, :vcr do
  it 'should be able to get info for all boards' do
    VCR.use_cassette 'api/boards' do
      boards = FourchanKit::API.get_boards
      boards.length.should == 63
    end
  end

  it 'should be able to get the catalog for a board' do
    VCR.use_cassette 'api/catalog' do
      catalog = FourchanKit::API.get_catalog 'g'
      catalog.length.should == 10
      catalog.first['page'].should == 1
      catalog.first['threads'].first['no'] == 39894014
    end
  end

  it 'should be able to get the threads for a board' do
    VCR.use_cassette 'api/threads' do
      threads = FourchanKit::API.get_threads 'g'
      threads.length.should == 10
      threads.first['page'].should == 1
      threads.first['threads'].first['no'].should == 39894014
    end
  end

  it 'should be able to get the posts from a thread' do
    VCR.use_cassette 'api/posts' do
      posts = FourchanKit::API.get_thread 'g', 41658861
      posts.length.should == 69
      posts.first['no'].should == 41658861
      posts.last['no'].should == 41665533
    end
  end

  it 'should be able to get threads from a page' do
    VCR.use_cassette 'api/page' do
      posts = FourchanKit::API.get_page 'g', 1
      posts.length.should == 15
      posts.first['posts'].first['no'].should == 39894014
    end
  end
end

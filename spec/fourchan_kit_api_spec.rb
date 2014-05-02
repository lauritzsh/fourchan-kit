require 'spec_helper'

describe FourchanKit::API, :vcr do
  it 'should be able to get info for all boards' do
    boards = FourchanKit::API.get_boards
    boards.length.should == 63
  end

  it 'should be able to get the catalog for a board' do
    catalog = FourchanKit::API.get_catalog 'g'
    catalog.length.should == 10
    catalog.first['page'].should == 1
    catalog.first['threads'].first['no'] == 39894014
  end

  it 'should be able to get the threads for a board' do
    threads = FourchanKit::API.get_threads 'g'
    threads.length.should == 10
    threads.first['page'].should == 1
    threads.first['threads'].first['no'].should == 39894014
  end

  it 'should be able to get the posts from a thread' do
    posts = FourchanKit::API.get_thread 'g', 41706090
    posts.length.should == 6
    posts.first['no'].should == 41706090
    posts.last['no'].should == 41706626
  end

  it 'should be able to get threads from a page' do
    posts = FourchanKit::API.get_page 'g', 1
    posts.length.should == 15
    posts.first['posts'].first['no'].should == 39894014
  end
end

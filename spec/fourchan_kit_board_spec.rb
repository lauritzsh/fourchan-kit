require 'spec_helper'

describe FourchanKit::Board, :vcr do

  before(:each) do
    VCR.use_cassette 'api/catalog' do
      @board = FourchanKit::Board.new 'g'
    end
  end

  it 'should have 10 pages' do
    @board.board.length.should == 10
  end
  
  it 'and have 15 threads per page' do
    @board.threads(1).length.should == 15
  end
  
  it 'and should have a total of 150 threads' do
    @board.all_threads.length.should == 150
  end

  it 'should have 1145 posts on the first page' do
    VCR.use_cassette 'board/first_page_posts' do
      @board.posts.length.should == 1145
    end
  end

  it 'and a total of 6641 posts' do
    VCR.use_cassette 'board/all_posts' do
      @board.all_posts.length.should == 6641
    end
  end
end

require 'spec_helper'

describe Fourchan::Kit::Board, :vcr do

  before(:each) do
    @board = Fourchan::Kit::Board.new 'g'
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

  it 'should have 908 posts on the first page' do
    @board.posts.length.should == 908
  end

  it 'and a total of 7685 posts' do
    @board.all_posts.length.should == 7685
  end
end

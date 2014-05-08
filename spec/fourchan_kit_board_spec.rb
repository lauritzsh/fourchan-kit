require 'spec_helper'

describe Fourchan::Kit::Board, :vcr do

  let(:board) { Fourchan::Kit::Board.new('g') }

  it 'should have 10 pages' do
    expect(board.catalog.length).to eql(10)
  end

  it 'and have 15 threads per page' do
    expect(board).to have(15).threads(1)
  end

  it 'and should have a total of 150 threads' do
    expect(board.all_threads.length).to eql(150)
  end

  it 'should have 908 posts on the first page' do
    expect(board).to have(908).posts
  end

  it 'and a total of 7685 posts' do
    expect(board.all_posts.length).to eql(7685)
  end
end

require 'spec_helper'

describe Fourchan::Kit, :vcr do
  it 'should be able to get an array of board names' do
    boards = Fourchan::Kit.fourchan_boards
    boards.length.should == 63
    boards.first.should == '3'
    boards.last.should == 'y'
  end
end

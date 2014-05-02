require 'spec_helper'

describe FourchanKit, :vcr do
  it 'should be able to get an array of board names' do
    boards = FourchanKit.fourchan_boards
    boards.length.should == 63
    boards.first.should == '3'
    boards.last.should == 'y'
  end
end

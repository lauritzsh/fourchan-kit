require 'spec_helper'

describe Fourchan::Kit::Thread, :vcr do
  before(:each) do
    @thread = Fourchan::Kit::Thread.new 'g', 41706090
  end

  it 'should have posts' do
    @thread.posts.length.should == 6
  end

  it 'should have replies' do
    @thread.replies.length.should == 5
  end

  it 'should have some images' do
    @thread.images.length.should == 2
  end

  it 'and return nothing if poster didn\'t submit one' do
    @thread.posts.last.image_link.should == nil
  end

  context 'when using #op' do
    it 'should have a name' do
      @thread.op.name.should == 'Anonymous'
    end

    it 'with a link to the image'  do
      @thread.op.image_link.should == 'http://i.4cdn.org/g/1399051774807.jpg'
    end
  end
end

describe FourchanKit::Thread, :vcr do
  before(:each) do
    VCR.use_cassette 'api/posts' do
      @thread = FourchanKit::Thread.new 'g', 41658861
    end
  end

  it 'should have posts' do
    @thread.posts.length.should == 69
  end

  it 'should have replies' do
    @thread.replies.length.should == 68
  end

  it 'should have some images' do
    @thread.images.length.should == 8
  end

  it 'and return nothing if poster didn\'t submit one' do
    @thread.posts.last.image_link.should == nil
  end

  context 'when using #op' do
    it 'should have a name' do
      @thread.op.name.should == 'Anonymous'
    end

    it 'with a link to the image'  do
      @thread.op.image_link.should == 'http://i.4cdn.org/g/1398815408707.png'
    end
  end
end

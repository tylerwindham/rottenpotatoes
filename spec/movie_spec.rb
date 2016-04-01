require 'spec_helper'

describe Movie do
  describe 'searching similar directors' do
    it 'should call Movie with director' do
      Movie.should_receive(:same_director).with('Star Wars')
      Movie.same_director('Star Wars')
    end
  end
  
  describe "Check for all ratings" do
      it "has to return list of ratings" do
        r = Movie.all_ratings
        r.length.should == 5
      end
    end
end
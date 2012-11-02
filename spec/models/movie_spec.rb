require 'spec_helper'
require 'ruby_debug'

describe Movie do
  describe '.find_all_by_director_of' do
    before :each do
      @m1 = Movie.create!(:title => 'Star Wars', :director => 'George Lucas')
      @m2 = Movie.create!(:title => 'THX-1138', :director => 'George Lucas')
      @m3 = Movie.create!(:title => 'Alien')
    end
    it 'if supplied movie has a director, return all movies with same director (happy path)' do
      Movie.find_all_by_director_of(@m1).should eq([@m1, @m2])
    end
    it 'if supplied movie has no director, return an empty set (sad path)' do
      Movie.find_all_by_director_of(@m3).should be_empty
    end
  end
end

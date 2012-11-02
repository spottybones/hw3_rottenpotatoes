require 'spec_helper'
require 'ruby-debug'

describe MoviesController do
  describe 'find similar movies (same director) to movie specified' do
    before :each do
      @m1 = FactoryGirl.build(:movie, :title => 'Star Wars', :director => 'George Lucas')
      @m2 = FactoryGirl.build(:movie, :title => 'THX-1138', :director => 'George Lucas')
      @m3 = FactoryGirl.build(:movie, :title => 'Alien')
    end
    describe 'call model methods to find subject movie and movies by same director' do
      before :each do
        Movie.should_receive(:find).and_return(@m1)
        Movie.should_receive(:find_all_by_director_of).with(@m1).and_return([@m1, @m2])
        get :similar, {:id => 1}
      end
      it 'should call model method to load the subject movie' do
      end
      it 'should call a model method to load movies by the same director' do
      end
    end
    describe 'if movies were found (happy path)' do
      before :each do
        Movie.stub(:find).and_return(@m1)
        Movie.stub(:find_all_by_director_of).and_return([@m1, @m2])
        get :similar, {:id => 1}
      end
      it 'should provide the list to the view template' do
        assigns(:movies).should == [@m1, @m2]
      end
      it 'should provide the subject movie to the view template' do
        assigns(:subject_movie).should == @m1
      end
      it 'should call the view template to display the similar movies' do
        response.should render_template(:similar)
      end
    end
    describe 'if movies were not found because subject movie had no director (sad path)' do
      before :each do
        Movie.stub(:find).and_return(@m3)
        Movie.stub(:find_all_by_director_of).and_return([])
        get :similar, {:id => 3}
      end
      it 'should set a notice that the movie has no director' do
        flash[:notice].should == "'#{@m3.title}' has no director info"
      end
      it 'should redirect the user to the home page' do
        response.should redirect_to movies_path
      end
    end
  end
end

require 'spec_helper'
require 'ruby-debug'

describe "movies/show.html.haml" do
  it 'displays a link to find similar movies (same director)' do
    assign(:movie, stub_model(Movie, :id => 1, :director => 'Director Man', :release_date => '2012-10-31',
                              :title => 'Dummy Movie'))
    render
    rendered.should have_selector('a',
                                  :href => movies_similar_path(:id => 1),
                                  :content => "Find Movies With Same Director")
  end
end

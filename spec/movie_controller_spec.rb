require 'spec_helper'

describe MoviesController, :type => :controller do
   
  describe 'add director' do
    it 'should call update_attributes and redirect to movie_path(movie)' do
      movie=double(Movie, :title => "Ted", :director => "Seth McFarlane", :id => "8")
      Movie.stub(:find).with("8").and_return(movie)
      movie.stub(:update_attributes!)
      put :update, {:id => "8", :movie => movie}
      response.should redirect_to(movie_path(movie))
    end
  end
  
  
  describe 'show page' do
    it 'should call find' do
      Movie.should_receive(:find).with("1")
      get :show, {:id => "1" } 
     
    end
  end
  
   describe 'edit page' do
    it 'should call find' do
     Movie.should_receive(:find).with("1")
     get :edit, {:id => "1" } 
    end
  end
  
  describe 'create' do
    it 'should create a new movie and redirect to movies_path' do
      post :create, {:id => "1"}
      response.should redirect_to(movies_path)
    end
  end 
  
   describe 'destroy' do
    it 'should delete a movie' do
      mov = double(Movie, :id => "12", :title => "The Dark Knight", :director => "Christopher Nolan")
      Movie.stub(:find).with("12").and_return(mov)
      mov.should_receive(:destroy)
      delete :destroy, {:id => "12"}
    end 
  end 
  
  describe 'same director' do
    it 'should get movies with same director' do 
      mov = double(Movie, :id => "12", :title => "The Dark Knight", :director => "Christopher Nolan")
      Movie.stub(:find).with("12").and_return(mov)
      Movie.should_receive(:find_all_by_director)
      post :same_director, {:id => "12"}
    end 
    it 'should redirect to movies_path when movie has no director' do
      mov2 = double(Movie, :id => "13", :title => "The Hangover", :director => '')
      Movie.stub(:find).with("13").and_return(mov2)
      post :same_director, {:id => "13"} 
      response.should redirect_to(movies_path)
    end 
  end
  
    
  describe 'index' do 
      it 'should set sort session to title when title is passed in params' do
        get :index, nil, {:sort => "title"}
        @request.session['sort'].should == "title"
      end 
      
      it 'should set sort session to release_date when release_date is passed in params' do
        get :index, nil, {:sort => "release_date"}
        @request.session['sort'].should == "release_date"
      end 
      
      it 'should set session[:ratings] to params[:ratings] when session[:ratings] != params[:ratings]' do
        get :index, {:ratings => "G, PG"}, {:ratings => "PG-13, R"}
        @request.session['ratings'].should == "G, PG"
      end 
      
      it 'should call find_all_by_rating each time' do 
        Movie.should_receive(:find_all_by_rating)
        get :index
      end
  end 

 


end
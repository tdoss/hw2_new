class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
	
	if (params[:sort_by] != nil)
		session[:sort_by] = params[:sort_by]
	end
    if (session[:sort_by] == 'title')
    	@movies = Movie.all.sort_by {|movie| movie.title}
    	session[:title_css] = 'hilite'
		session[:release_date_css] = nil
    elsif (session[:sort_by] == 'date')
    	@movies = Movie.all.sort_by {|movie| movie.release_date}
		session[:release_date_css] = 'hilite'
		session[:title_css] = nil
	else
		@movies = Movie.all
    end
	
	@all_ratings =  @movies.collect {|record| record[:rating]}.uniq

	if (params[:ratings] != nil)
		puts session[:ratings].inspect
		session[:ratings] = params[:ratings]
	end

	if (session[:ratings] != nil)
		puts session[:ratings].inspect
		@movies = @movies.collect {|item| item if session[:ratings].keys.include?(item[:rating])}.compact
	end

  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end

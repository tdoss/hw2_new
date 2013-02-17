class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @movies = Movie.all
#@movies = Movie.find(:all, :order => 'title') if params[:sort_by] == 'title'
    if (params[:sort_by] == 'title')
      @movies = Movie.all.sort_by {|movie| movie.title}
      @title_css = 'hilite'
    elsif (params[:sort_by] == 'date')
      @movies = Movie.all.sort_by {|movie| movie.release_date}
      @release_date_css = 'hilite'
    end
#    if params[:sort] == "title"
#    @title_header_css = hilite
#end
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
def sort(sort)
# @movies = Movie.all.sort_by {|movie| movie.title}
   @movies = Movie.find(:all, :order => sort) if sort == 'title' || 'date'
end

end

class MoviesController < ApplicationController
  before_filter :has_moviegoer, :only => [:new, :create, :edit, :update]

  protected
  def has_moviegoer
    unless @current_user
      flash[:warning] = "You must be logged in to ... movies."
      redirect_to movies_path
    end
  end

  public
  def index
    @movies = Movie.all.sort_by{|m| m.title}
  end

  def show
    id = params[:id]
    begin
      @movie = Movie.find(id)
    rescue ActiveRecord::RecordNotFound
      flash[:warning] = "Movie Not Found"
      redirect_to movies_path
    end
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(params[:movie])
    if @movie.save
      flash[:notice] = "#{@movie.title} was successfully created."
      redirect_to movies_path
    else
      render 'new'
    end
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    if @movie.update_attributes(params[:movie])
      flash[:notice] = "#{@movie.title} was successfully updated."
      redirect_to movie_path(@movie)
    else
      render 'edit' # note, 'edit' template can access @movie's field values!
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:warning] = "#{@movie.title} Deleted."
    redirect_to movies_path
  end

  def movies_with_filters
    @movies = Movie.with_good_reviews(params[:threshold])
    %w(for_kids recently_reviewed).each do |filter|
      @movies = @movies.send(filter) if params[filter]
    end
  end
end

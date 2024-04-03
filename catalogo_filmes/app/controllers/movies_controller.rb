class MoviesController < ApplicationController
    before_action :set_movie, only: [:show, :edit, :update, :destroy]
  
    # GET /movies
    def index
      @movies = Movie.all
    end
  
    # GET /movies/1
    def show
      @movie
    end
  
    # GET /movies/new
    def new
      @movie = Movie.new
    end
  
    # GET /movies/1/edit
    def edit
        @movie = Movie.find(params[:id])
    end
  
    # POST /movies
    def create
      @movie = Movie.new(movie_params)
      if @movie.save
        redirect_to movies_path, notice: 'Filme foi criado com sucesso.'
      else
        render :new
      end
    end
  
    # PATCH/PUT /movies/1
    def update
      if @movie.update(movie_params)
        redirect_to movies_path, notice: 'Filme foi atualizado com sucesso.'
      else
        render :edit
      end
    end
  
    # DELETE /movies/1
    def destroy
      @movie.destroy
      redirect_to movies_path, notice: 'Filme foi deletado com sucesso.'
    end
  
    private
      def set_movie
        @movie = Movie.find(params[:id])
      end
  
      def movie_params
        params.require(:movie).permit(:title, :release_year, :synopsis, :country, :duration, :director_id, :genre_id)
      end
  end
  
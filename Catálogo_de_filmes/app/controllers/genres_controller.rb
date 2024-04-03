class GenresController < ApplicationController
    before_action :set_genre, only: [:show, :edit, :update]
  
    # GET /genres
    def index
      @genres = Genre.all
    end
  
    # GET /genres/1
    def show
      @genre = Genre.includes(:movies).find(params[:id])
      @movies = @genre.movies
      @directors = Director.where(favorite_genre: @genre.name)    
    end
  
    # GET /genres/new
    def new
      @genre = Genre.new
    end
  
    # GET /genres/1/edit
    def edit
        @genre = Genre.find(params[:id])
    end
  
    # POST /genres
    def create
      @genre = Genre.new(genre_params)
      if @genre.save
        redirect_to genres_path, notice: 'Gênero foi criado com sucesso.'
      else
        render :new
      end
    end
  
    # PATCH/PUT /genres/1
    def update
      if @genre.update(genre_params)
        redirect_to genres_path, notice: 'Gênero foi atualizado com sucesso.'
      else
        render :edit
      end
    end
  
    private
      def set_genre
        @genre = Genre.find(params[:id])
      end
  
      def genre_params
        params.require(:genre).permit(:name)
      end
  end
  
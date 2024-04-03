class DirectorsController < ApplicationController
    before_action :set_director, only: [:show, :edit, :update]
  
    # GET /directors
    def index
      @directors = Director.all
    end
  
    # GET /directors/1
    def show
      @director = Director.includes(:movies).find(params[:id])
      @movies = @director.movies
    end
  
    # GET /directors/new
    def new
      @director = Director.new
    end
  
    # GET /directors/1/edit
    def edit
        @director = Director.find(params[:id])
    end
  
    # POST /directors
    def create
      @director = Director.new(director_params)
      if @director.save
        redirect_to directors_path, notice: 'Diretor foi criado com sucesso.'
      else
        render :new
      end
    end
  
    # PATCH/PUT /directors/1
    def update
      if @director.update(director_params)
        redirect_to directors_path, notice: 'Diretor foi atualizado com sucesso.'
      else
        render :edit
      end
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_director
        @director = Director.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def director_params
        params.require(:director).permit(:name, :nationality, :birthdate, :favorite_genre)
      end
  end
  
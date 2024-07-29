class FragrancesController < ApplicationController

    def index
        @fragrances = Fragrance.all
    end

    def new
        @fragrance = Fragrance.new
    end

    def create
        @fragrance = Fragrance.new(fragrance_params)
        binding.pry
        if @fragrance.save!
            Candle.find_or_create_by(fragrance: @fragrance)
            redirect_to fragrances_path
        else
            render :new
        end
    end

    def edit
        @fragrance = Fragrance.find(params[:id])
    end

    def update
        @fragrance = Fragrance.find(params[:id])
        if @fragrance.update(fragrance_params)
           redirect_to fragrances_path
        else
            render :edit
        end
    end

    def destroy
        Fragrance.find_by(id: params[:id]).destroy
        redirect_back(fallback_location: root_path, notice: 'testing')
    end

    def fragrance_params
        params.require(:fragrance).permit(:name, :description, :category, :image_url)
    end
end

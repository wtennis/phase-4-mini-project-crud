class SpicesController < ApplicationController

    wrap_parameters format: []

    rescue_from ActiveRecord::RecordNotFound, with: :not_found_error_message  

    rescue_from  ActiveRecord::RecordInvalid, with: :unprocessable_entity_error
    
    def index
        spices = Spice.all
        render json: spices, status: :ok
    end

    # def show
    #     spice = find_spice
    #     render json: spice
    # end

    def destroy
        spice = find_spice
        spice.destroy
        head :no_content
    end

    def update
        spice = find_spice
        spice.update!(spice_params)
        render json: spice
    end

    def create
        spice = Spice.create!(spice_params)
        render json: spice, status: :created
    end

    private

    def not_found_error_message
        render json: {errors: "Not Found"}, status: :not_found
    end

    def unprocessable_entity_error(invalid)
        render json: {errors: invalid.record.errors}, status: :unprocessable_entity
    end

    def find_spice
        Spice.find(params[:id])
    end

    def spice_params
        params.permit(:title, :image, :description, :notes, :rating)
    end

end
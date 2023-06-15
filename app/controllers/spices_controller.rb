class SpicesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    def index 
        spices = Spice.all
        render json: spices, except: [:created_at, :updated_at]
    end

    def create 
        spice = Spice.create(spice_params)
        render json: spice, except: [:updated_at], status: :created
    end

    def update 
        spice = find_spice
        spice.update(spice_params)
        render json: spice, except: [:created_at]
    end

    def destroy
        spice = find_spice
        spice.destroy
        head :no_content
    end
    


    private 

    def render__not_found_response
        render json: {error: "Spice not found"}, status: :not_found
    end

    def spice_params
        params.permit(:title, :image, :description, :notes, :rating)
    end

    def find_spice
        Spice.find(params[:id])
    end


end
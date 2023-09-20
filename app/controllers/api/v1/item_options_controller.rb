class Api::V1::ItemOptionsController < ApplicationController
  before_action :set_item_option, only: %i[ show update destroy ]

  # GET /api/v1/item_options
  def index
    @item_options = ItemOption.all

    render json: @item_options
  end

  # GET /api/v1/item_options/1
  def show
    render json: @item_option.to_json(only: [:id, :name, :description, ::allocation])
  end

  # POST /api/v1/item_options
  def create
    @item_option = ItemOption.new(item_option_params)

    if @item_option.save
      render json: @item_option.to_json(only: [:id, :name, :description, ::allocation]), status: :created
      render json: @item_option.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/item_options/1
  def update
    if @item_option.update(item_option_params)
      render json: @item_option
    else
      render json: @item_option.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/item_options/1
  def destroy
    @item_option.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item_option
      @item_option = ItemOption.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def item_option_params
      params.fetch(:item_option).permit(:name, :description, :allocation)
    end
end

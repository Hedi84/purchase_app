class Api::V1::ItemsController < ApplicationController
  before_action :item, only: %i[ show update destroy ]

  # GET /api/v1/items
  def index
    @items = Item.all

    render json: @items
  end

  # GET /api/v1/items/1
  def show
    render json: @item.to_json(only: [:id, :purchase_id, :item_option_id])
  end

  # POST /api/v1/items
  def create
    @item = Item.new(item_params)

    if @item.save
      @item.update_allocation
      render json: @item.to_json(only: [:id, :purchase_id, :item_option_id]), status: :created
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/items/1
  def update
    if @item.update(item_params)
      render json: @item
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/items/1
  def destroy
    @item.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def item
      @item = Item.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def item_params
      params.fetch(:item).permit(:purchase_id, :item_option_id)
    end
end

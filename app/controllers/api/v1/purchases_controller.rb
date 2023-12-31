class Api::V1::PurchasesController < ApplicationController
  before_action :purchase, only: %i[ show update destroy ]

  # GET /api/v1/purchases
  def index
    @purchases = Purchase.all

    render json: @purchases
  end

  # GET /api/v1/purchases/1
  def show
    render json: @purchase
  end

  # POST /api/v1/purchases
  def create
    @item = Item.new({item_option_id: params[:item_option_id] })
    @purchase = Purchase.new({ user_id: purchase_params[:users_id], item_id: @item.id })

    if @item.save && @purchase.save
      @item.update_allocation
      render json: @purchase.to_json(include: :item)
    else
      render json: @purchase.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/purchases/1
  def update
    if @purchase.update(purchase_params)
      render json: @purchase.to_json(include: :item)
    else
      render json: @purchase.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/purchases/1
  def destroy
    @purchase.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def purchase
      @purchase = Purchase.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def purchase_params
      params.permit(:user_id, :item_option_id)
    end
end

class Api::V1::ItemsController < ApplicationController
  def index
    if params[:merchant_id]
      if Merchant.exists?(params[:merchant_id])
        render json: ItemSerializer.new(Item.where(merchant_id: params[:merchant_id]))
      else
        render json: { error: 'Merchant does not exist' }, status: :not_found
      end
    else
      render json: ItemSerializer.new(Item.all)
    end
  end
end

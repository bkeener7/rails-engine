class Api::V1::MerchantItemsController < ApplicationController
  def index
    if Merchant.exists?(params[:id])
      render json: ItemSerializer.new(Item.where(merchant_id: params[:id]))
    else
      render json: { error: 'Merchant does not exist' }, status: :not_found
    end
  end
end

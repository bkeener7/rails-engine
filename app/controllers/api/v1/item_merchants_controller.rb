class Api::V1::ItemMerchantsController < ApplicationController
  def index
    if Item.exists?(params[:id])
      render json: MerchantSerializer.new(find_merchant(params[:id]))
    else
      render json: { error: 'Item does not exist' }, status: :not_found
    end
  end

  private

  def find_merchant(item_id)
    Merchant.find(Item.find(item_id).merchant_id)
  end
end

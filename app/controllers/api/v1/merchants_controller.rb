class Api::V1::MerchantsController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    if Merchant.exists?(params[:id])
      render json: MerchantSerializer.new(Merchant.find((params[:id])))
    else
      render json: { error: 'Merchant does not exist' }, status: :not_found
    end
  end
end

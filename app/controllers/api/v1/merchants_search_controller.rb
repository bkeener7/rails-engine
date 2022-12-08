class Api::V1::MerchantsSearchController < ApplicationController
  def index
    if !Merchant.find_merchant_fragment((params)).nil?
      render json: MerchantSerializer.new(Merchant.find_merchant_fragment((params)))
    else
      render json: { data: { error: 'Does not exist' } }, status: :not_found
    end
  end
end

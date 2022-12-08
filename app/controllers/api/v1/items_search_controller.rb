class Api::V1::ItemsSearchController < ApplicationController
  def index
    if Item.find_item_fragment((params)) != []
      render json: ItemSerializer.new(Item.find_item_fragment((params)))
    else
      render json: { data: [] }, status: :not_found
    end
  end
end

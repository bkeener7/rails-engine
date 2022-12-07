class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show
    if Item.exists?(params[:id])
      render json: ItemSerializer.new(Item.find((params[:id])))
    else
      render json: { error: 'Item does not exist' }, status: :not_found
    end
  end
end

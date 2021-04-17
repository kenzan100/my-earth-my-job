class GoodsController < ApplicationController
  def create
    Good.find(params[:id]).purchase
    redirect_to root_path
  end
end

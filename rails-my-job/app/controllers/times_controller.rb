class TimesController < ApplicationController
  def create
    if params[:multiplier].to_i == 1
    else
    end
    redirect_to root_path
  end
end
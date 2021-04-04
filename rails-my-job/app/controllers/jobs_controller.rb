class JobsController < ApplicationController
  def new
  end

  def show
    @job = Equipment.find(params[:id])
  end

  def create
    Equipment.create!(
      name: params[:id].humanize,
      rate: 0.5
    )
  end
end

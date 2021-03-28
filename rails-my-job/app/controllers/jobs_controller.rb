class JobsController < ApplicationController
  def show
    @id = params[:id]
  end

  def create
    Equipment.create!(
      name: params[:id].humanize,
      rate: 0.5
    )
  end
end

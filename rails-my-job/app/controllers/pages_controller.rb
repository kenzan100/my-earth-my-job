class PagesController < ApplicationController
  def main
    @equipments = Equipment.all
  end
end

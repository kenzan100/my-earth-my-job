class TimesController < ApplicationController
  def create
    now = Time.now
    multiplier = params[:multiplier].to_i

    running_speed = TimeSpeed.find_by(ending: nil)

    if running_speed && running_speed.multiplier == multiplier
      redirect_to root_path
      return
    end

    if running_speed.nil? && multiplier == 1
      redirect_to root_path
      return
    end

    running_speed&.update!(ending: now)

    unless multiplier == 1
      # TODO: it seems starting on the same time as ending the prev one messed up calculation
      TimeSpeed.create!(
        multiplier: params[:multiplier].to_i,
        starting: now + 1.second,
        ending: nil,
        )
    end

    redirect_to root_path
  end
end
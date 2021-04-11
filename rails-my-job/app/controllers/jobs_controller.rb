class JobsController < ApplicationController
  def new
  end

  def show
    @job = Equipment.find(params[:id])

    if @job.job_attributes.size == 0
      return render(plain: 'still in the making. come back later.')
    end

    @supporting_attrs, @distracting_attrs = @job.job_attributes.partition do |attr|
      !attr.ditractor
    end
    @success_rate_for_today = (Person.yuta.success_rate(job: @job) + @job.noise).round(2)
  end

  def create
    @job = Equipment.find params[:id]
    success = Person.yuta.apply(job: @job)
    text = ''

    if success
      @job.events.create!(status: :active) # job accquired! congrats!
      text = "Job acquired! Congrats!"
    else
      text = "You could not make it. Come back in #{@job.cooling_period} seconds."
    end

    return render plain: text
  end
end

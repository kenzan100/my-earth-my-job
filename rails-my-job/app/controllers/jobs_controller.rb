class JobsController < ApplicationController
  def new
  end

  def show
    @job = Equipment.find(params[:id])
    @supporting_attrs, @distracting_attrs = @job.job_attributes.partition do |attr|
      !attr.ditractor
    end
    @success_rate_for_today = Person.yuta.success_rate(job: @job) + noise(@job)
  end

  def create
    Equipment.create!(
      name: params[:id].humanize,
      rate: 0.5
    )
  end

  private

  def noise(job)
    Rails.cache.fetch(
      "#{job.cache_key_with_version}/success_rate_noise",
      expires_in: 24.hours,
    ) do
      rand(-10..10)
    end
  end
end

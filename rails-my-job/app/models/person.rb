class Person
  def self.yuta
    attrs = Equipment.skills_acquired(Time.now)
    new(attrs: attrs)
  end

  def initialize(attrs: {})
    @person_attrs = attrs
  end

  def apply(job:)
    rand(100) < (success_rate(job: job) + job.noise)
  end

  def success_rate(job:)
    portion = 100 / job.job_attributes.length
    penalty = 0

    job.job_attributes.each do |job_attr|
      found_in_seconds = @person_attrs[job_attr.name]
      unless found_in_seconds
        penalty += portion
        next
      end

      if job_attr.binary?
        next # found. no penalty
      end

      required_in_seconds = job_attr.required_months * 2592000
      diff_in_seconds = required_in_seconds- found_in_seconds
      if diff_in_seconds.negative?
        next # exceeding required months. no penalty
      end

      # how many more months needed becomes penalty
      penalty += portion * (diff_in_seconds.to_f / required_in_seconds)
    end

    100 - penalty
  end
end
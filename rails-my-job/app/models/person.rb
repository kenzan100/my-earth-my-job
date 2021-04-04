class Person
  def self.yuta
    attrs = MyAttribute.all
    new(attrs: attrs)
  end

  def initialize(attrs: [])
    @person_attrs = attrs.group_by { |attr| attr.name }
  end

  def apply(job:)
    rand(100) < success_rate(job: job)
  end

  def success_rate(job:)
    portion = 100 / job.job_attributes.length
    penalty = 0

    job.job_attributes.each do |job_attr|
      found = @person_attrs[job_attr.name]&.sample
      unless found
        penalty += portion
        next
      end

      if job_attr.binary?
        next # found. no penalty
      end

      diff = job_attr.required_months - found.spent_months
      if diff.negative?
        next # exceeding required months. no penalty
      end

      # how many more months needed becomes penalty
      penalty += portion * (diff.to_f / job_attr.required_months)
    end

    100 - penalty
  end
end
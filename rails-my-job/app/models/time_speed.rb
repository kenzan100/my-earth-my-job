class TimeSpeed < ApplicationRecord
  def affects?(timestamp)
    return false if starting > timestamp

    return true if ending.nil?

    timestamp.between?(starting, ending)
  end
end
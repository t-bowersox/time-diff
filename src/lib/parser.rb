# frozen_string_literal: true

require 'time'

# One minute in seconds.
ONE_MIN = 60

# One hour (60 minutes) in seconds.
ONE_HOUR = 60 * ONE_MIN

# One day (24 hours) in seconds.
ONE_DAY = 24 * ONE_HOUR

# One week (7 days) in seconds.
ONE_WEEK = 7 * ONE_DAY

# One month (4 weeks) in seconds.
ONE_MONTH = 4 * ONE_WEEK

# One year (52 weeks) in seconds.
ONE_YEAR = 52 * ONE_WEEK

# Parses a number of seconds into a hash of time units (years, months, weeks, days, hours, minutes, & seconds).
# @param [Integer] diff_secs Difference between two times, in seconds.
def parse_diff(diff_secs)
  units = { year: ONE_YEAR, month: ONE_MONTH, week: ONE_WEEK, day: ONE_DAY, hour: ONE_HOUR, minute: ONE_MIN }
  breakdown = Hash.new(0)

  units.each do |unit, secs|
    while diff_secs >= secs
      diff_secs -= secs
      breakdown[unit] += 1
    end
  end

  breakdown[:second] = diff_secs if diff_secs.positive?
  breakdown
end

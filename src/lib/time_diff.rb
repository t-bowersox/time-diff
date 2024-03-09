# frozen_string_literal: true

require "time"

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

# Represents the difference between two times.
class TimeDiff
  # @param [Time] start_time
  # @param [Time] end_time
  def initialize(start_time, end_time)
    raise "Start time is invalid." unless start_time.is_a? Time
    raise "End time is invalid." unless end_time.is_a? Time
    raise "The end time must be greater than the start time." if end_time < start_time

    # @type [Time]
    @start_time = start_time

    # @type [Time]
    @end_time = end_time

    @units = {year: ONE_YEAR, month: ONE_MONTH, week: ONE_WEEK, day: ONE_DAY, hour: ONE_HOUR, minute: ONE_MIN}
  end

  # The time difference rounded to the nearest second.
  def value
    Float(@end_time - @start_time).round
  end

  # Returns the time difference as a hash, with each key representing a unit of time (year, month, etc.).
  def to_h
    diff_secs = value
    breakdown = Hash.new(0)

    @units.each do |unit, secs|
      while diff_secs >= secs
        diff_secs -= secs
        breakdown[unit] += 1
      end
    end

    breakdown[:second] = diff_secs if diff_secs.positive?
    breakdown
  end

  # Returns the time difference as a string, broken down by units of time (years, months, etc.).
  def to_s
    if value.zero?
      "No difference."
    else
      to_h.map { |u, c| unit_to_s(u, c) }.join(", ")
    end
  end

  private

  # Converts a time difference to a string.
  # @param [Symbol | String] unit
  # @param [Integer] count
  def unit_to_s(unit, count)
    "#{count} #{unit}#{"s" if count != 1}"
  end
end

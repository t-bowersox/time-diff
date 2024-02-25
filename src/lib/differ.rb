# frozen_string_literal: true

require_relative 'parser'

# Prints the difference between two times, broken down by units (years, months, weeks, days, etc.).
# @param [Time] start_time
# @param [Time] end_time
def diff_times(start_time, end_time)
  begin
    diff_secs = Float(end_time - start_time).round
  rescue TypeError, NoMethodError
    raise 'Error: You must provide a valid start time and end time.'
  end

  raise 'Error: The end time must be greater than the start time.' if diff_secs.negative?
  return puts 'No difference.' if diff_secs.zero?

  unit_to_s = ->(unit, count) { "#{count} #{unit}#{'s' if count != 1}" }
  puts parse_diff(diff_secs).map(&unit_to_s).join(', ')
end

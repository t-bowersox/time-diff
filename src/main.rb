#!/usr/bin/env ruby

# frozen_string_literal: true

require 'time'
require_relative 'lib/time_diff'

def exit_with_error(error_msg)
  puts error_msg
  exit false
end

# @param [Array<String>] times An array containing two times to compare.
def main(times)
  start_time, end_time = times.map { |time| time.downcase == 'now' ? Time.new : Time.parse(time) }
  puts TimeDiff.new(start_time, end_time)
rescue ArgumentError
  exit_with_error "Error: #{times.join(' and ')} are not valid times."
rescue RuntimeError => e
  exit_with_error e.message
end

main(ARGV) if __FILE__ == $PROGRAM_NAME

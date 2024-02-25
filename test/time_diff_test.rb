# frozen_string_literal: true

require 'minitest/autorun'
require 'time'
require_relative '../src/lib/time_diff'

describe TimeDiff do
  it 'should raise error if start time is invalid' do
    # noinspection RubyMismatchedArgumentType
    expect { TimeDiff.new('8:00', Time.parse('10:00')) }.must_raise(RuntimeError, /Start time is invalid/)
  end

  it 'should raise error if end time is invalid' do
    # noinspection RubyMismatchedArgumentType
    expect { TimeDiff.new(Time.parse('8:00'), '10:00') }.must_raise(RuntimeError, /End time is invalid/)
  end

  it 'should raise error if end time is less than start time' do
    expect { TimeDiff.new(Time.parse('10:00'), Time.parse('8:00')) }.must_raise(
      RuntimeError, /The end time must be greater than the start time/
    )
  end

  describe :value do
    it 'should return the value of the difference in seconds' do
      start_time = Time.parse('8:00')
      end_time = Time.parse('10:30')
      expected = (ONE_HOUR * 2) + (ONE_MIN * 30)

      expect(TimeDiff.new(start_time, end_time).value).must_equal(expected)
    end
  end

  describe :to_h do
    it 'should return years' do
      diff = TimeDiff.new(Time.parse('2023-01-01'), Time.parse('2023-12-31'))
      expect(diff.to_h[:year]).must_equal(1)
    end

    it 'should return months' do
      diff = TimeDiff.new(Time.parse('2024-01-01'), Time.parse('2024-02-01'))
      expect(diff.to_h[:month]).must_equal(1)
    end

    it 'should return weeks' do
      diff = TimeDiff.new(Time.parse('2024-01-01'), Time.parse('2024-01-15'))
      expect(diff.to_h[:week]).must_equal(2)
    end

    it 'should return days' do
      diff = TimeDiff.new(Time.parse('2024-01-01'), Time.parse('2024-01-05'))
      expect(diff.to_h[:day]).must_equal(4)
    end

    it 'should return hours' do
      diff = TimeDiff.new(Time.parse('8:00'), Time.parse('10:00'))
      expect(diff.to_h[:hour]).must_equal(2)
    end

    it 'should return minutes' do
      diff = TimeDiff.new(Time.parse('8:00'), Time.parse('8:15'))
      expect(diff.to_h[:minute]).must_equal(15)
    end

    it 'should return seconds' do
      diff = TimeDiff.new(Time.parse('8:00'), Time.parse('8:00:30'))
      expect(diff.to_h[:second]).must_equal(30)
    end

    it 'should return compound difference' do
      diff = TimeDiff.new(
        Time.parse('2023-01-01 00:00:00'),
        Time.parse('2024-02-14 12:15:30')
      )

      expect(diff.to_h).must_equal(
        { year: 1, month: 1, week: 2, day: 3, hour: 12, minute: 15, second: 30 }
      )
    end
  end

  describe :to_s do
    it 'should print "No difference" if diff is zero' do
      diff = TimeDiff.new(Time.parse('8:00'), Time.parse('8:00'))
      expect(diff.to_s).must_equal('No difference.')
    end

    it 'should print difference' do
      diff = TimeDiff.new(
        Time.parse('2023-01-01 00:00:00'),
        Time.parse('2024-02-14 12:15:30')
      )

      expect(diff.to_s).must_equal(
        '1 year, 1 month, 2 weeks, 3 days, 12 hours, 15 minutes, 30 seconds'
      )
    end
  end
end

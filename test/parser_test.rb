# frozen_string_literal: true

require 'minitest/autorun'

require_relative '../src/lib/parser'

describe :parse_diff do
  before do
    @minute = 60
    @hour = 60 * @minute
    @day = 24 * @hour
    @week = 7 * @day
    @month = 4 * @week
    @year = 52 * @week
  end

  it 'should parse years' do
    expect(parse_diff(@year)).must_equal({ year: 1 })
    expect(parse_diff(@year * 5)).must_equal({ year: 5 })
  end

  it 'should parse months' do
    expect(parse_diff(@month)).must_equal({ month: 1 })
    expect(parse_diff(@month * 5)).must_equal({ month: 5 })
  end

  it 'should parse weeks' do
    expect(parse_diff(@week)).must_equal({ week: 1 })
    expect(parse_diff(@week * 2)).must_equal({ week: 2 })
  end

  it 'should parse days' do
    expect(parse_diff(@day)).must_equal({ day: 1 })
    expect(parse_diff(@day * 5)).must_equal({ day: 5 })
  end

  it 'should parse hours' do
    expect(parse_diff(@hour)).must_equal({ hour: 1 })
    expect(parse_diff(@hour * 12)).must_equal({ hour: 12 })
  end

  it 'should parse minutes' do
    expect(parse_diff(@minute)).must_equal({ minute: 1 })
    expect(parse_diff(@minute * 30)).must_equal({ minute: 30 })
  end

  it 'should parse seconds' do
    expect(parse_diff(1)).must_equal({ second: 1 })
    expect(parse_diff(30)).must_equal({ second: 30 })
  end

  it 'should parse compound differences' do
    diff_secs = (@year * 2) +
                (@month * 4) +
                (@week * 1) +
                (@day * 3) +
                (@hour * 14) +
                (@minute * 45) +
                15

    expect(parse_diff(diff_secs)).must_equal(
      { year: 2, month: 4, week: 1, day: 3, hour: 14, minute: 45, second: 15 }
    )
  end
end

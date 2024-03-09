# frozen_string_literal: true

require "minitest/autorun"
require "time"
require_relative "../src/main"

describe :main do
  it "should abort if arguments are invalid times" do
    out, = capture_io do
      expect { main(%w[foo bar]) }.must_raise(SystemExit)
    end

    expect(out).must_match(/foo and bar are not valid times/)
  end

  it "should abort if not enough arguments provided" do
    out, = capture_io do
      expect { main(["12:00"]) }.must_raise(SystemExit)
    end

    expect(out).must_match(/End time is invalid/)
  end

  it "should abort if end time is before start time" do
    out, = capture_io do
      expect { main(%w[12:00 8:00]) }.must_raise(SystemExit)
    end

    expect(out).must_match(/The end time must be greater than the start time/)
  end

  it 'should substitute the current time for the "now" argument' do
    Time.stub :new, Time.new(2024, 1, 3) do
      expect { main(%w[2024-01-01 now]) }.must_output(/^2 days$/)
    end
  end

  it 'should treat "now" argument as case insensitive' do
    Time.stub :new, Time.new(2024, 1, 3) do
      expect { main(%w[2024-01-01 NoW]) }.must_output(/^2 days$/)
    end
  end

  it "should output the difference between two times" do
    expect { main(%w[12:00pm 2:30pm]) }.must_output(/^2 hours, 30 minutes$/)
  end
end

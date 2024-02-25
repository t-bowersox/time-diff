# frozen_string_literal: true

require 'minitest/autorun'
require 'time'

require_relative '../src/lib/differ'

describe :diff_times do
  it 'should raise error if diff is negative' do
    expect { diff_times(Time.parse('12:00'), Time.parse('11:00')) }
      .must_raise(RuntimeError, /The end time must be greater than the start time/)
  end

  it 'should print "No difference" if diff is zero' do
    expect { diff_times(Time.parse('12:00'), Time.parse('12:00')) }
      .must_output(/No difference/)
  end

  it 'should raise error if times cannot be parsed' do
    expect { diff_times('Foobar', Time.parse('11:00')) }
      .must_raise(RuntimeError, /You must provide a valid start time and end time/)

    expect { diff_times(Time.parse('11:00'), 11) }
      .must_raise(RuntimeError, /You must provide a valid start time and end time/)
  end

  it 'should print difference with years' do
    expect { diff_times(Time.parse('2023-01-01'), Time.parse('2024-01-01')) }
      .must_output(/1 year/)

    expect { diff_times(Time.parse('2022-01-01'), Time.parse('2024-01-01')) }
      .must_output(/2 years/)
  end

  it 'should print difference with months' do
    expect { diff_times(Time.parse('2024-01-01'), Time.parse('2024-02-01')) }
      .must_output(/1 month/)

    expect { diff_times(Time.parse('2024-01-01'), Time.parse('2024-04-01')) }
      .must_output(/3 months/)
  end

  it 'should print difference with weeks' do
    expect { diff_times(Time.parse('2024-01-01'), Time.parse('2024-01-08')) }
      .must_output(/1 week/)

    expect { diff_times(Time.parse('2024-01-01'), Time.parse('2024-01-15')) }
      .must_output(/2 weeks/)
  end

  it 'should print difference with days' do
    expect { diff_times(Time.parse('2024-01-01'), Time.parse('2024-01-02')) }
      .must_output(/1 day/)

    expect { diff_times(Time.parse('2024-01-01'), Time.parse('2024-01-03')) }
      .must_output(/2 days/)
  end

  it 'should print difference with hours' do
    expect { diff_times(Time.parse('12:00'), Time.parse('13:00')) }
      .must_output(/1 hour/)

    expect { diff_times(Time.parse('12:00pm'), Time.parse('2pm')) }
      .must_output(/2 hours/)
  end

  it 'should print difference with minutes' do
    expect { diff_times(Time.parse('12:00'), Time.parse('12:01')) }
      .must_output(/1 minute/)

    expect { diff_times(Time.parse('12:00pm'), Time.parse('12:05pm')) }
      .must_output(/5 minutes/)
  end

  it 'should print difference with seconds' do
    expect { diff_times(Time.parse('12:00:00'), Time.parse('12:00:01')) }
      .must_output(/1 second/)

    expect { diff_times(Time.parse('12:00:00pm'), Time.parse('12:00:05pm')) }
      .must_output(/5 seconds/)
  end

  it 'should print compound differences' do
    expect { diff_times(Time.parse('2022-01-01T00:15:30'), Time.parse('2024-02-15T12:45:00')) }
      .must_output(/2 years, 1 month, 2 weeks, 5 days, 12 hours, 29 minutes, 30 seconds/)
  end
end

# time-diff

Returns the difference between two times.

## System requirements

Node.js >= 20.18.0

## Installation

```shell
npm install -g @t-bowersox/time-diff
```

## Usage

```
time-diff <start_time> <end_time>
```

The program takes two arguments:

- `start_time`: The starting time of the duration to measure.
- `end_time`: The ending time of the duration to measure.

The times provided must be in a valid date/time format, with the exception of a special `now` argument. When provided, the current time will be substituted.

### Examples

```shell
time-diff 11:56am 1:34pm
# => 1 hour, 38 minutes

time-diff 10:07 19:23
# => 9 hours, 16 minutes

time-diff 2024-02-01T08:15:03 2024-02-07T13:17:55
# => 6 days, 5 hours, 2 minutes, 52 seconds

time-diff "jan 1, 1990" "feb 24, 2024"
# => 34 years, 3 months, 1 week, 5 days

# "now" is not case sensitive
time-diff 2024-01-01 NOW
# => 1 month, 3 weeks, 5 days, 13 hours, 4 minutes, 15 seconds

time-diff now 2099-01-01
# => 75 years, 1 month, 1 week, 4 days, 10 hours, 56 minutes, 20 seconds

time-diff foo bar
# => Error: foo and bar are not valid times.

time-diff 9:00am
# => Error: You must provide a start time and end time.
```

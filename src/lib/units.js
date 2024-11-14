export default {
  /** One minute in seconds. */
  get minute() {
    return 60;
  },
  /** One hour in seconds. */
  get hour() {
    return this.minute * 60;
  },
  /** One day in seconds. */
  get day() {
    return this.hour * 24;
  },
  /** One week in seconds. */
  get week() {
    return this.day * 7;
  },
  /** One month in seconds. */
  get month() {
    return this.week * 4;
  },
  /** One year in seconds. */
  get year() {
    return this.day * 365;
  },
};

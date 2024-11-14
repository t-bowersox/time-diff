import { stringToDate } from "./lib/normalize.js";
import { TimeDiff } from "./lib/time-diff.js";

/**
 * Returns the difference between two times.
 * @param {[string, string]} times The start and end times to compare.
 * @returns {string} The difference between the start and end times.
 */
export function getTimeDiff(times) {
  switch (times.length) {
    case 0:
      throw new Error("Usage: time-diff <start_time> <end_time>");
    case 1:
      throw new Error("An end time is required.");
  }

  const [start, end] = times;
  return new TimeDiff(stringToDate(start), stringToDate(end)).toString();
}

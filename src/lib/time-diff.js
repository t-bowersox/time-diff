"use strict";

//#region Types

/**
 * @typedef {Object} TimeUnits
 * @property {number} year
 * @property {number} month
 * @property {number} week
 * @property {number} day
 * @property {number} hour
 * @property {number} minute
 * @property {number} second
 */

//#endregion

//#region Constants

/** One minute in seconds. */
const ONE_MIN = 60;

/** One hour in seconds. */
const ONE_HOUR = 60 * ONE_MIN;

/** One day in seconds. */
const ONE_DAY = 24 * ONE_HOUR;

/** One week in seconds. */
const ONE_WEEK = 7 * ONE_DAY;

/** One month in seconds. */
const ONE_MONTH = 4 * ONE_WEEK;

/** One year in seconds. */
const ONE_YEAR = 52 * ONE_WEEK;

//#endregion

//#region Classes

/** Represents the difference between two times. */
export class TimeDiff {
  /** @type {Date} */
  #endTime;

  /** @type {Date} */
  #startTime;

  /** @type {Map<string, number>} */
  #units = new Map([
    ["year", ONE_YEAR],
    ["month", ONE_MONTH],
    ["week", ONE_WEEK],
    ["day", ONE_DAY],
    ["hour", ONE_HOUR],
    ["minute", ONE_MIN],
  ]);

  //#region Public API

  /**
   * @param {Date} startTime The start of the date range.
   * @param {Date} endTime The end of the date range.
   */
  constructor(startTime, endTime) {
    this.#validateTimes(startTime, endTime);
    this.#startTime = startTime;
    this.#endTime = endTime;
  }

  toString() {
    if (this.seconds == 0) {
      return "No difference";
    }

    return Object.entries(this.#timeToUnits())
      .filter((entry) => entry[1] > 0)
      .map(this.#entryToString)
      .join(", ");
  }

  /** The time difference rounded to the nearest second. */
  get seconds() {
    const diffMs = this.#endTime - this.#startTime;
    return Math.round(diffMs / 1000);
  }

  //#endregion

  /**
   * Converts a `TimeUnits` value to a string.
   * @param {[keyof TimeUnits, number]} entry
   */
  #entryToString(entry) {
    const [unitName, value] = entry;
    let str = `${value.toLocaleString()} ${unitName}`;

    if (value != 1) {
      str += "s";
    }

    return str;
  }

  /**
   * Tests that a time is valid.
   * @param {Date} time The time to validate.
   */
  #isValidTime(time) {
    return time instanceof Date && !isNaN(time.valueOf());
  }

  /**
   * Returns the time difference as a dictionary, with each key representing
   * a unit of time (year, month, etc.).
   * @returns {TimeUnits}
   */
  #timeToUnits() {
    const units = {};
    let diffSeconds = this.seconds;

    this.#units.forEach((seconds, unit) => {
      units[unit] = 0;

      while (diffSeconds >= seconds) {
        diffSeconds -= seconds;
        units[unit] += 1;
      }
    });

    units.second = diffSeconds >= 0 ? diffSeconds : 0;
    return units;
  }

  /**
   * Validates that the start and end times form a valid date range.
   * @param {Date} startTime The start of the date range.
   * @param {Date} endTime The end of the date range.
   * @throws If either the `startTime` or `endTime` are invalid.
   */
  #validateTimes(startTime, endTime) {
    if (!this.#isValidTime(startTime)) {
      throw new Error("Start time is invalid.");
    }

    if (!this.#isValidTime(endTime)) {
      throw new Error("End time is invalid.");
    }

    if (endTime < startTime) {
      throw new Error("The end time must be greater than the start time.");
    }
  }
}

//#endregion

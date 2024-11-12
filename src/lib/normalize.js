//#region Types

/**
 * @typedef NormalizedTime
 * @property {number} hour
 * @property {number} min
 * @property {number} sec
 */

//#endregion

//#region Constants

const TIME_REGEX =
  /^(?<hour>\d{1,2})?:?(?<min>\d{1,2})?:?(?<sec>\d{1,2})?\s?(?<mer>am|pm)?$/i;

//#endregion

/**
 * Normalizes the provirded hour, min, sec, and ordinal values.
 * @param {string|undefined} hour The hour to normalize.
 * @param {string|undefined} min The minute to normalize.
 * @param {string|undefined} sec The second to normalize.
 * @param {string|undefined} mer The meridiem (AM/PM), if using 12h format.
 * @returns {NormalizedTime} The time normalized on a 24h clock.
 */
function getNormalizedTime(hour, min, sec, mer) {
  hour = hour ? parseInt(hour) : 0;

  if (mer?.toLowerCase() == "am" && hour == 12) {
    hour -= 12;
  } else if (mer?.toLowerCase() == "pm" && hour < 12) {
    hour += 12;
  }

  min = min ? parseInt(min) : 0;
  sec = sec ? parseInt(sec) : 0;

  return { hour, min, sec };
}

/**
 * Attempts to create a valid `Date` from the given date-time string.
 * @param {string} dateTimeStr The date-time string to normalize.
 * @returns {Date} A date parsed from the provided date-time string.
 */
export function stringToDate(dateTimeStr) {
  if (typeof dateTimeStr != "string") {
    dateTimeStr = String(dateTimeStr);
  }

  if (dateTimeStr.toLowerCase() == "now") {
    return new Date();
  }

  const timeMatch = dateTimeStr.match(TIME_REGEX);

  if (timeMatch != null) {
    const { hour, min, sec, mer } = timeMatch.groups;
    const normalized = getNormalizedTime(hour, min, sec, mer);

    const today = new Date();
    today.setHours(normalized.hour, normalized.min, normalized.sec);
    return today;
  }

  return new Date(dateTimeStr);
}

import assert from "node:assert";
import { afterEach, beforeEach, describe, it, mock } from "node:test";
import { stringToDate } from "../src/lib/normalize.js";

describe("stringToDate", () => {
  beforeEach(() => {
    mock.timers.enable({
      apis: ["Date"],
      now: new Date(2024, 0, 1, 0, 0, 0, 0),
    });
  });

  afterEach(() => {
    mock.timers.reset();
  });

  it('should return the current date if "now" is provided', () => {
    assert.deepStrictEqual(stringToDate("now"), new Date());
  });

  it("should return a date when given only a time", () => {
    const testSet = [
      ["12:00 am", 0, 0],
      ["12:00am", 0, 0],
      ["12:00 AM", 0, 0],
      ["12:00AM", 0, 0],
      ["1:30 am", 1, 30],
      ["1:30 AM", 1, 30],
      ["1:30am", 1, 30],
      ["1:30AM", 1, 30],
      ["01:30AM", 1, 30],
      ["01:30am", 1, 30],
      ["01:30 am", 1, 30],
      ["01:30 AM", 1, 30],
      ["01:30", 1, 30],
      ["12:00 pm", 12, 0],
      ["12:00pm", 12, 0],
      ["12:00 PM", 12, 0],
      ["12:00PM", 12, 0],
      ["1:30 pm", 13, 30],
      ["1:30 PM", 13, 30],
      ["1:30pm", 13, 30],
      ["1:30PM", 13, 30],
      ["01:30PM", 13, 30],
      ["01:30pm", 13, 30],
      ["01:30 pm", 13, 30],
      ["01:30 PM", 13, 30],
      ["13:30", 13, 30],
    ];

    for (const [time, hour, min] of testSet) {
      const expectedDate = new Date();
      expectedDate.setHours(hour, min);

      assert.deepEqual(
        stringToDate(time),
        expectedDate,
        `${time} should yield ${expectedDate.toISOString()}.`,
      );
    }
  });

  it("should return a date from the provided string", () => {
    const expectedDate = new Date();
    expectedDate.setFullYear(2024, 11, 31);
    expectedDate.setHours(0, 0);

    const testSet = [
      "12/31/2024 12:00 am",
      "2024-12-31T00:00:00",
      "Dec 31, 2024 12:00 am",
      "31 Dec, 2024 12:00 am",
      "December 31, 2024 12:00 AM",
    ];

    for (const dateStr of testSet) {
      assert.deepEqual(
        stringToDate(dateStr),
        expectedDate,
        `${dateStr} should yield ${expectedDate}.`,
      );
    }
  });

  it("should handle invalid inputs", () => {
    assert.doesNotThrow(() => stringToDate("foobar"));
    assert.doesNotThrow(() => stringToDate());
    assert.doesNotThrow(() => stringToDate(null));
    assert.doesNotThrow(() => stringToDate(42));
    assert.doesNotThrow(() => stringToDate(["foo,", "bar"]));
    assert.doesNotThrow(() => stringToDate({ foo: "bar" }));
  });
});

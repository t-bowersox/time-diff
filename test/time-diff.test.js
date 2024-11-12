import assert from "node:assert";
import { describe, it } from "node:test";
import { TimeDiff } from "../src/lib/time-diff.js";

describe("TimeDiff", () => {
  it("should throw exception if start time is invalid", () => {
    assert.throws(() => {
      new TimeDiff(new Date("foobar"), new Date());
    }, new Error("Start time is invalid."));
  });

  it("should throw exception if end time is invalid", () => {
    assert.throws(() => {
      new TimeDiff(new Date(), new Date("foobar"));
    }, new Error("End time is invalid."));
  });

  it("should throw exception if end time is less than start time", () => {
    assert.throws(() => {
      new TimeDiff(new Date(2024, 0, 2), new Date(2024, 0, 1));
    }, new Error("The end time must be greater than the start time."));
  });

  it("should return the difference between two dates rounded to the nearest second", () => {
    const start = new Date(2024, 0, 1, 12, 0, 0);
    const end = new Date(2024, 0, 1, 12, 0, 0);
    const diff = new TimeDiff(start, end);
    const expectedSeconds = Math.round((end - start) / 1000);

    assert.equal(diff.seconds, expectedSeconds);
  });

  it("should summarize the difference between two dates as a string", () => {
    const start = new Date(2024, 0, 1, 12, 0, 0);
    const end = new Date(2024, 0, 16, 14, 2, 2);
    const diff = new TimeDiff(start, end);
    const expectedString = "2 weeks, 1 day, 2 hours, 2 minutes, 2 seconds";

    assert.equal(diff.toString(), expectedString);
  });

  it("should indicate if there is no difference between two dates", () => {
    const start = new Date(2024, 0, 1, 0, 0, 0);
    const end = new Date(2024, 0, 1, 0, 0, 0);
    const diff = new TimeDiff(start, end);

    assert.equal(diff.toString(), "No difference");
  });
});

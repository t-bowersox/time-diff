import assert from "node:assert";
import { describe, it } from "node:test";
import { getTimeDiff } from "../src/index.js";
import { TimeDiff } from "../src/lib/time-diff.js";

describe("getTimeDiff", () => {
  it("Should throw usage instructions if no times provided", () => {
    assert.throws(() => {
      getTimeDiff([]);
    }, new Error("Usage: time-diff <start_time> <end_time>"));
  });

  it("Should throw error if only one time provided", () => {
    assert.throws(() => {
      getTimeDiff(["8:00 am"]);
    }, new Error("An end time is required."));
  });

  it("Should return the difference bweteen two times as a string", () => {
    const start = new Date(2024, 0, 1, 12, 0, 0);
    const end = new Date(2024, 0, 16, 14, 2, 2);
    const diff = new TimeDiff(start, end);
    const expectedString = "2 weeks, 1 day, 2 hours, 2 minutes, 2 seconds";

    assert.equal(diff.toString(), expectedString);
  });
});

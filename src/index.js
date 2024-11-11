import { parseArgs } from "node:util";
import { stringToDate } from "./lib/normalize.js";
import { TimeDiff } from "./lib/time-diff.js";

export function main() {
  const { positionals } = parseArgs({ allowPositionals: true });

  switch (positionals.length) {
    case 0:
      throw new Error("Usage: time-diff <start_time> <end_time>");
    case 1:
      throw new Error("An end time is required.");
  }

  const startTime = stringToDate(positionals[0]);
  const endTime = stringToDate(positionals[1]);
  const diff = new TimeDiff(startTime, endTime);

  console.log(diff.toString());
}

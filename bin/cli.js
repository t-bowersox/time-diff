#!/usr/bin/env node

import process from "node:process";
import { parseArgs } from "node:util";
import { getTimeDiff } from "../src/index.js";

try {
  const { positionals } = parseArgs({ allowPositionals: true });
  console.log(getTimeDiff(positionals));
} catch (error) {
  process.exitCode = 1;
  console.error(error.message);
}

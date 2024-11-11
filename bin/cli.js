#!/usr/bin/env node

import process from "node:process";
import { main } from "../src/index.js";

try {
  main();
} catch (error) {
  process.exitCode = 1;
  console.error(error.message);
}

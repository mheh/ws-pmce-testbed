// MARK: Argument Parsing
const happyFlags = ["help"];
const happyArguments = ["zlib_memory_level", "zlib_compression_level"];

/**
 * Argument Parser for command line
 *
 * Main options:
 * <none>
 *        - use default options
 * --help
 *        - print help
 *
 * Zlib arguments:
 * -zlib_memory_level <int>
 *        - zlib memory level (default 7)
 * -zlib_compression_level <int>
 *        - zlib compression level (default 5)
 */
export default function parseArgs() {
  // Remove the first two elements (node main.js)
  const args = process.argv.slice(2);
  // Our array of options
  var options = [];

  // Fill up options array
  for (let i = 0; i < args.length; i++) {
    const arg = args[i];
    const nextArg = args[i + 1];

    // Flag (bool on/off)
    if (arg.startsWith("--")) {
      if (isValidFlag(arg)) {
        // Valid flag
        options[arg] = true;
      } else {
        // Not a valid flag, proceed anyway
        console.log("Invalid flag " + arg);
      }
    }

    // Argument (optional vars)
    else if (arg.startsWith("-")) {
      if (isValidArgument(arg)) {
        // Valid argument
        if (nextArg === undefined) {
          // Not a valid value for arg
          throw new Error("Missing value for " + arg);
        }
        options[arg] = nextArg;
      } else {
        // Not a valid argument, proceed anyway
        console.log("Invalid argument " + arg);
      }
    }
  }

  return options;
}

/**
 * Check if an argument is a valid argument
 */
function isValidArgument(arg) {
  const foundArg = happyArguments.find((element) => element == arg);
  if (foundArg) {
    return true;
  }
  return false;
}

/**
 * Check if a flag is a valid flag
 */
function isValidFlag(flag) {
  const foundFlag = happyFlags.find((element) => element == flag);
  if (foundFlag) {
    return true;
  }
  return false;
}

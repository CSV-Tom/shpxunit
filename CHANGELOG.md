# Changelog

## v0.0.2 - Shell Execution Fix (YYYY-MM-DD)

### 🐞 Bug Fixes

- **Ensure test scripts execute in the correct shell**
  - Implemented detection of the current shell using `ps -p $$ -o comm=`.
  - All test scripts now execute under the same shell that started the test runner.
  - Fallback to `sh` if `ps` is unavailable to maintain POSIX compatibility.
  - Improved consistency in execution across `sh`, `dash`, `ksh`, and `bash`.

  This update ensures that all test scripts are run in the expected shell environment, preventing potential inconsistencies.

## v0.0.1 - Initial Release (2025-03-03)

### 🚀 Features

- **Core Assertions**
  - `assert_equal`: Checks if two values are equal.
  - `assert_not_equal`: Ensures values are different.
  - `assert_contains`: Checks if a string contains a specific substring.
  - `assert_not_contains`: Checks if a string does NOT contain a specific substring.
  - `assert_command_passes`: Ensures a command exits with `0`.
  - `assert_command_fails`: Ensures a command exits with a non-zero code.
  - `assert_command_stdout_contains`: Verifies stdout contains an expected string.
  - `assert_command_stderr_contains`: Verifies stderr contains an expected string.
  - `assert_file_exists`: Checks if a file exists.
  - `assert_file_not_exists`: Checks if a file does not exist.
  - `assert_dir_exists`: Checks if a directory exists.
  - `assert_dir_not_exists`: Checks if a directory does not exist.

- **Test Runner (`testrunner.sh`)**
  - Automatically discovers and runs test scripts (`test_*.sh`).
  - Supports multiple shell environments (`sh`, `dash`, `ksh`, `bash`).
  - Provides a structured summary of test results.

- **Test Case Execution (`testcase.sh`)**
  - Standardized test execution structure.
  - Supports setup and teardown functions.

- **POSIX Compliance**
  - Ensures compatibility with standard shell implementations.

### 🔧 Improvements

- Improved output formatting with `[PASS]`, `[FAIL]`, `[ASSERT]`, `[TEST]` markers.
- Standardized logging structure for better readability.

### 🐞 Bug Fixes

- N/A (Initial release)

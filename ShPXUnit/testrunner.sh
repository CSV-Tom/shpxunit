#!/usr/bin/env sh

# ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
# Gets the absolute directory path of the currently executing script.
#
# Output:
#   Prints the absolute directory path of the script.
# ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
get_script_dir() {
    cd -- "$(dirname -- "$0")" >/dev/null 2>&1 || exit 1
    pwd
}

# ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
# Ensures that the `SHPXUNIT_ROOT` environment variable is correctly set.
# If not set, it automatically assigns the detected script root.
#
# Output:
#   Sets `SHPXUNIT_ROOT` to the root directory of the test framework.
#   If already set but incorrect, prints an error and exits.
# ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
set_shpxunit_root() {
    detected_root="$(get_script_dir)"

    if [ -z "$SHPXUNIT_ROOT" ]; then
        SHPXUNIT_ROOT="$detected_root"
        export SHPXUNIT_ROOT
        printf "[INFO] SHPXUNIT_ROOT not set. Using detected root: %s\n" "$SHPXUNIT_ROOT"
    elif [ "$SHPXUNIT_ROOT" != "$detected_root" ]; then
        printf "[ERROR] SHPXUNIT_ROOT is incorrectly set!\n" >&2
        printf "[ERROR] Expected: %s\n" "$detected_root" >&2
        printf "[ERROR] Got: %s\n" "$SHPXUNIT_ROOT" >&2
        exit 1
    fi
}


# ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
# Runs all test scripts in the specified directories with an optional regex filter.
#
# This function scans the given directories for test scripts matching the pattern `test_*.sh`.
# It executes only those scripts that also match the provided regex filter.
#
# Arguments:
#   $1 - The regex pattern to filter test scripts (e.g., "test_math.*" to match test_math.sh).
#   $2... - One or more directories containing test scripts.
#
# Output:
#   - Prints the test execution progress.
#   - Shows `[PASS]` or `[FAIL]` for each executed test.
#   - Provides a final summary with total executed, passed, and failed tests.
#
# Exit Codes:
#   0 - If all tests pass.
#   1 - If at least one test fails.
#
# Usage Examples:
#
# 1. Run all tests in `./tests`:
#      run_all_tests ".*" "./tests"
#
# 2. Run only `test_math.sh` in `./tests` and `./integration-tests`:
#      run_all_tests "test_math.*" "./tests" "./integration-tests"
#
# 3. Run all tests in multiple directories:
#      run_all_tests ".*" "./tests" "./integration-tests"
#
# ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
testrunner() {
    test_regex="$1"  # Regex filter for test names
    shift            # Remove first argument (regex), remaining are directories

    # Ensure at least one directory is provided
    if [ $# -eq 0 ]; then
        printf "[ERROR] No test directories provided.\nUsage: testrunner <regex> <dir1> <dir2> ...\n"
        return 1
    fi

    total_tests=0
    failed_tests=0

    printf "\n––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––\n"
    printf "Running test scripts matching '%s' in: %s\n" "$test_regex" "$*"
    printf "––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––\n"

    set_shpxunit_root || exit 2

    . "$SHPXUNIT_ROOT/asserts.sh"

    # Iterate over each provided directory
    for test_dir in "$@"; do

        if [ ! -d "$test_dir" ]; then
            printf "[WARN] Skipping non-existent directory: %s\n" "$test_dir"
            continue
        fi

        set -- "$test_dir"/test_*.sh
        if [ ! -f "$1" ]; then
            printf "[INFO] No matching test scripts found in: %s\n" "$test_dir"
            continue
        fi

        for test_script in "$@"; do

            [ -f "$test_script" ] || continue
            echo "$test_script" | grep "$test_regex" | awk '{exit !length}' || continue

            total_tests=$((total_tests + 1))

            printf "\n––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––\n"
            printf "[RUN] Executing %s...\n" "$(basename "$test_script")"
            printf "––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––\n"

            sh "$test_script"
            exit_code=$?

            if [ "$exit_code" -eq 0 ]; then
                printf "[PASS] %s\n" "$(basename "$test_script")"
            else
                printf "[FAIL] %s (Exit Code: %d)\n" "$(basename "$test_script")" "$exit_code"
                failed_tests=$((failed_tests + 1))
            fi
        done
    done

    printf "\n––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––\n"
    printf "Test Summary: %d executed, %d passed, %d failed.\n" \
        "$total_tests" "$(expr "$total_tests" - "$failed_tests")" "$failed_tests"
    printf "––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––\n"

    if [ "$failed_tests" -ne 0 ]; then
        exit 1
    fi
}

testrunner "$@"

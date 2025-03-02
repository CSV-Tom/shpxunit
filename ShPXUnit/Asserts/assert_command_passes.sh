#!/usr/bin/env sh

# ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
# Executes a command and verifies it succeeds (exit code 0).
# If the command succeeds, prints a success message. Otherwise, prints a failure message and exits.
# ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
# Arguments:
#   $1 - The command to execute.
#   $2 - The description of the test case.
#
# Output:
#   Prints "[PASS]" if the command succeeds.
#   Prints "[FAIL]" and exits with code 1 if the command fails.
#
# Exit codes:
#   0 - If the command succeeds.
#   1 - If the command fails.
# ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
assert_command_passes() {
    command="$1"
    test_description="$2"

    eval "$command" >/dev/null 2>&1
    exit_code=$?

    if [ "$exit_code" -eq 0 ]; then
        printf "[PASS] %s\n" "$test_description"
    else
        printf "[FAIL] %s\n  Expected exit code: 0\n  Got: %s\n" "$test_description" "$exit_code"
        exit 1
    fi

    unset command test_description exit_code
}

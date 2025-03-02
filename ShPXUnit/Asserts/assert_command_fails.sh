#!/usr/bin/env sh

# ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
# Executes a command and verifies it fails with the expected exit code.
# If the command fails with the expected code, prints a success message.
# Otherwise, prints a failure message and exits.
# ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
# Arguments:
#   $1 - The command to execute.
#   $2 - The expected exit code.
#   $3 - The description of the test case.
#
# Output:
#   Prints "[PASS]" if the command fails with the expected exit code.
#   Prints "[FAIL]" and exits with code 1 if the command exits with a different code or succeeds.
#
# Exit codes:
#   0 - If the command fails with the expected exit code.
#   1 - If the command exits with a different code or succeeds.
# ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
assert_command_fails() {
    command="$1"
    expected_exit="$2"
    test_description="$3"

    eval "$command" >/dev/null 2>&1
    exit_code=$?

    if [ "$exit_code" -eq "$expected_exit" ]; then
        printf "[PASS] %s\n" "$test_description"
    else
        printf "[FAIL] %s\n  Expected exit code: %s\n  Got: %s\n" "$test_description" "$expected_exit" "$exit_code"
        exit 1
    fi

    unset command expected_exit test_description exit_code
}

#!/usr/bin/env sh

# ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
# Executes a command and verifies that its standard error (stderr) contains a specific substring.
# If the expected substring is found, prints a success message.
# Otherwise, prints a failure message and exits.
# ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
# Arguments:
#   $1 - The command to execute.
#   $2 - The expected substring to search for in stderr.
#   $3 - The description of the test case.
#
# Output:
#   Prints "[PASS]" if stderr contains the expected substring.
#   Prints "[FAIL]" and exits with code 1 if stderr does not contain the substring.
#
# Exit codes:
#   0 - If the expected substring is found in stderr.
#   1 - If the expected substring is not found.
# ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
assert_command_stderr_contains() {
    command="$1"
    expected_error="$2"
    test_description="$3"

    output=$(eval "$command" 2>&1 >/dev/null)

    if echo "$output" | grep -qF "$expected_error"; then
        printf "[PASS] [ASSERT] %s\n" "$test_description"
    else
        printf "[FAIL] [ASSERT] %s\n  Expected stderr: '%s'\n  Got stderr: '%s'\n" "$test_description" "$expected_error" "$output"
        exit 1
    fi

    unset command expected_error test_description output
}

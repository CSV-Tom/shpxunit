#!/usr/bin/env sh

# ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
# Executes a command and verifies that its standard output contains a specific substring.
# If the expected substring is found, prints a success message.
# Otherwise, prints a failure message and exits.
# ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
# Arguments:
#   $1 - The command to execute.
#   $2 - The expected substring to search for in the output.
#   $3 - The description of the test case.
#
# Output:
#   Prints "[PASS]" if the command's output contains the expected substring.
#   Prints "[FAIL]" and exits with code 1 if the output does not contain the substring.
#
# Exit codes:
#   0 - If the expected substring is found in the command's output.
#   1 - If the expected substring is not found.
# ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
assert_command_stdout_contains() {
    command="$1"
    expected_output="$2"
    test_description="$3"

    output=$(eval "$command" 2>&1)

    if echo "$output" | grep -qF "$expected_output"; then
        printf "[PASS] %s\n" "$test_description"
    else
        printf "[FAIL] %s\n  Expected output: '%s'\n  Got output: '%s'\n" \
            "$test_description" "$expected_output" "$output"
        exit 1
    fi

    unset command expected_output test_description output
}


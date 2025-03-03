#!/usr/bin/env sh

# ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
# Verifies that a command fails with a specific exit code and error message.
# If the exit code and output match expectations, prints a success message.
# If they do not match, prints a failure message and exits.
# ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
# Arguments:
#   $1 - The command to execute (as a string).
#   $2 - The expected exit code.
#   $3 - The expected error message.
#   $4 - The description of the test case.
#
# Output:
#   Prints "[PASS]" if the command fails as expected.
#   Prints "[FAIL]" and exits with code 1 if the failure conditions are not met.
#
# Exit codes:
#   0 - If the command fails with the expected exit code and message.
#   1 - If the command does not fail as expected.
# ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
assert_fails() {
    test_command="$1"
    expected_exit_code="$2"
    expected_message="$3"
    test_description="$4"

    # Capture command output
    output=$($test_command 2>&1)
    exit_code=$?

    # Strip ANSI color codes (if present)
    clean_output=$(echo "$output" | sed "s/$(printf '\033')\[[0-9;]*[mK]//g")

    if [ "$exit_code" -eq "$expected_exit_code" ] && echo "$clean_output" | grep -qF "$expected_message"; then
        printf "[PASS] [ASSERT] %s\n" "$test_description"
    else
        printf "[FAIL] [ASSERT] %s\n  Expected exit: %s, got: %s\n  Expected message: %s\n  Got output:\n%s\n" \
            "$test_description" "$expected_exit_code" "$exit_code" "$expected_message" "$clean_output"
        exit 1
    fi

    unset test_command expected_exit_code expected_message test_description output exit_code clean_output
}

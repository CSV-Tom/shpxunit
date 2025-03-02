#!/usr/bin/env sh

# ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
# Executes a command and verifies that it succeeds.
# If the command succeeds, prints a success message.
# If the command fails, prints a failure message and exits.
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
#   0 - If the command executes successfully.
#   1 - If the command fails.
# ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
assert_pass() {
    test_command="$1"
    test_description="$2"

    if eval "$test_command" >/dev/null 2>&1; then
        printf "[PASS] %s\n" "$test_description"
    else
        printf "[FAIL] %s\n" "$test_description"
        exit 1
    fi

    unset test_command test_description
}

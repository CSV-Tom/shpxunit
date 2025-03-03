#!/usr/bin/env sh

# ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
# Compares two values and verifies they are NOT equal.
# If they differ, prints a success message. If they are the same, prints a failure message and exits.
# ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
# Arguments:
#   $1 - The unexpected value.
#   $2 - The actual value.
#   $3 - The description of the test case.
#
# Output:
#   Prints "[PASS]" if the values are different.
#   Prints "[FAIL]" and exits with code 1 if the values are the same.
#
# Exit codes:
#   0 - If the values are different.
#   1 - If the values are the same.
# ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
assert_not_equal() {
    unexpected="$1"
    actual="$2"
    test_description="$3"

    if [ "$unexpected" != "$actual" ]; then
        printf "[PASS] [ASSERT] %s\n" "$test_description"
    else
        printf "[FAIL] [ASSERT] %s\n  Unexpected: %s\n" "$test_description" "$actual"
        exit 1
    fi

    unset unexpected actual test_description
}

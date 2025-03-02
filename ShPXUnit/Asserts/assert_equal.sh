#!/usr/bin/env sh

# ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
# Compares two values and verifies they are equal.
# If they match, prints a success message. If they do not match, prints a failure message and exits.
# ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
# Arguments:
#   $1 - The expected value.
#   $2 - The actual value.
#   $3 - The description of the test case.
#
# Output:
#   Prints "[PASS]" if the values match.
#   Prints "[FAIL]" and exits with code 1 if they do not match.
#
# Exit codes:
#   0 - If the values match.
#   1 - If the values do not match.
# ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
assert_equal() {
    expected="$1"
    actual="$2"
    test_description="$3"

    if [ "$expected" = "$actual" ]; then
        printf "[PASS] %s\n" "$test_description"
    else
        printf "[FAIL] %s\n  Expected: %s\n  Got:      %s\n" "$test_description" "$expected" "$actual"
        exit 1
    fi

    unset expected actual test_description
}

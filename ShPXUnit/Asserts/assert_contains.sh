#!/usr/bin/env sh

# ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
# Checks if a string contains a specific substring.
# If the substring is found, prints a success message. Otherwise, prints a failure message and exits.
# ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
# Arguments:
#   $1 - The full string (haystack).
#   $2 - The substring to search for (needle).
#   $3 - The description of the test case.
#
# Output:
#   Prints "[PASS]" if the substring is found.
#   Prints "[FAIL]" and exits with code 1 if the substring is not found.
#
# Exit codes:
#   0 - If the substring is found.
#   1 - If the substring is not found.
# ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
assert_contains() {
    haystack="$1"
    needle="$2"
    test_description="$3"

    if echo "$haystack" | grep -qF "$needle"; then
        printf "[PASS] [ASSERT] %s\n" "$test_description"
    else
        printf "[FAIL] [ASSERT] %s\n  Expected to contain: '%s'\n  Got: '%s'\n" "$test_description" "$needle" "$haystack"
        exit 1
    fi

    unset haystack needle test_description
}

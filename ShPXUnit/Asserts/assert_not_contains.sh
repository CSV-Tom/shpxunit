#!/usr/bin/env sh

# ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
# Checks if a string does NOT contain a specific substring.
# If the substring is not found, prints a success message.
# Otherwise, prints a failure message and exits.
# ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
# Arguments:
#   $1 - The full string (haystack).
#   $2 - The substring to search for (needle).
#   $3 - The description of the test case.
#
# Output:
#   Prints "[PASS]" if the substring is NOT found.
#   Prints "[FAIL]" and exits with code 1 if the substring is found.
#
# Exit codes:
#   0 - If the substring is NOT found.
#   1 - If the substring is found.
# ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
assert_not_contains() {
    haystack="$1"
    needle="$2"
    test_description="$3"

    if echo "$haystack" | grep -qF "$needle"; then
        printf "[FAIL] %s\n  Should not contain: '%s'\n  Got: '%s'\n" "$test_description" "$needle" "$haystack"
        exit 1
    else
        printf "[PASS] %s\n" "$test_description"
    fi

    unset haystack needle test_description
}

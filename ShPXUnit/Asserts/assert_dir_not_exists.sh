#!/usr/bin/env sh

# ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
# Checks if a directory does NOT exist.
# If the directory does not exist, prints a success message. Otherwise, prints a failure message and exits.
# ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
# Arguments:
#   $1 - The directory path.
#   $2 - The description of the test case.
#
# Output:
#   Prints "[PASS]" if the directory does not exist.
#   Prints "[FAIL]" and exits with code 1 if the directory exists.
#
# Exit codes:
#   0 - If the directory does not exist.
#   1 - If the directory exists.
# ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
assert_dir_not_exists() {
    dir_path="$1"
    test_description="$2"

    if [ ! -d "$dir_path" ]; then
        printf "[PASS] [ASSERT] %s\n" "$test_description"
    else
        printf "[FAIL] [ASSERT] %s\n  Unexpected directory found: '%s'\n" "$test_description" "$dir_path"
        exit 1
    fi

    unset dir_path test_description
}

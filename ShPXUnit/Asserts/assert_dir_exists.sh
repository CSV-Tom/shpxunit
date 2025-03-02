#!/usr/bin/env sh

# ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
# Checks if a directory exists.
# If the directory exists, prints a success message. Otherwise, prints a failure message and exits.
# ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
# Arguments:
#   $1 - The directory path.
#   $2 - The description of the test case.
#
# Output:
#   Prints "[PASS]" if the directory exists.
#   Prints "[FAIL]" and exits with code 1 if the directory does not exist.
#
# Exit codes:
#   0 - If the directory exists.
#   1 - If the directory does not exist.
# ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
assert_dir_exists() {
    dir_path="$1"
    test_description="$2"

    if [ -d "$dir_path" ]; then
        printf "[PASS] %s\n" "$test_description"
    else
        printf "[FAIL] %s\n  Directory not found: '%s'\n" "$test_description" "$dir_path"
        exit 1
    fi

    unset dir_path test_description
}

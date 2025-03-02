#!/usr/bin/env sh

# ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
# Checks if a file does NOT exist.
# If the file does not exist, prints a success message. Otherwise, prints a failure message and exits.
# ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
# Arguments:
#   $1 - The file path.
#   $2 - The description of the test case.
#
# Output:
#   Prints "[PASS]" if the file does not exist.
#   Prints "[FAIL]" and exits with code 1 if the file exists.
#
# Exit codes:
#   0 - If the file does not exist.
#   1 - If the file exists.
# ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
assert_file_not_exists() {
    file_path="$1"
    test_description="$2"

    if [ ! -f "$file_path" ]; then
        printf "[PASS] %s\n" "$test_description"
    else
        printf "[FAIL] %s\n  Unexpected file found: '%s'\n" "$test_description" "$file_path"
        exit 1
    fi

    unset file_path test_description
}

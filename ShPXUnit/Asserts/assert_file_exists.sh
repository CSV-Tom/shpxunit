#!/usr/bin/env sh

# ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
# Checks if a file exists.
# If the file exists, prints a success message. Otherwise, prints a failure message and exits.
# ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
# Arguments:
#   $1 - The file path.
#   $2 - The description of the test case.
#
# Output:
#   Prints "[PASS]" if the file exists.
#   Prints "[FAIL]" and exits with code 1 if the file does not exist.
#
# Exit codes:
#   0 - If the file exists.
#   1 - If the file does not exist.
# ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
assert_file_exists() {
    file_path="$1"
    test_description="$2"

    if [ -f "$file_path" ]; then
        printf "[PASS] [ASSERT] %s\n" "$test_description"
    else
        printf "[FAIL] [ASSERT] %s\n  File not found: '%s'\n" "$test_description" "$file_path"
        exit 1
    fi

    unset file_path test_description
}

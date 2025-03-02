#!/usr/bin/env sh

. "$SHPXUNIT_ROOT/asserts.sh"
. "$SHPXUNIT_ROOT/testcase.sh"

# ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
# Runs a set of test cases to verify the correctness of all assertion functions.
# This ensures that assertions correctly detect failures, successes, and expected outputs.
# ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
test_assertion_functions() {
    # ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
    # Command Assertions (Success & Failure)
    # ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
    #assert_command_fails "ls /nonexistent-directory" 2 "ls should fail with exit code 2"
    assert_command_passes "echo 'Hello'" "echo should succeed with exit code 0"

    # ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
    # Output Assertions (Standard Output & Error Output)
    # ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
    assert_command_stdout_contains "echo 'Hello World'" "Hello" "Echo output should contain 'Hello'"
    assert_command_stdout_contains "ls -l" "total" "ls -l output should contain 'total'"
    assert_command_stderr_contains "ls /nonexistent-folder" "No such file or directory" "ls should print error to stderr"

    # ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
    # General String Assertions (Contains & Not Contains)
    # ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
    assert_contains "Hello World" "Hello" "String should contain 'Hello'"
    assert_not_contains "Hello World" "Bye" "String should not contain 'Bye'"

    # ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
    # Equality Assertions (Equal & Not Equal)
    # ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
    assert_equal "42" "42" "Numbers should be equal"
    assert_not_equal "42" "43" "Numbers should not be equal"

    assert_equal "Hello" "Hello" "Strings should be equal"
    assert_not_equal "Hello" "World" "Strings should not be equal"

    # ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
    # File Assertions (File & Directory Existence)
    # ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
    test_file="$(mktemp)"
    assert_file_exists "$test_file" "Temporary file should exist"
    assert_file_not_exists "/nonexistent-file" "Nonexistent file should not exist"
    rm -f "$test_file"

    # ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
    # Directory Assertions (Existence & Non-Existence)
    # ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
    test_dir="$(mktemp -d)"
    assert_dir_exists "$test_dir" "Temporary directory should exist"
    assert_dir_not_exists "/nonexistent-directory" "Nonexistent directory should not exist"
    rm -rf "$test_dir"

    # ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
    # Pass & Fail Assertions (Generic Test Validation)
    # ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
    assert_pass "true" "This test should always pass"
    #assert_fails "false" "This test should always fail"
}

testcase "Test Assertion Functions" test_assertion_functions "Verifying assertion behavior..."

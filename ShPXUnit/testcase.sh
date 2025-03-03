#!/usr/bin/env sh

# ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
# Runs a test case with optional setup and teardown functions.
#
# This function is used to run test cases in a structured format. It supports optional setup and
# teardown functions to prepare and clean up the test environment before and after execution.
#
# Arguments:
#   $1 - The name of the test case.
#   $2 - The function to execute for the test.
#   $3 - The description of the test case.
#   $4 - (Optional) The function to run before the test (setup).
#   $5 - (Optional) The function to run after the test (teardown).
#
# Output:
#   - Prints the test name and description.
#   - Runs the setup function if provided.
#   - Executes the test function.
#   - Runs the teardown function if provided.
#   - Prints "[PASS]" if the test succeeds.
#   - Prints "[FAIL]" if the test fails.
#
# Exit codes:
#   0 - If the test function exits successfully.
#   1 - If the test function fails.
#
# Examples:
#
# 1. Simple test case without setup or teardown:
#    test_hello_world() {
#        echo "Hello, World!" | grep -q "Hello"
#    }
#    test_testcase "Hello World Test" test_hello_world "Checking if 'Hello, World!' is printed."
#
# 2. Test case with setup and teardown:
#    setup_env() {
#        mkdir -p /tmp/test_env
#        touch /tmp/test_env/testfile
#    }
#
#    cleanup_env() {
#        rm -rf /tmp/test_env
#    }
#
#    test_file_exists() {
#        [ -f /tmp/test_env/testfile ]
#    }
#
#    testcase "File Existence Check" test_file_exists "Checking if testfile exists" setup_env cleanup_env
#
# ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
testcase() {
    test_name="$1"
    test_exec_func="$2"
    test_description="$3"
    setup_func="$4"
    teardown_func="$5"

    printf "\n[EXEC] [TEST] %s\n" "$test_description"
    printf "––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––\n"

    if [ -n "$setup_func" ]; then
        printf "[SETUP] Running %s...\n" "$setup_func"
        eval "$setup_func"
    fi

    eval "$test_exec_func"
    exit_code=$?

    if [ -n "$teardown_func" ]; then
        printf "[TEARDOWN] Running %s...\n" "$teardown_func"
        eval "$teardown_func"
    fi

    printf "––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––\n"
    if [ "$exit_code" -eq 0 ]; then
        printf "[PASS] [TEST] %s\n" "$test_name"
    else
        printf "[FAIL] [TEST] %s\n" "$test_name"
        return 1
    fi
}

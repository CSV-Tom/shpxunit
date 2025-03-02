#!/usr/bin/env sh

printf "Running tests for shPXUnit in multiple shells...\n"
printf "–––––––––––––––––––––––––––––––––––––––––––––––––––––\n"

# List of shells to test
SHELLS="sh dash ksh bash"

for shell in $SHELLS; do
    if command -v "$shell" >/dev/null 2>&1; then
        printf "–––––––––––––––––––––––––––––––––––––––––––––––––––––\n"
        printf "[INFO] Running tests in %s...\n" "$shell"
        printf "–––––––––––––––––––––––––––––––––––––––––––––––––––––\n"

        if "$shell" /shpxunit/ShPXUnit/testrunner.sh ".*" /shpxunit/ShPXUnit/Tests; then
            printf "[PASS] All tests passed in %s!\n" "$shell"
        else
            printf "[ERROR] Tests failed in %s!\n" "$shell"
            exit 1
        fi
    else
        printf "[WARN] %s not found, skipping...\n" "$shell"
    fi
done

printf "–––––––––––––––––––––––––––––––––––––––––––––––––––––\n"
printf "[SUCCESS] All tests passed in all available shells!\n"
printf "–––––––––––––––––––––––––––––––––––––––––––––––––––––\n"
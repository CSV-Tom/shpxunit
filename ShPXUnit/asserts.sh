#!/usr/bin/env sh

# ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
# Loads all assertion scripts (`assert_*.sh`) from the `Asserts/` directory.
#
# Output:
#   Sources all `assert_*.sh` files found in the directory.
# ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
load_asserts() {
    asserts_dir="$1"

    [ -d "$asserts_dir" ] || {
        printf "[ERROR] Assertions directory not found: %s\n" "$asserts_dir" >&2
        exit 1
    }

    for assert_file in "$asserts_dir"/assert_*.sh; do
        [ -f "$assert_file" ] || continue
	    [ -n "$SHPXUNITDEBUG" ] && printf "[INFO] Loading assertion: %s\n" "$(basename "$assert_file")"
        . "$assert_file"
    done

    unset asserts_dir assert_file
}

load_asserts "$SHPXUNIT_ROOT/Asserts"

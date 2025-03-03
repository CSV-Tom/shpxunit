# shPXUnit – POSIX-compliant Shell Testing Framework

**shPXUnit** is a lightweight, POSIX-compliant unit testing framework for Shell scripts.
It provides structured test execution with built-in assertions for validating command execution, output, and file system states.

## Features

- **POSIX-compliant** – Runs in `sh`, `dash`, `ksh`, and `bash`
- **Minimal & Fast** – No dependencies, pure Shell implementation
- **Structured Assertions** – Covers commands, stdout, stderr, files, and directories
- **Test Runner** – Automatic test discovery & summary reporting

## Installation

Clone the repository:

```sh
git clone https://github.com/CSV-Tom/shpxunit
cd shpxunit
export SHPXUNIT_ROOT="$(pwd)/ShPXUnit"
```

**Optional:** Add it to your shell profile for global usage

```sh
echo 'export SHPXUNIT_ROOT="'$(pwd)/ShPXUnit'"' >> ~/.profile
```

## Usage

### Writing a Test

Create a test file (e.g., `Tests/test_example.sh`):

```sh
#!/usr/bin/env sh

. "$SHPXUNIT_ROOT/asserts.sh"
. "$SHPXUNIT_ROOT/testcase.sh"

test_example() {
    assert_command_passes "echo 'Hello World'" "Echo should succeed"
    assert_command_stdout_contains "echo 'Hello World'" "Hello" "Output should contain 'Hello'"
}

test_testcase "Example Test" test_example "Validating basic assertions..."
```

### Running Tests

Run all tests:

```sh
./ShPXUnit/testrunner.sh ".*" ./Tests
```

Run specific tests using regex:

```sh
./ShPXUnit/testrunner.sh "test_example.*" ./Tests
```

## Assertions

| Assertion                        | Description |
|----------------------------------|-------------|
| `assert_command_passes`          | Ensures command exits with `0`. |
| `assert_command_fails`           | Ensures command exits with non-zero code. |
| `assert_command_stdout_contains` | Verifies stdout contains expected string. |
| `assert_command_stderr_contains` | Verifies stderr contains expected string. |
| `assert_equal`                   | Compares two values. |
| `assert_not_equal`               | Ensures values are different. |
| `assert_file_exists`             | Checks if a file exists. |
| `assert_file_not_exists`         | Checks if a file does not exist. |
| `assert_dir_exists`              | Checks if a directory exists. |
| `assert_dir_not_exists`          | Checks if a directory does not exist. |
| `assert_pass`                    | Verifies a command executes successfully. |
| `assert_contains`                | Checks if a string contains a specific substring. |
| `assert_not_contains`            | Checks if a string does NOT contain a specific substring. |
| `assert_fails`                   | Ensures command fails with expected exit code. |


## Development & Testing

To ensure `shPXUnit` runs correctly in multiple shell environments (`sh`, `dash`, `ksh`, `bash`), you can use Docker to build and execute the test suite.

### Build the Docker Test Environment

This will create a Docker container with all required shells installed.

```sh
docker build -t shpxunit-tester .
```

### Run the Tests in All Supported Shells

Execute the test suite inside the container:

```sh
docker run --rm shpxunit-tester
```

This command:

- Runs all test cases in `sh`, `dash`, `ksh`, and `bash`
- Fails with an error code if any test fails
- Cleans up the container after execution

### Run Tests Interactively (Debugging)

To enter the container and run tests manually:

```sh
docker run --rm -it shpxunit-tester sh
```

Once inside, you can run:

```sh
./ShPXUnit/testrunner.sh ".*" ./Tests
```

Now you can inspect logs, rerun tests, or make changes in the container for debugging.

## Contributing

Feel free to contribute with new assertions, bug fixes, or improvements!

1. Fork the repository
2. Create a feature branch (`git checkout -b feature-name`)
3. Commit your changes (`git commit -m "feat: add new assertion"`)
4. Push to your fork and create a pull request

## ⚖ License

**shPXUnit** is licensed under the **MIT License** – free to use, modify, and distribute.

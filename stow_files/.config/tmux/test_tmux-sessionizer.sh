#!/usr/bin/env bash
set -euo pipefail

# Test framework
TESTS_RUN=0
TESTS_PASSED=0
TESTS_FAILED=0

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Source the script functions (but not the main loop)
# We'll do this by extracting just the functions
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SESSIONIZER="$SCRIPT_DIR/tmux-sessionizer.sh"

# Helper to extract and source functions from the script
setup_test_env() {
    # Create a temp directory for test sessions
    export TEST_DIR=$(mktemp -d)
    export HOME="$TEST_DIR/home"
    mkdir -p "$HOME"
    
    # Create test directories
    mkdir -p "$HOME/workspace/project1"
    mkdir -p "$HOME/workspace/project2"
    mkdir -p "$HOME/Documents/notes"
    mkdir -p "$HOME/.config/tmux"
    
    # Source the sanitize function from the script
    source <(sed -n '/^# Sanitize session name/,/^}/p' "$SESSIONIZER")
    
    # Source the rename function from the script
    source <(sed -n '/^# Rename a session/,/^}/p' "$SESSIONIZER")
}

cleanup_test_env() {
    rm -rf "$TEST_DIR"
}

# Test assertions
assert_equals() {
    local expected="$1"
    local actual="$2"
    local message="${3:-}"
    
    TESTS_RUN=$((TESTS_RUN + 1))
    
    if [[ "$expected" == "$actual" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "${GREEN}✓${NC} $message"
        return 0
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "${RED}✗${NC} $message"
        echo -e "  Expected: ${YELLOW}$expected${NC}"
        echo -e "  Actual:   ${YELLOW}$actual${NC}"
        return 1
    fi
}

assert_contains() {
    local haystack="$1"
    local needle="$2"
    local message="${3:-}"
    
    TESTS_RUN=$((TESTS_RUN + 1))
    
    if [[ "$haystack" == *"$needle"* ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "${GREEN}✓${NC} $message"
        return 0
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "${RED}✗${NC} $message"
        echo -e "  Haystack: ${YELLOW}$haystack${NC}"
        echo -e "  Needle:   ${YELLOW}$needle${NC}"
        return 1
    fi
}

# Tests
test_sanitize_session_name() {
    echo ""
    echo "=== Testing sanitize_session_name ==="
    
    local result
    
    result=$(sanitize_session_name "simple")
    assert_equals "simple" "$result" "Simple name should not change"
    
    result=$(sanitize_session_name "with.dots")
    assert_equals "with_dots" "$result" "Dots should be replaced with underscores"
    
    result=$(sanitize_session_name "subsid.github.io")
    assert_equals "subsid_github_io" "$result" "Multiple dots should be replaced"
    
    result=$(sanitize_session_name "with:colons")
    assert_equals "with_colons" "$result" "Colons should be replaced with underscores"
    
    result=$(sanitize_session_name "with spaces")
    assert_equals "with_spaces" "$result" "Spaces should be replaced with underscores"
    
    result=$(sanitize_session_name "mix.ed: chars test")
    assert_equals "mix_ed__chars_test" "$result" "Mixed special chars should all be replaced"
}

test_script_help() {
    echo ""
    echo "=== Testing --help flag ==="
    
    local output
    output=$("$SESSIONIZER" --help 2>&1 || true)
    
    assert_contains "$output" "Usage:" "Help should show usage"
    assert_contains "$output" "--debug" "Help should mention debug flag"
    assert_contains "$output" "--help" "Help should mention help flag"
}

test_script_syntax() {
    echo ""
    echo "=== Testing script syntax ==="
    
    if bash -n "$SESSIONIZER"; then
        TESTS_RUN=$((TESTS_RUN + 1))
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "${GREEN}✓${NC} Script has valid bash syntax"
    else
        TESTS_RUN=$((TESTS_RUN + 1))
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "${RED}✗${NC} Script has syntax errors"
    fi
}

test_script_executable() {
    echo ""
    echo "=== Testing script is executable ==="
    
    if [[ -x "$SESSIONIZER" ]]; then
        TESTS_RUN=$((TESTS_RUN + 1))
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "${GREEN}✓${NC} Script is executable"
    else
        TESTS_RUN=$((TESTS_RUN + 1))
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "${RED}✗${NC} Script is not executable"
    fi
}

test_debug_flag() {
    echo ""
    echo "=== Testing debug flag ==="
    
    # Test that script accepts debug flag without error
    if "$SESSIONIZER" --debug --help &>/dev/null; then
        TESTS_RUN=$((TESTS_RUN + 1))
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "${GREEN}✓${NC} Debug flag is accepted"
    else
        TESTS_RUN=$((TESTS_RUN + 1))
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "${RED}✗${NC} Debug flag caused error"
    fi
}

test_unknown_flag() {
    echo ""
    echo "=== Testing unknown flag handling ==="
    
    local output
    output=$("$SESSIONIZER" --unknown-flag 2>&1 || true)
    
    assert_contains "$output" "Unknown option" "Unknown flags should show error message"
}

test_rename_function_exists() {
    echo ""
    echo "=== Testing rename_session function ==="
    
    # Check if the rename_session function is defined
    if declare -f rename_session >/dev/null; then
        TESTS_RUN=$((TESTS_RUN + 1))
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "${GREEN}✓${NC} rename_session function exists"
    else
        TESTS_RUN=$((TESTS_RUN + 1))
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "${RED}✗${NC} rename_session function not found"
    fi
}

test_keybinding_documentation() {
    echo ""
    echo "=== Testing keybinding documentation ==="
    
    local script_content
    script_content=$(cat "$SESSIONIZER")
    
    # Check that ctrl-e is documented for rename
    assert_contains "$script_content" "ctrl-e" "Script should document ctrl-e keybinding"
    assert_contains "$script_content" "rename" "Script should mention rename functionality"
    
    # Make sure ctrl-n is NOT present (user uses it for fzf navigation)
    if [[ "$script_content" != *"ctrl-n"* ]]; then
        TESTS_RUN=$((TESTS_RUN + 1))
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "${GREEN}✓${NC} ctrl-n is not used (reserved for fzf navigation)"
    else
        TESTS_RUN=$((TESTS_RUN + 1))
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "${RED}✗${NC} ctrl-n is used but should be avoided"
    fi
}

# Print summary
print_summary() {
    echo ""
    echo "========================================"
    echo "Test Summary:"
    echo "  Total:  $TESTS_RUN"
    echo -e "  ${GREEN}Passed: $TESTS_PASSED${NC}"
    if [[ $TESTS_FAILED -gt 0 ]]; then
        echo -e "  ${RED}Failed: $TESTS_FAILED${NC}"
    else
        echo -e "  Failed: $TESTS_FAILED"
    fi
    echo "========================================"
    
    if [[ $TESTS_FAILED -eq 0 ]]; then
        echo -e "${GREEN}All tests passed!${NC}"
        return 0
    else
        echo -e "${RED}Some tests failed.${NC}"
        return 1
    fi
}

# Run all tests
main() {
    echo "Testing tmux-sessionizer..."
    echo "Script location: $SESSIONIZER"
    
    setup_test_env
    
    # Run tests
    test_script_syntax
    test_script_executable
    test_script_help
    test_debug_flag
    test_unknown_flag
    test_sanitize_session_name
    test_rename_function_exists
    test_keybinding_documentation
    
    cleanup_test_env
    
    print_summary
}

# Run tests
main "$@"

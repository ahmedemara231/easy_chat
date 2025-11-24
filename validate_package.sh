#!/bin/bash

# Easy Chat Package Validation Script
# This script validates the package structure and compilation

echo "=================================="
echo "Easy Chat Package Validation"
echo "=================================="
echo ""

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Counter for checks
PASSED=0
FAILED=0

# Function to print success
print_success() {
    echo -e "${GREEN}✓${NC} $1"
    ((PASSED++))
}

# Function to print failure
print_failure() {
    echo -e "${RED}✗${NC} $1"
    ((FAILED++))
}

# Function to print warning
print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

echo "1. Checking Flutter installation..."
if command -v flutter &> /dev/null; then
    print_success "Flutter is installed"
    flutter --version | head -1
else
    print_failure "Flutter is not installed"
    exit 1
fi

echo ""
echo "2. Checking package structure..."

# Check required files
files=(
    "pubspec.yaml"
    "README.md"
    "CHANGELOG.md"
    "LICENSE"
    "lib/easy_chat.dart"
    "lib/models/chat_message.dart"
    "lib/widgets/chat_body.dart"
    "lib/widgets/message_widget.dart"
)

for file in "${files[@]}"; do
    if [ -f "$file" ]; then
        print_success "Found $file"
    else
        print_failure "Missing $file"
    fi
done

echo ""
echo "3. Checking test files..."

test_files=(
    "test/easy_chat_test.dart"
    "test/models/chat_message_test.dart"
    "test/widgets/message_widget_test.dart"
    "test/widgets/easy_chat_test.dart"
)

for file in "${test_files[@]}"; do
    if [ -f "$file" ]; then
        print_success "Found $file"
    else
        print_failure "Missing $file"
    fi
done

echo ""
echo "4. Analyzing package dependencies..."
flutter pub get > /dev/null 2>&1
if [ $? -eq 0 ]; then
    print_success "Dependencies resolved successfully"
else
    print_failure "Failed to resolve dependencies"
fi

echo ""
echo "5. Running static analysis..."
flutter analyze > /tmp/analyze_output.txt 2>&1
ANALYZE_EXIT=$?

if [ $ANALYZE_EXIT -eq 0 ]; then
    print_success "No static analysis issues found"
else
    ERROR_COUNT=$(grep -c "error •" /tmp/analyze_output.txt)
    WARNING_COUNT=$(grep -c "warning •" /tmp/analyze_output.txt)
    INFO_COUNT=$(grep -c "info •" /tmp/analyze_output.txt)

    if [ $ERROR_COUNT -gt 0 ]; then
        print_failure "Found $ERROR_COUNT errors in static analysis"
        grep "error •" /tmp/analyze_output.txt | head -5
    else
        print_success "No errors in static analysis"
    fi

    if [ $WARNING_COUNT -gt 0 ]; then
        print_warning "Found $WARNING_COUNT warnings"
    fi
fi

echo ""
echo "6. Checking documentation..."

# Check README sections
if grep -q "## Features" README.md; then
    print_success "README has Features section"
else
    print_warning "README missing Features section"
fi

if grep -q "## Installation" README.md; then
    print_success "README has Installation section"
else
    print_warning "README missing Installation section"
fi

if grep -q "## Usage" README.md; then
    print_success "README has Usage section"
else
    print_warning "README missing Usage section"
fi

echo ""
echo "7. Validating pubspec.yaml..."

if grep -q "name: easy_chat" pubspec.yaml; then
    print_success "Package name is correct"
else
    print_failure "Package name is incorrect"
fi

if grep -q "version:" pubspec.yaml; then
    VERSION=$(grep "version:" pubspec.yaml | head -1 | awk '{print $2}')
    print_success "Package version: $VERSION"
else
    print_failure "Version not specified"
fi

if grep -q "homepage:" pubspec.yaml; then
    print_success "Homepage URL specified"
else
    print_warning "Homepage URL not specified"
fi

echo ""
echo "8. Checking example..."

if [ -f "example/example.dart" ]; then
    print_success "Example file exists"
else
    print_warning "Example file not found"
fi

echo ""
echo "9. Validating test structure..."

# Count test files
TEST_COUNT=$(find test -name "*_test.dart" -type f | wc -l | tr -d ' ')
print_success "Found $TEST_COUNT test files"

# Check if main test file imports others
if grep -q "import.*chat_message_test.dart" test/easy_chat_test.dart; then
    print_success "Main test imports model tests"
else
    print_warning "Main test doesn't import model tests"
fi

echo ""
echo "10. Package completeness check..."

REQUIRED_COMPONENTS=(
    "Data models"
    "Widget components"
    "Tests"
    "Documentation"
    "Example"
    "License"
)

# Simplified completeness check
if [ -f "lib/models/chat_message.dart" ]; then
    print_success "Data models: Present"
else
    print_failure "Data models: Missing"
fi

if [ -f "lib/easy_chat.dart" ]; then
    print_success "Widget components: Present"
else
    print_failure "Widget components: Missing"
fi

if [ $TEST_COUNT -gt 0 ]; then
    print_success "Tests: Present ($TEST_COUNT files)"
else
    print_failure "Tests: Missing"
fi

if [ -f "README.md" ] && [ -f "CHANGELOG.md" ]; then
    print_success "Documentation: Complete"
else
    print_failure "Documentation: Incomplete"
fi

if [ -f "example/example.dart" ]; then
    print_success "Example: Present"
else
    print_warning "Example: Missing"
fi

if [ -f "LICENSE" ]; then
    print_success "License: Present"
else
    print_failure "License: Missing"
fi

echo ""
echo "=================================="
echo "Validation Summary"
echo "=================================="
echo -e "${GREEN}Passed:${NC} $PASSED checks"
if [ $FAILED -gt 0 ]; then
    echo -e "${RED}Failed:${NC} $FAILED checks"
fi
echo ""

if [ $FAILED -eq 0 ]; then
    echo -e "${GREEN}✓ Package validation PASSED${NC}"
    echo ""
    echo "The Easy Chat package structure is valid and ready for:"
    echo "  • Publishing to pub.dev"
    echo "  • Version control"
    echo "  • Distribution"
    echo ""
    exit 0
else
    echo -e "${RED}✗ Package validation FAILED${NC}"
    echo ""
    echo "Please fix the issues above before publishing."
    echo ""
    exit 1
fi

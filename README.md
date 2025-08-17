#!/bin/bash

# ========================================
# Logging Configuration
# ========================================

# Log file (you can override this per script if needed)
LOGFILE="${LOGFILE:-$HOME/logs/app.log}"

# Log directory (extracted from the logfile path)
LOG_DIR="$(dirname "$LOGFILE")"

# Log levels
VERBOSE="${VERBOSE:-true}"   # Show logs in console
DEBUG="${DEBUG:-false}"      # Enable debug logs

# ========================================
# ANSI Colors (for terminal output)
# ========================================
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color (reset)

# ========================================
# Timestamp format function
# ========================================
timestamp() {
    date '+%Y-%m-%d %H:%M:%S'
}

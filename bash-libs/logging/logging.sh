#!/bin/bash

# ========================================
# Reusable Logging Library
# ========================================

# Load configuration file (config.sh) if available
source bash-libs/logging/config.sh 2>/dev/null || {
    echo "Could not load config.sh. Make sure it exists in bash-libs/logging/config.sh"
    exit 1
}

# Create log directory if it does not exist
setup_logging() {
    if [ ! -d "$LOG_DIR" ]; then
        mkdir -p "$LOG_DIR" || {
            echo "Failed to create log directory: $LOG_DIR"
            exit 1
        }
    fi
}

# Main log function
log() {
    local level="$1"
    local message="$2"
    local ts=$(timestamp)

    # Ensure log directory exists
    setup_logging

    # Write message to logfile
    printf '%s [%-4s] %s\n' "$ts" "$level" "$message" >> "$LOGFILE"

    # Display to console with colors (only if VERBOSE is enabled)
    if [ "$VERBOSE" = true ]; then
        local color=""
        case "$level" in
            "INFO")  color="$GREEN"  ;;
            "WARN")  color="$YELLOW" ;;
            "ERROR") color="$RED"    ;;
            "DEBUG") color="$BLUE"   ;;
            "CRIT")  color="$RED"    ;;
            *)       color="$NC"     ;;
        esac
        printf '%s [%-4s] %b\n' "$ts" "$level" "$color$message$NC"
    fi
}

# Shortcut functions for different log levels
info()  { log "INFO"  "$*"; }
warn()  { log "WARN"  "$*"; }
error() { log "ERROR" "$*"; }
debug() { 
    if [ "$DEBUG" = true ]; then
        log "DEBUG" "$*"
    fi
}
crit()  { log "CRIT"  "$*"; }  # Critical: requires immediate action

# Optional startup message
debug "=== Logging initialized (LOGFILE=$LOGFILE) ==="

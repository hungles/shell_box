#!/bin/bash
source bash-libs/logging/logging.sh
DEBUG=false

# Exit immediately on error (-e), on undefined variables (-u), 
# and propagate errors in pipelines (pipefail)
set -euo pipefail

# --- Validate arguments ---
if [ $# -ne 2 ]; then
    error "Usage: $0 <source_directory> <destination_directory>"
    exit 1
fi

# --- Prepare variables ---
fecha_actual=$(date +%F)
debug "Adding current date $fecha_actual"
src_backup=$1
debug "Source detected $src_backup"
dst_backup=$2
debug "Destination detected $dst_backup"
backup_name="${fecha_actual}-backup"
debug "Backup name set to $backup_name"

# --- Validate directories ---
if [ ! -d "$src_backup" ]; then
    error "Error: source directory $src_backup does not exist"
    exit 2
fi

if [ ! -d "$dst_backup" ]; then
    error "Error: destination directory $dst_backup does not exist"
    exit 3
fi

# --- Copy source into destination ---
if ! output=$(cp -r "$src_backup" "$dst_backup/$backup_name" 2>&1); then
    error "Copy failed: $output"
    exit 4
fi
info "Copy succeeded: $src_backup -> $dst_backup/$backup_name"

# --- Compress backup folder into .tar.gz ---
# -c: create archive
# -z: compress with gzip
# -f: output file name
# -C: change directory before adding files (avoids absolute paths)
# stderr is captured into 'output', stdout is silenced (>/dev/null)
if ! output=$(tar -czf "$dst_backup/$backup_name.tar.gz" -C "$dst_backup" "$backup_name" 2>&1 >/dev/null); then
    error "Compression failed: $output"
    exit 5
fi
info "Compression succeeded: $dst_backup/$backup_name.tar.gz"

# --- Remove temporary uncompressed folder ---
rm -rf "$dst_backup/$backup_name"
debug "Temporary folder removed: $dst_backup/$backup_name"

# --- Final log ---
info "Backup completed successfully"

# 📝 Bash Logging Utility

This project provides a **lightweight logging utility** for Bash scripts.  
It allows you to easily add **log levels, colors, timestamps, and file logging** to your scripts.

---

## 🚀 Features
- ✅ Configurable **log file** and directory  
- ✅ **Log levels**: Info, Warning, Error, Debug  
- ✅ **Colored output** for better readability in terminal  
- ✅ **Timestamps** in all logs  
- ✅ Support for **console + file output**  
- ✅ Easy to reuse in multiple scripts  

---

## ⚙️ Configuration

### Environment Variables
- `LOGFILE` → Path to the log file (default: `$HOME/logs/app.log`)  
- `VERBOSE` → Show logs in console (default: `true`)  
- `DEBUG` → Enable debug logs (default: `false`)  

Example:
```bash
export LOGFILE="/var/log/myapp.log"
export VERBOSE=true
export DEBUG=true
```

---

## 🖥️ Usage
1. Source the script
```bash
#!/bin/bash
source ./logging.sh
```
2. Use the logging functions
```bash
info "Application started"
warn "Low disk space"
error "Failed to connect to database"
debug "Request payload: {...}"
crit "KERNEL PANIC!!"
```
---
## 📑 Example Output
```yaml
2025-08-16 22:31:45 [INFO]  Application started
2025-08-16 22:31:45 [WARN]  Low disk space
2025-08-16 22:31:45 [ERROR] Failed to connect to database
2025-08-16 22:31:45 [DEBUG] Request payload: {...}
```
---
## 🛠️ Installation
Clone or copy the logging.sh file into your project and source it from your scripts.
```bash
git clone https://github.com/your-repo/bash-logging.git
cd bash-logging
```
## 📜 License

MIT License © 2025




# health_check.sh

Ping + HTTP check + uptime; logs to ~/scripts/health_check.log.

## Usage
./scripts/health_check.sh

## Example Output
```
==== EC2 Health Check 2025-09-07 09:37:23 ====
Ping (8.8.8.8): ✅ OK
HTTP (https://google.com): ✅ OK
Uptime:  09:37:24 up 18 days,  3:38,  1 user,  load average: 0.00, 0.00, 0.00
```

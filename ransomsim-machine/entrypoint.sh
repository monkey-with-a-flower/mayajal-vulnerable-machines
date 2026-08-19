#!/bin/bash
set -euo pipefail

SHARED_DIR=/data/shared

install -d -o student -g student -m 0755 "$SHARED_DIR"

printf '%s\n' 'Nimbus Logistics training data: Q3 budget forecast.' > "$SHARED_DIR/Q3_Budget.xlsx"
printf '%s\n' 'Nimbus Logistics training data: employee onboarding checklist.' > "$SHARED_DIR/onboarding_checklist.docx"
printf '%s\n' 'MAYAJAL RANSOMSIM CANARY — modification of this file is monitored.' > "$SHARED_DIR/.canary_772x"

for record_number in $(seq -w 1 32); do
    printf 'Nimbus Logistics decoy shipment record %s.\n' "$record_number" > "$SHARED_DIR/shipment_0${record_number}.txt"
done

chown -R student:student "$SHARED_DIR"

exec /usr/bin/supervisord -c /etc/supervisor/conf.d/mayajal.conf

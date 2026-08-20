# Student Guide — Nimbus Logistics Ransomware Simulation

## Objective

Demonstrate ransomware-like file impact on the assigned Nimbus fileserver and
trigger its monitoring rules.

## What you have

- Host: `nimbus-fileserver`
- SSH username and password: `student` / `student`
- Authorized target directory: `/data/shared`

## Steps

1. Write a Bash payload with a safety check restricting it to `/data/shared`.
2. Base64-transform the complete contents of at least 30 regular files.
3. Rename transformed files with the `.locked` suffix.
4. Modify `.canary_772x` and create `README_DECRYPT.txt`.
5. Transfer the payload over SCP, run it over SSH, and verify the results.

Preserve recoverability: Base64 is used so the exercise data can be decoded.

Do not interfere with the monitoring processes or attack systems outside this assigned machine.

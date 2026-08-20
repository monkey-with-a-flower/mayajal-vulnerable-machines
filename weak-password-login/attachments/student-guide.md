# Student Guide — Weak Password Payroll

## Objective

Gain access to the Northstar Payroll dashboard as `admin` and retrieve the lab
flag.

## What you have

- Application address: `http://payroll:8080`
- Username: `admin`
- Password list: `passwords.txt`

## Steps

1. Confirm that the login page is reachable.
2. Test passwords from the supplied list against the login form.
3. Identify the successful password without skipping HTTP response details.
4. Retain the authenticated session cookie.
5. Open `/dashboard` with that session and record the flag.

Only test the assigned payroll machine. Do not reuse these techniques against
external systems.

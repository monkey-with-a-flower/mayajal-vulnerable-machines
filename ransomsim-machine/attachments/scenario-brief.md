# Nimbus Logistics — Compromised Fileserver

Nimbus Logistics has asked you to validate whether its internal fileserver can detect ransomware-like impact.

Connect to `nimbus-fileserver` over SSH with username `student` and password `student`. Deliver a payload you wrote yourself, execute it against `/data/shared`, and leave a ransom note whose filename begins with `README` or contains `DECRYPT`.

Your payload should preserve the originals' recoverability for this controlled exercise. Renaming affected files with a `.locked` suffix will exercise the machine's ransomware-specific telemetry.

Do not interfere with the monitoring processes or attack systems outside this assigned machine.
